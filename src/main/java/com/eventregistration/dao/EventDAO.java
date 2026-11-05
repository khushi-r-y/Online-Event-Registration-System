
package com.eventregistration.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.eventregistration.model.Event;
import com.eventregistration.util.DBConnection;

public class EventDAO {

    // CREATE: Add a new event
    public boolean addEvent(Event event) {

        String sql = "INSERT INTO OERS_EVENTS " +
                "(EVENT_ID, EVENT_TITLE, EVENT_DESCRIPTION, EVENT_DATE, " +
                "VENUE_ID, MAX_CAPACITY, STATUS) " +
                "VALUES (OERS_EVENTS_SEQ.NEXTVAL, ?, ?, " +
                "TO_DATE(?, 'YYYY-MM-DD'), ?, ?, 'ACTIVE')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, event.getEventTitle());
            ps.setString(2, event.getEventDescription());
            ps.setString(3, event.getEventDate());
            ps.setInt(4, event.getVenueId());
            ps.setInt(5, event.getMaxCapacity());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // READ: Get all active events
    public List<Event> getAllActiveEvents() {

        List<Event> events = new ArrayList<>();

        String sql = "SELECT E.EVENT_ID, E.EVENT_TITLE, " +
                "E.EVENT_DESCRIPTION, E.EVENT_DATE, E.VENUE_ID, " +
                "V.VENUE_NAME, E.MAX_CAPACITY, E.STATUS " +
                "FROM OERS_EVENTS E " +
                "JOIN OERS_VENUES V ON E.VENUE_ID = V.VENUE_ID " +
                "WHERE E.STATUS = 'ACTIVE' " +
                "ORDER BY E.EVENT_DATE";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();

                event.setEventId(rs.getInt("EVENT_ID"));
                event.setEventTitle(rs.getString("EVENT_TITLE"));
                event.setEventDescription(
                        rs.getString("EVENT_DESCRIPTION"));
                event.setEventDate(rs.getString("EVENT_DATE"));
                event.setVenueId(rs.getInt("VENUE_ID"));
                event.setVenueName(rs.getString("VENUE_NAME"));
                event.setMaxCapacity(rs.getInt("MAX_CAPACITY"));
                event.setStatus(rs.getString("STATUS"));

                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }

    // READ: Get one active event by ID
    public Event getEventById(int eventId) {

        String sql = "SELECT E.EVENT_ID, E.EVENT_TITLE, " +
                "E.EVENT_DESCRIPTION, E.EVENT_DATE, E.VENUE_ID, " +
                "V.VENUE_NAME, E.MAX_CAPACITY, E.STATUS " +
                "FROM OERS_EVENTS E " +
                "JOIN OERS_VENUES V ON E.VENUE_ID = V.VENUE_ID " +
                "WHERE E.EVENT_ID = ? AND E.STATUS = 'ACTIVE'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Event event = new Event();

                    event.setEventId(rs.getInt("EVENT_ID"));
                    event.setEventTitle(rs.getString("EVENT_TITLE"));
                    event.setEventDescription(
                            rs.getString("EVENT_DESCRIPTION"));
                    event.setEventDate(rs.getString("EVENT_DATE"));
                    event.setVenueId(rs.getInt("VENUE_ID"));
                    event.setVenueName(rs.getString("VENUE_NAME"));
                    event.setMaxCapacity(rs.getInt("MAX_CAPACITY"));
                    event.setStatus(rs.getString("STATUS"));

                    return event;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // UPDATE: Edit an existing active event
    public boolean updateEvent(Event event) {

        String sql = "UPDATE OERS_EVENTS SET " +
                "EVENT_TITLE = ?, EVENT_DESCRIPTION = ?, " +
                "EVENT_DATE = TO_DATE(?, 'YYYY-MM-DD'), " +
                "VENUE_ID = ?, MAX_CAPACITY = ? " +
                "WHERE EVENT_ID = ? AND STATUS = 'ACTIVE'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, event.getEventTitle());
            ps.setString(2, event.getEventDescription());
            ps.setString(3, event.getEventDate());
            ps.setInt(4, event.getVenueId());
            ps.setInt(5, event.getMaxCapacity());
            ps.setInt(6, event.getEventId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE: Soft-delete an event
    public boolean deleteEvent(int eventId) {

        String sql = "UPDATE OERS_EVENTS SET STATUS = 'DELETED' " +
                "WHERE EVENT_ID = ? AND STATUS = 'ACTIVE'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
