package com.eventregistration.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;
import com.eventregistration.model.Registration;

import com.eventregistration.util.DBConnection;

public class RegistrationDAO {

    public String registerForEvent(int userId, int eventId) {

        String checkEvent =
                "SELECT MAX_CAPACITY FROM OERS_EVENTS " +
                "WHERE EVENT_ID = ? AND STATUS = 'ACTIVE' " +
                "FOR UPDATE";

        String checkDuplicate =
                "SELECT REGISTRATION_ID FROM OERS_REGISTRATIONS " +
                "WHERE USER_ID = ? AND EVENT_ID = ? AND STATUS = 'ACTIVE'";

        String countRegistrations =
                "SELECT COUNT(*) FROM OERS_REGISTRATIONS " +
                "WHERE EVENT_ID = ? AND STATUS = 'ACTIVE'";

        String insertRegistration =
                "INSERT INTO OERS_REGISTRATIONS " +
                "(REGISTRATION_ID, USER_ID, EVENT_ID, STATUS) " +
                "VALUES (OERS_REGISTRATIONS_SEQ.NEXTVAL, ?, ?, 'ACTIVE')";

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            int capacity;

            // Check that the event exists and is active.
            try (PreparedStatement ps = con.prepareStatement(checkEvent)) {
                ps.setInt(1, eventId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        con.rollback();
                        return "EVENT_UNAVAILABLE";
                    }

                    capacity = rs.getInt("MAX_CAPACITY");
                }
            }

            // Check whether this student already registered.
            try (PreparedStatement ps = con.prepareStatement(checkDuplicate)) {
                ps.setInt(1, userId);
                ps.setInt(2, eventId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        con.rollback();
                        return "ALREADY_REGISTERED";
                    }
                }
            }

            // Check the number of active registrations.
            try (PreparedStatement ps = con.prepareStatement(countRegistrations)) {
                ps.setInt(1, eventId);

                try (ResultSet rs = ps.executeQuery()) {
                    rs.next();

                    if (rs.getInt(1) >= capacity) {
                        con.rollback();
                        return "EVENT_FULL";
                    }
                }
            }

            // Save the registration.

            // Reactivate an existing cancelled registration, if present.
            String reactivateRegistration =
                    "UPDATE OERS_REGISTRATIONS " +
                    "SET STATUS = 'ACTIVE' " +
                    "WHERE USER_ID = ? AND EVENT_ID = ? " +
                    "AND STATUS = 'CANCELLED'";

            int rowsUpdated;

            try (PreparedStatement ps =
                    con.prepareStatement(reactivateRegistration)) {

                ps.setInt(1, userId);
                ps.setInt(2, eventId);

                rowsUpdated = ps.executeUpdate();
            }

            // If no cancelled registration exists, insert a new one.
            if (rowsUpdated == 0) {
                try (PreparedStatement ps =
                        con.prepareStatement(insertRegistration)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, eventId);
                    ps.executeUpdate();
                }
            }

            con.commit();
            return "SUCCESS";


        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (Exception rollbackError) {
                    rollbackError.printStackTrace();
                }
            }

            e.printStackTrace();
            return "ERROR";

        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public List<Registration> getRegistrationsByUser(int userId) {

        List<Registration> registrations = new ArrayList<>();

        String sql = "SELECT R.REGISTRATION_ID, R.USER_ID, R.EVENT_ID, " +
                     "TO_CHAR(R.REGISTRATION_DATE, 'YYYY-MM-DD HH24:MI:SS') AS REG_DATE, " +
                     "R.STATUS, E.EVENT_TITLE, " +
                     "TO_CHAR(E.EVENT_DATE, 'YYYY-MM-DD') AS EVENT_DATE, " +
                     "V.VENUE_NAME " +
                     "FROM OERS_REGISTRATIONS R " +
                     "JOIN OERS_EVENTS E ON R.EVENT_ID = E.EVENT_ID " +
                     "JOIN OERS_VENUES V ON E.VENUE_ID = V.VENUE_ID " +
                     "WHERE R.USER_ID = ? " +
                     "ORDER BY R.REGISTRATION_DATE DESC";

        try (Connection con = DBConnection.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (java.sql.ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Registration registration = new Registration();

                    registration.setRegistrationId(
                        rs.getInt("REGISTRATION_ID"));

                    registration.setUserId(
                        rs.getInt("USER_ID"));

                    registration.setEventId(
                        rs.getInt("EVENT_ID"));

                    registration.setRegistrationDate(
                        rs.getString("REG_DATE"));

                    registration.setStatus(
                        rs.getString("STATUS"));

                    registration.setEventTitle(
                        rs.getString("EVENT_TITLE"));

                    registration.setEventDate(
                        rs.getString("EVENT_DATE"));

                    registration.setVenueName(
                        rs.getString("VENUE_NAME"));

                    registrations.add(registration);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return registrations;
    }

public boolean cancelRegistration(int registrationId, int userId) {

    String sql = "UPDATE OERS_REGISTRATIONS " +
                 "SET STATUS = 'CANCELLED' " +
                 "WHERE REGISTRATION_ID = ? " +
                 "AND USER_ID = ? " +
                 "AND STATUS = 'ACTIVE'";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, registrationId);
        ps.setInt(2, userId);

        int rowsUpdated = ps.executeUpdate();

        return rowsUpdated == 1;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

}
