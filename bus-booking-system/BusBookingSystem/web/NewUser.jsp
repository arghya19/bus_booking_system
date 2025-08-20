<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.busbooking.utils.FetchID" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bus Booking System - New User</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: #1e1e2f;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #f1f1f1;
        }

        .form-container {
            background: #2c2c3c;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
            width: 800px;
            max-width: 95%;
        }

        .form-container h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 10px;
            color: #00bcd4;
            letter-spacing: 1px;
        }

        .form-container h2 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 25px;
            color: #ffffff;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px 20px;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"],
        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background: #3d3d4f;
            color: #fff;
            font-size: 15px;
            box-sizing: border-box;
        }

        input::placeholder,
        textarea::placeholder,
        select {
            color: #b0b0b0;
        }

        textarea {
            resize: none;
            grid-column: span 2;
        }

        .full-width {
            grid-column: span 2;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        input[type="submit"],
        input[type="reset"] {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"] {
            background: #00bcd4;
            color: #fff;
        }

        input[type="reset"] {
            background: #ff5252;
            color: #fff;
        }

        input[type="submit"]:hover {
            background: #0097a7;
        }

        input[type="reset"]:hover {
            background: #e53935;
        }

        .back-link {
            text-align: center;
            margin-top: 10px;
        }

        .back-link a {
            text-decoration: none;
            color: #64b5f6;
            font-size: 14px;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>

</head>
<body>

    <div class="form-container">
        <h1>Bus Booking System</h1>
        <h2>Create New Account</h2>

        <form method="post" action="RegisterUserServlet" id="registerForm">
            <input type="text" name="uid" value="<%= FetchID.getNextUID() %>" readonly>
            <input type="text" name="uname" placeholder="Username" required />

            <input type="text" name="fname" placeholder="First Name" required />
            <input type="text" name="lname" placeholder="Last Name" required />

            <select name="gender" required>
                <option value="" disabled selected>Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
            <textarea name="address" rows="2" placeholder="Location / Address" required></textarea>

            <input type="email" name="email" placeholder="Email" required />
            <input type="tel" name="phone" placeholder="Phone Number" required />

            <input type="password" name="password" placeholder="Password" required />
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required />
  <%
    String error = (String) session.getAttribute("error");
    if (error != null) {
%>
    <p id="error-msg" style="color: red; text-align: center; margin-top: 10px;"><%= error %></p>
<%
        session.removeAttribute("error");
    }
%>


            <div class="btn-group full-width">
                <input type="submit" value="Register" />
                <input type="reset" value="Clear" />
            </div>

            <div class="back-link full-width">
                <a href="login.jsp">Back to Login</a>
            </div>
        </form>
    </div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById('registerForm');
        const resetBtn = form.querySelector('input[type="reset"]');

        resetBtn.addEventListener('click', function () {
            // Remove error message from the page
            const errorElement = document.getElementById('error-msg');
            if (errorElement) {
                errorElement.style.display = 'none';
            }
        });
    });
</script>


</body>
</html>
