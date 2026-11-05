
package com.eventregistration.servlet;

import java.io.IOException;
import java.util.List;

import com.eventregistration.dao.RegistrationDAO;
import com.eventregistration.model.Registration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-registrations")
public class MyRegistrationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        RegistrationDAO registrationDAO = new RegistrationDAO();

        List<Registration> registrations =
                registrationDAO.getRegistrationsByUser(userId);

        request.setAttribute("registrations", registrations);

        request.getRequestDispatcher("/my-registrations.jsp")
               .forward(request, response);
    }
}
