
package com.eventregistration.servlet;

import java.io.IOException;

import com.eventregistration.dao.RegistrationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancel-registration")
public class CancelRegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            int registrationId = Integer.parseInt(
                    request.getParameter("registrationId"));

            RegistrationDAO registrationDAO = new RegistrationDAO();

            boolean cancelled = registrationDAO.cancelRegistration(
                    registrationId, userId);

            if (cancelled) {
                response.sendRedirect(
                        "my-registrations?cancellation=SUCCESS");
            } else {
                response.sendRedirect(
                        "my-registrations?cancellation=FAILED");
            }

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid registration ID.");
        }
    }
}
