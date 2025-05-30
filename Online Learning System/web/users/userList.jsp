<%-- File: web/users/usersList.jsp --%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Users List - Admin Panel</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 40px;
                background-color: #f7f9fc;
                color: #333;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 30px;
            }

            .add-user-btn {
                display: inline-block;
                margin-bottom: 20px;
                padding: 10px 20px;
                background: #28a745;
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
                font-weight: bold;
                transition: background 0.3s;
            }

            .add-user-btn:hover {
                background: #218838;
            }

            .filter-search-form {
                background: #fff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: center;
                margin-bottom: 30px;
            }

            .filter-search-form label {
                font-weight: 500;
                margin-right: 5px;
            }

            .filter-search-form select,
            .filter-search-form input[type="text"] {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 6px;
                min-width: 150px;
            }

            .filter-search-form button {
                background-color: #007bff;
                color: white;
                padding: 9px 18px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .filter-search-form button:hover {
                background-color: #0056b3;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            th, td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
                text-align: left;
            }

            th {
                background-color: #f1f3f5;
                font-weight: 600;
                cursor: pointer;
            }

            tr:hover {
                background-color: #f9fbfd;
            }

            td a {
                color: #007bff;
                text-decoration: none;
            }

            td a:hover {
                text-decoration: underline;
            }

            .pagination {
                margin-top: 30px;
                text-align: center;
            }

            .pagination a,
            .pagination span {
                padding: 8px 14px;
                margin: 0 4px;
                border-radius: 6px;
                border: 1px solid #ddd;
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
            }

            .pagination a:hover {
                background-color: #f0f0f0;
            }

            .pagination span.current-page {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
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
                form.elements['sortOrder'].value = (currentSortBy === sortBy && currentSortOrder === 'asc') ? 'desc' : 'asc';
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

        <a href="addUsers" class="add-user-btn">+ Add New User</a>

        <div class="filter-search-form">
            <form id="userListForm" action="${pageContext.request.contextPath}/admin/users" method="get">
                <label for="genderFilter">Gender:</label>
                <select name="genderFilter" id="genderFilter" onchange="applyFiltersAndSort()">
                    <option value="all" <%= "all".equals(request.getAttribute("genderFilter")) ? "selected" : ""%>>All</option>
                    <option value="Male" <%= "Male".equals(request.getAttribute("genderFilter")) ? "selected" : ""%>>Male</option>
                    <option value="Female" <%= "Female".equals(request.getAttribute("genderFilter")) ? "selected" : ""%>>Female</option>
                    <option value="Other" <%= "Other".equals(request.getAttribute("genderFilter")) ? "selected" : ""%>>Other</option>
                </select>

                <label for="roleFilter">Role:</label>
                <select name="roleFilter" id="roleFilter" onchange="applyFiltersAndSort()">
                    <option value="all" <%= "all".equals(request.getAttribute("roleFilter")) ? "selected" : ""%>>All</option>
                    <option value="Admin" <%= "Admin".equals(request.getAttribute("roleFilter")) ? "selected" : ""%>>Admin</option>
                    <option value="User" <%= "User".equals(request.getAttribute("roleFilter")) ? "selected" : ""%>>User</option>
                </select>

                <label for="statusFilter">Status:</label>
                <select name="statusFilter" id="statusFilter" onchange="applyFiltersAndSort()">
                    <option value="all" <%= "all".equals(request.getAttribute("statusFilter")) ? "selected" : ""%>>All</option>
                    <option value="true" <%= "true".equals(request.getAttribute("statusFilter")) ? "selected" : ""%>>Active</option>
                    <option value="false" <%= "false".equals(request.getAttribute("statusFilter")) ? "selected" : ""%>>Inactive</option>
                </select>

                <label for="search">Search:</label>
                <input type="text" name="search" id="search" value="${requestScope.searchKeyword != null ? requestScope.searchKeyword : ''}" placeholder="Enter keyword">

                <select name="searchBy" id="searchBy">
                    <option value="firstName" <%= "firstName".equals(request.getAttribute("searchBy")) ? "selected" : ""%>>First Name</option>
                    <option value="lastName" <%= "lastName".equals(request.getAttribute("searchBy")) ? "selected" : ""%>>Last Name</option>
                    <option value="email" <%= "email".equals(request.getAttribute("searchBy")) ? "selected" : ""%>>Email</option>
                    <option value="mobile" <%= "mobile".equals(request.getAttribute("searchBy")) ? "selected" : ""%>>Mobile</option>
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
                    <tr><td colspan="8">No users found.</td></tr>
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
