<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bus Booking System - Forgot Password</title>
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
            width: 400px;
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

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px 0;
            border: none;
            border-radius: 6px;
            background: #3d3d4f;
            color: #fff;
            font-size: 15px;
        }

        input[type="text"]::placeholder,
        input[type="password"]::placeholder {
            color: #b0b0b0;
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
            margin-top: 20px;
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
        <h2>Forgot Password</h2>
        
        <%
    String error = request.getParameter("error");
    if (error != null) {
        String message = "";
        String cssClass = "error-msg"; // default to error class

        switch (error) {
            case "1":
                message = "User not found";
                break;
            case "2":
                message = "Passwords do not match";
                break;
            case "3":
                message = "Password update failed. Please try again.";
                break;
            case "4":
                message = "Something went wrong. Please try again.";
                break;
            case "5":
                message = "Password successfully updated!";
                cssClass = "success-msg"; // success class for success message
                break;
        }
%>
    <div class="<%= cssClass %>" style="text-align: center; margin-bottom: 15px;color: red;">
        <%= message %>
    </div>
<%
    }
%>



        <form method="post" action="ForgotPasswordServlet">
            <input type="text" name="uid" placeholder="Enter your User ID" required />
            <input type="text" name="username" placeholder="Enter your Username" required />
            <input type="password" name="newPassword" placeholder="Enter New Password" required />
            <input type="password" name="confirmPassword" placeholder="Confirm New Password" required />

            <div class="btn-group">
                <input type="submit" value="Submit" />
                <input type="reset" value="Clear" onclick="clearForm()" />
            </div>

            <div class="back-link">
                <a href="login.jsp">Back to Login</a>
            </div>
        </form>
    </div>
<script>
function clearForm() {
    // Reset all form fields
    document.querySelector('form').reset();

    // Remove error or success messages
    document.querySelectorAll('.error-msg, .success-msg').forEach(el => el.remove());

    // Remove 'error' parameter from URL
    const url = new URL(window.location.href);
    url.searchParams.delete('error');
    window.history.replaceState(null, '', url);
}
</script>



</body>
</html>
