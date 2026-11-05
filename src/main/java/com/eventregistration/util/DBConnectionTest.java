
package com.eventregistration.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnectionTest {

    public static void main(String[] args) {

        try {
            Connection con = DBConnection.getConnection();

            System.out.println("Oracle database connected successfully!");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                "SELECT VENUE_ID, VENUE_NAME, VENUE_TYPE " +
                "FROM OERS_VENUES ORDER BY VENUE_ID"
            );

            while (rs.next()) {
                System.out.println(
                    rs.getInt("VENUE_ID") + " - " +
                    rs.getString("VENUE_NAME") + " - " +
                    rs.getString("VENUE_TYPE")
                );
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
