<%-- 
    Document   : myCourse
    Created on : Jul 1, 2025, 12:19:02 PM
    Author     : sonpk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>  
        <!-- Main Content -->
        <div class="container py-4">
            <div class="row mb-4">
                <div class="col-12">
                    <h1 class="mb-0">My Courses</h1>
                </div>
            </div>

            <!-- Course Filters -->
            <div class="row mb-4">
                <div class="col-md-6 mb-3 mb-md-0">
                    <div class="btn-group" role="group" aria-label="Course status filter">
                        <input type="radio" class="btn-check" name="courseStatus" id="allCourses" checked>
                        <label class="btn btn-outline-primary" for="allCourses">All Courses</label>

                        <input type="radio" class="btn-check" name="courseStatus" id="inProgress">
                        <label class="btn btn-outline-primary" for="inProgress">In Progress</label>

                        <input type="radio" class="btn-check" name="courseStatus" id="notStarted">
                        <label class="btn btn-outline-primary" for="notStarted">Not Started</label>

                        <input type="radio" class="btn-check" name="courseStatus" id="completed">
                        <label class="btn btn-outline-primary" for="completed">Completed</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search courses...">
                        <button class="btn btn-primary" type="button">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </div>
            </div>
            <!-- No course Message -->
            <div id="noCourseMessage" class="text-center my-4" style="display: none">
                <img src="https://cdn-icons-png.flaticon.com/512/6134/6134065.png" alt="No Courses" style="width: 120px; opacity: 0.7;" class="mb-3">
                <div class="alert alert-warning d-inline-block px-4 py-2">
                    There're nothing to show with Course displayed with the display/ filter.
                </div>
            </div>
            <!-- Course List -->
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <c:forEach var="uc" items="${userCourse}">
                    <!-- Xác định class theo tiến độ -->
                    <c:set var="statusClass" value="in-progress" />
                    <c:if test="${uc.progress == 0}">
                        <c:set var="statusClass" value="not-started" />
                    </c:if>
                    <c:if test="${uc.progress == 100}">
                        <c:set var="statusClass" value="completed" />
                    </c:if>

                    <div class="col course-item ${statusClass}">
                        <div class="card h-100 shadow-sm course-card">
                            <img src="${uc.imageURL}" class="card-img-top course-img" alt="${uc.title}" />
                            <div class="card-body d-flex flex-column">

                                <c:choose>
                                    <c:when test="${uc.progress == 100}">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h5 class="card-title mb-0">${uc.title}</h5>
                                            <span class="badge bg-success">Completed</span>
                                        </div>
                                    </c:when>
                                    <c:when test="${uc.progress == 0}">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h5 class="card-title mb-0">${uc.title}</h5>
                                            <span class="badge bg-secondary">Not Started</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h5 class="card-title mb-0">${uc.title}</h5>
                                            <span class="badge bg-primary">In Progress</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <p class="card-text text-muted mb-3">${uc.description}</p>

                                <div class="mt-auto">
                                    <c:choose>
                                        <c:when test="${uc.progress > 0}">
                                            <div class="d-flex align-items-center mb-2">
                                                <div class="progress flex-grow-1 me-2">
                                                    <div class="progress-bar bg-success" role="progressbar"
                                                         style="width: ${uc.progress}%" aria-valuenow="${uc.progress}"
                                                         aria-valuemin="0" aria-valuemax="100">
                                                    </div>
                                                </div>
                                                <span class="text-muted small">${uc.progress}%</span>
                                            </div>
                                            <a href="courseDetail?courseID=${uc.courseID}" class="btn btn-primary w-100">
                                                <c:choose>
                                                    <c:when test="${uc.progress == 100}">View Certificate</c:when>
                                                    <c:otherwise>Continue Learning</c:otherwise>
                                                </c:choose>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="CourseDetail?courseID=${uc.courseID}" class="btn btn-primary w-100 mt-auto">
                                                Start Course
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <%@include file="includes/foot.jsp" %>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const items = document.querySelectorAll('.course-item');
                const msg = document.getElementById('noCourseMessage');
                const input = document.querySelector('input[type="text"]');
                const searchBtn = document.querySelector('.btn-primary');

                const updateVisibility = () => {
                    const visible = [...items].some(i => i.style.display !== 'none');
                    msg.style.display = visible ? 'none' : 'block';
                };

                const applyFilter = (filter) => {
                    items.forEach(i => {
                        const show =
                                filter === 'allCourses' ||
                                (filter === 'inProgress' && i.classList.contains('in-progress')) ||
                                (filter === 'notStarted' && i.classList.contains('not-started')) ||
                                (filter === 'completed' && i.classList.contains('completed'));
                        i.style.display = show ? 'block' : 'none';
                    });
                    updateVisibility();
                };

                const applySearch = () => {
                    const term = input.value.toLowerCase();
                    items.forEach(i => {
                        const t = i.querySelector('.card-title').textContent.toLowerCase();
                        const d = i.querySelector('.card-text').textContent.toLowerCase();
                        i.style.display = t.includes(term) || d.includes(term) ? 'block' : 'none';
                    });
                    updateVisibility();
                };

                document.querySelectorAll('.btn-check').forEach(btn =>
                    btn.addEventListener('change', () => applyFilter(btn.id))
                );
                searchBtn.addEventListener('click', applySearch);
                input.addEventListener('keyup', e => e.key === 'Enter' && applySearch());
                updateVisibility();
            });
        </script>
    </body>
</html>
