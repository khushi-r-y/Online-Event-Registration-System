
package com.eventregistration.servlet;

import java.io.IOException;

import com.eventregistration.dao.UserDAO;
import com.eventregistration.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String requestedRole = request.getParameter("role");
        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.length() < 8) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Enter your name, email, and a password of at least 8 characters."
            );
            return;
        }

        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setRole(requestedRole);
        UserDAO dao = new UserDAO();

        if (dao.registerUser(user)) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?registered=1"
            );
        } else {
            response.sendRedirect(
                request.getContextPath() + "/register.jsp?error=1"
            );
        }
    }
}
