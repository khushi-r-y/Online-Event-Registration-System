
package com.eventregistration.servlet;

import java.io.IOException;

import com.eventregistration.dao.RegistrationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register-event")
public class EventRegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String context = request.getContextPath();
        HttpSession session = request.getSession(false);

        // A user must be logged in before registering.
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(context + "/login.jsp");
            return;
        }

        // Only student accounts can register for events.
        String role = (String) session.getAttribute("role");

        if (!"USER".equalsIgnoreCase(role)) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Only student accounts can register for events."
            );
            return;
        }

        try {
            Object userIdObject = session.getAttribute("userId");

            if (!(userIdObject instanceof Integer)) {
                session.invalidate();
                response.sendRedirect(context + "/login.jsp");
                return;
            }

            int userId = (Integer) userIdObject;
            int eventId = Integer.parseInt(
                request.getParameter("eventId")
            );

            if (userId <= 0 || eventId <= 0) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user or event ID."
                );
                return;
            }

            RegistrationDAO dao = new RegistrationDAO();
            String result = dao.registerForEvent(userId, eventId);

            response.sendRedirect(
                context + "/events.jsp?registration=" + result
            );

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid event ID."
            );
        }
    }
}
