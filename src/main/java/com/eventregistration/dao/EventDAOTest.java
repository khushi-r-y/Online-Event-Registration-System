
package com.eventregistration.dao;

import java.util.List;
import com.eventregistration.model.Event;

public class EventDAOTest {

    public static void main(String[] args) {

        Event event = new Event();

        event.setEventTitle("Java Programming Workshop");
        event.setEventDescription("A workshop for BCA students to learn Java.");
        event.setEventDate("2026-11-15");
        event.setVenueId(100);
        event.setMaxCapacity(50);

        EventDAO dao = new EventDAO();

        boolean added = dao.addEvent(event);

        if (added) {
            System.out.println("Event added successfully!");
        } else {
            System.out.println("Event could not be added.");
        }

        List<Event> events = dao.getAllActiveEvents();

        System.out.println("\nAvailable Events:");

        for (Event e : events) {
            System.out.println(
                e.getEventTitle() + " | " +
                e.getEventDate() + " | " +
                e.getVenueName() + " | Capacity: " +
                e.getMaxCapacity()
            );
        }
    }
}
