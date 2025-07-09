<%-- 
    Document   : myRegistration
    Created on : Jul 4, 2025, 3:56:55 PM
    Author     : sonpk
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <div class="container mt-4 mb-4">
            <div class="row">
                <div class=" col-sm-9">
                    <h1 class="mb-4 fs-3">My Course Registrations</h1>
                    <!-- Table -->
                    <div class="card rounded-4 shadow-sm">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="fw-semibold border-0 p-3">ID</th>
                                            <th class="fw-semibold border-0 p-3">Subject</th>
                                            <th class="fw-semibold border-0 p-3">Registration Time</th>
                                            <th class="fw-semibold border-0 p-3">Package / Cost</th>
                                            <th class="fw-semibold border-0 p-3">Status</th>
                                            <th class="fw-semibold border-0 p-3">Valid Period</th>
                                            <th class="fw-semibold border-0 p-3">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty userCourses}">
                                                <c:forEach var="course" items="${userCourses}">
                                                    <tr>
                                                        <td class="p-3 align-middle">${course.courseID}</td>
                                                        <td class="p-3 align-middle">${course.title}</td>
                                                        <td class="p-3 align-middle">${course.enrollDate}</td>
                                                        <td class="p-3 align-middle">
                                                            <div>${course.pkgName}</div>
                                                            <div class="text-success fw-bold">${course.price}đ</div>
                                                        </td>
                                                        <td class="p-3 align-middle">
                                                            <c:choose>
                                                                <c:when test="${course.status == 'SUCCESS'}">
                                                                    <span class="badge bg-success rounded-pill px-3 py-2">Active</span>
                                                                </c:when>
                                                                <c:when test="${course.status == 'Pending'}">
                                                                    <span class="badge bg-warning text-dark rounded-pill px-3 py-2">Submitted</span>
                                                                </c:when>
                                                                <c:when test="${course.status == 'Expired'}">
                                                                    <span class="badge bg-secondary rounded-pill px-3 py-2">Expired</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-light text-dark rounded-pill px-3 py-2">${course.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="p-3 align-middle">
                                                            <div class="small">
                                                                <div>
                                                                    <strong>From:</strong>
                                                                    <div>${empty course.validFrom ? "-" : course.validFrom}</div>
                                                                </div>
                                                                <div>
                                                                    <strong>To:</strong>
                                                                    <div>${empty course.validTo ? "-" : course.validTo}</div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="p-3 align-middle">
                                                            <c:if test="${course.status == 'SUCCESS' || course.status == 'Expired'}">
                                                                <form action="MyCourse" method="post">
                                                                    <input type="hidden" name="userID" value="${userID}" />
                                                                    <button type="submit" class="btn btn-sm btn-secondary me-1 rounded-2 mb-2">
                                                                        <i class="bi bi-eye"></i> View
                                                                    </button>
                                                                </form>
                                                            </c:if>                                                         
                                                            <c:if test="${course.status == 'Pending'}">
                                                                <button 
                                                                    class="btn btn-sm btn-primary me-1 rounded-2 mb-2"
                                                                    data-course-id="${course.courseID}">
                                                                    <i class="bi bi-pencil"></i> Edit
                                                                </button>
                                                                <button class="btn btn-sm btn-danger rounded-2"
                                                                        onclick="confirmCancel('${course.title}', ${course.courseID})">
                                                                    <i class="bi bi-x-lg"></i> Cancel
                                                                </button>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="7" class="text-center p-3">No course registrations found.</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <form id="cancelForm" action="myRegistration" method="post" style="display: none;">
                        <input type="hidden" name="userID" value="${userID}" />
                        <input type="hidden" name="courseID" id="cancelCourseID" />
                          <input type="hidden" name="delete" value="true" />
                    </form>
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
        <%@include file="includes/foot.jsp" %>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                // Cancel
                window.confirmCancel = function (courseName, courseId) {
                    if (confirm("Are you sure you want to cancel this registration for \"" + courseName + "\"?")) {
                        document.getElementById("cancelCourseID").value = courseId;
                        document.getElementById("cancelForm").submit();
                    }
                };
                
                // Edit
                document.querySelectorAll('button[data-course-id]').forEach(button => {
                    button.addEventListener('click', function () {
                        const courseId = this.getAttribute("data-course-id");
                        window.location.href = "CourseDetail?courseID=" + courseId + "&popup=1";
                    });
                });
            });
        </script>
    </body>
</html>
