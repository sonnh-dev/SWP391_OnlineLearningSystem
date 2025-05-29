<%-- File: web/users/userProfile.jsp --%>
<%@page import="com.yourcompany.yourproject.model.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Profile</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f7f6; }
        .profile-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 25px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { color: #333; text-align: center; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group input[type="url"],
        .form-group select {
            width: calc(100% - 12px);
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 1rem;
        }
        .form-group input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }
        .gender-options label {
            display: inline-block;
            margin-right: 15px;
            font-weight: normal;
        }
        .gender-options input[type="radio"] {
            margin-right: 5px;
        }
        .profile-actions {
            text-align: center;
            margin-top: 25px;
        }
        .profile-actions button {
            padding: 10px 25px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1rem;
        }
        .profile-actions button:hover {
            background-color: #0056b3;
        }
        .avatar-preview {
            text-align: center;
            margin-bottom: 20px;
        }
        .avatar-preview img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #eee;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        .message.success { color: green; text-align: center; margin-bottom: 15px; }
        .message.error { color: red; text-align: center; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="profile-container">
        <h1>User Profile</h1>

        <%-- Hiển thị thông báo thành công/lỗi --%>
        <% String successMessage = (String) request.getAttribute("successMessage"); %>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (successMessage != null && !successMessage.isEmpty()) { %>
            <p class="message success"><%= successMessage %></p>
        <% } %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <p class="message error"><%= errorMessage %></p>
        <% } %>

        <% 
            User user = (User) request.getAttribute("user");
            // Định dạng ngày sinh để hiển thị trong input type="date"
            String dobFormatted = "";
            if (user != null && user.getDateOfBirth() != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dobFormatted = sdf.format(user.getDateOfBirth());
            }
        %>

        <% if (user != null) { %>
            <form action="${pageContext.request.contextPath}/user/profile" method="post">
                <div class="avatar-preview">
                    <img src="<%= user.getAvatarURL() != null && !user.getAvatarURL().isEmpty() ? user.getAvatarURL() : "https://via.placeholder.com/120?text=No+Avatar" %>" alt="Avatar">
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="text" id="email" name="email" value="<%= user.getEmail() %>" readonly>
                    <small>Email cannot be changed.</small>
                </div>

                <div class="form-group">
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" value="<%= user.getFirstName() %>" required>
                </div>

                <div class="form-group">
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" value="<%= user.getLastName() %>" required>
                </div>

                <div class="form-group">
                    <label>Gender:</label>
                    <div class="gender-options">
                        <label>
                            <input type="radio" name="gender" value="Male" <%= "Male".equals(user.getGender()) ? "checked" : "" %>> Male
                        </label>
                        <label>
                            <input type="radio" name="gender" value="Female" <%= "Female".equals(user.getGender()) ? "checked" : "" %>> Female
                        </label>
                        <label>
                            <input type="radio" name="gender" value="Other" <%= "Other".equals(user.getGender()) ? "checked" : "" %>> Other
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="<%= user.getPhoneNumber() %>">
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= user.getAddress() %>">
                </div>

                <div class="form-group">
                    <label for="dateOfBirth">Date of Birth:</label>
                    <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= dobFormatted %>">
                </div>
                
                <div class="form-group">
                    <label for="avatarURL">Avatar URL:</label>
                    <input type="url" id="avatarURL" name="avatarURL" value="<%= user.getAvatarURL() != null ? user.getAvatarURL() : "" %>" placeholder="Enter URL for your avatar image">
                </div>

                <div class="profile-actions">
                    <button type="submit">Update Profile</button>
                </div>
            </form>
        <% } else { %>
            <p style="text-align: center; color: red;">User profile could not be loaded.</p>
        <% } %>
    </div>
</body>
</html>