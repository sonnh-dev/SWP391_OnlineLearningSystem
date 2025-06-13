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
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>

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
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#popupModal">
                                    Enroll Now
                                </button>
                                <button class="btn btn-outline-primary px-3">Wish List</button>
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
                                    <div class="carousel-item ${status.first ? 'active' : ''} position-relative" data-caption="${item.caption}" style="height: 562.5px;">
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
                                        <button class="btn btn-light rounded-circle position-absolute bottom-0 end-0 m-3 info-button z-2">
                                            <i class="bi bi-info-circle"></i>
                                        </button>
                                        <div class="description position-absolute bottom-0 start-0 text-white p-3 w-100"
                                             style="display: none; background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);">
                                            <h5>Description:</h5>
                                            <p>${item.content}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div id="click-hint" class="position-absolute start-50 translate-middle-x px-3 py-2 rounded-pill text-dark"
                                 style="bottom: 70px; background: rgba(255, 255, 255, 0.85); z-index: 10;">
                                Click on picture or button for more detail
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#courseCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#courseCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                    </div>
                    <div id="external-caption" class="text-center px-3 py-2 rounded-5 mb-2" style="background: #c7f3fb; margin-left:20px; margin-right:  20px"></div>
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
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-sm-3">
                    <!-- Search Box -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3">Search Subjects</h5>
                            <form class="d-flex">
                                <input class="form-control me-2" type="search" placeholder="Search subjects..."
                                       aria-label="Search">
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
                                        <a href="#" class="text-decoration-none text-dark">${category}</a>
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
                                                <a href="courseDetail?courseID=${c.courseID}" class="text-decoration-none text-dark"> ${c.title}</a>
                                            </h6>
                                            <div class="d-flex align-items-center">
                                                <c:set var="p" value="${minPackage[course.courseID]}" />
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
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3">Contact Us</h5>
                            <ul class="list-unstyled mb-0">
                                <li class="mb-3 d-flex">
                                    <i class="bi bi-geo-alt text-primary me-2"></i>
                                    <span>123 Education Street, Learning City, 10001</span>
                                </li>
                                <li class="mb-3 d-flex">
                                    <i class="bi bi-telephone text-primary me-2"></i>
                                    <span>+1 (555) 123-4567</span>
                                </li>
                                <li class="mb-3 d-flex">
                                    <i class="bi bi-envelope text-primary me-2"></i>
                                    <span>info@edulearn.com</span>
                                </li>
                                <li class="d-flex">
                                    <i class="bi bi-clock text-primary me-2"></i>
                                    <div>
                                        <p class="mb-1">Monday - Friday: 9am - 5pm</p>
                                        <p class="mb-0">Saturday - Sunday: Closed</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- interface popup -->
        <div class="modal fade" id="popupModal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" style="max-width:  700px">
                <div class="modal-content rounded-top-5">
                    <!--Header -->
                    <div class="text-white px-4 py-3 rounded-top-4" style="background-color: #4f46e5;">
                        <div class="d-flex justify-content-between align-items-center w-100">
                            <div>
                                <h5 class="fw-bold mb-1 fs-4">Course Registration</h5>
                                <p class="mb-0 text-light small">JavaScript Web Development</p>
                            </div>
                            <button type="button" class="btn p-0 border-0 bg-transparent text-white fs-2"
                                    data-bs-dismiss="modal">
                                &times; <!-- HTML code for X (close button) -->
                            </button>
                        </div>
                    </div>
                    <!-- Modal Body -->
                    <div class="modal-body">
                        <iframe src="CourseRegister?courseID=8" width="100%" height="550px"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <%@include file="includes/foot.jsp" %>
        <script src="assets/js/courseDetail.js"></script>
    </body>
</html>
