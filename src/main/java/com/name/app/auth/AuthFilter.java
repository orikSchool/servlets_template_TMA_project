package com.name.app.auth;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * פילטר אבטחה: בודק אם המשתמש מחובר לפני גישה לדף הבית (/home).
 * אם הוא לא מחובר, הוא מועבר אוטומטית לדף ההתחברות (/login).
 */
@WebFilter(urlPatterns = {"/home"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
        // אין צורך באתחול מיוחד
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // בדיקה אם קיים Session עם שם משתמש
        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("username") != null);

        if (loggedIn) {
            // המשתמש מחובר - ממשיכים בטעינת הדף
            chain.doFilter(req, res);
        } else {
            // המשתמש לא מחובר - העברה לדף התחברות
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // אין צורך בניקוי משאבים
    }
}