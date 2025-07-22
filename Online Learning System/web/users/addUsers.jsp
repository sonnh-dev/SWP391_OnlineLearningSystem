<%-- File: web/users/addUser.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New User - Admin Panel</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h1 {
                color: #333;
            }
            form {
                border: 1px solid #ccc;
                padding: 20px;
                border-radius: 5px;
                background-color: #f9f9f9;
                max-width: 600px;
                margin: 20px auto;
            }
            form div {
                margin-bottom: 15px;
            }
            form label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            form input[type="text"],
            form input[type="email"],
            form input[type="tel"],
            form input[type="date"],
            form select {
                width: calc(100% - 12px);
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            form input[type="submit"] {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            form input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .error-message {
                color: red;
                margin-bottom: 10px;
            }
            .success-message {
                color: green;
                margin-bottom: 10px;
            }
            .back-link {
                display: block;
                margin-top: 15px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Add New User</h1>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="error-message">${requestScope.errorMessage}</p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
        <p class="success-message">${requestScope.successMessage}</p>
        <% }%>

        <form action="${pageContext.request.contextPath}/admin/addUsers" method="post">
            <div>
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            <div>
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            <div>
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div>
                <label for="phoneNumber">Mobile:</label>
                <input type="tel" id="phoneNumber" name="phoneNumber">
            </div>
            <div>
                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="User">User</option>
                    <option value="Admin">Admin</option>
                </select>
            </div>
            <div>
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
            </div>
            <div>
                <label for="address">Address:</label>
                <input type="text" id="address" name="address">
            </div>
            <div>
                <label for="dateOfBirth">Date of Birth:</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth">
            </div>

            <div>
                <input type="submit" value="Add User">
            </div>
        </form>
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/admin/users">Back to Users List</a>
        </div>
         <%@include file="../includes/foot.jsp" %>
    </body>
</html>