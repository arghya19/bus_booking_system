<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.utils.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String uid = (String) session.getAttribute("uid");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullname = "";
    try {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT fname, lname FROM userdetails WHERE uname = ?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            fullname = rs.getString("fname") + " " + rs.getString("lname");
        }
        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #131328;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #ffffff;
        }

        .header {
            background-color: #015d82;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .header h2 {
            margin: 0;
            color: #fff;
        }

        .logout-btn {
            background-color: #ff5252;
            color: #fff;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .card-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 40px;
            padding: 60px 20px;
            flex-wrap: wrap;
        }

        .card {
            background-color: #22223a;
            width: 260px;
            padding: 30px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 217, 255, 0.4);
            cursor: pointer;
        }

        .card h3 {
            color: #00d9ff;
            margin-bottom: 12px;
        }

        .card p {
            color: #cccccc;
            font-size: 14px;
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            color: #00d9ff;
            text-decoration: none;
            font-weight: bold;
        }

        .card a:hover {
            text-decoration: underline;
        }

        .footer {
            text-align: center;
            padding: 20px;
            font-size: 14px;
            color: #aaa;
        }

        @media (max-width: 768px) {
            .card-container {
                flex-direction: column;
                align-items: stretch;
                padding: 20px;
            }

            .card {
                width: 90%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>

    <div class="header">
        <h2>Welcome, <%= fullname %>!</h2>
        <form method="post" action="login.jsp">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>

    <div class="card-container">
        <div class="card">
            <h3>My Profile</h3>
            <p>View and edit your personal and contact details.</p>
            <a href="User_profile.jsp?uid=<%= uid %>">Go to Profile</a>
        </div>

        <div class="card">
            <h3>Book Tickets</h3>
            <p>Search and book available bus tickets as per your schedule.</p>
            <a href="Book_ticket.jsp">Book Now</a>
        </div>

        <div class="card">
            <h3>My Bookings</h3>
            <p>Check your past and upcoming bus ticket bookings.</p>
            <a href="MyBookings.jsp">View Bookings</a>
        </div>

        <div class="card">
            <h3>Contact Us</h3>
            <p>Get in touch for any queries, help or suggestions.</p>
            <a href="ContactUs.jsp">Reach Out</a>
        </div>
    </div>

    <div class="footer">
        © 2025 Bus Booking System. All rights reserved.
    </div>

</body>
</html>
