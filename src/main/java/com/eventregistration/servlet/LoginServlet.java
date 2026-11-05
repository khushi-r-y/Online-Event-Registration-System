
package com.eventregistration.servlet;

import java.io.IOException;

import com.eventregistration.dao.UserDAO;
import com.eventregistration.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String loginType = request.getParameter("loginType");

        String context = request.getContextPath();

        // Accept only the two supported login types.
        if (!"STUDENT".equals(loginType)
                && !"ADMIN".equals(loginType)) {
            response.sendRedirect(context + "/index.html");
            return;
        }

        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {
            response.sendRedirect(context + "/"
                    + ("ADMIN".equals(loginType)
                    ? "admin-login.jsp" : "student-login.jsp")
                    + "?error=1");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email.trim(), password);

        // Credentials must be valid, and the account role must
        // match the selected login section.
        String expectedRole = "ADMIN".equals(loginType)
                ? "ADMIN" : "USER";

        if (user == null || user.getRole() == null
                || !expectedRole.equalsIgnoreCase(user.getRole())) {
        	
            String loginPage = "ADMIN".equals(loginType)
                    ? "admin-login.jsp" : "student-login.jsp";

            response.sendRedirect(
                    context + "/" + loginPage + "?error=1");
            return;
        }

        // Prevent an existing session from being reused at login.
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("role", user.getRole());

        if ("ADMIN".equals(user.getRole())) {
            response.sendRedirect(
                    context + "/admin-dashboard.jsp");
        } else {
            response.sendRedirect(context + "/events.jsp");
        }
    }
}
