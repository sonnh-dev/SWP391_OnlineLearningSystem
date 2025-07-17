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
        <title>Quizzes List</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            /* CSS tùy chỉnh cho tooltip */
            .tooltip {
                position: relative;
                display: inline-block;
            }
            .tooltip .tooltiptext {
                visibility: hidden;
                width: 160px; /* Tăng chiều rộng để chứa đủ chữ */
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1;
                bottom: 125%; /* Tooltip ở trên nút */
                left: 50%;
                margin-left: -80px; /* Điều chỉnh lại margin-left */
                opacity: 0;
                transition: opacity 0.3s;
            }
            .tooltip .tooltiptext::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: #333 transparent transparent transparent;
            }
            .tooltip:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }
            /* Active page for pagination */
            .pagination .active {
                @apply z-10 bg-indigo-50 border-indigo-500 text-indigo-600;
            }
            /* CSS cho nút active view (chỉ cho List View, Grid View đã bị xóa) */
            .active-view-btn {
                background-color: #4f46e5; /* indigo-600 */
                color: white;
                border-color: #4f46e5;
            }
            .active-view-btn:hover {
                background-color: #4338ca; /* indigo-700 */
            }

            .text-indigo-600 {
                color: #4f46e5;
            }
            .transition {
                transition-property: background-color, border-color, color, fill, stroke, opacity, box-shadow, transform, filter, backdrop-filter;
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
                transition-duration: 150ms;
            }
            .ease-in-out {
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }
            /* Thêm CSS cho ẩn cột */
            .hidden-column {
                display: none !important;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans leading-normal tracking-normal">
       
        <div class="min-h-screen bg-gray-100">
            <header class="bg-indigo-600 text-white p-4 shadow-md">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex justify-between items-center">
                    <h1 class="text-3xl font-bold">Quizzes List</h1>
                    <%-- Nút thêm mới --%>
                    <a href="${pageContext.request.contextPath}/quizDetail"
                       class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-500 hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                        <i class="fas fa-plus mr-2"></i> Add New Quiz
                    </a>
                </div>
            </header>

            <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                <% if (request.getAttribute("errorMessage") != null) {%>
                <p class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                    <%= request.getAttribute("errorMessage")%>
                </p>
                <% } %>
                <% if (request.getAttribute("successMessage") != null) {%>
                <p class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                    <%= request.getAttribute("successMessage")%>
                </p>
                <% }%>

                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <form action="${pageContext.request.contextPath}/quizzes" method="GET" id="filterForm">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
                            <div class="col-span-1 md:col-span-2">
                                <label for="searchName" class="block text-sm font-medium text-gray-700 mb-1">Search</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="fas fa-search text-gray-400"></i>
                                    </div>
                                    <input type="text" name="searchName" id="searchName"
                                           class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                                           placeholder="Search by quiz name..."
                                           value="${searchName != null ? searchName : ''}">
                                </div>
                            </div>
                            <div>
                                <label for="subject" class="block text-sm font-medium text-gray-700 mb-1">Subject</label>
                                <select name="subject" id="subject" class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                    <option value="">All Subjects</option>
                                    <option value="Leadership" <%= "Leadership".equals(request.getAttribute("subject")) ? "selected" : ""%>>Leadership</option>
                                    <option value="Time Management" <%= "Time Management".equals(request.getAttribute("subject")) ? "selected" : ""%>>Time Management</option>
                                    <option value="Problem Solving" <%= "Problem Solving".equals(request.getAttribute("subject")) ? "selected" : ""%>>Problem Solving</option>
                                    <option value="Emotional Intelligence" <%= "Emotional Intelligence".equals(request.getAttribute("subject")) ? "selected" : ""%>>Emotional Intelligence</option>
                                    <option value="Communication" <%= "Communication".equals(request.getAttribute("subject")) ? "selected" : ""%>>Communication</option>
                                </select>
                            </div>
                            <div>
                                <label for="quizType" class="block text-sm font-medium text-gray-700 mb-1">Quiz Type</label>
                                <select name="quizType" id="quizType" class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                    <option value="">All Types</option>
                                    <option value="Luyện tập" <%= "Luyện tập".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Luyện tập</option>
                                    <option value="Kiểm tra" <%= "Kiểm tra".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Kiểm tra</option>
                                </select>
                            </div>
                        </div>
                        <div class="mt-4 flex justify-end">
                            <button type="button" id="resetFilters" class="mr-2 bg-white hover:bg-gray-100 text-gray-700 font-medium py-2 px-4 border border-gray-300 rounded-md">
                                Reset
                            </button>
                            <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2 px-4 rounded-md">
                                <i class="fas fa-filter mr-2"></i> Filter/Search
                            </button>
                        </div>
                    </form>
                </div>

                <div class="d-flex align-items-center justify-between pb-3 p-3 rounded-t border bg-white"
                     style="border-color: #dee2e6;">
                    <div style="cursor: pointer; margin-right: 8px;" id="optionCustom">
                        <i class="fas fa-sliders-h"></i> Tùy chỉnh hiển thị cột và phân trang
                    </div>
                </div>

               <div id="optionContent" class="px-4 py-3 bg-white border rounded-b mb-4" style="display: none">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div class="mb-3">
            <label class="block text-sm font-medium text-gray-700 mb-2 font-bold">Hiển thị thông tin cột:</label>

            <div class="form-check mb-2">
                <input class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out" type="checkbox" id="info-all" checked>
                <label class="ml-2 block text-sm text-gray-900" for="info-all">Hiển thị tất cả</label>
            </div>

            <div class="grid grid-cols-2 gap-2"> <%-- 2 cột để hiển thị gọn hơn --%>
                <c:set var="columnLabels" value="${['ID', 'Name', 'Subject', 'Level', '# Questions', 'Duration (min)', 'Pass Rate (%)', 'Quiz Type', 'Actions']}" />
                <c:forEach var="label" items="${columnLabels}" varStatus="loop">
                    <c:set var="key" value="${loop.index}" />
                    <div class="form-check flex items-center">
                        <input class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out info-checkbox" type="checkbox" id="info-${key}" value="${key}">
                        <label class="ml-2 text-sm text-gray-900" for="info-${key}">${label}</label>
                    </div>
                </c:forEach>
            </div>

            <div class="mt-4 flex items-center">
                <label for="rowsPerPage" class="block text-sm font-medium text-gray-700 mr-2 font-bold">Số hàng mỗi trang:</label>
                <select id="rowsPerPage" class="block w-auto py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                    <option value="5" selected>5</option>
                    <option value="10" >10</option>
                    <option value="20">20</option>
                    <option value="all">Tất cả</option>
                </select>
            </div>
        </div>
    </div>
</div>


                <div id="quizListContainer" class="bg-white rounded-lg shadow-sm overflow-hidden mt-4">
                    <%-- HIỂN THỊ DẠNG BẢNG (CHỈ CÒN DẠNG NÀY) --%>
                    <div id="tableView" class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200" id="quizTable">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="0">
                                        ID
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="1">
                                        Name
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="2">
                                        Subject
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="3">
                                        Level
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="4">
                                        # Questions
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="5">
                                        Duration (min)
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="6">
                                        Pass Rate (%)
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="7">
                                        Quiz Type
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" data-col-index="8">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200" id="quizTableBody">
                                <%
                                    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
                                    if (quizzes != null && !quizzes.isEmpty()) {
                                        for (int rowIndex = 0; rowIndex < quizzes.size(); rowIndex++) {
                                            Quiz quiz = quizzes.get(rowIndex);
                                %>
                                <tr data-row-index="<%= rowIndex%>" class="hover:bg-gray-50 quiz-row"> <%-- THÊM CLASS 'quiz-row' --%>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" data-col-index="0">
                                        <%= quiz.getQuizID()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" data-col-index="1">
                                        <%= quiz.getQuizName()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500" data-col-index="2">
                                        <%= quiz.getSubject()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500" data-col-index="3">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                                     <%
                                                         String level = quiz.getLevel();
                                                         if ("Beginner".equals(level)) {
                                                             out.print("bg-green-100 text-green-800");
                                                         } else if ("Intermediate".equals(level)) {
                                                             out.print("bg-yellow-100 text-yellow-800");
                                                         } else if ("Advanced".equals(level)) {
                                                             out.print("bg-red-100 text-red-800");
                                                         }
                                                     %>">
                                            <%= level%>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500" data-col-index="4">
                                        <%= quiz.getNumQuestions()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500" data-col-index="5">
                                        <%= quiz.getDurationMinutes()%> min
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500" data-col-index="6">
                                        <%= String.format("%.2f", quiz.getPassRate())%>%
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500" data-col-index="7">
                                        <%= quiz.getQuizType()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium" data-col-index="8">
                                        <div class="flex space-x-2">
                                            <%
                                                boolean canEdit = (quiz.getQuestionOrder() == null || quiz.getQuestionOrder() == 0);
                                            %>
                                            <a href="${pageContext.request.contextPath}/quizDetail?id=<%= quiz.getQuizID()%>"
                                               class="tooltip <%= canEdit ? "text-indigo-600 hover:text-indigo-900" : "text-gray-400 cursor-not-allowed pointer-events-none"%>"
                                               <%= canEdit ? "" : "onclick=\"return false;\""%>>
                                                <i class="fas fa-edit"></i>
                                                <% if (!canEdit) { %>
                                                <span class="tooltiptext">Không thể chỉnh sửa - đã có lượt làm bài</span>
                                                <% }%>
                                            </a>
                                            <button type="button" onclick="showDeleteModal('<%= quiz.getQuizID()%>')"
                                                    class="text-red-600 hover:text-red-900">
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
                                    <td colspan="9" class="px-6 py-4 text-center text-gray-500 no-quiz-message"> <%-- THÊM CLASS 'no-quiz-message' --%>
                                        Không tìm thấy bài kiểm tra nào.
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                    <div class="flex-1 flex justify-between sm:hidden">
                        <%-- Nút Previous/Next cho di động --%>
                        <%
                            // Sử dụng Integer thay vì int cho null check
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
                           class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 <%= (currentPage == 1) ? "opacity-50 cursor-not-allowed" : ""%>">
                            Previous
                        </a>

                        <a href="<%= (currentPage < totalPages) ? request.getContextPath() + "/quizzes?page=" + (currentPage + 1) + queryParams : "#"%>"
                           class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 <%= (currentPage == totalPages) ? "opacity-50 cursor-not-allowed" : ""%>">
                            Next
                        </a>

                    </div>
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">
                                Hiển thị <span class="font-medium" id="pagination-info-start">0</span> đến <span class="font-medium" id="pagination-info-end">0</span> của <span class="font-medium" id="pagination-info-total">0</span> kết quả
                            </p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination" id="pagination-nav"> <%-- THÊM ID 'pagination-nav' --%>
                                <%-- Các nút phân trang sẽ được tạo bằng JavaScript --%>
                            </nav>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <div id="deleteModal" class="fixed z-10 inset-0 overflow-y-auto hidden" aria-labelledby="modal-title" role="dialog" aria-modal="true">
            <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                    <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
                </div>
                <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
                <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <div class="sm:flex sm:items-start">
                            <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">
                                <i class="fas fa-exclamation-triangle text-red-600"></i>
                            </div>
                            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                                <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
                                    Xóa bài kiểm tra
                                </h3>
                                <div class="mt-2">
                                    <p class="text-sm text-gray-500">
                                        Bạn có chắc chắn muốn xóa bài kiểm tra này không? Thao tác này không thể hoàn tác.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                        <form id="deleteForm" action="${pageContext.request.contextPath}/quizzes" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="quizId" id="modalQuizId">
                            <button type="submit" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                                Xóa
                            </button>
                        </form>
                        <button type="button" id="cancelDelete" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Hủy
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/quizList.js"></script>
     
    </body>
</html>