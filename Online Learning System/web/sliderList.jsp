<%-- 
    Document   : sliderList
    Created on : 13 Jun 2025, 14:55:18
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Slider"%>
<%
    List<Slider> sliders = (List<Slider>) request.getAttribute("sliders");
    String keyword = request.getAttribute("search") != null ? request.getAttribute("search").toString() : "";
    String status = request.getAttribute("status") != null ? request.getAttribute("status").toString() : "all";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Slider List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; } /* Thêm style cơ bản cho body */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; /* Thêm margin cho bảng */
        }
        th, td {
            border: 1px solid #ddd; /* Chỉnh màu border nhẹ hơn */
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2; /* Màu nền cho header bảng */
        }
        .status-active {
            background-color: #28a745; /* Màu xanh lá cây */
            color: white;
            padding: 4px 8px; /* Tăng padding */
            border-radius: 5px; /* Bo góc nhẹ hơn */
            font-size: 0.9em;
            display: inline-block;
        }
        .status-hidden {
            background-color: #6c757d; /* Màu xám */
            color: white;
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 0.9em;
            display: inline-block;
        }

        #editModal {
            display: none;
            position: fixed;
            top: 50%; /* Căn giữa màn hình */
            left: 50%;
            transform: translate(-50%, -50%); /* Dịch chuyển để căn đúng tâm */
            width: 500px; /* Tăng chiều rộng modal */
            background: #fff;
            padding: 30px; /* Tăng padding */
            border: 1px solid #ccc;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.3); /* Shadow rõ hơn */
            z-index: 1000;
            border-radius: 8px; /* Bo góc modal */
        }
        #editModal h3 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        #editModal label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        #editModal input[type="text"],
        #editModal select {
            width: calc(100% - 20px); /* Điều chỉnh chiều rộng input */
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* Đảm bảo padding không làm tăng chiều rộng */
        }
        #editModal input[type="file"] {
            margin-bottom: 15px;
        }
        #editModal .image-preview {
            width: 100px; /* Kích thước ảnh preview */
            height: 100px;
            border: 1px solid #eee;
            margin-bottom: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            background-color: #f9f9f9;
        }
        #editModal .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        #editModal .image-preview span {
            color: #aaa;
            font-size: 0.9em;
        }

        #editModal button {
            padding: 10px 20px; /* Tăng padding nút */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            font-size: 1em;
        }
        #editModal button[type="submit"] {
            background-color: #007bff;
            color: white;
        }
        #editModal button[type="submit"]:hover {
            background-color: #0056b3;
        }
        #editModal button[type="button"] {
            background-color: #6c757d;
            color: white;
        }
        #editModal button[type="button"]:hover {
            background-color: #5a6268;
        }
        
        .clickable-row {
            cursor: pointer;
        }
        .clickable-row:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <h2>Slider List</h2>

    <form action="slider-list" method="get">
        <input type="text" name="search" placeholder="Search by title or back link"
               value="<%= keyword %>" />
        <select name="status">
            <option value="all" <%= "all".equals(status) ? "selected" : "" %>>All</option>
            <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
            <option value="hidden" <%= "hidden".equals(status) ? "selected" : "" %>>Hidden</option>
        </select>
        <button type="submit">Search</button>
    </form>
    <br/>

    <table>
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Title</th>
            <th>Content</th>
            <th>URL</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
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
                <button onclick="event.stopPropagation(); openModal(<%= s.getSliderID() %>, 
                                         '<%= s.getSliderTitle().replace("'", "\\'") %>',
                                         '<%= s.getSliderContent().replace("'", "\\'") %>',
                                         '<%= java.net.URLEncoder.encode(s.getSliderURL(), "UTF-8").replace("+", "%20").replace("'", "\\'") %>', <%-- Đảm bảo URL được mã hóa đúng và không có dấu nháy đơn gây lỗi JS --%>
                                         <%= s.getStatus() %>)">
                    Edit
                </button>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>

    <div id="editModal">
        <h3>Edit Slider</h3>
        <form action="edit-slider" method="post" enctype="multipart/form-data"> <%-- THÊM enctype="multipart/form-data" --%>
            <input type="hidden" name="sliderID" id="editSliderID" />
            <label>Title:</label><br/>
            <input type="text" name="sliderTitle" id="editSliderTitle" /><br/><br/>
            <label>Content:</label><br/>
            <input type="text" name="sliderContent" id="editSliderContent" /><br/><br/>
            <label>Backlink:</label><br/> <%-- Đổi tên từ 'Backlink (Image URL)' thành 'Backlink' --%>
            <input type="text" name="sliderURL" id="editSliderURL" /><br/><br/>
            
            <label>Current Image:</label><br/>
            <div class="image-preview" id="currentImagePreview">
                <img src="" alt="Current Image" id="modalImage">
                <span id="noImageText">IMG</span> <%-- Hiển thị IMG nếu không có ảnh --%>
            </div>
            <label>Choose File:</label><br/>
            <input type="file" name="newImage" id="newImageInput" accept="image/*" /><br/><br/> <%-- THÊM input file --%>

            <label>Status:</label><br/>
            <select name="status" id="editSliderStatus">
                <option value="1">Active</option>
                <option value="0">Hidden</option>
            </select><br/><br/>
            <button type="submit">Save</button>
            <button type="button" onclick="closeModal()">Cancel</button>
        </form>
    </div>

    <script>
        function openModal(id, title, content, url, status) {
            document.getElementById('editSliderID').value = id;
            document.getElementById('editSliderTitle').value = title;
            document.getElementById('editSliderContent').value = content;
            
            // Decode URL và hiển thị trong input text
            const decodedUrl = decodeURIComponent(url);
            document.getElementById('editSliderURL').value = decodedUrl; 

            // Hiển thị ảnh hiện tại trong modal
            const modalImage = document.getElementById('modalImage');
            const noImageText = document.getElementById('noImageText');
            if (decodedUrl && decodedUrl !== "null" && decodedUrl !== "undefined") { // Kiểm tra nếu URL không rỗng
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
            // Reset input file khi đóng modal
            document.getElementById('newImageInput').value = '';
        }

        // Tùy chọn: Xem trước ảnh khi chọn file mới
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
                // Nếu không có file mới được chọn, hiển thị ảnh cũ hoặc "IMG"
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