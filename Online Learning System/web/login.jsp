<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Learning System - Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #004aad;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            display: flex;
            width: 800px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .welcome, .login-box {
            flex: 1;
            background-color: #dcdcdc;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .welcome {
            border-right: 2px solid black;
        }

        .welcome h2 {
            font-size: 18px;
            text-align: center;
            font-weight: bold;
        }

        .welcome p {
            font-size: 0.85em;
            color: gray;
            margin-top: 20px;
        }

        .login-box h2 {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        label {
            align-self: flex-start;
            margin-bottom: 5px;
            font-weight: 500;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #aaa;
            border-radius: 4px;
        }

        .actions {
            width: 100%;
            display: flex;
            justify-content: space-between;
            font-size: 0.85em;
            margin-bottom: 15px;
        }

        .actions a {
            text-decoration: none;
            color: #0056b3;
        }

        .login-btn {
            width: 100%;
            background-color: #33adff;
            color: black;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-btn:hover {
            background-color: #0099ff;
        }

        .error-message {
            color: red;
            font-size: 0.85em;
            margin: -10px 0 10px;
            align-self: flex-start;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="welcome">
        <h2>Welcome to our online learning system</h2>
    </div>
    <div class="login-box">
        <h2>Login</h2>
        <form action="LoginServlet" method="POST" accept-charset="UTF-8">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" required autofocus
                   placeholder="Enter your email"
                   value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            <% if (request.getAttribute("errorEmail") != null) { %>
                <div class="error-message"><%= request.getAttribute("errorEmail") %></div>
            <% } %>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message"><%= request.getAttribute("error") %></div>
            <% } %>

            <div class="actions">
                <a href="#">Forgot password?</a>
                <a href="register.jsp">Register new information</a>
            </div>

            <button type="submit" class="login-btn">Login</button>
        </form>
    </div>
</div>
</body>
</html>
