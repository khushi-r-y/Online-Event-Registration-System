
package com.eventregistration.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.eventregistration.util.DBConnection;

public class VenueDAO {

    public List<String> getAllVenues() {

        List<String> venues = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                "SELECT VENUE_NAME FROM OERS_VENUES ORDER BY VENUE_ID"
            );

            while (rs.next()) {
                venues.add(rs.getString("VENUE_NAME"));
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return venues;
    }
}
