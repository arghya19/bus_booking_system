<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.busbooking.utils.DBConnection" %>
<%
    HttpSession currentSession = request.getSession(false);
    String username = (currentSession != null) ? (String) currentSession.getAttribute("username") : null;

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>



<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Contact Us</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0D0C33;
            color: white;
        }

        .navbar {
            background-color: #005B94;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            margin: 0;
            color: white;
        }

        .navbar .buttons {
            display: flex;
            gap: 10px;
        }

        .nav-link {
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            color: white;
            transition: background-color 0.3s;
        }

        .nav-link.green {
            background-color: #00C896;
        }

        .nav-link.red {
            background-color: #FF4D4D;
        }

        .nav-link:hover {
            opacity: 0.9;
        }

        .contact-box {
            max-width: 550px;
            background-color: #1E1B47;
            margin: 60px auto;
            padding-left: 40px;
            padding-right: 40px;
            padding-top: 20px;
            padding-bottom: 20px;
            border-radius: 20px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.3);
        }

        .contact-box h2 {
            text-align: center;
            color: #00D9FF;
            margin-bottom: 10px;
        }

        label {
            font-weight: bold;
            margin-bottom: 6px;
            display: block;
        }

        textarea {
    width: 100%;
    padding: 12px;
    background-color: #2E2B5A;
    border: 1px solid #444;
    border-radius: 8px;
    color: white;
    font-size: 15px;
    margin-bottom: 30px;
    resize: none; /* ← This line disables resizing */
    box-sizing: border-box;
}


        .btn-group {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .btn {
            padding: 10px 30px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-green {
            background-color: #00bfa6;
        }

        .btn-red {
            background-color: #e63946;
        }

        .btn:hover {
            opacity: 0.9;
        }
        .error-msg {
            text-align: center;
            color: #ff6b6b;
            margin-bottom: 15px;
        }

        .footer {
            text-align: center;
            margin-top: 50px;
            font-size: 14px;
            color: #aaa;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Contact Us</h1>
        <div class="buttons">
            <a href="User_dashboard.jsp" class="nav-link green">Dashboard</a>
            <a href="login.jsp" class="nav-link red">Logout</a>
        </div>
    </div>

    <div class="contact-box">
        <div style="margin-top: 10px;">
    <h2 style="text-align: center; color: #00D9FF;">Pending Requests</h2>
    <table border="1" style="width: 100%; margin-top: 20px; border-collapse: collapse; background-color: #1E1B47; color: white; text-align: center;">
        <tr style="background-color: #005B94;">
            <th>Tracking ID</th>
            <th>Message</th>
            <th>Status</th>
        </tr>
        <%
            try {
                Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM contactus WHERE status = 'pending'");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("uid") %></td>
            <td><%= rs.getString("message") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error loading pending requests.</td></tr>");
                e.printStackTrace();
            }
        %>
    </table>
</div>
        <h2>Send Us a Message</h2>
        <% 
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">User not found!</div>
        <% 
            } else if ("2".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Previous query status: pending</div>
        <% 
            } else if ("3".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Something went wrong!</div>
        <%
            }
        %>
        
        <form action="Contact" method="post">
            <label for="message">Your Message</label>
            <textarea id="message" name="message" rows="5" required></textarea>

            <div class="btn-group">
                <input type="submit" class="btn btn-green" value="Send">
                <input type="reset" class="btn btn-red" value="Clear">
            </div>
        </form>
        
    </div>

    <div class="footer">
        &copy; 2025 Bus Booking System. All rights reserved.
    </div>
<script>
    document.querySelector('.btn-red').addEventListener('click', function () {
        const errorDiv = document.getElementById('errorMsg');
        if (errorDiv) {
            errorDiv.style.display = 'none';
        }

        // Remove ?error=... from URL without reloading
        const url = new URL(window.location);
        url.searchParams.delete('error');
        window.history.replaceState({}, document.title, url);
    });
</script>

</body>
</html>
