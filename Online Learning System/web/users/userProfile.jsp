<%-- File: web/users/userProfile.jsp --%>
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
        <title>User Profile</title>
        <style>
            /* CSS cho overlay và container pop-up */
            body {
                font-family: Arial, sans-serif;
                background: #f2f2f2; /* Màu nền cho body nếu trang này là một trang độc lập */
                margin: 0;
                padding: 0;
            }

            /* Dùng cho trường hợp này là một trang con được nhúng hoặc iframe */
            .popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Nền mờ */
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000; /* Đảm bảo nó nằm trên cùng */
            }

            .container {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                padding: 30px;
                width: 700px; /* Tăng chiều rộng để phù hợp với cả hai section */
                display: flex;
                gap: 40px;
                position: relative; /* Cho nút đóng */
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

            .left-section {
                flex: 0 0 160px; /* Giữ cố định chiều rộng cho left-section */
                text-align: center;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-right: 20px;
                border-right: 1px solid #eee;
            }
            .left-section img {
                width: 140px;
                height: 140px;
                border-radius: 50%;
                border: 2px solid #ccc;
                object-fit: cover;
                margin-bottom: 10px;
            }
            .left-section .name {
                margin-top: 15px;
                font-weight: bold;
                font-size: 1.2em;
                color: #333;
            }
            .left-section .email-display {
                font-size: 0.9em;
                color: #777;
                margin-top: 5px;
            }

            /* Nút chỉnh sửa avatar được di chuyển sang trang edit */
            .left-section .edit-avatar {
                display: none; /* Ẩn nút này trên trang hiển thị */
            }

            .right-section {
                flex-grow: 1; /* Cho phép right-section mở rộng */
                padding-left: 20px;
            }
            .right-section h2 {
                margin-top: 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
                margin-bottom: 20px;
                color: #007bff;
                font-size: 1.5em;
            }
            .right-section h2 button {
                padding: 8px 18px;
                border: 1px solid #007bff;
                background: #007bff;
                color: #fff;
                border-radius: 5px;
                cursor: pointer;
                font-size: 0.9em;
                transition: background-color 0.3s ease;
            }
            .right-section h2 button:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .info-item {
                margin-bottom: 15px;
                display: flex; /* Dùng flexbox cho từng dòng thông tin */
                align-items: baseline;
            }
            .info-item span {
                font-weight: bold;
                color: #555;
                flex: 0 0 120px; /* Đặt chiều rộng cố định cho label */
                text-align: right;
                margin-right: 15px;
            }
            .info-item div {
                flex-grow: 1;
                color: #333;
            }

            .change-password {
                margin-top: 25px;
                text-align: right; /* Căn phải nút đổi mật khẩu */
                padding-top: 15px;
                border-top: 1px solid #eee;
            }
            .change-password a {
                text-decoration: none;
                color: #007bff;
                font-size: 1em;
                font-weight: bold;
                transition: color 0.3s ease;
            }
            .change-password a:hover {
                color: #0056b3;
            }
            .error-message {
                color: red;
                text-align: center;
                margin-top: 20px;
            }
        </style>
        <script>
            // Hàm để đóng pop-up (nếu nó được mở trong iframe/modal)
            function closePopup() {
                console.log("Closing popup...");
                if (window.opener) {
                    window.close();
                } else {
                    const overlay = document.querySelector('.popup-overlay');
                    if (overlay) {
                        overlay.style.display = 'none'; // Hoặc remove nó khỏi DOM
                    }
                }
            }

            // Hàm mở trang chỉnh sửa trong một pop-up mới
            function openEditProfilePopup() {
                // URL của trang chỉnh sửa profile
                const editUrl = '${pageContext.request.contextPath}/profile/edit'; 

                const popupOptions = 'width=800,height=650,top=100,left=300,resizable=yes,scrollbars=yes';

                window.open(editUrl, '_blank', popupOptions);
            }
        </script>
    </head>
    <body>

        <%
            User user = (User) request.getAttribute("user");
            String dobFormatted = "";
            if (user != null && user.getDateOfBirth() != null) {
                // Chuyển đổi LocalDate sang java.util.Date rồi định dạng
                Date utilDate = Date.from(user.getDateOfBirth().atStartOfDay(ZoneId.systemDefault()).toInstant());
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                dobFormatted = sdf.format(utilDate);
            }
        %>

        <% if (user != null) { %>
        <div class="popup-overlay">
            <div class="container">
                <span class="close-button" onclick="closePopup()">&times;</span> <%-- Nút đóng pop-up --%>
                <div class="left-section">
                    <%-- Kiểm tra nếu avatarUrl null/rỗng thì dùng ảnh mặc định --%>
                    <% if (user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty()) {%>
                    <img src="${pageContext.request.contextPath}/<%= user.getAvatarUrl()%>" alt="Avatar">
                    <% } else { %>
                    <img src="https://via.placeholder.com/80" alt="Default Avatar">
                    <% }%> 
                    <div class="name"><%= user.getFullName() != null ? user.getFullName() : (user.getFirstName() + " " + user.getLastName())%></div>
                    <div class="email-display"><%= user.getEmail() != null ? user.getEmail() : ""%></div>
                </div>
                <div class="right-section">
                    <h2>
                        My Profile
                        <button onclick="openEditProfilePopup()">Edit</button>
                    </h2>
                    <div class="info-item"><span>User ID</span> : <div><%= user.getUserId()%></div></div>
                    <div class="info-item"><span>Gender</span> : <div><%= user.getGender() != null ? user.getGender() : ""%></div></div>
                    <div class="info-item"><span>Phone number</span> : <div><%= user.getPhoneNumber() != null ? user.getPhoneNumber() : ""%></div></div>
                    <div class="info-item"><span>Date of birth</span> : <div><%= dobFormatted%></div></div>
                    <div class="info-item"><span>Address</span> : <div><%= user.getAddress() != null ? user.getAddress() : ""%></div></div>
                    <div class="info-item"><span>Role</span> : <div><%= user.getRole() != null ? user.getRole() : ""%></div></div>
                    <div class="info-item"><span>Status</span> : <div><%= user.isStatus() ? "Active" : "Inactive"%></div></div>

                    <div class="change-password">
                        <a href="${pageContext.request.contextPath}/changePassword">Change password</a>
                    </div>
                </div>
            </div>
        </div>
        <% } else { %>
        <p class="error-message">User profile could not be loaded. Please ensure you are logged in.</p>
        <% }%>
    </body>
</html>