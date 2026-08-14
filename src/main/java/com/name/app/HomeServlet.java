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
import java.sql.Types;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

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
            String sql = "SELECT * FROM grades WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("g11_exam", rs.getObject("g11_exam"));
                request.setAttribute("g11_magen", rs.getObject("g11_magen"));
                request.setAttribute("g11_war", rs.getBoolean("g11_war"));

                request.setAttribute("g12_exam", rs.getObject("g12_exam"));
                request.setAttribute("g12_magen", rs.getObject("g12_magen"));
                request.setAttribute("g12_war", rs.getBoolean("g12_war"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");

        String g11ExamStr = request.getParameter("g11_exam");
        String g11MagenStr = request.getParameter("g11_magen");
        boolean g11War = "true".equals(request.getParameter("g11_war"));

        String g12ExamStr = request.getParameter("g12_exam");
        String g12MagenStr = request.getParameter("g12_magen");
        boolean g12War = "true".equals(request.getParameter("g12_war"));

        Double g11Final = null;
        Double g12Final = null;
        Double totalFinal = null;

        if (g11ExamStr != null && !g11ExamStr.isEmpty() && g11MagenStr != null && !g11MagenStr.isEmpty()) {
            int exam = Integer.parseInt(g11ExamStr);
            int magen = Integer.parseInt(g11MagenStr);

            if (g11War) {
                int max = Math.max(exam, magen);
                int min = Math.min(exam, magen);
                g11Final = (max * 0.60) + (min * 0.40);
            } else {
                g11Final = (exam * 0.50) + (magen * 0.50);
            }
        }

        if (g12ExamStr != null && !g12ExamStr.isEmpty() && g12MagenStr != null && !g12MagenStr.isEmpty()) {
            int exam = Integer.parseInt(g12ExamStr);
            int magen = Integer.parseInt(g12MagenStr);

            if (g12War) {
                int max = Math.max(exam, magen);
                int min = Math.min(exam, magen);
                g12Final = (max * 0.60) + (min * 0.40);
            } else {
                g12Final = (exam * 0.50) + (magen * 0.50);
            }
        }

        if (g11Final != null && g12Final != null) {
            totalFinal = (g11Final * 0.65) + (g12Final * 0.35);
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            String deleteSql = "DELETE FROM grades WHERE username = ?";
            PreparedStatement deletePs = conn.prepareStatement(deleteSql);
            deletePs.setString(1, username);
            deletePs.executeUpdate();

            String insertSql = "INSERT INTO grades (username, g11_exam, g11_magen, g11_war, g11_final, g12_exam, g12_magen, g12_war, g12_final, total_final) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertSql);

            ps.setString(1, username);

            if (g11ExamStr != null && !g11ExamStr.isEmpty()) ps.setInt(2, Integer.parseInt(g11ExamStr));
            else ps.setNull(2, Types.INTEGER);
            if (g11MagenStr != null && !g11MagenStr.isEmpty()) ps.setInt(3, Integer.parseInt(g11MagenStr));
            else ps.setNull(3, Types.INTEGER);
            ps.setBoolean(4, g11War);
            if (g11Final != null) ps.setDouble(5, g11Final);
            else ps.setNull(5, Types.DOUBLE);

            if (g12ExamStr != null && !g12ExamStr.isEmpty()) ps.setInt(6, Integer.parseInt(g12ExamStr));
            else ps.setNull(6, Types.INTEGER);
            if (g12MagenStr != null && !g12MagenStr.isEmpty()) ps.setInt(7, Integer.parseInt(g12MagenStr));
            else ps.setNull(7, Types.INTEGER);
            ps.setBoolean(8, g12War);
            if (g12Final != null) ps.setDouble(9, g12Final);
            else ps.setNull(9, Types.DOUBLE);

            if (totalFinal != null) ps.setDouble(10, totalFinal);
            else ps.setNull(10, Types.DOUBLE);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/results");
    }
}