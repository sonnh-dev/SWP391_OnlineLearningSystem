<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Blog"%>
<!DOCTYPE html>
<html>
<head>
    <title>Latest Post</title>
    <%-- Nhúng phần head chứa CSS, JS chung --%>
    <%@include file="includes/head.jsp" %>
    <style>
        /* CSS cơ bản cho bố cục và style trang */
        body { font-family: Arial, sans-serif; }
        .container { display: flex; justify-content: space-between; padding: 20px; }
        .main-content { width: 70%; }
        .sidebar { width: 28%; }
        .post-box { border: 1px solid black; margin-bottom: 15px; padding: 10px; display: flex; gap: 15px; }
        .post-box img { width: 100px; height: 100px; object-fit: cover; }
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a button { margin: 0 5px; padding: 5px 10px; cursor: pointer; }
        .pagination a button.active { font-weight: bold; background-color: #ddd; }
        .search-box input[type="text"] { width: 70%; padding: 5px; }
        .search-box input[type="submit"] { padding: 6px 10px; cursor: pointer; }
        .category-box, .latest-posts, .contact-box { border: 1px solid black; padding: 10px; margin-bottom: 20px; }
        .category-box div { border-top: 1px solid black; padding: 5px 0; }
        .category-box div:first-child { border-top: none; }
        .category-box a { text-decoration: none; color: black; display: block; padding: 3px 0; }
        .category-box a.active-category { font-weight: bold; color: blue; }
    </style>
</head>
<body>
    <%-- Navbar chung --%>
    <%@include file="includes/navbar.jsp" %>

    <div class="container">
        <!-- MAIN CONTENT: Danh sách bài viết -->
        <div class="main-content">
            <h2>Latest Posts</h2>
            <%
                // Lấy danh sách bài viết từ request (được truyền từ Servlet)
                List<Blog> posts = (List<Blog>) request.getAttribute("posts");
                if (posts != null && !posts.isEmpty()) {
                    for (Blog p : posts) {
            %>
                <div class="post-box">
                    <div>
                        <%-- Hiển thị ảnh bài viết nếu có, nếu không dùng ảnh mặc định --%>
                        <% if (p.getImageURL() != null && !p.getImageURL().isEmpty()) { %>
                            <img src="<%= p.getImageURL() %>" alt="Thumbnail">
                        <% } else { %>
                            <img src="default-thumbnail.jpg" alt="No Image">
                        <% } %>
                    </div>
                    <div>
                        <%-- Tiêu đề, danh mục, tóm tắt --%>
                        <h3><a href="detail?id=<%= p.getBlogID() %>"><%= p.getTitle() %></a></h3>
                        <p><strong>Category:</strong> <%= p.getCategory() %></p>
                        <p><%= p.getSummary() %></p>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <p>No posts available.</p>
            <%
                }
            %>

            <!-- PHÂN TRANG -->
            <div class="pagination">
                <%
                    // Lấy số trang hiện tại và tổng số trang từ Servlet
                    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
                    int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
                    String categoryParam = (String) request.getAttribute("category");
                    if (categoryParam == null) categoryParam = "";

                    // Nếu có lọc theo category thì giữ lại query
                    String categoryQuery = "";
                    if (!categoryParam.isEmpty()) {
                        categoryQuery = "&category=" + java.net.URLEncoder.encode(categoryParam, "UTF-8");
                    }

                    // Nút Previous
                    if (currentPage > 1) {
                %>
                    <a href="post?page=<%= currentPage - 1 %><%= categoryQuery %>"><button>Previous</button></a>
                <%
                    }

                    // Các số trang
                    for (int i = 1; i <= totalPages; i++) {
                %>
                    <a href="post?page=<%= i %><%= categoryQuery %>">
                        <button class="<%= (i == currentPage ? "active" : "") %>"><%= i %></button>
                    </a>
                <%
                    }

                    // Nút Next
                    if (currentPage < totalPages) {
                %>
                    <a href="post?page=<%= currentPage + 1 %><%= categoryQuery %>"><button>Next</button></a>
                <%
                    }
                %>
            </div>
        </div>

        <!-- SIDEBAR: Search, Category, Latest Posts, Contact -->
        <div class="sidebar">
            <!-- Tìm kiếm -->
            <div class="search-box">
                <h3>Search</h3>
                <form method="get" action="post">
                    <input type="text" name="search" placeholder="Search posts..." value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>" />
                    <input type="submit" value="Search" />
                </form>
            </div>

            <!-- Danh mục bài viết -->
            <div class="category-box">
                <h3>Categories</h3>
                <%
                    String[] categories = {"Technology", "News", "Lifestyle", "Education"};
                    String currentCategory = categoryParam;
                %>
                <div>
                    <a href="post"<%= (currentCategory.isEmpty() ? " class='active-category'" : "") %>>All</a>
                </div>
                <%
                    for (String cat : categories) {
                %>
                    <div>
                        <a href="post?category=<%= cat %>" <%= (cat.equals(currentCategory) ? "class='active-category'" : "") %>><%= cat %></a>
                    </div>
                <%
                    }
                %>
            </div>

            <!-- Bài viết mới nhất -->
            <div class="latest-posts">
                <h3>Latest Post</h3>
                <%
                    List<Blog> latestPosts = (List<Blog>) request.getAttribute("latestPosts");
                    if (latestPosts != null && !latestPosts.isEmpty()) {
                        for (Blog lp : latestPosts) {
                %>
                    <p><strong><%= lp.getTitle() %></strong><br/><em><%= lp.getDate() %></em></p>
                <%
                        }
                    } else {
                %>
                    <p>No recent posts.</p>
                <%
                    }
                %>
            </div>

            <!-- Thông tin liên hệ -->
            <div class="contact-box">
                <h3>Contact & Link</h3>
                <p><strong>Email:</strong> Contact@gmail.com</p>
                <p><strong>Phone:</strong> 0123456789</p>
            </div>
        </div>
    </div>

    <%-- Footer --%>
    <%@include file="includes/foot.jsp" %>
</body>
</html>
