package com.name.app;

import com.name.app.db.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/results")
public class ResultsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "SELECT g11_final, g12_final, total_final FROM grades WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("g11_final", rs.getObject("g11_final"));
                request.setAttribute("g12_final", rs.getObject("g12_final"));
                request.setAttribute("total_final", rs.getObject("total_final"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "SELECT AVG(g11_final), AVG(g12_final), AVG(total_final) FROM grades";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                request.setAttribute("avg_g11", rs.getObject(1) != null ? String.format("%.1f", rs.getDouble(1)) : "-");
                request.setAttribute("avg_g12", rs.getObject(2) != null ? String.format("%.1f", rs.getDouble(2)) : "-");
                request.setAttribute("avg_total", rs.getObject(3) != null ? String.format("%.1f", rs.getDouble(3)) : "-");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/results.jsp").forward(request, response);
    }
}