<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.utils.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Contact Queries</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #0f172a;
            color: white;
        }

.navbar {
    background-color: #0d3b66;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar h1 {
    margin: 0;
    font-size: 24px;
    color: white;
}

.navbar-buttons {
    display: flex;
    gap: 10px; /* Controls spacing between buttons */
}

.navbar-buttons a button {
    background-color: #14b8a6;
    color: white;
    border: none;
    padding: 10px 16px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.navbar-buttons a button:hover {
    background-color: #0f9483;
    transform: translateY(-2px);
}


        .container {
            padding: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #1e293b;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background-color: #0d3b66;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #334155;
        }

        tr:nth-child(odd) {
            background-color: #1e293b;
        }

        td {
            color: white;
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1>Confirm Queries</h1>
    <div class="navbar-buttons">
        <a href="EditUserProfile.jsp"><button>Edit User Profile</button></a>
        <a href="ConfirmTicketBooking.jsp"><button>Confirm Ticket Booking</button></a>
        <a href="Admin_dashboard.jsp"><button>Back to Dashboard</button></a>
    </div>
</div>


<div class="container">
    <h2>Pending Queries</h2>

    <!-- Action Form -->
    <div style="display: flex; justify-content: center; align-items: center; margin-bottom: 20px; gap: 10px;">
        <form action="QueryActionServlet" method="post" style="display: flex; align-items: center; gap: 10px;">
            <input type="text" name="trackid" placeholder="Enter Tracking ID" required
                   style="padding: 10px; border-radius: 5px; border: none; outline: none; background-color: #334155; color: white; width: 200px;"/>

            <button type="submit" name="action" value="approve"
                style="background-color: #14b8a6; color: white; border: none; padding: 10px 16px; border-radius: 5px; cursor: pointer;
                       transition: background-color 0.3s ease, transform 0.2s ease;"
                onmouseover="this.style.backgroundColor='#0ea5e9'; this.style.transform='scale(1.05)'"
                onmouseout="this.style.backgroundColor='#14b8a6'; this.style.transform='scale(1)'">
                Approve
            </button>

            <button type="submit" name="action" value="decline"
                style="background-color: #ef4444; color: white; border: none; padding: 10px 16px; border-radius: 5px; cursor: pointer;
                       transition: background-color 0.3s ease, transform 0.2s ease;"
                onmouseover="this.style.backgroundColor='#dc2626'; this.style.transform='scale(1.05)'"
                onmouseout="this.style.backgroundColor='#ef4444'; this.style.transform='scale(1)'">
                Decline
            </button>
        </form>
    </div>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM contactus WHERE status = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "pending");
            rs = ps.executeQuery();
    %>

    <table>
        <tr>
            <th>UID</th>
            <th>Tracking ID</th>
            <th>Message</th>
            <th>Status</th>
        </tr>
        <%
            boolean hasResults = false;
            while (rs.next()) {
                hasResults = true;
        %>
        <tr>
            <td><%= rs.getString("uid") %></td>
            <td><%= rs.getString("trackid") %></td>
            <td><%= rs.getString("message") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
            }
            if (!hasResults) {
        %>
        <tr>
            <td colspan="4">No pending queries found.</td>
        </tr>
        <% 
            }
        %>
    </table>

    <%
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>
</div>

<%
    String msg = request.getParameter("msg");
%>
<script>
    const msg = "<%= msg != null ? msg : "" %>";
    if (msg === "success") {
        alert("Query action completed successfully.");
    } else if (msg === "fail") {
        alert("No query was updated. Please check the Tracking ID.");
    } else if (msg === "error") {
        alert("An error occurred while processing the request.");
    }
</script>

</body>
</html>
