<%-- File: web/users/editUserProfile.jsp --%>
<%@page import="model.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f8f8;
            margin: 0;
            padding: 20px;
        }
        .edit-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 550px;
            margin: 20px auto;
            position: relative;
        }
        .close-button {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: #888;
        }
        .close-button:hover {
            color: #333;
        }
        h2 {
            text-align: center;
            color: #007bff;
            margin-top: 0;
            margin-bottom: 25px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        .avatar-upload-section {
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .avatar-upload-section img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ccc;
            margin-bottom: 10px;
        }
        .avatar-upload-section label {
            display: inline-block;
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
        }
        .avatar-upload-section label:hover {
            background-color: #0056b3;
        }
        .avatar-upload-section input[type="file"] {
            display: none; /* Ẩn input file mặc định */
        }

        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #555;
        }
        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group input[type="tel"],
        .form-group select {
            width: calc(100% - 20px); /* Kích thước trừ padding */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }
        .form-group input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
        .form-actions button {
            padding: 10px 25px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .form-actions button.save {
            background-color: #28a745;
            color: white;
        }
        .form-actions button.save:hover {
            background-color: #218838;
        }
        .form-actions button.cancel {
            background-color: #6c757d;
            color: white;
        }
        .form-actions button.cancel:hover {
            background-color: #5a6268;
        }
        .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
    <script>
        function previewAvatar(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const output = document.getElementById('avatar-preview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        // Hàm để đóng cửa sổ pop-up này
        function closePopup() {
            window.close(); // Đóng cửa sổ hiện tại
        }

        // Thông báo cho cửa sổ cha để refresh (nếu cần)
        function notifyParentAndClose() {
            if (window.opener && !window.opener.closed) {
                // Ví dụ: gọi một hàm refresh trên trang cha
                // window.opener.location.reload(); // Cách đơn giản nhưng có thể không tối ưu
                // Hoặc gửi một sự kiện tùy chỉnh nếu trang cha có listener
                const event = new Event('profileUpdated');
                window.opener.document.dispatchEvent(event);
            }
            closePopup();
        }

        // Kiểm tra xem có thông báo từ Servlet không
        window.onload = function() {
            const successMessage = document.getElementById('successMessage');
            const errorMessage = document.getElementById('errorMessage');
            if (successMessage && successMessage.textContent.trim() !== '') {
                setTimeout(notifyParentAndClose, 1500); // Đóng sau 1.5 giây nếu thành công
            }
        };
    </script>
</head>
<body>

<%
    // Lấy thông tin user từ request (do Servlet truyền đến)
    User user = (User) request.getAttribute("user");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");

    String dobValue = "";
    if (user != null && user.getDateOfBirth() != null) {
        dobValue = user.getDateOfBirth().toString(); // Định dạng yyyy-MM-dd cho input type="date"
    }
%>

<% if (user != null) { %>
<div class="edit-container">
    <span class="close-button" onclick="closePopup()">&times;</span>
    <h2>Edit Profile</h2>

    <% if (message != null) { %>
        <div class="message <%= messageType %>" id="<%= messageType %>Message">
            <%= message %>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/profile/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <input type="hidden" name="currentAvatarUrl" value="<%= user.getAvatarUrl() != null ? user.getAvatarUrl() : "" %>">

        <div class="avatar-upload-section">
            <img id="avatar-preview" src="<%= user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty() ? user.getAvatarUrl() : request.getContextPath() + "/assets/default-avatar.png" %>" alt="Avatar Preview">
            <label for="avatarFile">Change Avatar</label>
            <input type="file" id="avatarFile" name="avatarFile" accept="image/*" onchange="previewAvatar(event)">
        </div>

        <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="firstName" value="<%= user.getFirstName() != null ? user.getFirstName() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="lastName" value="<%= user.getLastName() != null ? user.getLastName() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" readonly> <%-- Email là readonly --%>
        </div>
        <div class="form-group">
            <label for="phoneNumber">Phone Number</label>
            <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>">
        </div>
        <div class="form-group">
            <label for="dob">Date of Birth</label>
            <input type="date" id="dob" name="dob" value="<%= dobValue %>">
        </div>
        <div class="form-group">
            <label for="gender">Gender</label>
            <select id="gender" name="gender">
                <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
            </select>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
        </div>

        <div class="form-actions">
            <button type="submit" class="save">Save Changes</button>
            <button type="button" class="cancel" onclick="closePopup()">Cancel</button>
        </div>
    </form>
</div>
<% } else { %>
    <p class="message error">Failed to load user profile for editing.</p>
<% } %>

</body>
</html>