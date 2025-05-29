<%-- 
    Document   : register
    Created on : 29 May 2025, 14:09:04
    Author     : ADMIN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Account</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #0047ab;
        }

        .register-container {
            width: 600px;
            background-color: #d9d9d9;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .register-header {
            background-color: #757575;
            padding: 20px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
        }

        .register-form {
            padding: 30px;
            display: flex;
            flex-wrap: wrap;
            column-gap: 40px;
            row-gap: 20px;
        }

        .form-group {
            width: 45%;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: none;
            background-color: #fff;
        }

        .register-button {
            width: 100%;
            padding: 15px;
            background-color: #33b5ff;
            color: #000;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }

        .login-link {
            text-align: center;
            padding: 10px;
            font-size: 12px;
        }

        .login-link a {
            color: #0000ff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">Register Account</div>
        <form action="register" method="post" class="register-form">
            <div class="form-group">
                <label for="fullName">Full name</label>
                <input type="text" id="fullName" name="fullName" required />
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required />
            </div>
            <div class="form-group">
                <label for="phone">Phone number</label>
                <input type="text" id="phone" name="phone" required />
            </div>
            <div class="form-group">
                <label for="gender">Gender</label>
                <select id="gender" name="gender">
                    <option value="Male" selected>Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div style="width: 100%;">
                <button type="submit" class="register-button">Register</button>
            </div>
        </form>
        <div class="login-link">
            Already have account? <a href="login.jsp">Return to login page</a>
        </div>
    </div>
</body>
</html>

