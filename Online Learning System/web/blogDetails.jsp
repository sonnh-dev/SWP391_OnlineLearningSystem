<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <!-- Header -->
        <%@include file="includes/navbar.jsp" %>

        <div class="container row mb-5 mx-auto">
            <!-- Left Column -->
            <div class="col-md-9">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4 p-md-5">
                        <!-- Author and Date -->
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <h1 class="fw-bold mb-3">${blogDetail.title}</h1>
                            <p class="text-muted small mb-0">Updated: ${blogDetail.date}</p>
                        </div>
                        <!-- Blog Title -->


                        <!-- Category -->
                        <div class="mb-4">
                            <span class="badge bg-primary rounded-pill px-3 py-2">${blogDetail.category}</span>
                            <span class="text-end text-muted small mx-2">
                                Views: ${blogDetail.totalView}
                            </span>
                        </div>

                        <!-- Featured Image -->
                        <div class="ratio ratio-16x9 mb-4">
                            <img src="${blogDetail.imageUrl}" class="img-fluid rounded object-fit-cover" alt="${blogDetail.title}">
                        </div>

                        <!-- Blog Content -->
                        <div class="blog-content">
                            <p> <c:out value="${content}" escapeXml="false" /></p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Right Column - Sidebar -->
            <div class="col-md-3">
                <!-- Search Box -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body p-4">
                        <h5 class="card-title mb-4">Search</h5>
                        <form class="d-flex rounded-pill overflow-hidden">
                            <input type="search" class="form-control border-2 text-dark rounded-start-pill"
                                   placeholder="Search Blogs..." aria-label="Search">
                            <button class="btn rounded-end-pill px-3 text-white"
                                    style="background-color: rgba(30, 136, 229, 0.85);" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>
                    </div>
                </div>
                <!-- Categories -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body p-4">
                        <h5 class="card-title mb-3">Categories</h5>
                        <ul class="list-group list-group-flush">
                            <c:forEach var="entry" items="${categoryMap}">
                                <li class="list-group-item d-flex justify-content-between align-items-center px-0 border-0">
                                    <a href="#" class="text-decoration-none text-dark">${entry.key}</a>
                                    <span class="badge bg-primary rounded-pill">${entry.value}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <!-- Latest Posts -->
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="card-title h4 fw-bold mb-3">Latest Posts</h3>
                            <!-- Link to latest posts page .........................................................-->
                        </div>
                        <div class="latest-posts">
                            <c:forEach var="blog" items="${latestBlogs}">
                                <a href="BlogDetail?blogID=${blog.blogID}" class="text-decoration-none text-dark">
                                    <!--link........................................................................................-->
                                    <div class="d-flex mb-5">
                                        <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                            <img src="${blog.imageUrl}" alt="${blog.title}" class="w-100 h-100 latest-post-img">
                                        </div>
                                        <!-- Nội dung bài viết -->
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1">${blog.title}</h6>
                                            <p class="text-muted small mb-0">
                                                <i class="far fa-calendar-alt me-1"></i>  ${blog.date}
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                            <!-- button see all-->
                            <div class="text-center mb-2">
                                <button class="btn mt-3 px-3" style="background-color: #e0e0e0; color: #000;"
                                        onclick="window.location.href = 'blogList.jsp'">
                                    See All
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Contact Info -->
                <div class="card shadow mt-4">
                    <div class="card-body">
                        <h3 class="card-title h5 fw-bold mb-3">Contact Us</h3>
                        <div class="list-unstyled" style="text-decoration: none; color: #000;">
                            <div class="d-flex mt-3 mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-map-marker-alt"></i></span>
                                <span> 123 Hoa Lac, Thach That, Ha Noi, 600000</span>
                            </div>
                            <div class="d-flex mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-phone-alt"></i></span>
                                <span>+84 (0) 123 456 789</span>
                            </div>
                            <div class="d-flex mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-envelope"></i></span>
                                <span>sonnhhe189023@fpt.edu.vn</span>
                            </div>
                            <div class="d-flex mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-clock"></i></span>
                                <div class="mb-2">
                                    <p class="mb-1">Monday - Friday: 7.30am - 5pm</p>
                                    <p class="mb-0">Saturday - Sunday: Closed</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Right Column - Sidebar -->
        </div>

        <!-- Footer -->
        <%@include file="includes/foot.jsp" %>
    </body>
</html>
