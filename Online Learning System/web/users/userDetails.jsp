<%-- File: web/users/userDetails.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Details - Admin Panel</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1 { color: #333; }
            .user-details { border: 1px solid #ccc; padding: 20px; border-radius: 5px; background-color: #f9f9f9; max-width: 600px; margin: 20px auto; }
            .user-details p { margin-bottom: 10px; }
            .user-details p strong { display: inline-block; width: 120px; }
            .user-details img { max-width: 150px; height: auto; border-radius: 50%; margin-bottom: 15px; border: 2px solid #ddd;}
            .actions { margin-top: 20px; }
            .actions a { display: inline-block; padding: 10px 15px; margin-right: 10px; text-decoration: none; color: white; border-radius: 5px; }
            .actions .edit-btn { background-color: #ffc107; }
            .actions .edit-btn:hover { background-color: #e0a800; }
            .actions .add-btn { background-color: #28a745; }
            .actions .add-btn:hover { background-color: #218838; }
            .actions .back-btn { background-color: #6c757d; }
            .actions .back-btn:hover { background-color: #5a6268; }
        </style>
    </head>
    <body>
        <h1>User Details</h1>

        <% User user = (User) request.getAttribute("user"); %>
        <% if (user != null) { %>
            <div class="user-details">
                <% if (user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty()) { %>
                    <p><img src="${pageContext.request.contextPath}/<%= user.getAvatarUrl() %>" alt="User Avatar"></p>
                <% } %>
                <p><strong>ID:</strong> <%= user.getUserId() %></p>
                <p><strong>Full Name:</strong> <%= user.getFullName() %></p>
                <p><strong>Gender:</strong> <%= user.getGender() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Mobile:</strong> <%= user.getPhoneNumber() %></p>
                <p><strong>Role:</strong> <%= user.getRole() %></p>
                <p><strong>Address:</strong> <%= user.getAddress() != null ? user.getAddress() : "N/A" %></p>
                <p><strong>Date of Birth:</strong> <%= user.getDateOfBirth() != null ? user.getDateOfBirth() : "N/A" %></p>
                <p><strong>Status:</strong> <%= user.isStatus() ? "Active" : "Inactive" %></p>
                
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/admin/editUser?userId=<%= user.getUserId() %>" class="edit-btn">Edit User</a>
                    <a href="${pageContext.request.contextPath}/admin/addUsers" class="add-btn">Add New User</a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="back-btn">Back to List</a>
                </div>
            </div>
        <% } else { %>
            <p>User not found or an error occurred.</p>
            <a href="${pageContext.request.contextPath}/admin/users">Back to Users List</a>
        <% } %>
         <%@include file="../includes/foot.jsp" %>
    </body>
</html>