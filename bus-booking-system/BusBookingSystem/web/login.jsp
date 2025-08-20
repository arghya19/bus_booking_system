<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bus Booking System - Login</title>
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

        .login-container {
            background: #2c2c3c;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
            width: 400px;
        }

        .login-container h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 10px;
            color: #00bcd4;
            letter-spacing: 1px;
        }

        .login-container h2 {
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

        .forgot-password {
            text-align: right;
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .forgot-password a {
            text-decoration: none;
            color: #64b5f6;
            font-size: 14px;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        .create-account {
            text-align: center;
            margin-top: 20px;
        }

        .create-account a {
            text-decoration: none;
            color: #64b5f6;
            font-size: 14px;
        }

        .create-account a:hover {
            text-decoration: underline;
        }

        .error-msg {
            text-align: center;
            color: #ff6b6b;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h1>Bus Booking System</h1>
        <h2>Login</h2>

        <% 
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Invalid username or password</div>
        <% 
            } else if ("2".equals(error)) {
        %>
            <div class="error-msg" id="errorMsg">Something went wrong. Please try again.</div>
        <% 
            }
        %>

        <form method="post" action="LoginServlet" onreset="clearError()">
            <input type="text" name="username" placeholder="Username" required />
            <input type="password" name="password" placeholder="Password" required />

            <div class="forgot-password">
                <a href="Forgot_pass.jsp">Forgot Password?</a>
            </div>

            <div class="btn-group">
                <input type="submit" value="Login" />
                <input type="reset" value="Clear" />
            </div>

            <div class="create-account">
                <a href="NewUser.jsp">Create an account?</a>
            </div>
        </form>
    </div>

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
