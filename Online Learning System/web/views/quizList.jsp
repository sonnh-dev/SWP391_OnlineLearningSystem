<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Quiz"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                width: 140px; /* Tăng chiều rộng để chứa đủ chữ */
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1;
                bottom: 125%; /* Tooltip ở trên nút */
                left: 50%;
                margin-left: -70px; /* Điều chỉnh lại margin-left */
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
        </style>
    </head>
    <body class="bg-gray-100 font-sans leading-normal tracking-normal">
        <div class="min-h-screen bg-gray-100">
            <header class="bg-indigo-600 text-white p-4 shadow-md">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex justify-between items-center">
                    <h1 class="text-3xl font-bold">Quizzes List</h1>
                    <%-- Nút thêm mới đặt ở đây cho dễ nhìn --%>
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
                                    <%-- Thêm các Subject khác từ DB hoặc tĩnh --%>
                                </select>
                            </div>
                            <div>
                                <label for="quizType" class="block text-sm font-medium text-gray-700 mb-1">Quiz Type</label>
                                <select name="quizType" id="quizType" class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                    <option value="">All Types</option>
                                    <option value="Luyện tập" <%= "Luyện tập".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Luyện tập</option>
                                    <option value="Kiểm tra" <%= "Kiểm tra".equals(request.getAttribute("quizType")) ? "selected" : ""%>>Kiểm tra</option>
                                    <%-- Thêm các QuizType khác từ DB hoặc tĩnh --%>
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

                <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        ID
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Name
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Subject
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Level
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        # Questions
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Duration (min)
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Pass Rate (%)
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Quiz Type
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <%
                                    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
                                    if (quizzes != null && !quizzes.isEmpty()) {
                                        for (Quiz quiz : quizzes) {
                                %>
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                        <%= quiz.getQuizID()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <%= quiz.getQuizName()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <%= quiz.getSubject()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <%-- Badge màu cho Level --%>
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
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <%= quiz.getNumQuestions()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <%= quiz.getDurationMinutes()%> min
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <%= String.format("%.2f", quiz.getPassRate())%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <%= quiz.getQuizType()%>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div class="flex space-x-2">
                                            <%
                                                // Sử dụng questionOrder để kiểm tra số lượt làm bài
                                                // Giả định: nếu questionOrder = 0 hoặc NULL, có nghĩa là chưa có lượt làm bài.
                                                // Nếu questionOrder > 0, có nghĩa là đã có lượt làm bài.
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
                                            <%-- Nút Delete sẽ hiển thị modal xác nhận --%>
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
                                <p class="text-sm text-gray-700">
                                    <%
                                        // Để hiển thị chính xác "Showing X to Y of Z results",
                                        // bạn cần truyền tổng số lượng quiz (ví dụ: totalQuizCount) từ servlet
                                        // Nếu không, quizzes.size() chỉ trả về số lượng quiz trên trang hiện tại.
                                        int totalQuizzesCount = (request.getAttribute("totalQuizzesCount") != null) ? (Integer) request.getAttribute("totalQuizzesCount") : (quizzes != null ? quizzes.size() : 0);
                                        int itemsPerPage = 10; // Giả định số mục trên mỗi trang là 10. Điều chỉnh nếu khác.
                                        int startItem = (quizzes != null && !quizzes.isEmpty()) ? ((currentPage - 1) * itemsPerPage + 1) : 0;
                                        int endItem = (quizzes != null && !quizzes.isEmpty()) ? Math.min(currentPage * itemsPerPage, totalQuizzesCount) : 0;
                                    %>
                                    Showing <span class="font-medium"><%= startItem%></span> to <span class="font-medium"><%= endItem%></span> of <span class="font-medium"><%= totalQuizzesCount%></span> results
                                </p>
                            </div>
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
            const filterForm = document.querySelector('form[method="GET"]'); // Lấy form lọc GET

            // Hàm hiển thị modal xác nhận xóa
            function showDeleteModal(quizId) {
                modalQuizId.value = quizId; // Gán ID của quiz vào input hidden trong form xóa
                deleteModal.classList.remove('hidden'); // Hiển thị modal
            }

            // Hàm ẩn modal xác nhận xóa
            function hideDeleteModal() {
                deleteModal.classList.add('hidden'); // Ẩn modal
                modalQuizId.value = ''; // Xóa ID đã lưu
            }

            // Gắn sự kiện click cho nút "Hủy" trong modal
            cancelDeleteBtn.addEventListener('click', hideDeleteModal);

            // Gắn sự kiện click cho nút "Reset" trong phần lọc
            resetFiltersBtn.addEventListener('click', () => {
                document.getElementById('searchName').value = '';
                document.getElementById('subject').value = '';
                document.getElementById('quizType').value = '';
                // Gửi lại form để server xử lý reset các bộ lọc
                filterForm.submit();
            });
        </script>
    </body>
</html>