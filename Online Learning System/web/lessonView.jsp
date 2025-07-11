<%-- 
    Document   : lessionView
    Created on : Jul 11, 2025, 12:54:00 PM
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
        <title>Lession View Page</title>
        <%@include file="includes/head.jsp" %>
        <style>
            .sidebar-hidden {
                display: none !important;
            }
            .mobile-menu-visible {
                display: inline-block !important;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="includes/navbar.jsp" %>
        <!-- Lession View -->
        <div class="d-flex flex-column flex-md-row" id="mainContainer">
            <!-- Sidebar -->
            <div class="bg-light" style="width: 100%; min-width: 250px; max-width: 300px; height: 100vh; " id="sidebar">
                <button id="toggleSidebar" class="btn d-flex justify-content-between text-white bg-primary p-3 rounded w-100">
                    <span class="fw-bold">Course Content</span>
                    <i class="bi bi-chevron-left ps-3"></i>
                </button>    
                <!-- Progress -->
                <div class="p-3 border-bottom" id="progressSection" style="background-color: #f1f5f9;">
                    <div class="text-muted mb-2" style="font-size: 14px;">
                        Course Progress: ${completedCount} of ${totalLessons} lessons completed
                    </div>
                    <div class="bg-light rounded-pill" style="height: 8px; overflow: hidden;">
                        <div class="bg-success rounded-pill h-100 transition-all" style="width: ${percentCompleted}%;"></div>
                    </div>
                </div>
                <!-- Chapter-->
                <c:forEach var="chapter" items="${chapter}">
                    <div class="flex-grow-1">
                        <!-- Chapter Title Collapse Button -->
                        <button
                            class="w-100 text-start d-flex justify-content-between align-items-center p-3 bg-light border-bottom border-0"
                            type="button" data-bs-toggle="collapse" data-bs-target="#chapter${chapter.chapterID}" aria-expanded="false"
                            aria-controls="chapter${chapter.chapterID}">
                            <h5 class="fw-semibold text-dark m-0" style="font-size: 16px;">${chapter.title}</h5>
                            <i class="bi bi-chevron-down text-primary chapter-icon"></i>
                        </button>

                        <!-- Chapter Lessons and Quizzes -->
                        <div class="collapse" id="chapter${chapter.chapterID}">
                            <c:forEach var="item" items="${chapterContent[chapter]}">
                                <c:choose>
                                    <c:when test="${item.type == 'lesson'}">
                                        <c:set var="lesson" value="${item.data}" />
                                        <a href="LessonView?courseID=${chapter.courseID}&lessonID=${lesson.lessonID}" class="lesson-item d-flex align-items-center px-3 py-2 text-decoration-none"
                                           style="cursor: pointer;">
                                            <div class="icon-wrapper rounded-circle bg-success text-white d-flex align-items-center justify-content-center me-2"
                                                 style="width: 15px; height: 15px;">
                                                <i class="bi bi-play-fill"></i>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <span class="text-truncate" style="color: #1e293b;">
                                                    ${lesson.title}
                                                </span>
                                            </div>
                                        </a>
                                    </c:when>
                                    <c:when test="${item.type == 'quiz'}">
                                        <c:set var="quiz" value="${item.data}" />
                                        <a href="quizLesson?quizId=${lesson.lessonID}" class="lesson-item d-flex align-items-center px-3 py-2 bg-light" style="cursor: pointer;">
                                            <div class="icon-wrapper rounded-circle bg-warning text-dark d-flex align-items-center justify-content-center me-2"
                                                 style="width: 15px; height: 15px;">
                                                <i class="bi bi-question-circle"></i>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <span class="text-truncate" style="color: #1e293b;">
                                                    Quiz: ${quiz.quizName}
                                                </span>
                                                <span class="badge bg-warning text-dark ms-2">${quiz.quizType}</span>
                                            </div>
                                        </a>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Main Content -->
            <div class="flex-grow-1 d-flex flex-column">
                <!-- Content Header -->
                <div class="bg-white p-3 border-bottom d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <button id="mobileMenuBtn" class="btn btn-link p-0 me-3 fs-5" style="color: #374151;">
                            <i class="bi bi-list"></i>
                        </button>
                        <h2 class="m-0" id="currentLessonTitle" style="font-size: 18px; color: #1e293b;">
                            <c:out value="${selectedLesson.title}" default="Select a lesson to view" />
                        </h2>
                    </div>
                </div>
                <!-- Video Container -->
                <c:if test="${not empty selectedLesson.lessonContent.videoURL}">
                    <c:set var="videoURL" value="${selectedLesson.lessonContent.videoURL}" />
                    <c:choose>
                        <c:when test="${fn:contains(videoURL, 'watch?v=')}">
                            <c:set var="embedUrl" value="${fn:replace(videoURL, 'watch?v=', 'embed/')}" />
                        </c:when>
                        <c:when test="${fn:contains(videoURL, 'youtu.be/')}">
                            <c:set var="embedUrl" value="${fn:replace(videoURL, 'youtu.be/', 'www.youtube.com/embed/')}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="embedUrl" value="${videoURL}" />
                        </c:otherwise>
                    </c:choose>
                    <div class="m-4">
                        <div class="ratio ratio-16x9">
                            <iframe src="${embedUrl}" frameborder="0"
                                    allowfullscreen
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                    style="border: none;">
                            </iframe>
                        </div>
                    </div>
                </c:if>
                <!-- Lesson Content -->
                <div class="flex-grow-1 bg-white p-4" style="overflow-y: auto; font-size: 15px; color: #475569;">
                    <h3 class="mb-3 text-dark fw-semibold" style="font-size: 18px;">Lesson Content</h3>
                    <div style="line-height: 1.6;">
                        <c:out value="${selectedLesson.lessonContent.docContent}" escapeXml="false" />
                    </div>
                </div>
                <!-- Content Actions -->
                <div class="bg-white p-3 border-top d-flex justify-content-between align-items-center" style="position: sticky; bottom: 0;">
                    <div>
                        <small style="color: #64748b;">Lesson complete ${completedCount}  in Total: ${totalLessons}</small>
                    </div>
                    <form method="post" action="LessonView" class="m-0">
                        <input type="hidden" name="courseID" value="${courseID}" />
                        <input type="hidden" name="lessonID" value="${selectedLesson.lessonID}" />
                        <button class="btn btn-success d-flex align-items-center gap-2" style="font-weight: 500;">
                            <i class="bi bi-check-circle"></i> Mark as Complete
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const sidebar = document.getElementById("sidebar");
                const mainContainer = document.getElementById("mainContainer");
                const toggleBtn = document.getElementById("toggleSidebar");
                const mobileBtn = document.getElementById("mobileMenuBtn");

                toggleBtn?.addEventListener("click", function () {
                    sidebar.classList.add("d-none");
                    mobileBtn.classList.remove("d-none");
                    mainContainer.classList.remove("flex-md-row");
                    mainContainer.classList.add("flex-column");
                });

                mobileBtn?.addEventListener("click", function () {
                    sidebar.classList.remove("d-none");
                    mobileBtn.classList.add("d-none");
                    mainContainer.classList.add("flex-md-row");
                    mainContainer.classList.remove("flex-column");
                });
            });
        </script>

    </body>
</html>
