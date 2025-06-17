<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>homePage</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <!-- Header -->
        <%@include file="includes/navbar.jsp" %>    
        <!-- Content -->
        <div class="container row mb-5 mx-auto mt-3">
            <!-- Left side -->
            <div class="col-md-9">
                <!-- Slider --> 
                <div id="slider" class="carousel slide mt-3" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <c:forEach var="slider" items="${slider}" varStatus="status">
                            <c:choose>
                                <c:when test="${status.first}">
                                    <button type="button" data-bs-target="#slider" data-bs-slide-to="${status.index}" class="active" ></button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" data-bs-target="#slider" data-bs-slide-to="${status.index}" ></button>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="carousel-inner">
                        <c:forEach var="slider" items="${slider}" varStatus="status">
                            <div class="carousel-item ${status.first ? 'active' : ''}"  >
                                <a href="CourseDetail?courseID=${slider.courseID}">
                                    <img src="${slider.sliderURL}" class="d-block w-100" style="height: 475px; object-fit: cover;" alt="First slide">
                                    <div class="carousel-caption bg-dark bg-opacity-50 rounded-3">
                                        <h5 class="text-white">${slider.sliderTitle}</h5>
                                        <p class="text-white-80">${slider.sliderContent}.</p>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                        <!-- Slider controls -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#slider" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#slider" data-bs-slide="next">
                            <span class="carousel-control-next-icon"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                    <!-- End of slider-->
                </div>
                <!-- Hot posts -->
                <div class="mb-5 mt-5" id="hot-posts">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="section-title h3 fw-bold">Hot Posts</h2>
                        <a href="blogList" class="text-decoration-none text-primary mb-1">View All</a>
                        <!-- Link to blog list page --------------------------------------------------------------------------------------------------------------------------------------------->
                    </div>
                    <div class="row row-cols-md-3 g-4">
                        <c:forEach var="blog" items="${hotBlogs}">
                            <div class="col">
                                <a href="BlogDetail?blogID=${blog.blogID}" class="text-decoration-none text-dark">
                                    <!--link........................................................................................-->
                                    <div class="card shadow h-100">
                                        <img src="${blog.imageURL}" class="img-fluid p-3" style="height: 200px; object-fit: cover;"
                                             alt="${blog.title}">
                                        <div class="card-body">
                                            <h5 class=" card-title">${blog.title}</h5>
                                            <p class="text-muted small mb-2">
                                                <i class="far fa-calendar-alt me-1"></i>  ${blog.date}
                                            </p>
                                            <p class="card-text text-muted">
                                                <c:out value="${fn:length(blog.summary) > 100 ? blog.summary.substring(0, 100).concat('...') : blog.summary}" />
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- Featured subjects -->
                <div>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="section-title h3 fw-bold">Featured Subjects</h2>
                        <a href="#" class="text-decoration-none text-primary">View All</a>
                    </div>
                    <div class="row row-cols-md-3 g-4">
                        <c:forEach var="course" items="${featuredCourse}">
                            <div class="col">
                                <a href="CourseDetail?courseID=${course.courseID}" class="text-decoration-none text-dark">
                                    <div class="card shadow">
                                        <div class="p-3 position-relative">
                                            <img src="${course.imageURL}" class="img-fluid w-100"
                                                 style="height: 200px; object-fit: cover; border-radius: 15px;"
                                                 alt="${course.title}">
                                            <span class="badge bg-info text-white position-absolute top-0 start-0 m-2">
                                                ${course.category}
                                            </span>
                                        </div>
                                        <div class="card-body">
                                            <h5 class="card-title mb-1">${course.title}</h5>
                                            <c:set var="p" value="${minPackage[course.courseID]}" />
                                            <c:set var="sale" value="${p.originalPrice * (1 - p.saleRate / 100.0)}" />
                                            <span class="fw-bold ms-2 fs-5" style="color: #0d6efd;">
                                                <fmt:formatNumber value="${sale}" type="number" maxFractionDigits="2" />đ
                                            </span>
                                            <span class="text-muted text-decoration-line-through me-2">
                                                <fmt:formatNumber value="${p.originalPrice}" type="number" maxFractionDigits="2" />đ
                                            </span>
                                            <div class="d-flex align-items-center mt-3">
                                                <a href="CourseDetail?courseID=${course.courseID}" class="btn btn-outline-info me-2">View Course</a>
                                                <div class="ms-auto text-end d-flex align-items-center">
                                                    <i class="fas fa-file-alt me-1"></i>${course.lectures} lectures
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Right side -->
            <div class="col-md-3">
                <div class="card shadow">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="card-title h4 fw-bold">Latest Posts</h3>
                            <!-- Link to latest posts page .........................................................-->
                        </div>
                        <div class="latest-posts">
                            <c:forEach var="blog" items="${latestBlogs}">
                                <a href="BlogDetail?blogID=${blog.blogID}" class="text-decoration-none text-dark">
                                    <!--link........................................................................................-->
                                    <div class="d-flex mb-5">
                                        <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                            <img src="${blog.imageURL}" alt="${blog.title}" class="w-100 h-100 latest-post-img">
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
                                        onclick="window.location.href = 'blogList'">
                                    See All
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
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
            <!-- End of all-->
        </div>
        <%@include file="includes/foot.jsp" %>

        <c:if test="${param.logout eq 'success'}">
            <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
                <div id="logoutToast" class="toast align-items-center text-bg-success border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            Logout successfully!
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <script>
                // Tự động ẩn sau 3 giây
                setTimeout(() => {
                    const toast = bootstrap.Toast.getOrCreateInstance(document.getElementById('logoutToast'));
                    toast.hide();
                }, 3000);
            </script>
        </c:if>
    </body>
</html>
