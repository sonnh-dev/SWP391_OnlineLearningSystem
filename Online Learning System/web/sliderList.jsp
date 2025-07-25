<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Slider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<Slider> sliders = (List<Slider>) request.getAttribute("sliders");
    String keyword = request.getAttribute("search") != null ? request.getAttribute("search").toString() : "";
    String status = request.getAttribute("status") != null ? request.getAttribute("status").toString() : "all";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Slider List</title>
    <%@ include file="/includes/head.jsp" %>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .container {
            flex: 1;
        }
        footer {
            flex-shrink: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
        }
        .status-active {
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
        }
        .status-hidden {
            background-color: #6c757d;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.9em;
        }
        .clickable-row {
            cursor: pointer;
        }
        .clickable-row:hover {
            background-color: #f1f1f1;
        }
        #editModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 500px;
            background: #fff;
            padding: 30px;
            border: 1px solid #ccc;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.3);
            z-index: 1000;
            border-radius: 8px;
        }
        #editModal input[type="text"],
        #editModal select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .image-preview {
            width: 100px;
            height: 100px;
            border: 1px solid #eee;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 15px;
        }
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        .image-preview span {
            color: #aaa;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/navbar.jsp" %>

    <div class="page-wrapper">
        <div class="container mt-5">
            <h2>Slider List</h2>

            <form action="slider-list" method="get" class="row g-2 mb-3">
                <div class="col-md-5">
                    <input type="text" name="search" class="form-control" placeholder="Search by title or URL" value="<%= keyword %>"/>
                </div>
                <div class="col-md-3">
                    <select name="status" class="form-select">
                        <option value="all" <%= "all".equals(status) ? "selected" : "" %>>All</option>
                        <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
                        <option value="hidden" <%= "hidden".equals(status) ? "selected" : "" %>>Hidden</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">Search</button>
                </div>
            </form>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Content</th>
                        <th>URL</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (sliders != null) {
                        for (Slider s : sliders) {
                %>
                    <tr class="clickable-row" onclick="window.location='slider-detail?id=<%= s.getSliderID() %>'">
                        <td><%= s.getSliderID() %></td>
                        <td><img src="<%= s.getSliderURL() %>" width="80"/></td>
                        <td><%= s.getSliderTitle() %></td>
                        <td><%= s.getSliderContent() %></td>
                        <td><%= s.getSliderURL() %></td>
                        <td>
                            <% if (s.getStatus() == 1) { %>
                                <span class="status-active">Active</span>
                            <% } else { %>
                                <span class="status-hidden">Hidden</span>
                            <% } %>
                        </td>
                        <td>
                            <button type="button" class="btn btn-sm btn-outline-primary"
                                onclick="event.stopPropagation(); openModal(<%= s.getSliderID() %>, 
                                '<%= s.getSliderTitle().replace("'", "\\'") %>',
                                '<%= s.getSliderContent().replace("'", "\\'") %>',
                                '<%= java.net.URLEncoder.encode(s.getSliderURL(), "UTF-8").replace("+", "%20").replace("'", "\\'") %>', 
                                <%= s.getStatus() %>)">
                                Edit
                            </button>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Modal Edit -->
        <div id="editModal">
            <h3>Edit Slider</h3>
            <form action="edit-slider" method="post" enctype="multipart/form-data">
                <input type="hidden" name="sliderID" id="editSliderID" />
                <label>Title:</label>
                <input type="text" name="sliderTitle" id="editSliderTitle" />
                <label>Content:</label>
                <input type="text" name="sliderContent" id="editSliderContent" />
                <label>Backlink:</label>
                <input type="text" name="sliderURL" id="editSliderURL" />
                <label>Current Image:</label>
                <div class="image-preview" id="currentImagePreview">
                    <img src="" alt="Current Image" id="modalImage">
                    <span id="noImageText">IMG</span>
                </div>
                <label>Choose File:</label>
                <input type="file" name="newImage" id="newImageInput" accept="image/*" />
                <label>Status:</label>
                <select name="status" id="editSliderStatus">
                    <option value="1">Active</option>
                    <option value="0">Hidden</option>
                </select>
                <div class="mt-3 text-end">
                    <button type="submit" class="btn btn-primary">Save</button>
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/includes/foot.jsp" %>

    <script>
        function openModal(id, title, content, url, status) {
            document.getElementById('editSliderID').value = id;
            document.getElementById('editSliderTitle').value = title;
            document.getElementById('editSliderContent').value = content;

            const decodedUrl = decodeURIComponent(url);
            document.getElementById('editSliderURL').value = decodedUrl;

            const modalImage = document.getElementById('modalImage');
            const noImageText = document.getElementById('noImageText');
            if (decodedUrl && decodedUrl !== "null" && decodedUrl !== "undefined") {
                modalImage.src = decodedUrl;
                modalImage.style.display = 'block';
                noImageText.style.display = 'none';
            } else {
                modalImage.src = '';
                modalImage.style.display = 'none';
                noImageText.style.display = 'block';
            }

            document.getElementById('editSliderStatus').value = status;
            document.getElementById('editModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
            document.getElementById('newImageInput').value = '';
        }

        document.getElementById('newImageInput').addEventListener('change', function(event) {
            const file = event.target.files[0];
            const modalImage = document.getElementById('modalImage');
            const noImageText = document.getElementById('noImageText');

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    modalImage.src = e.target.result;
                    modalImage.style.display = 'block';
                    noImageText.style.display = 'none';
                };
                reader.readAsDataURL(file);
            } else {
                const currentUrl = document.getElementById('editSliderURL').value;
                if (currentUrl && currentUrl !== "null" && currentUrl !== "undefined") {
                    modalImage.src = currentUrl;
                    modalImage.style.display = 'block';
                    noImageText.style.display = 'none';
                } else {
                    modalImage.src = '';
                    modalImage.style.display = 'none';
                    noImageText.style.display = 'block';
                }
            }
        });
    </script>
</body>
</html>