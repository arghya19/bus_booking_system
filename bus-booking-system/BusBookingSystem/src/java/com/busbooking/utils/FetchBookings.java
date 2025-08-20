//FetchBookings.java
package com.busbooking.utils;

import com.busbooking.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FetchBookings {
    public static String getUID(String uname) {
        String uid = null;

        try {
            if (uname != null) {
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                    "SELECT uid FROM userdetails WHERE uname = ?"
                );
                stmt.setString(1, uname);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    uid = rs.getString("uid");
                }

                conn.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return uid;
    }
    public static List<Booking> getBookingsByUID(String uid) {
        List<Booking> bookings = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Connect to the DB
            conn = DBConnection.getConnection();
            String query = "SELECT * FROM ticketbooking WHERE uid = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, uid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBid(rs.getString("bid"));
                booking.setFrom(rs.getString("from"));
                booking.setTo(rs.getString("to"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setStatus(rs.getString("status"));

                // Add any other fields you need

                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace(); // You may log this instead
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return bookings;
    }
}
