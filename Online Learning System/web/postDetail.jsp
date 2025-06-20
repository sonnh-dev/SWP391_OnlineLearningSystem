<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Post1" %>
<%@ page import="model.PostImage" %>
<%@ page import="model.PostVideo" %>

<%
    Post1 post = (Post1) request.getAttribute("post");
    List<PostImage> images = (List<PostImage>) request.getAttribute("images");
    List<PostVideo> videos = (List<PostVideo>) request.getAttribute("videos");

    PostVideo explainVideo = null;
    PostVideo advertiseVideo = null;
    if (videos != null && videos.size() >= 1) explainVideo = videos.get(0);
    if (videos != null && videos.size() >= 2) advertiseVideo = videos.get(1);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post Details</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            font-size: 14px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .row {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .left, .right {
            flex: 1;
            min-width: 250px;
            margin-right: 20px;
        }
        .right {
            margin-right: 0;
        }
        img, video {
            max-width: 100%;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            border-radius: 4px;
        }
        .media-block {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 25px;
            background-color: #f9f9f9;
            border-radius: 6px;
        }
        textarea[disabled] {
            width: 100%;
            background: #e9ecef;
            border: 1px solid #ced4da;
            padding: 8px;
            margin-bottom: 10px;
            resize: none;
            overflow: hidden;
            font-family: inherit;
            font-size: inherit;
        }
        .image-text-row {
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            gap: 20px;
        }
        .image-column, .postinfo-column {
            flex: 1;
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 46px;
            height: 24px;
            margin-left: 10px;
        }
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .switch-label {
            font-weight: bold;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #007bff;
        }
        input:checked + .slider:before {
            transform: translateX(22px);
        }
        #editModal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }
       #editModal .modal-content {
    background: white;
    padding: 30px;
    border-radius: 10px;
    width: 900px; /* Tăng chiều rộng modal */
    max-width: 95%;
    max-height: 90vh; /* Giới hạn chiều cao để không tràn màn hình */
    overflow-y: auto; /* Cho phép cuộn nếu nội dung dài */
    position: relative;
}
.modal-content img,
.modal-content video {
    max-width: 100%;
    max-height: 200px;
    height: auto;
    width: auto;
    display: block;
    margin-bottom: 10px;
    border-radius: 6px;
    object-fit: contain;
}



    </style>
</head>
<body>
<div class="container">

    <% if (post != null) { %>

        <div class="header">
            <h1>Post Details</h1>
            <div class="button-group">
                <button class="btn" onclick="openEditModal()">Edit Post</button>
                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        </div>

        <div class="row">
            <div class="left">
                <h2><%= post.getTitle() %></h2>

                <form action="ToggleFeaturedServlet" method="post">
                    <input type="hidden" name="postID" value="<%= post.getPostID() %>">
                    <label class="switch-label">Featured:</label>
                    <label class="switch">
                        <input type="checkbox" name="featured" value="true" onchange="this.form.submit()" <%= post.isFeatured() ? "checked" : "" %>>
                        <span class="slider round"></span>
                    </label>
                </form><br>

                <label><strong>Thumbnail</strong></label><br>
                <% if (post.getThumbnailURL() != null && !post.getThumbnailURL().isEmpty()) { %>
                    <img src="<%= post.getThumbnailURL() %>" alt="Thumbnail">
                <% } else { %>
                    <p>No thumbnail available.</p>
                <% } %>

                <div style="margin-top: 10px;">
                    <strong>Category:</strong> <%= post.getCategory() %><br>
                    <strong>Status:</strong> <%= post.getStatus() %>
                </div>
            </div>

            <div class="right">
                <label><strong>Brief information</strong></label>
                <textarea id="briefInfo" disabled></textarea>

                <label><strong>Description:</strong></label>
                <textarea id="description" disabled></textarea>
            </div>
        </div>

        <% if (explainVideo != null) { %>
            <h3>Video</h3>
            <div class="media-block">
                <video controls>
                    <source src="<%= explainVideo.getVideoURL() %>" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
                <div class="description-label">Description: Explain the post</div>
            </div>
        <% } %>

        <h3>Images</h3>
        <div class="image-text-row">
            <div class="image-column">
                <% if (images != null && images.size() >= 1) { %>
                    <div class="media-block">
                        <img src="<%= images.get(0).getImageURL() %>" alt="Topic Image">
                        <div class="description-label">Description: Topic of the post</div>
                    </div>
                <% } %>
                <% if (images != null && images.size() >= 2) { %>
                    <div class="media-block">
                        <img src="<%= images.get(1).getImageURL() %>" alt="Logo Image">
                        <div class="description-label">Description: Logo of the course advertised</div>
                    </div>
                <% } %>
            </div>
            <div class="postinfo-column">
                <div class="media-block">
                    <div class="description-label">Post information:</div>
                    <textarea id="postInfoText" disabled></textarea>
                </div>
            </div>
        </div>

        <% if (advertiseVideo != null) { %>
            <h3>Advertised Course Video</h3>
            <div class="media-block">
                <video controls>
                    <source src="<%= advertiseVideo.getVideoURL() %>" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
                <div class="description-label">Description: Advertise course</div>
            </div>
        <% } %>

    <% } else { %>
        <h2>Post not found.</h2>
        <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
    <% } %>
</div>

<!-- Pop-up Modal -->
<div id="editModal">
    <div class="modal-content">
        <h2>Edit Post</h2>
        <form action="EditPostServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="postID" value="<%= post.getPostID() %>">

            <label>Title</label>
            <input type="text" name="title" value="<%= post.getTitle() %>" required style="width:100%; padding:8px; margin-bottom:10px;">

            <label>Category</label>
            <select name="category" style="width:100%; padding:8px; margin-bottom:10px;">
                <option value="Workplace" <%= post.getCategory().equals("Workplace") ? "selected" : "" %>>Workplace</option>
                <option value="Communication" <%= post.getCategory().equals("Communication") ? "selected" : "" %>>Communication</option>
            </select>

            <label>Brief Information</label>
            <textarea name="briefInfo" rows="3" style="width:100%; padding:8px; margin-bottom:10px;"><%= post.getBriefInfo() %></textarea>

            <label>Description</label>
            <textarea name="description" rows="4" style="width:100%; padding:8px; margin-bottom:10px;"><%= post.getDescription() %></textarea>

            <label>Post Information</label>
            <textarea name="postinfo" rows="4" style="width:100%; padding:8px; margin-bottom:10px;"><%= post.getPostinfo() %></textarea>

            <!-- Thumbnail -->
            <label>Current Thumbnail</label><br>
            <% if (post.getThumbnailURL() != null && !post.getThumbnailURL().isEmpty()) { %>
                <img src="<%= post.getThumbnailURL() %>" alt="Thumbnail" style="width:100%; max-height:200px; margin-bottom:10px;">
            <% } else { %>
                <p>No thumbnail available.</p>
            <% } %>
            <label>Upload New Thumbnail</label>
            <input type="file" name="thumbnail" accept="image/*" style="margin-bottom:10px;">

            <!-- Image 1 -->
            <label>Current Topic Image</label><br>
            <% if (images != null && images.size() >= 1) { %>
                <img src="<%= images.get(0).getImageURL() %>" alt="Image 1" style="width:100%; max-height:200px; margin-bottom:10px;">
            <% } else { %>
                <p>No image available.</p>
            <% } %>
            <label>Upload New Topic Image</label>
            <input type="file" name="image1" accept="image/*" style="margin-bottom:10px;">

            <!-- Image 2 -->
            <label>Current Logo Image</label><br>
            <% if (images != null && images.size() >= 2) { %>
                <img src="<%= images.get(1).getImageURL() %>" alt="Image 2" style="width:100%; max-height:200px; margin-bottom:10px;">
            <% } else { %>
                <p>No image available.</p>
            <% } %>
            <label>Upload New Logo Image</label>
            <input type="file" name="image2" accept="image/*" style="margin-bottom:10px;">

            <!-- Video 1 -->
            <label>Current Explain Video</label><br>
            <% if (explainVideo != null) { %>
                <video controls style="width:100%; max-height:240px; margin-bottom:10px;">
                    <source src="<%= explainVideo.getVideoURL() %>" type="video/mp4">
                </video>
            <% } else { %>
                <p>No explain video available.</p>
            <% } %>
            <label>Upload New Explain Video</label>
            <input type="file" name="video1" accept="video/*" style="margin-bottom:10px;">

            <!-- Video 2 -->
            <label>Current Advertise Video</label><br>
            <% if (advertiseVideo != null) { %>
                <video controls style="width:100%; max-height:240px; margin-bottom:10px;">
                    <source src="<%= advertiseVideo.getVideoURL() %>" type="video/mp4">
                </video>
            <% } else { %>
                <p>No advertise video available.</p>
            <% } %>
            <label>Upload New Advertise Video</label>
            <input type="file" name="video2" accept="video/*" style="margin-bottom:10px;">

            <label>Status</label>
            <select name="status" style="width:100%; padding:8px; margin-bottom:10px;">
                <option value="Draft" <%= post.getStatus().equals("Draft") ? "selected" : "" %>>Draft</option>
                <option value="Published" <%= post.getStatus().equals("Published") ? "selected" : "" %>>Published</option>
            </select>

            <label style="display:flex; align-items:center;">Featured
                <input type="checkbox" name="featured" value="true" <%= post.isFeatured() ? "checked" : "" %> style="margin-left:10px;">
            </label>

            <div style="margin-top:20px; text-align:right;">
                <button type="button" onclick="closeEditModal()" class="btn btn-secondary">Cancel</button>
                <button type="submit" class="btn">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
    function autoResize(id, content) {
        const el = document.getElementById(id);
        el.value = content;
        el.style.height = 'auto';
        el.style.height = el.scrollHeight + 'px';
    }

    autoResize("postInfoText", `<%= post.getPostinfo().replace("\r", "").replace("\"", "\\\"").replace("\n", "\\n") %>`.replace(/\\n/g, '\n'));
    autoResize("description", `<%= post.getDescription().replace("\r", "").replace("\"", "\\\"").replace("\n", "\\n") %>`.replace(/\\n/g, '\n'));
    autoResize("briefInfo", `<%= post.getBriefInfo().replace("\r", "").replace("\"", "\\\"").replace("\n", "\\n") %>`.replace(/\\n/g, '\n'));

    function openEditModal() {
        document.getElementById("editModal").style.display = "flex";
    }

    function closeEditModal() {
        document.getElementById("editModal").style.display = "none";
    }
</script>
</body>
</html>
