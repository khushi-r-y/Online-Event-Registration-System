
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

@WebServlet("/add-event")
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Only an administrator can add events.");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        try {
            String title = request.getParameter("eventTitle");
            String description =
                    request.getParameter("eventDescription");
            String dateValue = request.getParameter("eventDate");
            String venueValue = request.getParameter("venueId");
            String capacityValue = request.getParameter("maxCapacity");

            // Validate required fields.
            if (title == null || title.trim().isEmpty()
                    || dateValue == null || dateValue.trim().isEmpty()
                    || venueValue == null || venueValue.trim().isEmpty()
                    || capacityValue == null || capacityValue.trim().isEmpty()) {

                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Please fill in all required fields.");
                return;
            }

            // Reject dates earlier than today.
            LocalDate eventDate = LocalDate.parse(dateValue);

            if (eventDate.isBefore(LocalDate.now())) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-event-form.jsp?error=pastDate");
                return;
            }

            int venueId = Integer.parseInt(venueValue);
            int capacity = Integer.parseInt(capacityValue);

            if (capacity < 1) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Capacity must be at least 1.");
                return;
            }

            Event event = new Event();
            event.setEventTitle(title.trim());
            event.setEventDescription(description);
            event.setEventDate(dateValue);
            event.setVenueId(venueId);
            event.setMaxCapacity(capacity);

            EventDAO dao = new EventDAO();

            if (dao.addEvent(event)) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-event-form.jsp?success=1");
            } else {
                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Could not save the event.");
            }

        } catch (DateTimeParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid event date. Please select a valid date.");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid venue or capacity.");
        }
    }
}
