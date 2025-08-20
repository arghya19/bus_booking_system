package com.busbooking.utils;

// DBConnection.java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // MySQL database details
        String url = "jdbc:mysql://localhost:3308/bus_booking";
        String username = "root";
        String password = ""; // WAMP default is empty unless you set one

        // Connect and return
        return DriverManager.getConnection(url, username, password);
    }
    
}
