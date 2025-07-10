<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Quiz"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quizzes List</title>

        <%-- Nhúng Tailwind CSS (sử dụng CDN cho đơn giản) --%>
        <script src="https://cdn.tailwindcss.com"></script>
        <%-- Nhúng Font Awesome (sử dụng CDN cho các biểu tượng) --%>
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
            /* CSS cho nút active view */
            .active-view-btn {
                background-color: #4f46e5; /* indigo-600 */
                color: white;
                border-color: #4f46e5;
            }
            .active-view-btn:hover {
                background-color: #4338ca; /* indigo-700 */
            }

            /* CSS cho ẩn cột/hàng (quan trọng: !important để đảm bảo ghi đè) */
            .hidden-col {
                display: none !important;
            }

            /* Tùy chỉnh cho checkbox dropdown menu của Tailwind */
            .form-checkbox { /* Tùy chỉnh checkbox cơ bản */
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                display: inline-block;
                vertical-align: middle;
                height: 1rem;
                width: 1rem;
                cursor: pointer;
                background-color: #fff;
                border: 1px solid #d1d5db;
                border-radius: 0.25rem;
            }
            .form-checkbox:checked {
                background-color: #4f46e5;
                border-color: #4f46e5;
                background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='white' xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M12.207 4.793a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0l-2-2a1 1 0 011.414-1.414L6.5 9.086l4.293-4.293a1 1 0 011.414 0z'/%3e%3c/svg%3e");
            }
            .form-checkbox:focus {
                outline: 2px solid transparent;
                outline-offset: 2px;
                box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.5); /* focus:ring-indigo-500 */
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
        </style>
    </head>
    <body class="bg-gray-100 font-sans leading-normal tracking-normal">
        <%@include file="../includes/navbar.jsp" %>
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
                    <form action="${pageContext.request.contextPath}/quizzes" method="GET">
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

                <%-- Các nút chuyển đổi chế độ xem và ẩn/hiện cột/hàng --%>
                <div class="flex justify-between items-center mb-4">
                    <div class="flex space-x-2">
                        <div class="relative inline-block text-left">
                            <button type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" id="columnToggleMenuButton" aria-expanded="true" aria-haspopup="true">
                                <i class="fas fa-eye-slash mr-2"></i> Ẩn/Hiện Cột
                                <i class="fas fa-chevron-down ml-2 -mr-1"></i>
                            </button>
                            <div class="origin-top-right absolute left-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none hidden" role="menu" aria-orientation="vertical" aria-labelledby="columnToggleMenuButton" id="columnToggleMenu">
                                <div class="py-1" role="none">
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="0" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">ID</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="1" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Name</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="2" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Subject</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="3" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Level</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="4" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2"># Questions</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="5" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Duration (min)</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="6" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Pass Rate (%)</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="7" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Quiz Type</span>
                                    </label>
                                    <label class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                        <input type="checkbox" data-col-target="8" checked class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out">
                                        <span class="ml-2">Actions</span>
                                    </label>
                                </div>
                                <div class="px-4 py-2 border-t border-gray-200 text-right">
                                    <button class="px-3 py-1 text-sm rounded-md bg-indigo-600 text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" id="applyColumnChangesBtn">OK</button>
                                </div>
                            </div>
                        </div>
                        <button id="toggleAllRowsBtn" class="px-4 py-2 rounded-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            <i class="fas fa-eye-slash mr-2"></i> Ẩn Tất Cả Hàng
                        </button>
                    </div>

                    <div class="flex space-x-2">
                        <button id="listViewBtn" class="px-4 py-2 rounded-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 active-view-btn">
                            <i class="fas fa-list"></i> List View
                        </button>
                        <button id="gridViewBtn" class="px-4 py-2 rounded-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            <i class="fas fa-th-large"></i> Grid View
                        </button>
                    </div>
                </div>

                <div id="quizListContainer" class="bg-white rounded-lg shadow-sm overflow-hidden">
                    <%-- HIỂN THỊ DẠNG BẢNG (MẶC ĐỊNH) --%>
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
                                <tr data-row-index="<%= rowIndex %>" class="hover:bg-gray-50">
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
                                        <%= String.format("%.2f", quiz.getPassRate())%>
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
                                    <td colspan="9" class="px-6 py-4 text-center text-gray-500">
                                        Không tìm thấy bài kiểm tra nào.
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <%-- HIỂN THỊ DẠNG LƯỚI --%>
                    <div id="gridView" class="hidden p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                        <%
                            if (quizzes != null && !quizzes.isEmpty()) {
                                for (Quiz quiz : quizzes) {
                        %>
                        <div class="bg-white rounded-lg shadow-md border border-gray-200 p-4 flex flex-col justify-between">
                            <div>
                                <h3 class="text-lg font-semibold text-gray-900 mb-2"><%= quiz.getQuizName()%></h3>
                                <p class="text-sm text-gray-600 mb-1">
                                    <i class="fas fa-book mr-1 text-indigo-500"></i> <strong>Subject:</strong> <%= quiz.getSubject()%>
                                </p>
                                <p class="text-sm text-gray-600 mb-1">
                                    <i class="fas fa-hourglass-half mr-1 text-blue-500"></i> <strong>Duration:</strong> <%= quiz.getDurationMinutes()%> min
                                </p>
                                <p class="text-sm text-gray-600 mb-1">
                                    <i class="fas fa-question-circle mr-1 text-green-500"></i> <strong>Questions:</strong> <%= quiz.getNumQuestions()%>
                                </p>
                                <p class="text-sm text-gray-600 mb-2">
                                    <i class="fas fa-percent mr-1 text-purple-500"></i> <strong>Pass Rate:</strong> <%= String.format("%.2f", quiz.getPassRate())%>%
                                </p>
                                <div class="mb-3">
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
                                    <span class="ml-2 px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                                        <%= quiz.getQuizType()%>
                                    </span>
                                </div>
                            </div>
                            <div class="flex justify-end space-x-2 mt-4 border-t pt-3">
                                <%
                                    boolean canEdit = (quiz.getQuestionOrder() == null || quiz.getQuestionOrder() == 0);
                                %>
                                <a href="${pageContext.request.contextPath}/quizDetail?id=<%= quiz.getQuizID()%>"
                                   class="tooltip px-3 py-1 text-sm rounded-md <%= canEdit ? "bg-indigo-500 text-white hover:bg-indigo-600" : "bg-gray-300 text-gray-500 cursor-not-allowed pointer-events-none"%>"
                                   <%= canEdit ? "" : "onclick=\"return false;\""%>>
                                    <i class="fas fa-edit mr-1"></i> Edit
                                    <% if (!canEdit) { %>
                                    <span class="tooltiptext">Không thể chỉnh sửa - đã có lượt làm bài</span>
                                    <% }%>
                                </a>
                                <button type="button" onclick="showDeleteModal('<%= quiz.getQuizID()%>')"
                                        class="px-3 py-1 text-sm rounded-md bg-red-500 text-white hover:bg-red-600">
                                    <i class="fas fa-trash mr-1"></i> Delete
                                </button>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="col-span-full text-center py-8 text-gray-500">
                            Không tìm thấy bài kiểm tra nào.
                        </div>
                        <% } %>
                    </div>
                </div>

                <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                    <div class="flex-1 flex justify-between sm:hidden">
                        <%-- Nút Previous/Next cho di động --%>
                        <%
                            int currentPage = (Integer) request.getAttribute("currentPage");
                            int totalPages = (Integer) request.getAttribute("totalPages");
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
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                <%-- Nút Previous --%>
                                <a href="<%= (currentPage > 1) ? request.getContextPath() + "/quizzes?page=" + (currentPage - 1) + queryParams : "#"%>"
                                   class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 <%= (currentPage == 1) ? "opacity-50 cursor-not-allowed" : ""%>">
                                    <span class="sr-only">Previous</span>
                                    <i class="fas fa-chevron-left"></i>
                                </a>

                                <%-- Các nút số trang --%>
                                <% for (int i = 1; i <= totalPages; i++) {%>
                                <a href="${pageContext.request.contextPath}/quizzes?page=<%= i%><%= queryParams%>"
                                   class="relative inline-flex items-center px-4 py-2 border text-sm font-medium
                                          <%= (i == currentPage) ? "active" : "bg-white border-gray-300 text-gray-500 hover:bg-gray-50"%>">
                                    <%= i%>
                                </a>
                                <% }%>

                                <%-- Nút Next --%>
                                <a href="<%= (currentPage < totalPages) ? request.getContextPath() + "/quizzes?page=" + (currentPage + 1) + queryParams : "#"%>"
                                   class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 <%= (currentPage == totalPages) ? "opacity-50 cursor-not-allowed" : ""%>">
                                    <span class="sr-only">Next</span>
                                    <i class="fas fa-chevron-right"></i>
                                </a>

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

        <script>
            // Lấy các phần tử DOM cần thiết
            const deleteModal = document.getElementById('deleteModal');
            const cancelDeleteBtn = document.getElementById('cancelDelete');
            const modalQuizId = document.getElementById('modalQuizId');
            const resetFiltersBtn = document.getElementById('resetFilters');
            const filterForm = document.querySelector('form[method="GET"]');

            const listViewBtn = document.getElementById('listViewBtn');
            const gridViewBtn = document.getElementById('gridViewBtn');
            const tableView = document.getElementById('tableView');
            const gridView = document.getElementById('gridView');
            const quizListContainer = document.getElementById('quizListContainer');

            const quizTable = document.getElementById('quizTable');
            const quizTableBody = document.getElementById('quizTableBody');
            const columnToggleMenuButton = document.getElementById('columnToggleMenuButton');
            const columnToggleMenu = document.getElementById('columnToggleMenu');
            const toggleAllRowsBtn = document.getElementById('toggleAllRowsBtn');
            const applyColumnChangesBtn = document.getElementById('applyColumnChangesBtn'); // Nút OK

            // Biến tạm thời để lưu trạng thái cột đã chọn trong dropdown
            let tempHiddenColumns = new Set(); // Sử dụng Set để lưu các columnIndex cần ẩn


            // --- Hàm hiển thị/ẩn modal xóa (Tailwind CSS) ---
            function showDeleteModal(quizId) {
                modalQuizId.value = quizId;
                deleteModal.classList.remove('hidden'); // Hiển thị modal
            }

            function hideDeleteModal() {
                deleteModal.classList.add('hidden'); // Ẩn modal
                modalQuizId.value = '';
            }

            cancelDeleteBtn.addEventListener('click', hideDeleteModal);

            // --- Hàm Reset Filters ---
            resetFiltersBtn.addEventListener('click', () => {
                document.getElementById('searchName').value = '';
                document.getElementById('subject').value = '';
                document.getElementById('quizType').value = '';
                filterForm.submit();
            });

            // --- Logic đóng/mở dropdown ẩn/hiện cột (Tailwind CSS) ---
            columnToggleMenuButton.addEventListener('click', (event) => {
                event.stopPropagation(); // Ngăn sự kiện click lan ra ngoài
                columnToggleMenu.classList.toggle('hidden');
            });

            document.addEventListener('click', (event) => {
                // Đóng dropdown nếu click ra ngoài menu hoặc nút
                if (!columnToggleMenuButton.contains(event.target) && !columnToggleMenu.contains(event.target)) {
                    columnToggleMenu.classList.add('hidden');
                }
            });

            // --- Gắn sự kiện cho các checkbox trong menu ẩn/hiện cột ---
            document.querySelectorAll('#columnToggleMenu input[type="checkbox"]').forEach(checkbox => {
                checkbox.addEventListener('change', (event) => {
                    const columnIndex = parseInt(event.target.dataset.colTarget);
                    if (event.target.checked) {
                        tempHiddenColumns.delete(columnIndex); // Nếu checked, tức là muốn hiện, xóa khỏi set ẩn
                    } else {
                        tempHiddenColumns.add(columnIndex); // Nếu unchecked, tức là muốn ẩn, thêm vào set ẩn
                    }
                });
            });

            // --- Hàm áp dụng thay đổi cột khi nhấn OK ---
            applyColumnChangesBtn.addEventListener('click', () => {
                // Áp dụng trạng thái ẩn cho các cột
                document.querySelectorAll('#quizTable th, #quizTable td').forEach(cell => {
                    const columnIndex = parseInt(cell.dataset.colIndex);
                    if (tempHiddenColumns.has(columnIndex)) {
                        cell.classList.add('hidden-col');
                    } else {
                        cell.classList.remove('hidden-col');
                    }
                });

                // Lưu trạng thái cuối cùng vào localStorage
                localStorage.setItem('hiddenColumns', JSON.stringify(Array.from(tempHiddenColumns)));

                // Đóng dropdown menu sau khi áp dụng
                columnToggleMenu.classList.add('hidden');
            });

            // --- Hàm để ẩn/hiện tất cả các hàng ---
            let allRowsHidden = false;
            toggleAllRowsBtn.addEventListener('click', () => {
                const rows = quizTableBody.querySelectorAll('tr');
                rows.forEach(row => {
                    if (allRowsHidden) {
                        row.classList.remove('hidden-col');
                    } else {
                        row.classList.add('hidden-col');
                    }
                });
                allRowsHidden = !allRowsHidden;
                toggleAllRowsBtn.innerHTML = `<i class="fas ${allRowsHidden ? 'fa-eye' : 'fa-eye-slash'} mr-2"></i> ${allRowsHidden ? 'Hiện Tất Cả Hàng' : 'Ẩn Tất Cả Hàng'}`;
            });

            // --- Khôi phục trạng thái cột khi tải trang ---
            function restoreColumnState() {
                const storedHiddenColumns = JSON.parse(localStorage.getItem('hiddenColumns')) || [];
                tempHiddenColumns = new Set(storedHiddenColumns); // Khôi phục trạng thái tạm thời từ localStorage

                // Cập nhật trạng thái checkbox và ẩn/hiện cột theo storedHiddenColumns
                document.querySelectorAll('#columnToggleMenu input[type="checkbox"]').forEach(checkbox => {
                    const columnIndex = parseInt(checkbox.dataset.colTarget);
                    const cells = document.querySelectorAll(`#quizTable th[data-col-index="${columnIndex}"], #quizTable td[data-col-index="${columnIndex}"]`);

                    if (storedHiddenColumns.includes(columnIndex)) {
                        // Nếu cột này đáng lẽ phải ẩn
                        cells.forEach(cell => {
                            if (!cell.classList.contains('hidden-col')) {
                                cell.classList.add('hidden-col');
                            }
                        });
                        checkbox.checked = false; // Bỏ chọn checkbox
                    } else {
                        // Nếu cột này đáng lẽ phải hiện
                        cells.forEach(cell => {
                            if (cell.classList.contains('hidden-col')) {
                                cell.classList.remove('hidden-col');
                            }
                        });
                        checkbox.checked = true; // Chọn checkbox
                    }
                });
            }

            // --- Logic chuyển đổi chế độ xem (List/Grid) ---
            let currentView = localStorage.getItem('quizViewMode') || 'list';

            function updateView() {
                if (currentView === 'list') {
                    tableView.classList.remove('hidden');
                    gridView.classList.add('hidden');
                    listViewBtn.classList.add('active-view-btn');
                    gridViewBtn.classList.remove('active-view-btn');
                } else {
                    tableView.classList.add('hidden');
                    gridView.classList.remove('hidden');
                    listViewBtn.classList.remove('active-view-btn');
                    gridViewBtn.classList.add('active-view-btn');
                }
            }

            // --- Gọi các hàm khởi tạo khi DOM đã tải ---
            document.addEventListener('DOMContentLoaded', () => {
                updateView(); // Cập nhật chế độ xem trước
                restoreColumnState(); // Sau đó khôi phục trạng thái ẩn của cột
            });

            listViewBtn.addEventListener('click', () => {
                currentView = 'list';
                localStorage.setItem('quizViewMode', 'list');
                updateView();
            });

            gridViewBtn.addEventListener('click', () => {
                currentView = 'grid';
                localStorage.setItem('quizViewMode', 'grid');
                updateView();
            });
        </script>
        <%@include file="../includes/foot.jsp" %>
    </body>
</html>