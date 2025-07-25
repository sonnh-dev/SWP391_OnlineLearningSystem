<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Quiz"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quizzes List - Admin Panel</title>

        <%-- Bootstrap CSS --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <%-- Font Awesome CSS for icons (used in header, table actions, and footer) --%>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f7f9fc; /* Light gray background to match previous page */
                color: #333;
            }
            .main-content {
                padding-top: 40px;
                padding-bottom: 40px;
            }
            h1 {
                font-size: 2rem; /* Bootstrap h1 default */
                margin-bottom: 1.5rem; /* Bootstrap mb-3 */
                font-weight: 700; /* Bootstrap font-bold */
            }
            .header-bg {
                background-color: #4f46e5; /* Tailwind indigo-600 equivalent */
            }
            .btn-success-custom {
                background-color: #28a745; /* green-500 equivalent */
                border-color: #28a745;
                color: white;
            }
            .btn-success-custom:hover {
                background-color: #218838; /* green-600 equivalent */
                border-color: #218838;
            }
            .form-control-custom {
                border-radius: 0.375rem; /* rounded-md equivalent */
                box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); /* shadow-sm equivalent */
                border: 1px solid #ced4da; /* border-gray-300 equivalent */
            }
            .form-control-custom:focus {
                border-color: #6610f2; /* focus:border-indigo-500 equivalent */
                box-shadow: 0 0 0 0.25rem rgba(102, 16, 242, 0.25); /* focus:ring-indigo-500 equivalent */
            }
            .btn-indigo-custom {
                background-color: #4f46e5; /* indigo-600 equivalent */
                border-color: #4f46e5;
                color: white;
            }
            .btn-indigo-custom:hover {
                background-color: #4338ca; /* indigo-700 equivalent */
                border-color: #4338ca;
            }
            .bg-white-shadow {
                background-color: white;
                border-radius: 0.5rem; /* rounded-lg equivalent */
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow-sm equivalent */
            }

            /* Custom CSS for tooltip, adapted to Bootstrap context */
            .tooltip-custom {
                position: relative;
                display: inline-block;
            }
            .tooltip-custom .tooltiptext {
                visibility: hidden;
                width: 180px; /* Increased width */
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1050; /* Higher z-index than Bootstrap modals */
                bottom: 125%; /* Tooltip above button */
                left: 50%;
                margin-left: -90px; /* Center tooltip */
                opacity: 0;
                transition: opacity 0.3s;
            }
            .tooltip-custom .tooltiptext::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: #333 transparent transparent transparent;
            }
            .tooltip-custom:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }

            /* Status badges */
            .badge-beginner {
                background-color: #d1fae5; /* green-100 */
                color: #065f46; /* green-800 */
                padding: 0.25em 0.6em;
                border-radius: 0.25rem;
                font-size: 0.75em;
                font-weight: 600;
            }
            .badge-intermediate {
                background-color: #fffde7; /* yellow-100 */
                color: #92400e; /* yellow-800 */
                padding: 0.25em 0.6em;
                border-radius: 0.25rem;
                font-size: 0.75em;
                font-weight: 600;
            }
            .badge-advanced {
                background-color: #fee2e2; /* red-100 */
                color: #991b1b; /* red-800 */
                padding: 0.25em 0.6em;
                border-radius: 0.25rem;
                font-size: 0.75em;
                font-weight: 600;
            }

            /* Table styling */
            .table-responsive-custom {
                overflow-x: auto;
            }
            .table th, .table td {
                padding: 0.75rem;
                vertical-align: top;
                border-top: 1px solid #dee2e6;
            }
            .table th {
                background-color: #f8f9fa; /* light gray header */
                font-weight: 600;
                text-align: left;
                font-size: 0.75rem; /* text-xs */
                text-transform: uppercase; /* uppercase */
                letter-spacing: 0.05em; /* tracking-wider */
                color: #6c757d; /* text-gray-500 */
            }
            .table tbody tr:hover {
                background-color: #f8f9fa; /* hover:bg-gray-50 */
            }

            /* Pagination styling */
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem 1.5rem;
                border-top: 1px solid #dee2e6;
                background-color: white;
            }
            .pagination-info {
                font-size: 0.875rem; /* text-sm */
                color: #495057; /* text-gray-700 */
            }
            .pagination-info .font-weight-bold {
                font-weight: 700;
            }
            .pagination-links .page-item .page-link {
                color: #6c757d; /* text-gray-700 */
                background-color: white;
                border: 1px solid #dee2e6;
                border-radius: 0.25rem;
                margin-left: -1px; /* To make them touch */
            }
            .pagination-links .page-item:first-child .page-link {
                border-top-left-radius: 0.25rem;
                border-bottom-left-radius: 0.25rem;
            }
            .pagination-links .page-item:last-child .page-link {
                border-top-right-radius: 0.25rem;
                border-bottom-right-radius: 0.25rem;
            }
            .pagination-links .page-item.active .page-link {
                z-index: 1;
                color: #fff;
                background-color: #4f46e5; /* indigo-600 */
                border-color: #4f46e5;
            }
            .pagination-links .page-item.disabled .page-link {
                color: #6c757d;
                pointer-events: none;
                background-color: #fff;
                border-color: #dee2e6;
                opacity: 0.65;
            }
            .pagination-links .page-link:hover {
                z-index: 2;
                color: #4338ca; /* indigo-700 */
                background-color: #e9ecef;
                border-color: #dee2e6;
            }

            /* Column Customization Panel */
            #optionContent {
                border: 1px solid #dee2e6; /* border-gray-200 */
                padding: 1rem; /* p-4 */
                background-color: white; /* bg-white */
                border-radius: 0.5rem; /* rounded-lg */
                margin-bottom: 1rem; /* mb-4 */
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow-sm */
            }
            #optionCustom {
                cursor: pointer;
                margin-right: 0.5rem;
                padding: 0.5rem;
                border: 1px solid #dee2e6;
                border-radius: 0.25rem;
                background-color: white;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #495057;
            }
            #optionCustom:hover {
                background-color: #f8f9fa;
            }
            .hidden-column {
                display: none !important;
            }
            /* Styling for the modal (delete confirmation) */
            .modal-dialog {
                max-width: 500px; /* sm:max-w-lg */
            }
            .modal-content {
                border-radius: 0.5rem; /* rounded-lg */
                overflow: hidden; /* overflow-hidden */
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04); /* shadow-xl */
            }
            .modal-header {
                padding: 1.25rem 1.5rem; /* px-4 pt-5 pb-4 sm:p-6 sm:pb-4 */
                background-color: #fff;
                border-bottom: none;
            }
            .modal-body {
                padding: 0 1.5rem 1rem;
            }
            .modal-footer {
                padding: 0.75rem 1.5rem; /* px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse */
                background-color: #f8f9fa; /* bg-gray-50 */
                border-top: none;
                display: flex;
                justify-content: flex-end; /* sm:flex-row-reverse */
            }
            .modal-icon-wrapper {
                margin: auto; /* mx-auto */
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 3rem; /* h-12 */
                width: 3rem; /* w-12 */
                border-radius: 9999px; /* rounded-full */
                background-color: #fee2e2; /* bg-red-100 */
                margin-bottom: 0.75rem; /* mt-3 */
            }
            .modal-icon {
                color: #ef4444; /* text-red-600 */
            }
            .modal-title-text {
                font-size: 1.125rem; /* text-lg */
                line-height: 1.75rem; /* leading-6 */
                font-weight: 500; /* font-medium */
                color: #1a202c; /* text-gray-900 */
            }
            .modal-description-text {
                margin-top: 0.5rem; /* mt-2 */
                font-size: 0.875rem; /* text-sm */
                color: #6b7280; /* text-gray-500 */
            }
            .btn-danger-custom {
                background-color: #ef4444; /* red-600 */
                border-color: #ef4444;
                color: white;
            }
            .btn-danger-custom:hover {
                background-color: #dc2626; /* red-700 */
                border-color: #dc2626;
            }
            .btn-outline-secondary-custom {
                background-color: white;
                border-color: #ced4da; /* gray-300 */
                color: #495057; /* gray-700 */
            }
            .btn-outline-secondary-custom:hover {
                background-color: #f8f9fa; /* gray-50 */
            }
        </style> 
    </head>
    <body class="bg-gray-100 font-sans leading-normal tracking-normal">

        <div class="min-h-screen bg-gray-100">
            <header class="header-bg text-white p-4 shadow-sm">
                <div class="container d-flex justify-content-between align-items-center">
                    <h1 class="text-white my-0">Quizzes List</h1> <%-- Use Bootstrap heading and remove margin for alignment --%>
                    <%-- Nút thêm mới --%>
                    <a href="${pageContext.request.contextPath}/quizDetail"
                       class="btn btn-success-custom d-inline-flex align-items-center">
                        <i class="fas fa-plus me-2"></i> Add New Quiz
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
                        <i class="fas fa-home me-1"></i> Back to Home
                    </a>
                </div>
            </header>

            <main class="container main-content">
                <% if (request.getAttribute("errorMessage") != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("errorMessage")%>
                </div>
                <% } %>
                <% if (request.getAttribute("successMessage") != null) {%>
                <div class="alert alert-success" role="alert">
                    <%= request.getAttribute("successMessage")%>
                </div>
                <% }%>

                <div class="bg-white-shadow p-4 mb-4"> <%-- Replaced shadow-sm p-6 with p-4 mb-4 for consistency --%>
                    <form action="${pageContext.request.contextPath}/quizzes" method="GET" id="filterForm">
                        <div class="row g-3 align-items-end"> <%-- Use Bootstrap row and gap --%>
                            <div class="col-12 col-md-6"> <%-- col-span-1 md:col-span-2 --%>
                                <label for="searchName" class="form-label mb-1">Search</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search text-muted"></i></span>
                                    <input type="text" name="searchName" id="searchName"
                                           class="form-control form-control-custom"
                                           placeholder="Search by quiz name..."
                                           value="${searchName != null ? searchName : ''}">
                                </div>
                            </div>
                            <div class="col-12 col-md-3">
                                <label for="subject" class="form-label mb-1">Subject</label>
                                <select name="subject" id="subject" class="form-select form-control-custom">
                                    <option value="">All Subjects</option>
                                    <option value="Leadership" <%= "Leadership".equals(request.getAttribute("subject")) ? "selected" : ""%>>Leadership</option>
                                    <option value="Time Management" <%= "Time Management".equals(request.getAttribute("subject")) ? "selected" : ""%>>Time Management</option>
                                    <option value="Problem Solving" <%= "Problem Solving".equals(request.getAttribute("subject")) ? "selected" : ""%>>Problem Solving</option>
                                    <option value="Emotional Intelligence" <%= "Emotional Intelligence".equals(request.getAttribute("subject")) ? "selected" : ""%>>Emotional Intelligence</option>
                                    <option value="Communication" <%= "Communication".equals(request.getAttribute("subject")) ? "selected" : ""%>>Communication</option>
                                </select>
                            </div>
                            <div class="col-12 col-md-3">
                                <label for="quizType" class="form-label mb-1">Quiz Type</label>
                                <select name="quizType" id="quizType" class="form-select form-control-custom">
                                    <option value="">All Types</option>
                                    <option value="Course Assessment" <%= "Course Assessment".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Course Assessment</option>
                                    <option value="Practice" <%= "Practice".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Practice</option>
                                    <option value="Learn" <%= "Learn".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Learn</option>
                                </select>
                            </div>
                        </div>
                        <div class="mt-4 d-flex justify-content-end">
                            <button type="button" id="resetFilters" class="btn btn-outline-secondary me-2">
                                Reset
                            </button>
                            <button type="submit" class="btn btn-indigo-custom">
                                <i class="fas fa-filter me-2"></i> Filter/Search
                            </button>
                        </div>
                    </form>
                </div>

                <div class="d-flex align-items-center justify-content-between p-3 rounded-top border bg-white"
                     style="border-color: #dee2e6;">
                    <div style="cursor: pointer;" id="optionCustom" class="tooltip-custom">
                        <i class="fas fa-sliders-h"></i> Customize column display and pagination
                    </div>
                </div>

                <div id="optionContent" class="px-4 py-3 bg-white border rounded-bottom mb-4" style="display: none">
                    <div class="row g-3">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-bold mb-2">Display column information:</label>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="info-all" checked>
                                <label class="form-check-label" for="info-all">Show all</label>
                            </div>
                            <div class="row g-2"> <%-- Use Bootstrap row and gap for 2 columns --%>
                                <c:set var="columnLabels" value="${['ID', 'Name', 'Subject', 'Level', '# Questions', 'Duration (min)', 'Pass Rate (%)', 'Quiz Type', 'Actions']}" />
                                <c:forEach var="label" items="${columnLabels}" varStatus="loop">
                                    <div class="col-6"> <%-- Each checkbox in a col-6 for two columns --%>
                                        <div class="form-check d-flex align-items-center">
                                            <input class="form-check-input info-checkbox" type="checkbox" id="info-${loop.index}" value="${loop.index}">
                                            <label class="form-check-label ms-2" for="info-${loop.index}">${label}</label>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 d-flex align-items-center mt-4 mt-md-0">
                            <label for="rowsPerPage" class="form-label fw-bold me-2 mb-0">Number of rows per page:</label>
                            <select id="rowsPerPage" class="form-select w-auto">
                                <option value="5" selected>5</option>
                                <option value="10" >10</option>
                                <option value="20">20</option>
                                <option value="all">All</option>
                            </select>
                        </div>
                    </div>
                </div>


                <div id="quizListContainer" class="bg-white-shadow overflow-hidden mt-4">
                    <%-- TABLE DISPLAY --%>
                    <div id="tableView" class="table-responsive-custom">
                        <table class="table table-hover mb-0" id="quizTable"> <%-- Added table-hover and mb-0 (margin-bottom:0) --%>
                            <thead class="bg-light">
                                <tr>
                                    <th scope="col" data-col-index="0">ID</th>
                                    <th scope="col" data-col-index="1">Name</th>
                                    <th scope="col" data-col-index="2">Subject</th>
                                    <th scope="col" data-col-index="3">Level</th>
                                    <th scope="col" data-col-index="4"># Questions</th>
                                    <th scope="col" data-col-index="5">Duration (min)</th>
                                    <th scope="col" data-col-index="6">Pass Rate (%)</th>
                                    <th scope="col" data-col-index="7">Quiz Type</th>
                                    <th scope="col" data-col-index="8">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="quizTableBody">
                                <%
                                    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
                                    if (quizzes != null && !quizzes.isEmpty()) {
                                        for (int rowIndex = 0; rowIndex < quizzes.size(); rowIndex++) {
                                            Quiz quiz = quizzes.get(rowIndex);
                                %>
                                <tr data-row-index="<%= rowIndex%>" class="quiz-row">
                                    <td data-col-index="0"><%= quiz.getQuizID()%></td>
                                    <td data-col-index="1"><%= quiz.getQuizName()%></td>
                                    <td data-col-index="2"><%= quiz.getSubject()%></td>
                                    <td data-col-index="3">
                                        <span class="badge
                                              <%
                                                  String level = quiz.getLevel();
                                                  if ("Beginner".equals(level)) {
                                                      out.print("badge-beginner");
                                                  } else if ("Intermediate".equals(level)) {
                                                      out.print("badge-intermediate");
                                                  } else if ("Advanced".equals(level)) {
                                                      out.print("badge-advanced");
                                                  }
                                              %>">
                                            <%= level%>
                                        </span>
                                    </td>
                                    <td data-col-index="4"><%= quiz.getNumQuestions()%></td>
                                    <td data-col-index="5"><%= quiz.getDurationMinutes()%> min</td>
                                    <td data-col-index="6"><%= String.format("%.2f", quiz.getPassRate())%>%</td>
                                    <td data-col-index="7"><%= quiz.getQuizType()%></td>
                                    <td data-col-index="8">
                                        <div class="d-flex gap-2"> <%-- Use Bootstrap gap for spacing --%>
                                            <%
                                                boolean canEdit = (quiz.getQuestionOrder() == null || quiz.getQuestionOrder() == 0);
                                            %>
                                            <a href="${pageContext.request.contextPath}/quizDetail?id=<%= quiz.getQuizID()%>"
                                               class="tooltip-custom <%= canEdit ? "text-primary" : "text-secondary disabled-link"%>" <%-- text-primary for Bootstrap blue, text-secondary for gray --%>
                                               <%= canEdit ? "" : "onclick=\"return false;\""%>>
                                                <i class="fas fa-edit"></i>
                                                <% if (!canEdit) { %>
                                                <span class="tooltiptext">Không thể chỉnh sửa - đã có lượt làm bài</span>
                                                <% }%>
                                            </a>
                                            <button type="button" onclick="showDeleteModal('<%= quiz.getQuizID()%>')"
                                                    class="btn btn-link text-danger p-0 border-0"> <%-- Use btn-link to make it look like text, remove padding/border --%>
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="9" class="text-center text-muted no-quiz-message">
                                        Không tìm thấy bài kiểm tra nào.
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="pagination-container mt-4"> <%-- Custom class for pagination container --%>
                    <div class="d-none d-sm-block"> <%-- hidden sm:flex-1 sm:flex sm:items-center sm:justify-between for mobile hide --%>
                        <p class="pagination-info">
                            Hiển thị <span class="font-weight-bold" id="pagination-info-start">0</span> đến <span class="font-weight-bold" id="pagination-info-end">0</span> của <span class="font-weight-bold" id="pagination-info-total">0</span> kết quả
                        </p>
                    </div>
                    <div>
                        <nav aria-label="Pagination">
                            <ul class="pagination mb-0" id="pagination-nav"> <%-- Use Bootstrap's pagination classes --%>
                                <%-- Pagination buttons will be generated by JavaScript --%>
                            </ul>
                        </nav>
                    </div>
                    <%-- Mobile Previous/Next buttons (Bootstrap's default is a single list, this mimics the Tailwind flex-between) --%>
                    <div class="d-flex justify-content-between w-100 d-sm-none">
                        <%
                            Integer currentPageObj = (Integer) request.getAttribute("currentPage");
                            Integer totalPagesObj = (Integer) request.getAttribute("totalPages");
                            int currentPage = (currentPageObj != null) ? currentPageObj : 1;
                            int totalPages = (totalPagesObj != null) ? totalPagesObj : 1;
                            String searchName = (String) request.getAttribute("searchName");
                            String subject = (String) request.getAttribute("subject");
                            String quizType = (String) request.getAttribute("quizType");

                            String queryParams = "";
                            if (searchName != null && !searchName.isEmpty()) {
                                queryParams += "&searchName=" + searchName;
                            }
                            if (subject != null && !subject.isEmpty()) {
                                queryParams += "&subject=" + subject;
                            }
                            if (quizType != null && !quizType.isEmpty())
                                queryParams += "&quizType=" + quizType;
                        %>
                        <a href="<%= (currentPage > 1) ? request.getContextPath() + "/quizzes?page=" + (currentPage - 1) + queryParams : "#"%>"
                           class="btn btn-outline-secondary <%= (currentPage == 1) ? "disabled" : ""%>">
                            Previous
                        </a>
                        <a href="<%= (currentPage < totalPages) ? request.getContextPath() + "/quizzes?page=" + (currentPage + 1) + queryParams : "#"%>"
                           class="btn btn-outline-secondary <%= (currentPage == totalPages) ? "disabled" : ""%>">
                            Next
                        </a>
                    </div>
                </div>
            </main>
        </div>

        <%-- Delete Confirmation Modal --%>
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="modal-title" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header d-flex flex-column align-items-center border-0 pb-0">
                        <div class="modal-icon-wrapper mb-3">
                            <i class="fas fa-exclamation-triangle modal-icon fa-2x"></i>
                        </div>
                        <h5 class="modal-title text-center modal-title-text" id="modal-title">Xóa bài kiểm tra</h5>
                    </div>
                    <div class="modal-body text-center pt-0">
                        <p class="modal-description-text">
                            Bạn có chắc chắn muốn xóa bài kiểm tra này không? Thao tác này không thể hoàn tác.
                        </p>
                    </div>
                    <div class="modal-footer justify-content-end border-0 pt-0">
                        <form id="deleteForm" action="${pageContext.request.contextPath}/quizzes" method="POST" class="d-inline-block">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="quizId" id="modalQuizId">
                            <button type="submit" class="btn btn-danger-custom">
                                Xóa
                            </button>
                        </form>
                        <button type="button" id="cancelDelete" class="btn btn-outline-secondary-custom" data-bs-dismiss="modal">
                            Hủy
                        </button>
                    </div>
                </div>
            </div>

        </div>

        <%-- Bootstrap JavaScript Bundle (includes Popper.js) --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <%-- Your custom JavaScript file for quiz list functionality --%>
        <script src="${pageContext.request.contextPath}/assets/js/quizList.js"></script>
        <%-- Include the footer --%>
        <%@include file="../includes/foot.jsp"%>
    </body>
</html>