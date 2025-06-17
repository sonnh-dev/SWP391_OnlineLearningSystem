<%-- 
    Document   : sliderDetail
    Created on : 13 Jun 2025, 16:09:39
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Slider"%>
<%
    Slider slider = (Slider) request.getAttribute("slider");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Slider Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 900px; /* Tăng chiều rộng để phù hợp với bố cục */
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        h1 {
            margin: 0;
            color: #333;
        }
        .back-button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }

        .main-content {
            display: flex; /* Sử dụng flexbox cho bố cục chính */
            gap: 30px; /* Khoảng cách giữa các cột */
            margin-bottom: 20px;
        }
        .image-section {
            flex: 0 0 250px; /* Chiều rộng cố định cho ảnh */
            height: 200px; /* Chiều cao cố định cho ảnh */
            border: 1px solid #ccc;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0;
            border-radius: 5px;
            overflow: hidden; /* Đảm bảo ảnh không tràn ra ngoài */
        }
        .image-section img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain; /* Giữ tỷ lệ khung hình */
            border: none; /* Bỏ border đã định nghĩa trước đó */
            margin: 0; /* Bỏ margin */
        }
        .image-section span {
            color: #777;
        }

        .info-section {
            flex-grow: 1; /* Phần thông tin chiếm không gian còn lại */
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* Căn trên cùng */
        }
        .info-section h2 {
            margin-top: 0;
            margin-bottom: 15px;
            color: #222;
        }
        .info-row {
            display: flex;
            margin-bottom: 8px;
            align-items: center;
        }
        .info-label {
            font-weight: bold;
            width: 80px; /* Chiều rộng cố định cho label */
            color: #555;
        }
        .info-value {
            flex-grow: 1;
        }
        .info-value a {
            color: #007bff;
            text-decoration: none;
        }
        .info-value a:hover {
            text-decoration: underline;
        }
        .status-badge {
            background-color: #28a745; /* Màu xanh lá cây cho Active */
            color: white;
            padding: 4px 10px;
            border-radius: 5px;
            font-size: 0.9em;
            display: inline-block;
        }
        .status-badge.hidden {
            background-color: #6c757d; /* Màu xám cho Hidden */
        }

        .notes-section {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            background-color: #fdfdfd;
        }
        .notes-section h3 {
            margin-top: 0;
            color: #333;
            margin-bottom: 10px;
        }
        .notes-section p {
            margin: 0;
            line-height: 1.6;
            color: #444;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Slider Detail</h1>
            <a href="slider-list" class="back-button">Back to list</a>
        </div>

        <% if (slider != null) { %>
            <div class="main-content">
                <div class="image-section">
                    <% if (slider.getSliderURL() != null && !slider.getSliderURL().isEmpty()) { %>
                        <img src="<%= slider.getSliderURL() %>" alt="Slider Image">
                    <% } else { %>
                        <span>IMG</span>
                    <% } %>
                </div>
                <div class="info-section">
                    <h2><%= slider.getSliderTitle() %></h2>
                    <div class="info-row">
                        <span class="info-label">Backlink:</span>
                        <span class="info-value">
                            <a href="<%= slider.getSliderURL() %>" target="_blank">
                                <%= slider.getSliderURL() %>
                            </a>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Status:</span>
                        <span class="info-value">
                            <span class="status-badge <%= slider.getStatus() == 0 ? "hidden" : "" %>">
                                <%= slider.getStatus() == 1 ? "Active" : "Hidden" %>
                            </span>
                        </span>
                    </div>
                    <%--
                    <div class="info-row">
                        <span class="info-label">ID:</span>
                        <span class="info-value"><%= slider.getSliderID() %></span>
                    </div>
                    --%>
                </div>
            </div>

            <div class="notes-section">
                <h3>Notes</h3>
                <p><%= slider.getSliderContent() %></p>
            </div>

        <% } else { %>
            <p>Slider not found.</p>
        <% } %>
    </div>
</body>
</html>