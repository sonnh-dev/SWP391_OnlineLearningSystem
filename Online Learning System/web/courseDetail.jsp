<%-- 
    Document   : courseDetails
    Created on : Jun 1, 2025, 6:57:12 AM
    Author     : sonpk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Detail</title>
        <%@include file="includes/head.jsp" %>
        <style>
            .media-preview-wrapper {
                position: relative;
                width: 180px;
                height: 120px;
                margin: 8px;
                overflow: hidden;
                border-radius: 6px;
                box-shadow: 0 0 4px rgba(0, 0, 0, 0.1);
            }
            .media-preview-wrapper img,
            .media-preview-wrapper video {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                cursor: pointer;
                border-radius: 6px;
            }
            .carousel-control-prev,
            .carousel-control-next {
                width: 5%;
                top: 50%;
                transform: translateY(-50%);
                opacity: 0.8;
            }

            .carousel-control-prev {
                left: 10px;
            }
            .carousel-control-next {
                right: 10px;
            }

        </style>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container py-5">
            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-sm-9">
                    <!-- Course Header -->
                    <div style="background-color: #31d2f245; border-radius: 0.5rem; padding: 2rem; margin-bottom: 2rem;">
                        <span class="badge text-white mb-2" style="background-color: #0d6efd;">${course.category}</span>
                        <h1 class="display-5 fw-bold mb-2">${course.title}</h1>
                        <p class="lead mb-3">${course.courseShortDescription}</p>
                    </div>
                    <div class="border border-primary rounded-4 p-4 bg-light shadow">
                        <div class="d-flex align-items-start mb-3">
                            <div>
                                <span class="fw-bold fs-2 text-primary">
                                    <fmt:formatNumber value="${price.originalPrice * (100 - price.saleRate) / 100}" type="number" maxFractionDigits="0"/>₫</span>
                                <span class="text-muted text-decoration-line-through ms-2 fs-5">
                                    <fmt:formatNumber value="${price.originalPrice}" type="number" maxFractionDigits="0"/>₫</span>
                            </div>
                            <span class="badge bg-danger ms-3" style="margin-top: 3px;">Sale ${price.saleRate}%</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-start flex-wrap mb-3">
                            <div class="d-flex gap-2 flex-wrap">
                                <c:choose>
                                    <c:when test="${not empty userCourse && userCourse.status == 'SUCCESS'}">
                                        <form action="MyCourse" method="post" style="display: inline;">
                                            <input type="hidden" name="userID" value="${userID}" />
                                            <button type="submit" class="btn btn-success ps-4 pe-4">
                                                Go to My Course
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-primary ps-4 pe-4" data-bs-toggle="modal" data-bs-target="#popupModal">
                                            Enroll Now
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="text-muted d-flex flex-column align-items-end mt-2 mt-sm-0"
                                 style="font-size: 0.95rem;">
                                <span><i class="bi bi-people-fill me-1"></i>${course.totalEnrollment} enrolled</span>
                                <span><i class="bi bi-film me-1"></i>${course.lectures} lectures</span>
                            </div>
                        </div>
                        <div class="alert alert-info d-flex align-items-center py-2 px-3 mb-0" style="font-size: 0.9rem;">
                            <i class="bi bi-info-circle-fill me-2"></i> Enroll now to get the discount!
                        </div>
                    </div>
                    <!-- Slider -->
                    <div class="container-fluid d-flex justify-content-center mt-3">
                        <div id="courseCarousel" class="carousel slide rounded-4" data-bs-ride="carousel" style="overflow: hidden;">
                            <div class="carousel-indicators">
                                <c:forEach var="item" items="${courseAdditional}" varStatus="status">
                                    <button type="button" data-bs-target="#courseCarousel" data-bs-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></button>
                                </c:forEach>
                            </div>
                            <div class="carousel-inner">
                                <c:forEach var="item" items="${courseAdditional}" varStatus="status">
                                    <div class="carousel-item ${status.first ? 'active' : ''} position-relative" style="height: 562.5px"
                                         data-caption="${item.caption}"  data-content="${fn:escapeXml(item.content)}">
                                        <c:choose>
                                            <c:when test="${item.isVideo}">
                                                <div class="youtube-container w-100 h-100"
                                                     data-id="${fn:substringAfter(item.contentURL, 'v=')}"
                                                     style="aspect-ratio: 16/9; border-radius: 1rem; overflow: hidden;"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${item.contentURL}" class="w-100 h-100 rounded-3" style="aspect-ratio: 16/9; object-fit: cover;" alt="Slide">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#courseCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#courseCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                    </div>
                    <div id="external-caption" class="px-4 py-3 rounded-4 mb-4 mx-3"
                         style="background: #c7f3fb;">
                        <h4 id="caption-title" class="mb-2"></h4>
                        <p id="caption-content" class="mb-0"></p>
                    </div>
                    <!-- End of Slider -->
                    <!-- Course Description -->
                    <!-- Tabs Navigation -->
                    <ul class="nav nav-tabs mb-4" id="courseTab">
                        <li class="nav-item">
                            <button class="nav-link active" id="overview-tab" data-bs-toggle="tab"
                                    data-bs-target="#overview" type="button" role="tab" aria-controls="overview"
                                    aria-selected="true">Overview</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" id="curriculum-tab" data-bs-toggle="tab" data-bs-target="#curriculum"
                                    type="button" role="tab" aria-controls="curriculum"
                                    aria-selected="false">Curriculum</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" id="faq-tab" data-bs-toggle="tab" data-bs-target="#faq" type="button"
                                    role="tab" aria-controls="faq" aria-selected="false">FAQ</button>
                        </li>
                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content" id="courseTabContent">
                        <!-- Overview Tab -->
                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
                            ${course.description}             
                        </div>
                        <!-- Curriculum Tab -->
                        <div class="tab-pane fade" id="curriculum" role="tabpanel" aria-labelledby="curriculum-tab">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h3 class="card-title mb-4">Course Curriculum</h3>
                                    <div class="accordion course-content-list" id="courseContentAccordion">
                                        <c:forEach var="chapter" items="${chapters}" varStatus="status">
                                            <c:set var="chapterId" value="${chapter.chapterID}" />
                                            <c:set var="lessons" value="${lessonMap[chapterId]}" />

                                            <div class="accordion-item">
                                                <h2 class="accordion-header" id="heading${chapterId}">
                                                    <button class="accordion-button <c:if test='${status.index != 0}'>collapsed</c:if>'"
                                                            type="button" data-bs-toggle="collapse"
                                                            data-bs-target="#collapse${chapterId}"
                                                        aria-expanded="<c:out value='${status.index == 0}'/>"
                                                        aria-controls="collapse${chapterId}">
                                                        <div class="w-100 d-flex justify-content-between">
                                                            <span>Module ${status.index + 1}: ${chapter.title}</span>
                                                            <span class="text-muted">${fn:length(lessons)} lessons</span>
                                                        </div>
                                                    </button>
                                                </h2>

                                                <div id="collapse${chapterId}"
                                                     class="accordion-collapse collapse <c:if test='${status.index == 0}'>show</c:if>"
                                                     aria-labelledby="heading${chapterId}"
                                                     data-bs-parent="#courseContentAccordion">
                                                    <div class="accordion-body">
                                                        <ul class="list-group list-group-flush">
                                                            <c:forEach var="lesson" items="${lessons}">
                                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                                    <div>
                                                                        <i class="bi bi-play-circle me-2"></i>
                                                                        ${lesson.title}
                                                                    </div>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- FAQ Tab -->
                        <div class="tab-pane fade" id="faq" role="tabpanel" aria-labelledby="faq-tab">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h3 class="card-title mb-4">Frequently Asked Questions</h3>
                                    <div class="accordion" id="faqAccordion">
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="faqOne">
                                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#faqCollapseOne" aria-expanded="true"
                                                        aria-controls="faqCollapseOne">
                                                    How long do I have access to the course?
                                                </button>
                                            </h2>
                                            <div id="faqCollapseOne" class="accordion-collapse collapse show"
                                                 aria-labelledby="faqOne" data-bs-parent="#faqAccordion">
                                                <div class="accordion-body">
                                                    Once you register for the course, you'll have limited access to course materials as the package you choose.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="faqTwo">
                                                <button class="accordion-button collapsed" type="button"
                                                        data-bs-toggle="collapse" data-bs-target="#faqCollapseTwo"
                                                        aria-expanded="false" aria-controls="faqCollapseTwo">
                                                    Are there any prerequisites for this course?
                                                </button>
                                            </h2>
                                            <div id="faqCollapseTwo" class="accordion-collapse collapse"
                                                 aria-labelledby="faqTwo" data-bs-parent="#faqAccordion">
                                                <div class="accordion-body">
                                                    No, there are no prerequisites. This course is designed for all levels, from beginners to advanced communicators looking to refine their skills.
                                                </div>
                                            </div>
                                        </div>

                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="faqThree">
                                                <button class="accordion-button collapsed" type="button"
                                                        data-bs-toggle="collapse" data-bs-target="#faqCollapseThree"
                                                        aria-expanded="false" aria-controls="faqCollapseThree">
                                                    Will I receive a certificate upon completion?
                                                </button>
                                            </h2>
                                            <div id="faqCollapseThree" class="accordion-collapse collapse"
                                                 aria-labelledby="faqThree" data-bs-parent="#faqAccordion">
                                                <div class="accordion-body">
                                                    Yes, you'll receive a downloadable certificate of completion once you finish
                                                    all course modules and pass the final assessment. This certificate can be
                                                    shared on your LinkedIn profile or with employers.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Review Tab -->
                        <div class="card shadow-sm mb-4">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-sm-6 text-center border-end">
                                        <h2 class="mb-2">Course Reviews</h2>
                                        <p class="text-muted mb-0">${totalReviews} students have shared their experience</p>
                                    </div>
                                    <div class="col-sm-6 text-center">
                                        <h4 class="mb-2">${recommendPercentage}% Recommend this course</h4>
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: ${recommendPercentage}%"
                                                 aria-valuenow="${recommendPercentage}" aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Write a Review -->
                        <c:choose>
                            <c:when test="${not empty user}">
                                <div class="card shadow-sm mb-4">
                                    <div class="card-header bg-white">
                                        <h5 class="mb-0">Write a Review</h5>
                                    </div>
                                    <div class="card-body">
                                        <form id="reviewForm" action="CourseDetail" enctype="multipart/form-data" method="post">
                                            <input type="hidden" name="courseId" id="courseId" value="${course.courseID}">  <!-- Lấy course ID cho việc gửi form -->
                                            <div class="mb-4">
                                                <h5 class="mb-3">Would you recommend this course?</h5>
                                                <div class="row g-2">
                                                    <div class="col-sm-6">
                                                        <button type="button" class="btn btn-outline-success w-100" id="recommendYes">
                                                            <i class="bi bi-hand-thumbs-up me-2"></i>Yes, I recommend
                                                        </button>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <button type="button" class="btn btn-outline-danger w-100" id="recommendNo">
                                                            <i class="bi bi-hand-thumbs-down me-2"></i>No, I don't recommend
                                                        </button>
                                                    </div>
                                                </div>
                                                <input type="hidden" id="recommend" name="recommend" value=""> <!-- Lấy giá trị recommend thông qua js -->
                                            </div>
                                            <!-- Review Text -->
                                            <div class="mb-3">
                                                <label for="reviewComment" class="form-label">Your Review</label>
                                                <textarea class="form-control"  rows="4" id="comment" name="comment"
                                                          placeholder="Share your experience with this course..."></textarea> <!-- Lấy giá trị comment-->
                                            </div>
                                            <!-- Media Upload -->
                                            <div class="mb-4">
                                                <label class="form-label">Add Photos/Videos (Optional)</label>
                                                <div class="input-group mb-3">
                                                    <input type="file" name="mediaFiles" class="form-control" id="mediaUpload" multiple accept="image/*,video/*">   <!-- Media upload lên js -->
                                                    <button class="btn btn-outline-secondary" type="button" id="uploadMediaBtn">Upload</button>
                                                </div>
                                                <div class="form-text mb-2">You can upload up to 5 photos or videos</div>
                                                <div class="preview-container d-flex flex-wrap gap-3" id="mediaPreviewContainer" style="max-width: 100%;"></div>
                                            </div>
                                            <!-- submit -->
                                            <div class="d-grid gap-2">
                                                <button type="submit" class="btn btn-primary">Submit Review</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center mt-4">
                                    <p class="mb-3">You need to <strong>log in</strong> to write a review.</p>
                                    <a href="login.jsp?redirect=courseDetail?courseID=${course.courseID}" class="btn btn-primary">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>Login to Write a Review
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <!-- Filter Reviews -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0">Student Reviews (${filterTotalReview})</h5>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button"
                                        id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    Filter Reviews
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="filterDropdown">
                                    <li>
                                        <a class="dropdown-item"
                                           href="CourseDetail?courseID=${course.courseID}">
                                            All Reviews
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="CourseDetail?courseID=${course.courseID}&filter=recommended">
                                            Recommended
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="CourseDetail?courseID=${course.courseID}&filter=not_recommended">
                                            Not Recommended
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <c:forEach var="review" items="${courseReviews}">
                            <div class="card shadow-sm review-card">
                                <div class="card-body">
                                    <div class="d-flex mb-3">
                                        <c:set var="user" value="${userMap[review.userID]}" />
                                        <img src="${user.avatarUrl != null ? user.avatarUrl : 'https://via.placeholder.com/50x50'}"
                                             alt="User" class="review-avatar me-3 rounded-circle" style="width: 37px; height: 37px;">
                                        <h6 class="mb-0 pt-2">${user.firstName} ${user.lastName}</h6>
                                        <div class="review-date ms-3 pt-1">${review.createdAt}</div>
                                    </div>
                                    <div class="mb-2">
                                        <c:choose>
                                            <c:when test="${review.recommended}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-hand-thumbs-up me-1"></i> Recommended
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">
                                                    <i class="bi bi-hand-thumbs-down me-1"></i> Not Recommended
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <p>${review.comment}</p>
                                    <!-- Hiển thị media -->
                                    <c:if test="${not empty reviewMediaMap[review.reviewID]}">
                                        <div class="review-container" style="display: flex; flex-wrap: wrap; gap: 10px;">
                                            <c:forEach var="media" items="${reviewMediaMap[review.reviewID]}">
                                                <div class="review-item" style="width: 180px; position: relative; ">
                                                    <c:choose>
                                                        <c:when test="${media.video}">
                                                            <img
                                                                src="https://cdn.pixabay.com/photo/2017/03/13/04/25/play-button-2138735_1280.png"
                                                                alt="Video"
                                                                style="width: 100%; border-radius: 6px; cursor: pointer; object-fit: cover"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#mediaModal"
                                                                data-type="video"
                                                                data-src="${media.mediaURL}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${media.mediaURL}"
                                                                 alt="Review Image"
                                                                 style="width: 100%; border-radius: 6px; cursor: pointer; object-fit: cover"
                                                                 data-bs-toggle="modal"
                                                                 data-bs-target="#mediaModal"
                                                                 data-type="image"
                                                                 data-src="${media.mediaURL}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <input type="hidden" class="media-text" value="${media.caption}" />
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- Phân trang -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Review pagination" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="?courseID=${course.courseID}&page=${currentPage - 1}${filter != null ? '&filter=' + filter : ''}">
                                            Previous
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="?courseID=${course.courseID}&page=${i}${filter != null ? '&filter=' + filter : ''}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="?courseID=${course.courseID}&page=${currentPage + 1}${filter != null ? '&filter=' + filter : ''}">
                                            Next
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-sm-3">
                    <!-- Search Subjects -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3">Search Subjects</h5>
                            <form class="d-flex" action="CourseList" method="get">
                                <input name="search" class="form-control me-2" placeholder="Search subjects..."
                                       aria-label="Search" value="${param.keyword}">
                                <button class="btn btn-primary" type="submit">
                                    <i class="bi bi-search"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                    <!-- Categories -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3">Subject Categories</h5>
                            <ul class="list-group list-group-flush">
                                <c:forEach var="category" items="${category}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                        <a href="CourseList?category=${category}"
                                           class="text-decoration-none text-dark">
                                            ${category}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <!-- Featured Subjects -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3">Featured Subjects</h5>
                            <div class="featured-subjects">
                                <c:forEach var="c" items="${featuredSubjects}">
                                    <div class="d-flex mb-3 pb-3 border-bottom">
                                        <img src="${c.imageURL}" class="rounded me-3"
                                             width="70" height="70" alt="${c.title}">
                                        <div>
                                            <h6 class="mb-1">
                                                <a href="CourseDetail?courseID=${c.courseID}" class="text-decoration-none text-dark"> ${c.title}</a>
                                            </h6>
                                            <div class="d-flex align-items-center">
                                                <c:set var="p" value="${minPackage[c.courseID]}" />
                                                <c:set var="sale" value="${p.originalPrice * (1 - p.saleRate / 100.0)}" />
                                                <span class="text-primary fw-bold me-2">
                                                    <fmt:formatNumber value="${sale}" type="number" maxFractionDigits="2" />đ
                                                </span>
                                                <span class="text-muted text-decoration-line-through small">
                                                    <fmt:formatNumber value="${p.originalPrice}" type="number" maxFractionDigits="2" />đ
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
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
            </div>
        </div>
        <!-- interface popup -->
        <div class="modal fade" id="popupModal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" style="max-width: 700px">
                <div class="modal-content rounded-top-5">
                    <div class="text-white px-4 py-3 rounded-top-4" style="background-color: #4f46e5;">
                        <div class="d-flex justify-content-between  w-100">
                            <div>
                                <h5 class="fw-bold mb-1 fs-4">Course Registration</h5>
                                <p class="mb-0 text-light small">${course.title}</p>
                            </div>
                            <button type="button" class="btn p-0 border-0 bg-transparent text-white fs-2"
                                    data-bs-dismiss="modal">
                                &times; <!-- HTML code for X (close button) -->
                            </button>
                        </div>
                    </div>
                    <!-- Modal Body -->
                    <div class="modal-body">
                        <iframe src="CourseRegister?courseID=${course.courseID}" width="100%" height="550px"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <!-- Review popup with media-->
        <div class="modal fade" id="mediaModal" tabindex="-1" aria-labelledby="mediaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" >Review Media</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center" id="mediaContent">
                        <!-- Content will be dynamically inserted here -->
                    </div>
                    <div class="modal-footer">
                        <p id="mediaCaption" class="w-100 text-center mb-0"></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Media upload model -->
        <div class="modal fade" id="mediaUploadModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Media Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="mediaCaptionForm">
                            <div class="mb-3">
                                <label for="mediaCaptionInput" class="form-label">Caption or description</label>
                                <textarea class="form-control" id="mediaCaptionInput" rows="3"
                                          placeholder="Describe what's shown in this photo/video..."></textarea>
                            </div>
                            <input type="hidden" id="currentMediaIndex">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" id="saveCaptionBtn">Save</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <%@include file="includes/foot.jsp" %>
        <script src="assets/js/courseDetail.js"></script>
        <script src="assets/js/courseDetailReview.js"></script>
        <script>
            window.addEventListener("message", (event) => {
                const {action} = event.data;
                if (action === "closePopupAndRedirect") {
                    document.getElementById("popupModal").style.display = "none";
                    window.location.href = event.data.redirectUrl;
                }
                if (action === "toMyRegister") {
                    document.getElementById("popupModal").style.display = "none";

                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = event.data.redirectUrl;
                    const input = document.createElement("input");
                    input.type = "hidden";
                    input.name = "userID";
                    input.value = event.data.userId;

                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }
                if (action === "proceedToPayment") {
                    const {userId, courseId, packageName, price, useTime} = event.data;
                    document.getElementById("popupModal").style.display = "none";

                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = "create-payment";
                    const fields = {userId, courseId, packageName, price, useTime};
                    for (const key in fields) {
                        const input = document.createElement("input");
                        input.type = "hidden";
                        input.name = key;
                        input.value = fields[key];
                        form.appendChild(input);
                    }
                    document.body.appendChild(form);
                    form.submit();
                }
            });
            window.addEventListener("message", function (event) {
                if (!event.data || typeof event.data !== "object")
                    return;

                const {action, message} = event.data;

                if (action === "notifyAccountCreated") {
                    document.getElementById("popupModal").style.display = "none";
                    alert(message);
                    window.location.href = "emailConfirmation.jsp";
                }
            });
            function getParam(param) {
                return new URLSearchParams(window.location.search).get(param);
            }
            window.addEventListener('DOMContentLoaded', () => {
                const showPopup = getParam('popup');
                const courseID = getParam('courseID');
                if (showPopup === '1' && courseID) {
                    const modal = new bootstrap.Modal(document.getElementById('popupModal'));
                    modal.show();
                }
            });
        </script>
    </body>
</html>
