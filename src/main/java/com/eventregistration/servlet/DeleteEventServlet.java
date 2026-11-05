
package com.eventregistration.servlet;

import java.io.IOException;

import com.eventregistration.dao.EventDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete-event")
public class DeleteEventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String context = request.getContextPath();
        HttpSession session = request.getSession(false);

        // Only admins can delete events.
        if (session == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(context + "/login.jsp?error=1");
            return;
        }

        try {
            int eventId = Integer.parseInt(
                    request.getParameter("eventId"));

            if (eventId <= 0) {
                response.sendRedirect(
                        context + "/admin-manage-events.jsp?delete=failed");
                return;
            }

            EventDAO dao = new EventDAO();
            boolean deleted = dao.deleteEvent(eventId);

            if (deleted) {
                response.sendRedirect(
                        context + "/admin-manage-events.jsp?delete=success");
            } else {
                response.sendRedirect(
                        context + "/admin-manage-events.jsp?delete=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(
                    context + "/admin-manage-events.jsp?delete=failed");
        }
    }
}