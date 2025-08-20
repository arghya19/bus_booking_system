<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Bus Booking System</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #1e1e2f;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #f1f1f1;
        }

        .navbar {
            background-color: #064b6b;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            margin: 0;
            font-size: 22px;
            color: #ffffff;
        }

        .logout-btn {
            background-color: #ff5252;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .dashboard-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            padding: 50px 20px;
            flex-wrap: wrap;
        }

        .card {
            background-color: #2c2c3c;
            padding: 30px;
            border-radius: 12px;
            width: 250px;
            text-decoration: none;
            color: #ffffff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.8);
            cursor: pointer;
        }

        .card h3 {
            margin-bottom: 15px;
            color: #00bcd4;
            font-size: 20px;
        }

        .card p {
            font-size: 14px;
            color: #d0d0d0;
        }

        .footer {
            text-align: center;
            padding: 30px 0;
            color: #888;
        }

        @media (max-width: 900px) {
            .dashboard-container {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>Welcome, Admin!</h2>
        <form action="login.jsp" method="post" style="margin: 0;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>

    <div class="dashboard-container">
        <a href="EditUserProfile.jsp" class="card">
            <h3>Edit User Profile</h3>
            <p>Manage user profiles including updates to their personal and contact information.</p>
        </a>

        <a href="ConfirmTicketBooking.jsp" class="card">
            <h3>Confirm Ticket Bookings</h3>
            <p>Review and confirm all pending ticket booking requests submitted by users.</p>
        </a>

        <a href="ConfirmQueries.jsp" class="card">
            <h3>Show All Queries</h3>
            <p>View and respond to user support queries and requests submitted through the system.</p>
        </a>
    </div>

    <div class="footer">
        © 2025 Bus Booking System. All rights reserved.
    </div>

</body>
</html>
