package com.name.app.auth;

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
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // אם המשתמש כבר מחובר, מעבירים אותו ישירות לדף הבית
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action"); // "login" או "register"

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "יש למלא שם משתמש וסיסמה");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        username = username.trim();

        if ("register".equals(action)) {
            // תהליך הרשמה
            if (registerUser(username, password)) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "שם המשתמש כבר תפוס, בחר שם אחר.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } else {
            // תהליך התחברות
            if (validateUser(username, password)) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "שם משתמש או סיסמה שגויים");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        }
    }

    /**
     * אימות משתמש קיים מול מסד הנתונים H2
     */
    private boolean validateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // מחזיר true אם נמצא משתמש תואם
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * הרשמת משתמש חדש בטבלת users
     */
    private boolean registerUser(String username, String password) {
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // אם ה-username כבר קיים, ה-UNIQUE constraint יכשיל את השאילתה
            e.printStackTrace();
            return false;
        }
    }
}