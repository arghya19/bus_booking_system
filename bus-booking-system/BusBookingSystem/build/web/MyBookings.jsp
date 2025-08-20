<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.busbooking.model.Booking" %>
<%@ page import="com.busbooking.utils.FetchBookings" %>
<%
    String username = (String) session.getAttribute("username");

    if (username == null || username.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }
    String uid = FetchBookings.getUID(username);

    // Fetch bookings for the user (replace with actual logic)
    List<Booking> bookings = FetchBookings.getBookingsByUID(uid);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1e1e2f;
            color: #f0f0f0;
        }

        header {
            background: #0f4c75;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
            font-size: 22px;
        }

        .back-btn {
            background-color: #00bfa6;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        .back-btn:hover {
            background-color: #009e8f;
        }

        .container {
            padding: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #2d2d44;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 16px;
            text-align: left;
        }

        th {
            background-color: #0f4c75;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #3a3a55;
        }

        tr:hover {
            background-color: #444464;
        }

        footer {
            text-align: center;
            color: #888;
            margin-top: 40px;
            padding-bottom: 30px;
        }

        .no-data {
            text-align: center;
            padding: 30px;
            font-size: 18px;
            color: #bbb;
        }
    </style>
</head>
<body>

<header>
    <h1>My Bookings</h1>
    <a href="User_dashboard.jsp" class="back-btn">Back to Dashboard</a>
</header>

<div class="container">
    <%
        if (bookings == null || bookings.isEmpty()) {
    %>
        <div class="no-data">You have no bookings yet.</div>
    <%
        } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Source</th>
                    <th>Destination</th>
                    <th>Date</th>
                    <th>Bus Departure Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Booking booking : bookings) {
            %>
                <tr>
    <td><%= booking.getBid() %></td>
    <td><%= booking.getFrom() %></td>
    <td><%= booking.getTo() %></td>
    <td><%= booking.getDate() %></td>
    <td><%= booking.getTime() %></td>
    <td><%= booking.getStatus() %></td>
</tr>

            <%
                }
            %>
            </tbody>
        </table>
    <%
        }
    %>
</div>

<footer>
    &copy; 2025 Bus Booking System. All rights reserved.
</footer>

</body>
</html>
