<%-- File: web/users/usersList.jsp --%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users List - Admin Panel</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h1 {
                color: #333;
            }
            .filter-search-form {
                margin-bottom: 20px;
                padding: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
            }
            .filter-search-form label {
                margin-right: 10px;
            }
            .filter-search-form select, .filter-search-form input[type="text"] {
                padding: 5px;
                margin-right: 10px;
                border: 1px solid #ddd;
                border-radius: 3px;
            }
            .filter-search-form button {
                padding: 8px 15px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 3px;
                cursor: pointer;
            }
            .filter-search-form button:hover {
                background-color: #0056b3;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
                cursor: pointer;
            }
            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a, .pagination span {
                display: inline-block;
                padding: 8px 12px;
                margin: 0 5px;
                border: 1px solid #ddd;
                text-decoration: none;
                color: #007bff;
                border-radius: 3px;
            }
            .pagination a:hover {
                background-color: #f2f2f2;
            }
            .pagination span.current-page {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }
            .add-user-btn {
                margin-bottom: 20px;
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
            .add-user-btn:hover {
                background-color: #218838;
            }
        </style>
        <script>
            function applyFiltersAndSort() {
                document.getElementById('userListForm').submit();
            }

            function sortTable(sortBy) {
                const form = document.getElementById('userListForm');
                const currentSortBy = form.elements['sortBy'].value;
                const currentSortOrder = form.elements['sortOrder'].value;

                form.elements['sortBy'].value = sortBy;
                if (currentSortBy === sortBy) {
                    form.elements['sortOrder'].value = (currentSortOrder === 'asc') ? 'desc' : 'asc';
                } else {
                    form.elements['sortOrder'].value = 'asc'; // Default to ascending for new sort column
                }
                form.submit();
            }

            function goToPage(page) {
                const form = document.getElementById('userListForm');
                form.elements['page'].value = page;
                form.submit();
            }
        </script>
    </head>
    <body>
        <h1>Users List</h1>
            <a href="addUsers" class="add-user-btn mb-3">Add New User</a>
        <div class="filter-search-form">
            <form id="userListForm" action="${pageContext.request.contextPath}/admin/users" method="get">
                <label for="genderFilter">Gender:</label>
                <select name="genderFilter" id="genderFilter" onchange="applyFiltersAndSort()">
                    <option value="all" <%= "all".equals(request.getAttribute("genderFilter")) ? "selected" : "" %>>All</option>
                    <option value="Male" <%= "Male".equals(request.getAttribute("genderFilter")) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(request.getAttribute("genderFilter")) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(request.getAttribute("genderFilter")) ? "selected" : "" %>>Other</option>
                </select>

                <label for="roleFilter">Role:</label>
                <select name="roleFilter" id="roleFilter" onchange="applyFiltersAndSort()">
                    <option value="all" <%= "all".equals(request.getAttribute("roleFilter")) ? "selected" : "" %>>All</option>
                    <option value="Admin" <%= "Admin".equals(request.getAttribute("roleFilter")) ? "selected" : "" %>>Admin</option>
                    <option value="User" <%= "User".equals(request.getAttribute("roleFilter")) ? "selected" : "" %>>User</option>
                </select>

                <label for="statusFilter">Status:</label>
                <select name="statusFilter" id="statusFilter" onchange="applyFiltersAndSort()">
                    <option value="all" <%= "all".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>All</option>
                    <option value="true" <%= "true".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Active</option>
                    <option value="false" <%= "false".equals(request.getAttribute("statusFilter")) ? "selected" : "" %>>Inactive</option>
                </select>

                <label for="search">Search:</label>
                <input type="text" name="search" id="search" value="${requestScope.searchKeyword != null ? requestScope.searchKeyword : ''}" placeholder="Enter keyword">
                <select name="searchBy" id="searchBy">
                    <option value="fullName" <%= "fullName".equals(request.getAttribute("searchBy")) ? "selected" : "" %>>Full Name</option>
                    <option value="email" <%= "email".equals(request.getAttribute("searchBy")) ? "selected" : "" %>>Email</option>
                    <option value="mobile" <%= "mobile".equals(request.getAttribute("searchBy")) ? "selected" : "" %>>Mobile</option>
                </select>
                <button type="submit">Search</button>

                <input type="hidden" name="sortBy" id="sortBy" value="${requestScope.sortBy != null ? requestScope.sortBy : ''}">
                <input type="hidden" name="sortOrder" id="sortOrder" value="${requestScope.sortOrder != null ? requestScope.sortOrder : ''}">
                <input type="hidden" name="page" id="page" value="${requestScope.currentPage}">
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th onclick="sortTable('userId')">ID</th>
                    <th onclick="sortTable('firstName')">Full Name</th>
                    <th onclick="sortTable('gender')">Gender</th>
                    <th onclick="sortTable('email')">Email</th>
                    <th onclick="sortTable('phoneNumber')">Mobile</th>
                    <th onclick="sortTable('role')">Role</th>
                    <th onclick="sortTable('status')">Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% List<User> users = (List<User>) request.getAttribute("users"); %>
                <% if (users != null && !users.isEmpty()) { %>
                <% for (User user : users) { %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getGender() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhoneNumber() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.isStatus() ? "Active" : "Inactive" %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/userDetails?userId=<%= user.getUserId() %>">View</a> |
                        <a href="${pageContext.request.contextPath}/admin/editUser?userId=<%= user.getUserId() %>">Edit</a>
                    </td>
                </tr>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="8">No users found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="pagination">
            <% int currentPage = (int) request.getAttribute("currentPage"); %>
            <% int totalPages = (int) request.getAttribute("totalPages"); %>
            <% for (int i = 1; i <= totalPages; i++) { %>
            <% if (i == currentPage) { %>
            <span class="current-page"><%= i %></span>
            <% } else { %>
            <a href="javascript:void(0)" onclick="goToPage(<%= i %>)"><%= i %></a>
            <% } %>
            <% } %>
        </div>
    </body>
</html>