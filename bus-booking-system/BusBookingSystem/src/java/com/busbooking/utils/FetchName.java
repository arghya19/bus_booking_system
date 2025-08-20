package com.busbooking.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FetchName {

    public static String getFullNameByUsername(String uname) {
        String fullName = null;

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT fname, lname FROM userdetails WHERE uname = ?"
            );
            ps.setString(1, uname);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String firstName = rs.getString("fname");
                String lastName = rs.getString("lname");
                fullName = firstName + " " + lastName;
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace(); // Log properly in production
        }

        return fullName != null ? fullName : "User";
    }
}

