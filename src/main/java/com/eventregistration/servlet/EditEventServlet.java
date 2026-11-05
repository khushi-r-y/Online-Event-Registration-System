
package com.eventregistration.servlet;

import java.io.IOException;

import com.eventregistration.dao.EventDAO;
import com.eventregistration.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/edit-event")
public class EditEventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(
                    request.getParameter("id"));

            EventDAO dao = new EventDAO();
            Event event = dao.getEventById(eventId);

            if (event == null) {
                response.sendRedirect(
                        request.getContextPath() + "/events.jsp");
                return;
            }

            request.setAttribute("event", event);

            request.getRequestDispatcher("/edit-event.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(
                    request.getContextPath() + "/events.jsp");
        }
    }
}
