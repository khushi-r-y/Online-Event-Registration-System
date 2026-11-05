
package com.eventregistration.dao;

import java.util.List;

public class VenueDAOTest {

    public static void main(String[] args) {

        VenueDAO dao = new VenueDAO();

        List<String> venues = dao.getAllVenues();

        for (String venue : venues) {
            System.out.println(venue);
        }

        System.out.println("Total venues: " + venues.size());
    }
}
