<%@ page pageEncoding="UTF-8" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>
<%@ page import="model.Account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/includes/auth.jsp" %>
<%
  if (auth != null) {
   User user = new UserDAO().getLoginUser(auth);
   request.setAttribute("user", user);
  }
%>
<nav class="navbar navbar-expand-lg navbar-light shadow-sm bg-white">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center" href="home">
            <img src="images/logo.png" alt="Logo" style="height: 50px">
        </a>
        <!-- Menu items -->
        <div>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item">
                    <a class="nav-link active" href="/Online_Learning_System/home">
                        <i class="bi bi-house-door-fill me-1"></i>Home
                    </a>
                </li>
                <c:choose>
                    <c:when test="${not empty auth}">
                        <li class="nav-item">
                            <a class="nav-link" href="CourseList">
                                <i class="bi bi-journal-code me-1"></i>Course
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <button class="nav-link dropdown-toggle btn btn-link text-decoration-none" 
                                    id="navbarDropdown" 
                                    data-bs-toggle="dropdown" 
                                    aria-expanded="false">
                                <i class="bi bi-person-circle me-1"></i> My account
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">My Profile</a></li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/MyCourse" method="post" class="dropdown-item p-0">
                                        <input type="hidden" name="userID" value="${user.userId}" />
                                        <button type="submit" class="dropdown-item w-100 text-start">My Courses</button>
                                    </form>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/myRegistration" method="post" class="dropdown-item p-0">
                                        <input type="hidden" name="userID" value="${user.userId}" />
                                        <button type="submit" class="dropdown-item w-100 text-start">My Registration</button>
                                    </form>
                                </li>
                                <c:if test="${sessionScope.user.role == 'Admin'}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">Manage User</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/quizzes">Manage Quiz</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout">Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="CourseList">
                                <i class="bi bi-journal-code me-1"></i>Course
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">
                                <i class="bi bi-person-circle me-1"></i>Account
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
