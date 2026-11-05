
package com.eventregistration.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import com.eventregistration.dao.EventDAO;
import com.eventregistration.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-event")
public class UpdateEventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String context = request.getContextPath();
        HttpSession session = request.getSession(false);

        if (session == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(context + "/login.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(
                    request.getParameter("eventId"));
            int venueId = Integer.parseInt(
                    request.getParameter("venueId"));
            int capacity = Integer.parseInt(
                    request.getParameter("maxCapacity"));

            String title = request.getParameter("eventTitle");
            String description = request.getParameter("eventDescription");
            String date = request.getParameter("eventDate");

            if (eventId <= 0 || venueId <= 0 || capacity <= 0 ||
                    title == null || title.trim().isEmpty() ||
                    description == null || description.trim().isEmpty() ||
                    date == null || date.trim().isEmpty()) {

                response.sendRedirect(context + "/events.jsp?edit=invalid");
                return;
            }

            // Validate the date format.
            LocalDate.parse(date);

            Event event = new Event();
            event.setEventId(eventId);
            event.setEventTitle(title.trim());
            event.setEventDescription(description.trim());
            event.setEventDate(date);
            event.setVenueId(venueId);
            event.setMaxCapacity(capacity);

            EventDAO dao = new EventDAO();
            boolean updated = dao.updateEvent(event);

            if (updated) {
                response.sendRedirect(context + "/events.jsp?edit=success");
            } else {
                response.sendRedirect(context + "/events.jsp?edit=failed");
            }

        } catch (NumberFormatException | DateTimeParseException e) {
            response.sendRedirect(context + "/events.jsp?edit=invalid");
        }
    }
}
