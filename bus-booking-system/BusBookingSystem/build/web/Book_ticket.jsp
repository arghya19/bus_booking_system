<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (session != null) ? (String) session.getAttribute("username") : null;
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Ticket</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #12122c;
            color: #f0f0f0;
        }

        header {
            background-color: #065a8e;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
            font-size: 24px;
        }

        .dashboard-btn, .logout-btn {
            padding: 10px 16px;
            border-radius: 6px;
            font-size: 14px;
            text-decoration: none;
            color: white;
            border: none;
            cursor: pointer;
        }

        .dashboard-btn {
            background-color: #00bfa6;
        }

        .dashboard-btn:hover {
            background-color: #009e8f;
        }

        .logout-btn {
            background-color: #e63946;
            margin-left: 10px;
        }

        .logout-btn:hover {
            background-color: #d62828;
        }

        .container {
            max-width: 500px;
            margin: 60px auto;
            background-color: #1e1e3f;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.5);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #00e5ff;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
            color: #cccccc;
        }

        select, input[type="date"] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: none;
            background-color: #2e2e4d;
            color: #ffffff;
            font-size: 14px;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }

        .btn-group input {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 15px;
            border: none;
            cursor: pointer;
        }

        .submit-btn {
            background-color: #00bfa6;
            color: white;
        }

        .submit-btn:hover {
            background-color: #009e8f;
        }

        .clear-btn {
            background-color: #e63946;
            color: white;
        }

        .clear-btn:hover {
            background-color: #d62828;
        }
        
        .error-msg {
            text-align: center;
            color: #ff6b6b;
            margin-bottom: 15px;
        }

        footer {
            text-align: center;
            color: #888;
            margin-top: 50px;
            padding-bottom: 30px;
        }
    </style>
</head>
<body>

<header>
    <h1>Book Your Ticket</h1>
    <div>
        <a href="User_dashboard.jsp" class="dashboard-btn">Dashboard</a>
        <a href="login.jsp" class="logout-btn">Logout</a>
    </div>
</header>

<div class="container">
    <h2>Plan Your Journey!</h2>
    <form action="BookTicketServlet" method="post">
        <input type="hidden" name="username" value="<%= username %>">
        
        <% 
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Username not found!</div>
        <% 
            } else if ("2".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Userid not found!</div>
        <% 
            } else if ("3".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Previous order pending!</div>
        <% 
            } else if ("4".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Something went wrong!</div>
        <% 
            }
        %>
        <label for="from">From:</label>
        <select id="from" name="from" required>
            <option value="">--Select City--</option>
            <option value="Kolkata">Kolkata</option>
            <option value="Mumbai">Mumbai</option>
            <option value="Bangalore">Bangalore</option>
            <option value="Delhi">Delhi</option>
            <option value="Gujrat">Gujrat</option>
        </select>

        <label for="to">To:</label>
        <select id="to" name="to" required>
            <option value="">--Select City--</option>
            <option value="Kolkata">Kolkata</option>
            <option value="Mumbai">Mumbai</option>
            <option value="Bangalore">Bangalore</option>
            <option value="Delhi">Delhi</option>
            <option value="Gujrat">Gujrat</option>
        </select>

        <label for="time">Time and Date:</label>
        <div style="display: flex; gap: 15px; margin-top: 5px;">
            <select id="time" name="time" required style="flex: 1;">
                <option value="">--Select Time--</option>
                <option value="10:00 AM">10:00 AM</option>
                <option value="10:00 PM">10:00 PM</option>
            </select>

            <input type="date" id="travelDate" name="travelDate" required style="flex: 1;">
        </div>

        <div class="btn-group">
            <input type="submit" value="Book Now" class="submit-btn">
            <input type="reset" value="Clear" class="clear-btn" onclick="clearError()">

        </div>
    </form>
</div>

<footer>
    &copy; 2025 Bus Booking System. All rights reserved.
</footer>
<script>
        function clearError() {
            const errDiv = document.getElementById('errorMsg');
            if (errDiv) {
                errDiv.remove();
            }

            if (window.history.replaceState) {
                const url = new URL(window.location.href);
                url.searchParams.delete('error');
                window.history.replaceState({}, document.title, url.pathname);
            }
        }
    </script>
</body>
</html>
