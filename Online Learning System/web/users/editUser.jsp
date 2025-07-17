<%-- File: web/users/editUser.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User - Admin Panel</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1 { color: #333; }
            form { border: 1px solid #ccc; padding: 20px; border-radius: 5px; background-color: #f9f9f9; max-width: 600px; margin: 20px auto; }
            form div { margin-bottom: 15px; }
            form label { display: block; margin-bottom: 5px; font-weight: bold; }
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
            .error-message { color: red; margin-bottom: 10px; }
            .success-message { color: green; margin-bottom: 10px; }
            .back-link { display: block; margin-top: 15px; text-align: center; }
        </style>
    </head>
    <body>
        <h1>Edit User</h1>

        <% User user = (User) request.getAttribute("user"); %>
        <% if (user != null) { %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <p class="error-message">${requestScope.errorMessage}</p>
            <% } %>
            <% if (request.getAttribute("successMessage") != null) { %>
                <p class="success-message">${requestScope.successMessage}</p>
            <% } %>

            <form action="${pageContext.request.contextPath}/admin/editUser" method="post">
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                <div>
                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" value="<%= user.getFullName() %>" readonly style="background-color: #eee;">
                </div>
                <div>
                    <label for="email">Email:</label>
                    <input type="email" id="email" value="<%= user.getEmail() %>" readonly style="background-color: #eee;">
                </div>
                
                <div>
                    <label for="role">Role:</label>
                    <select id="role" name="role" required>
                        <option value="User" <%= "User".equals(user.getRole()) ? "selected" : "" %>>User</option>
                        <option value="Admin" <%= "Admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                        </select>
                </div>
                <div>
                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <option value="true" <%= user.isStatus() ? "selected" : "" %>>Active</option>
                        <option value="false" <%= !user.isStatus() ? "selected" : "" %>>Inactive</option>
                    </select>
                </div>
                
                <div>
                    <input type="submit" value="Update User">
                </div>
            </form>
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/admin/userDetails?userId=<%= user.getUserId() %>">Back to User Details</a>
            </div>
        <% } else { %>
            <p>User not found or an error occurred.</p>
            <a href="${pageContext.request.contextPath}/admin/users">Back to Users List</a>
        <% } %>
    </body>
</html>