<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course List</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <style>
        .category-item:hover {
            background-color: #f1f5f9;
        }
        #priceRange::-webkit-slider-runnable-track {
            background: #3d8bfd;
            border-radius: 5px;
        }

        .sort-btn {
            background-color: white;
            border: 1px solid #dee2e6;
            color: #212529;
            transition: all 0.2s;
            margin-bottom: 8px;
            width: 100%;
            text-align: left;
            padding: 8px 12px;
        }

        .sort-btn:hover,
        button.sort-btn.active {
            background-color: #0d6efd !important;
            color: white !important;
        }
    </style>
    <body style=" background-color: #f8f9fa; color: #212529;">
        <!-- Header -->
        <%@include file="includes/navbar.jsp" %>    
        <div class="container py-4">
            <div class="row">
                <!-- Main Content - Subject Listings -->
                <div class="col-sm-9">
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body">
                            <h1 class="card-title fw-bold mb-2">Course List</h1>
                            <p class="card-text text-muted" style="font-size: 1.4rem">
                                Enhance your personal and professional development with our course selection.
                            </p>
                        </div>
                    </div>
                    <!-- Options Toggle -->
                    <div class="d-flex align-items-center justify-content-between pb-3 p-3 rounded-top border"
                         style="border-color: #dee2e6;">
                        <div style="cursor: pointer; margin-right: 8px;" id="optionCustom">
                            <i class="bi bi-sliders"></i> Custom display
                        </div>
                        <button class="btn btn-sm btn-primary p-2 px-3 rounded-4" id="reset">Reset search</button>
                    </div>

                    <!-- Display Options Content -->
                    <div id="optionContent" class="display-options-content px-4 py-3 bg-white border rounded-bottom mb-4" style="display: none">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Display information:</label>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" id="info-all" checked>
                                    <label class="form-check-label " for="info-all">Display All</label>
                                </div>
                                <c:forEach var="label" items="${fieldLabels}">
                                    <c:set var="key" value="${fn:toLowerCase(fn:replace(label, ' ', ''))}" />
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="info-${key}" value="${key}">
                                        <label class="form-check-label" for="info-${key}">${label}</label>
                                    </div>
                                </c:forEach>
                                <div class="mt-4 d-flex align-items-center">
                                    <label for="coursePerPage" class="form-label fw-bold me-2">Course per page:</label>
                                    <input type="number" min="1" max="100" value="4" id="coursePerPage" class="form-control w-auto" />
                                </div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Filter by category:</label>
                                <div class="category-filter border rounded p-3">
                                    <!-- All Category -->
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="cat-all" checked>
                                        <label class="form-check-label" for="cat-all">All Category</label>
                                    </div>
                                    <!-- Dynamic Categories -->
                                    <c:forEach var="category" items="${category}">
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="checkbox" id="cat-${fn:replace(category, ' ', '-')}" value="${fn:toLowerCase(category)}">
                                            <label class="form-check-label" for="cat-${fn:replace(category, ' ', '-')}">${category}</label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="d-flex justify-content-lg-around mt-3">
                                    <button class="btn btn-sm btn-outline-secondary p-2" id="clearFilter"> Clear All</button>
                                    <button class="btn btn-sm btn-primary p-2 px-3" id="applyFilter">Apply</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Subject List Container -->
                    <div class="list-view mt-3">
                        <!-- No course Message -->
                        <div id="noCourseMessage" class="text-center my-4" style="display: none">
                            <img src="https://cdn-icons-png.flaticon.com/512/6134/6134065.png" alt="No Courses" style="width: 120px; opacity: 0.7;" class="mb-3">
                            <div class="alert alert-warning d-inline-block px-4 py-2">
                                There're nothing to show with Course displayed with the display/ filter.
                            </div>
                        </div>
                        <!-- Subject Container -->
                        <div class="subject-container">
                            <!-- Subject -->
                            <c:forEach var="course" items="${listofCourse}">
                                <div class="course-item"
                                     data-courseID="${course.courseID}"
                                     data-courseName="${course.title}"
                                     data-updated="${course.updateDate.time}"
                                     data-enrolled="${course.totalEnrollment}"
                                     data-rating="${course.rating}"
                                     data-price="${course.coursePackage[0].originalPrice}"
                                     data-category="${fn:toLowerCase(course.category)}">
                                    <div class="card shadow-sm border-0 rounded-3 mb-4 subject-row">
                                        <div class="row g-0">
                                            <!-- Thumbnail -->
                                            <div class="col-md-3 bg-light ps-2 pt-2 course-thumbnail" style="height: 225px; overflow: hidden;">
                                                <img src="${course.imageURL}"
                                                     class="img-fluid w-100 h-100 object-fit-cover rounded-start"
                                                     alt="${course.title}" />
                                            </div>
                                            <!-- Course Info -->
                                            <div class="col-sm-6 d-flex flex-column p-3 bg-white">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <!-- Course category -->
                                                    <span class="badge bg-primary rounded-pill px-3 py-1 fw-semibold  course-category">
                                                        ${course.category}
                                                    </span>
                                                    <!-- Course updateDate -->
                                                    <small class="text-muted  course-updateDate">
                                                        <i class="bi bi-clock me-1"></i>
                                                        Updated: <fmt:formatDate value="${course.updateDate}" pattern="dd MMM yyyy"/>
                                                    </small>
                                                </div>
                                                <!-- Course Title -->
                                                <h5 class="fw-bold text-dark mb-2 fs-4 course-title">${course.title}</h5>
                                                <!-- Course Description -->
                                                <div class="text-dark mb-2 course-description" style="font-size: 1.1rem;">${course.courseShortDescription}</div>
                                                <div class="d-flex gap-3 text-muted small mb-2">
                                                    <!-- Course enroll and lecture -->
                                                    <div class="course-enroll"><i class="bi bi-people me-1"></i>${course.totalEnrollment} enrolled</div>
                                                    <div class="course-lecture"><i class="bi bi-collection me-1"></i>${course.lectures} lectures</div>
                                                </div>
                                                <!-- Course Rating -->
                                                <div class="d-flex align-items-center mb-3 small course-rating">
                                                    <span class="me-2 text-muted">Recommended:</span>
                                                    <div class="progress flex-grow-1" style="height: 8px; max-width: 100px;">
                                                        <div class="progress-bar bg-primary" style="width: ${course.rating}%;"></div>
                                                    </div>
                                                    <span class="ms-2 text-primary fw-bold">${course.rating}%</span>
                                                </div>
                                            </div>
                                            <!-- Pricing & Actions -->
                                            <div class="col-sm-3 d-flex flex-column justify-content-center p-3 bg-light border-start">
                                                <div class="mb-3">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="fw-bold text-secondary">Package:</span>
                                                        <span class="badge bg-danger discount-badge" style="display: none;" value></span>
                                                    </div>
                                                    <!-- Course Package -->
                                                    <select class="form-select form-select-sm mb-3 course-package">
                                                        <c:forEach var="pkg" items="${course.coursePackage}">
                                                            <option 
                                                                data-price="${pkg.originalPrice}"
                                                                data-saleRate="${pkg.saleRate}"
                                                                data-sale="${pkg.originalPrice * (1 - pkg.saleRate / 100.0)}">
                                                                ${pkg.packageName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="bg-light border rounded text-center p-2">
                                                        <span class="text-muted text-decoration-line-through small me-2 old-price" style="font-size: 0.85rem;"></span>
                                                        <span class="fw-bold text-primary new-price" style="font-size: 1.05rem;"></span>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-column gap-2 mt-auto">
                                                    <a class="btn btn-outline-secondary btn-sm w-100" href="CourseDetail?courseID=${course.courseID}">
                                                        <i class="bi bi-info-circle me-1"></i> View Details
                                                    </a>
                                                    <a class="btn btn-primary btn-sm w-100 register-btn" href="CourseDetail?courseID=${course.courseID}&popup=1">
                                                        <i class="bi bi-cart-plus me-1"></i> Register Now
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Pagination -->
                    <nav aria-label="Subject pagination" class="mt-4" style="display: none">
                        <ul class="pagination justify-content-center">
                        </ul>
                    </nav>
                </div>

                <!-- Sidebar -->
                <div class="col-sm-3">
                    <!-- Search Box -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3 ">Search Subjects</h5>
                            <form id="searchForm" class="d-flex">
                                <input id="searchInput" class="form-control me-2" type="search" placeholder="Search subjects..."
                                       aria-label="Search">
                                <button class="btn btn-primary" type="submit" id="searchBtn">
                                    <i class="bi bi-search"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                    <!-- Sort Options-->
                    <div class="card">
                        <div class=" bg-light text-dark p-2 d-flex align-items-center rounded-top">
                            <i class="bi bi-sort-down me-2"></i> Sort By
                        </div>
                        <div class="card-body">
                            <div class="d-flex flex-column gap-2">
                                <button class="btn btn-sm sort-btn active" data-sort="updated">
                                    <i class="bi bi-arrow-down-up me-2"></i> Recently updated
                                </button>
                                <button class="btn btn-sm sort-btn" data-sort="popular">
                                    <i class="bi bi-graph-up me-2"></i> Popular
                                </button>
                                <button class="btn btn-sm sort-btn" data-sort="price-asc">
                                    <i class="bi bi-sort-numeric-down me-2"></i> Price low to high
                                </button>
                                <button class="btn btn-sm sort-btn" data-sort="price-desc">
                                    <i class="bi bi-sort-numeric-up me-2"></i> Price high to low
                                </button>
                                <button class="btn btn-sm sort-btn" data-sort="recommend">
                                    <i class="bi bi-hand-thumbs-up me-2"></i> High recommendation
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- Price Range -->
                    <div class="card border mb-4 mt-4">
                        <div class="card-header fw-semibold border bg-light text-dark">
                            <i class="bi bi-cash-coin me-2"></i> Price Range
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <input type="range" class="form-range" min="0" max="2000000" value="2000000" id="priceRange">
                            </div>
                            <div class="d-flex justify-content-between small text-muted">
                                <span>0 ₫</span>
                                <span id="priceRangeValue">2.000.000 ₫</span>
                            </div>
                        </div>
                    </div>
                    <!-- Categories -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title mb-3">Subject Categories</h5>
                            <ul class="list-group list-group-flush">
                                <c:forEach var="category" items="${category}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0 category-item">
                                        <a href="#" class="text-decoration-none text-dark category-sidebar" data-category="${category}">${category}</a>
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
        <script src="assets/js/courseList.js"></script>
    </body>
</html>
