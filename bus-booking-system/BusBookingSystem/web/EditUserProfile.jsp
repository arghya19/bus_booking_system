<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.utils.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String uid = request.getParameter("uid");
    String fname = "", lname = "", gen = "", email = "", phno = "", addrs = "";
    boolean userFound = false;

    if (uid != null && !uid.trim().isEmpty()) {
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM userdetails WHERE uid = ?");
            ps.setString(1, uid.trim());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userFound = true;
                fname = rs.getString("fname");
                lname = rs.getString("lname");
                gen = rs.getString("gen");
                email = rs.getString("email");
                phno = rs.getString("phno");
                addrs = rs.getString("addrs");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Server-side logging
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User Profile</title>
    <style>
        body {
            background-color: #131328;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #f1f1f1;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #054a6b;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }

        .header h2 {
            margin: 0;
        }

        .btn {
            background-color: #14b8a6;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .form-box {
            background-color: #252538;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.5);
            width: 400px;
        }

        .form-box h3 {
            text-align: center;
            margin-bottom: 20px;
            color: #00d9ff;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        input[type="text"], input[type="email"], select {
            width: 100%;
            padding: 9px;
            background-color: #373754;
            border: none;
            border-radius: 4px;
            color: white;
        }

        .search-bar {
            display: flex;
            justify-content: center;
            margin: 20px;
            gap: 10px;
        }

        .search-bar input[type="text"] {
            width: 250px;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .submit-btn, .clear-btn {
            flex: 1;
            padding: 10px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .submit-btn {
            background-color: #00c2e0;
            color: white;
        }

        .submit-btn:hover {
            background-color: #00a7c2;
        }

        .clear-btn {
            background-color: #ff7675;
            color: white;
        }

        .clear-btn:hover {
            background-color: #e05555;
        }

        .message {
            text-align: center;
            color: #ff5252;
            font-weight: bold;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Edit User Profile</h2>
        <a href="Admin_dashboard.jsp"><button class="btn">Back to Dashboard</button></a>
    </div>

    <div class="search-bar">
        <form method="get" action="EditUserProfile.jsp">
            <input type="text" name="uid" placeholder="Enter User ID" required value="<%= uid != null ? uid : "" %>">
            <button type="submit" class="btn">Search</button>
        </form>
    </div>

    <% if (uid != null && !userFound) { %>
        <div class="message">No user found with ID: <%= uid %></div>
    <% } %>

    <% if (userFound) { %>
    <div class="container">
        <div class="form-box">
            <h3>Update User Information</h3>
            <form action="UpdateUserServlet" method="post" id="editForm">
                <input type="hidden" name="uid" value="<%= uid != null ? uid : "" %>">

                <!-- MODIFIED SECTION: First Name and Last Name side by side -->
                <div style="display: flex; gap: 10px;">
                    <div class="form-group" style="flex: 1; margin-bottom: 0;">
                        <label for="fname">First Name:</label>
                        <input type="text" name="fname" id="fname" value="<%= fname %>" required>
                    </div>

                    <div class="form-group" style="flex: 1; margin-bottom: 0;">
                        <label for="lname">Last Name:</label>
                        <input type="text" name="lname" id="lname" value="<%= lname %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="gen">Gender:</label>
                    <select name="gen" id="gen" required>
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equalsIgnoreCase(gen) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equalsIgnoreCase(gen) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equalsIgnoreCase(gen) ? "selected" : "" %>>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="email">Email Address:</label>
                    <input type="email" name="email" id="email" value="<%= email %>" required title="Please enter a valid email">
                </div>

                <div class="form-group">
                    <label for="phno">Phone Number:</label>
                    <input type="text" name="phno" id="phno" value="<%= phno %>" required pattern="^[0-9]{10}$" title="Enter a 10-digit phone number">
                </div>

                <div class="form-group">
                    <label for="addrs">Address:</label>
                    <input type="text" name="addrs" id="addrs" value="<%= addrs %>" required>
                </div>

                <div class="btn-group">
                    <button type="submit" class="submit-btn">Update Profile</button>
                    <button type="button" class="clear-btn" onclick="clearForm()">Clear</button>
                </div>
            </form>
        </div>
    </div>
    <% } %>

    <script>
        function clearForm() {
            const form = document.getElementById("editForm");
            if (!form) return;
            form.reset();
            form.querySelectorAll("input[type='text'], input[type='email'], input[type='hidden']").forEach(el => el.value = "");
            form.querySelector("select[name='gen']").selectedIndex = 0;
        }
    </script>
</body>
</html>
