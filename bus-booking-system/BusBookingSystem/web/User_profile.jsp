<%@ page import="java.sql.*, com.busbooking.utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");

    // If already stored in session, reuse it
    if (username == null) {
        username = (String) session.getAttribute("username");
    } else {
        session.setAttribute("username", username); // Store for future use
    }

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String uid = "", fullname = "", gender = "", address = "", email = "", phone = "";

    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM userdetails WHERE uname = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            uid = rs.getString("uid");
            fullname = rs.getString("fname") + " " + rs.getString("lname");
            gender = rs.getString("gen");
            address = rs.getString("addrs");
            email = rs.getString("email");
            phone = rs.getString("phno");
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
    <title>User Profile</title>
    <style>
        body {
            background-color: #0f0f25;
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #004c7a;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-left {
            display: flex;
            align-items: center;
        }

        .nav-left h1 {
            margin: 0;
            margin-right: 20px;
        }

        .nav-right {
            display: flex;
            align-items: center;
        }

        .dashboard-btn {
            background-color: #00b3b3;
            color: #fff;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            margin-right: 10px;
        }

        .logout-btn {
            background-color: #ff4d4d;
            color: #fff;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
            background-color: #1a1a3d;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 18px rgba(0, 0, 0, 0.3);
        }

        .container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #00e6e6;
        }

        .profile-info p {
            font-size: 18px;
            margin: 10px 0;
            border-bottom: 1px solid #333;
            padding-bottom: 8px;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #888;
        }
    </style>
</head>
<body>
<header>
    <div class="nav-left">
        <h1>User Profile</h1>
    </div>
    <div class="nav-right">
        <a href="User_dashboard.jsp" class="dashboard-btn">Dashboard</a>
        <a href="login.jsp" class="logout-btn">Logout</a>
    </div>
</header>

<div class="container">
    <h2>Welcome, <%= fullname %></h2>
    <div class="profile-info">
        <p><strong>User ID:</strong> <%= uid %></p>
        <p><strong>Username:</strong> <%= username %></p>
        <p><strong>Full Name:</strong> <%= fullname %></p>
        <p><strong>Gender:</strong> <%= gender %></p>
        <p><strong>Address:</strong> <%= address %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Phone Number:</strong> <%= phone %></p>
    </div>
</div>

<footer>
    &copy; 2025 Bus Booking System. All rights reserved.
</footer>
</body>
</html>
