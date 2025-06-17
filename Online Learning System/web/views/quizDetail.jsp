<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz"%>
<%@page import="model.Question"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Details</title>
        <%-- Nhúng Tailwind CSS (sử dụng CDN cho đơn giản) --%>
        <script src="https://cdn.tailwindcss.com"></script>
        <%-- Nhúng Font Awesome (sử dụng CDN cho các biểu tượng) --%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* Các CSS tùy chỉnh nếu cần */
            /* Để các option-row có khoảng cách trong phần questions list */
            .question-row {
                @apply hover:bg-gray-50;
            }
            .question-row td {
                @apply px-6 py-4 whitespace-nowrap text-sm;
            }
            .question-row td:first-child {
                @apply font-medium text-gray-900;
            }
            .question-row td:not(:first-child) {
                @apply text-gray-500;
            }
            .question-row td:last-child {
                @apply font-medium;
            }
            /* Style cho nút "Delete" trong bảng câu hỏi */
            .question-row form button {
                @apply text-red-600 hover:text-red-900 ml-2;
            }

            /* Tooltip cho nút Edit/Delete (nếu cần dùng) */
            .tooltip {
                position: relative;
                display: inline-block;
            }
            .tooltip .tooltiptext {
                visibility: hidden;
                width: 140px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1;
                bottom: 125%; /* Tooltip ở trên nút */
                left: 50%;
                margin-left: -70px;
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

            /* CSS cho tabs */
            .tab-button.active {
                @apply border-b-2 border-indigo-500 text-indigo-600;
            }
            .tab-content {
                display: none; /* Mặc định ẩn tất cả nội dung tab */
            }
            .tab-content.active {
                display: block; /* Hiển thị nội dung tab đang hoạt động */
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans leading-normal tracking-normal">
        <div class="min-h-screen bg-gray-100">
            <header class="bg-indigo-600 text-white p-4 shadow-md">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <%
                        Quiz quiz = (Quiz) request.getAttribute("quiz");
                        Boolean canEditObj = (Boolean) request.getAttribute("canEdit");
                        boolean canEdit = (canEditObj != null) ? canEditObj : false; // tránh NullPointerException
                        String pageTitle = (quiz == null || quiz.getQuizID() == 0) ? "Add New Quiz" : "Edit Quiz";
                    %>

                    <h1 class="text-3xl font-bold"><%= pageTitle%></h1>
                </div>
            </header>

            <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                <%-- Hiển thị thông báo lỗi/thành công --%>
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

                <div class="mb-6">
                    <div class="border-b border-gray-200">
                        <nav class="-mb-px flex space-x-8" aria-label="Tabs">
                            <button type="button" id="tab-details-btn"
                                    class="tab-button whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 active"
                                    data-tab="details">
                                <i class="fas fa-info-circle mr-2"></i>Chi tiết Quiz
                            </button>
                            <% if (quiz != null && quiz.getQuizID() > 0) { %>
                            <button type="button" id="tab-questions-btn"
                                    class="tab-button whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"
                                    data-tab="questions">
                                <i class="fas fa-question-circle mr-2"></i>Quản lý Câu hỏi
                            </button>
                            <% }%>
                        </nav>
                    </div>
                </div>

                <div id="tab-details" class="tab-content active bg-white rounded-lg shadow-sm p-6 mb-6">
                    <form action="${pageContext.request.contextPath}/quizzes" method="POST">
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="quizID" value="<%= (quiz != null) ? quiz.getQuizID() : 0%>">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="quizName" class="block text-sm font-medium text-gray-700 mb-1">Quiz Name:</label>
                                <input type="text" id="quizName" name="quizName"
                                       class="block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                       value="<%= (quiz != null && quiz.getQuizName() != null) ? quiz.getQuizName() : ""%>"
                                       <%= canEdit ? "" : "readonly"%> required>
                            </div>
                            <div>
                                <label for="subject" class="block text-sm font-medium text-gray-700 mb-1">Subject:</label>
                                <select name="subject" id="subject" class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                        <%= canEdit ? "" : "disabled"%>>
                                    <option value="">All Subjects</option>
                                    <option value="Leadership" <%= (quiz != null && "Leadership".equals(quiz.getSubject())) ? "selected" : ""%>>Leadership</option>
                                    <option value="Time Management" <%= (quiz != null && "Time Management".equals(quiz.getSubject())) ? "selected" : ""%>>Time Management</option>
                                    <option value="Problem Solving" <%= (quiz != null && "Problem Solving".equals(quiz.getSubject())) ? "selected" : ""%>>Problem Solving</option>
                                    <option value="Emotional Intelligence" <%= (quiz != null && "Emotional Intelligence".equals(quiz.getSubject())) ? "selected" : ""%>>Emotional Intelligence</option>
                                    <option value="Communication" <%= (quiz != null && "Communication".equals(quiz.getSubject())) ? "selected" : ""%>>Communication</option>
                                    <%-- Thêm các Subject khác từ DB hoặc tĩnh --%>
                                </select>
                            </div>
                            <div>
                                <label for="level" class="block text-sm font-medium text-gray-700 mb-1">Level:</label>
                                <select id="level" name="level"
                                        class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                        <%= canEdit ? "" : "disabled"%>>
                                    <option value="Dễ" <%= (quiz != null && "Dễ".equals(quiz.getLevel())) ? "selected" : ""%>>Dễ</option>
                                    <option value="Trung bình" <%= (quiz != null && "Trung bình".equals(quiz.getLevel())) ? "selected" : ""%>>Trung bình</option>
                                    <option value="Khó" <%= (quiz != null && "Khó".equals(quiz.getLevel())) ? "selected" : ""%>>Khó</option>
                                </select>
                            </div>
                            <div>
                                <label for="numQuestions" class="block text-sm font-medium text-gray-700 mb-1">Number of Questions:</label>
                                <input type="number" id="numQuestions" name="numQuestions"
                                       class="block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                       value="<%= (quiz != null) ? quiz.getNumQuestions() : 0%>"
                                       <%= canEdit ? "" : "readonly"%> required>
                            </div>
                            <div>
                                <label for="durationMinutes" class="block text-sm font-medium text-gray-700 mb-1">Duration (minutes):</label>
                                <input type="number" id="durationMinutes" name="durationMinutes"
                                       class="block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                       value="<%= (quiz != null) ? quiz.getDurationMinutes() : 0%>"
                                       <%= canEdit ? "" : "readonly"%> required>
                            </div>
                            <div>
                                <label for="passRate" class="block text-sm font-medium text-gray-700 mb-1">Pass Rate (%):</label>
                                <input type="number" step="0.01" id="passRate" name="passRate"
                                       class="block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                       value="<%= (quiz != null) ? quiz.getPassRate() : 0.0%>"
                                       <%= canEdit ? "" : "readonly"%> required>
                            </div>
                            <div>
                                <label for="quizType" class="block text-sm font-medium text-gray-700 mb-1">Quiz Type:</label>
                                <select id="quizType" name="quizType"
                                        class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                        <%= canEdit ? "" : "disabled"%>>
                                    <option value="Luyện tập" <%= (quiz != null && "Luyện tập".equals(quiz.getQuizType())) ? "selected" : ""%>>Luyện tập</option>
                                    <option value="Kiểm tra" <%= (quiz != null && "Kiểm tra".equals(quiz.getQuizType())) ? "selected" : ""%>>Kiểm tra</option>
                                    <option value="Thi cuối khóa" <%= (quiz != null && "Thi cuối khóa".equals(quiz.getQuizType())) ? "selected" : ""%>>Thi cuối khóa</option>
                                </select>
                            </div>

                            <div>
                                <label for="questionOrder" class="block text-sm font-medium text-gray-700 mb-1">QuestionOrder</label>
                                <select id="questionOrder" name="questionOrder"
                                        class="block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2 <%= canEdit ? "" : "bg-gray-100 cursor-not-allowed"%>"
                                        <%= canEdit ? "" : "disabled"%>>
                                    <option value="0" <%= (quiz != null && "0".equals(String.valueOf(quiz.getQuestionOrder()))) ? "selected" : ""%>>Not Attempted</option>
                                    <option value="1" <%= (quiz != null && "1".equals(String.valueOf(quiz.getQuestionOrder()))) ? "selected" : ""%>>Attempted</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-6 flex justify-end space-x-3">
                            <% if (canEdit) { %>
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                <i class="fas fa-save mr-2"></i> Save Quiz
                            </button>
                            <% } else { %>
                            <p class="text-blue-600 font-medium text-sm px-4 py-2">
                                <i class="fas fa-info-circle mr-1"></i> Cannot edit this quiz as tests have already been taken.
                            </p>
                            <% } %>
                            <a href="${pageContext.request.contextPath}/quizzes"
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                <i class="fas fa-arrow-alt-circle-left mr-2"></i> Back to List
                            </a>
                        </div>
                    </form>
                </div>

                <div id="tab-questions" class="tab-content bg-white rounded-lg shadow-sm p-6">
                    <% if (quiz != null && quiz.getQuizID() > 0 && canEdit) {%>
                    <h2 class="text-2xl font-bold text-gray-900 mb-4">Questions for this Quiz</h2>
                    <p class="mb-4">
                        <a href="${pageContext.request.contextPath}/questionDetail?quizId=<%= quiz.getQuizID()%>"
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            <i class="fas fa-plus-circle mr-2"></i> Add New Question
                        </a>
                    </p>

                    <%-- Bảng hiển thị danh sách câu hỏi của Quiz này --%>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Content</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <%
                                    List<Question> questions = (List<Question>) request.getAttribute("questions");
                                    if (questions != null && !questions.isEmpty()) {
                                        for (Question q : questions) {
                                %>
                                <tr class="question-row">
                                    <td><%= q.getQuestionID()%></td>
                                    <td><%= q.getQuestionContent()%></td>
                                    <td>
                                        <%= q.getQuestionType()%>
                                        <%-- Hiển thị các lựa chọn của câu hỏi nếu cần --%>
                                        <%--
                                        <% if (q.getOptions() != null && !q.getOptions().isEmpty()) { %>
                                            <ul class="list-disc list-inside text-xs mt-1 text-gray-600">
                                                <% for (Option opt : q.getOptions()) { %>
                                                    <li><%= opt.getOptionContent()%> <%= opt.isCorrect() ? "(Correct)" : ""%></li>
                                                <% } %>
                                            </ul>
                                        <% } %>
                                        --%>
                                    </td>
                                    <td>
                                        <div class="flex items-center space-x-2">
                                            <a href="${pageContext.request.contextPath}/questionDetail?questionId=<%= q.getQuestionID()%>&quizId=<%= quiz.getQuizID()%>"
                                               class="text-indigo-600 hover:text-indigo-900">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <button type="button" onclick="showDeleteQuestionModal('<%= q.getQuestionID()%>', '<%= quiz.getQuizID()%>')"
                                                    class="text-red-600 hover:text-red-900 ml-2">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="4" class="px-6 py-4 text-center text-gray-500">No questions added yet.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } else if (quiz != null && quiz.getQuizID() > 0 && !canEdit) { %>
                    <p class="text-orange-600 font-medium text-sm">
                        <i class="fas fa-exclamation-triangle mr-1"></i> Questions for this quiz cannot be managed because tests have already been taken.
                    </p>
                    <% } else { %>
                    <p class="text-gray-500 font-medium text-sm">
                        <i class="fas fa-info-circle mr-1"></i> Please save the quiz details first to manage questions.
                    </p>
                    <% }%>
                </div>
            </main>
        </div>

        <%-- Có thể thêm Modal xác nhận xóa câu hỏi nếu muốn cải thiện UX tương tự trang Quizzes List --%>
        <%-- Ví dụ: --%>
        <div id="deleteQuestionModal" class="fixed z-10 inset-0 overflow-y-auto hidden" aria-labelledby="modal-title" role="dialog" aria-modal="true">
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
                                    Xóa câu hỏi
                                </h3>
                                <div class="mt-2">
                                    <p class="text-sm text-gray-500">
                                        Bạn có chắc chắn muốn xóa câu hỏi này và tất cả các lựa chọn của nó không? Thao tác này không thể hoàn tác.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                        <form id="deleteQuestionForm" action="${pageContext.request.contextPath}/questions" method="POST">
                            <input type="hidden" name="action" value="deleteQuestion">
                            <input type="hidden" name="questionId" id="modalQuestionId">
                            <input type="hidden" name="quizId" id="modalQuizIdForQuestionDelete">
                            <button type="submit" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                                Xóa
                            </button>
                        </form>
                        <button type="button" id="cancelQuestionDelete" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Hủy
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // JavaScript cho Modal xác nhận xóa câu hỏi
            const deleteQuestionModal = document.getElementById('deleteQuestionModal');
            const cancelQuestionDeleteBtn = document.getElementById('cancelQuestionDelete');
            const modalQuestionId = document.getElementById('modalQuestionId');
            const modalQuizIdForQuestionDelete = document.getElementById('modalQuizIdForQuestionDelete');

            function showDeleteQuestionModal(questionId, quizId) {
                modalQuestionId.value = questionId;
                modalQuizIdForQuestionDelete.value = quizId;
                deleteQuestionModal.classList.remove('hidden');
            }

            function hideDeleteQuestionModal() {
                deleteQuestionModal.classList.add('hidden');
                modalQuestionId.value = '';
                modalQuizIdForQuestionDelete.value = '';
            }

            cancelQuestionDeleteBtn.addEventListener('click', hideDeleteQuestionModal);

            // Bổ sung: Thay thế onsubmit trong form xóa câu hỏi bằng modal
            document.querySelectorAll('form[action="${pageContext.request.contextPath}/questions"][method="POST"]').forEach(form => {
                if (form.querySelector('input[name="action"][value="deleteQuestion"]')) {
                    form.onsubmit = function (event) {
                        event.preventDefault(); // Ngăn form submit mặc định
                        const questionId = this.querySelector('input[name="questionId"]').value;
                        const quizId = this.querySelector('input[name="quizId"]').value;
                        showDeleteQuestionModal(questionId, quizId);
                    };
                }
            });

            // --- JavaScript cho Tabbed Sections ---
            const tabButtons = document.querySelectorAll('.tab-button');
            const tabContents = document.querySelectorAll('.tab-content');

            tabButtons.forEach(button => {
                button.addEventListener('click', () => {
                    // Remove active class from all buttons and hide all content
                    tabButtons.forEach(btn => btn.classList.remove('active'));
                    tabContents.forEach(content => content.classList.remove('active'));

                    // Add active class to the clicked button
                    button.classList.add('active');

                    // Show the corresponding content
                    const targetTabId = button.dataset.tab;
                    document.getElementById('tab-' + targetTabId).classList.add('active');
                });
            });

            // Set the first tab as active by default on page load
            document.addEventListener('DOMContentLoaded', () => {
                // Check if quizID is present and canEdit is true to decide default tab
                const quizID = <%= (quiz != null) ? quiz.getQuizID() : 0%>;
                const canEdit = <%= canEdit%>;

                if (quizID > 0 && canEdit) {
                    // If it's an editable quiz, default to "Questions" tab
                    document.getElementById('tab-questions-btn').click();
                } else {
                    // Otherwise, default to "Details" tab
                    document.getElementById('tab-details-btn').click();
                }
            });
        </script>
    </body>
</html>