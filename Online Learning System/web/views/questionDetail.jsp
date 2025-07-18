<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Question"%>
<%@page import="model.QuestionOption"%>
<%@page import="model.Quiz"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question Details</title>
        <%-- Nhúng Tailwind CSS (sử dụng CDN cho đơn giản) --%>
        <script src="https://cdn.tailwindcss.com"></script>
        <%-- Nhúng Font Awesome (sử dụng CDN cho các biểu tượng) --%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* Các CSS tùy chỉnh nếu cần */
            /* Để các option-row có khoảng cách */
            .option-row {
                @apply mb-3 p-4 border border-gray-200 rounded-md bg-gray-50;
            }
            .option-row label {
                @apply block text-sm font-medium text-gray-700 mb-1;
            }
            .option-row input[type="text"] {
                @apply w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2;
            }
            .option-row input[type="checkbox"] {
                /* Cần custom style cho checkbox nếu muốn đẹp hơn, Tailwind mặc định không style checkbox nhiều */
                @apply form-checkbox h-4 w-4 text-indigo-600 border-gray-300 rounded;
            }
            /* Đảm bảo các nút trong option-row không bị dính vào nhau */
            .option-row button {
                @apply ml-2 mt-2 md:mt-0 px-3 py-1 text-sm rounded-md shadow-sm;
            }
        </style>
        <script>
            function addOptionField() {
                var container = document.getElementById('optionsContainer');
                var currentOptions = container.querySelectorAll('.option-row').length;
                var newIndex = currentOptions + 1;

                var newOptionHtml = `
                    <div class="option-row flex flex-wrap items-center space-x-2">
                        <div class="flex-grow">
                            <label for="optionContent${newIndex}">Option ${newIndex}:</label>
                            <input type="text" id="optionContent${newIndex}" name="optionContent${newIndex}" required class="block w-full">
                        </div>
                        <div class="flex items-center mt-2 md:mt-0">
                            <input type="checkbox" id="isCorrect${newIndex}" name="isCorrect${newIndex}" value="true" class="form-checkbox h-4 w-4 text-indigo-600 border-gray-300 rounded">
                            <label for="isCorrect${newIndex}" class="ml-2 text-sm text-gray-700">Correct</label>
                        </div>
                        <button type="button" onclick="removeOptionField(this)" class="bg-red-500 hover:bg-red-600 text-white">
                            <i class="fas fa-trash-alt"></i> Remove
                        </button>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', newOptionHtml);
            }

            function removeOptionField(button) {
                // Đảm bảo không xóa nếu chỉ còn 1 option
                var container = document.getElementById('optionsContainer');
                if (container.querySelectorAll('.option-row').length <= 1) {
                    alert("A question must have at least one option.");
                    return;
                }

                button.closest('.option-row').remove();
                // Cập nhật lại tên và ID để đảm bảo đúng thứ tự (quan trọng khi gửi form)
                var optionRows = container.querySelectorAll('.option-row');
                optionRows.forEach((row, index) => {
                    var newIndex = index + 1;
                    row.querySelector('label[for^="optionContent"]').setAttribute('for', `optionContent${newIndex}`);
                    row.querySelector('label[for^="optionContent"]').innerText = `Option ${newIndex}:`;
                    row.querySelector('input[name^="optionContent"]').setAttribute('name', `optionContent${newIndex}`);
                    row.querySelector('input[name^="optionContent"]').setAttribute('id', `optionContent${newIndex}`);
                    row.querySelector('input[name^="isCorrect"]').setAttribute('name', `isCorrect${newIndex}`);
                    row.querySelector('input[name^="isCorrect"]').setAttribute('id', `isCorrect${newIndex}`);
                    row.querySelector('label[for^="isCorrect"]').setAttribute('for', `isCorrect${newIndex}`);
                });
            }
        </script>
    </head>
    <body class="bg-gray-100 font-sans leading-normal tracking-normal">
       
        <div class="min-h-screen bg-gray-100">
            <header class="bg-indigo-600 text-white p-4 shadow-md">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <%                        Question question = (Question) request.getAttribute("question");
                        Quiz parentQuiz = (Quiz) request.getAttribute("parentQuiz");
                        String pageTitle = (question == null || question.getQuestionID() == 0) ? "Add New Question" : "Edit Question";
                    %>

                    <h1 class="text-3xl font-bold"><%= pageTitle%> for Quiz: "<%= parentQuiz != null ? parentQuiz.getQuizName() : "N/A"%>"</h1>
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


                <div class="bg-white rounded-lg shadow-sm p-6">
                    <form action="${pageContext.request.contextPath}/questions" method="POST">
                        <input type="hidden" name="action" value="saveQuestion">
                        <input type="hidden" name="quizID" value="<%= parentQuiz != null ? parentQuiz.getQuizID() : ""%>">
                        <input type="hidden" name="questionID" value="<%= (question != null) ? question.getQuestionID() : 0%>">

                        <div class="mb-4">
                            <label for="questionContent" class="block text-sm font-medium text-gray-700 mb-1">Question Content:</label>
                            <textarea id="questionContent" name="questionContent" rows="5"
                                      class="block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 p-2"
                                      required><%= (question != null && question.getQuestionContent() != null) ? question.getQuestionContent() : ""%></textarea>
                        </div>

                        <div class="mb-6">
                            <label for="questionType" class="block text-sm font-medium text-gray-700 mb-1">Question Type:</label>
                            <select id="questionType" name="questionType"
                                    class="block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                <option value="Multiple Choice" <%= (question != null && "Multiple Choice".equals(question.getQuestionType())) ? "selected" : ""%>>Multiple Choice</option>
                                <option value="True/False" <%= (question != null && "True/False".equals(question.getQuestionType())) ? "selected" : ""%>>True/False</option>
                                <option value="Short Answer" <%= (question != null && "Short Answer".equals(question.getQuestionType())) ? "selected" : ""%>>Short Answer</option>
                            </select>
                        </div>

                        <h3 class="text-lg font-semibold text-gray-900 mb-3">Options:</h3>
                        <div id="optionsContainer">
                            <%
                                List<QuestionOption> options = (question != null) ? question.getOptions() : null;
                                if (options != null && !options.isEmpty()) {
                                    int index = 1;
                                    for (QuestionOption opt : options) {
                            %>
                            <div class="option-row flex flex-wrap items-center space-x-2">
                                <div class="flex-grow">
                                    <label for="optionContent<%= index%>">Option <%= index%>:</label>
                                    <input type="text" id="optionContent<%= index%>" name="optionContent<%= index%>" value="<%= opt.getOptionContent()%>" required class="block w-full">
                                </div>
                                <div class="flex items-center mt-2 md:mt-0">
                                    <input type="checkbox" id="isCorrect<%= index%>" name="isCorrect<%= index%>" value="true" class="form-checkbox h-4 w-4 text-indigo-600 border-gray-300 rounded" <%= opt.isIsCorrect() ? "checked" : ""%>>
                                    <label for="isCorrect<%= index%>" class="ml-2 text-sm text-gray-700">Correct</label>
                                </div>
                                <button type="button" onclick="removeOptionField(this)" class="bg-red-500 hover:bg-red-600 text-white">
                                    <i class="fas fa-trash-alt"></i> Remove
                                </button>
                            </div>
                            <%
                                    index++;
                                }
                            } else {
                            %>
                            <div class="option-row flex flex-wrap items-center space-x-2">
                                <div class="flex-grow">
                                    <label for="optionContent1">Option 1:</label>
                                    <input type="text" id="optionContent1" name="optionContent1" required class="block w-full">
                                </div>
                                <div class="flex items-center mt-2 md:mt-0">
                                    <input type="checkbox" id="isCorrect1" name="isCorrect1" value="true" class="form-checkbox h-4 w-4 text-indigo-600 border-gray-300 rounded">
                                    <label for="isCorrect1" class="ml-2 text-sm text-gray-700">Correct</label>
                                </div>
                                <button type="button" onclick="removeOptionField(this)" class="bg-red-500 hover:bg-red-600 text-white">
                                    <i class="fas fa-trash-alt"></i> Remove
                                </button>
                            </div>
                            <% }%>
                        </div>
                        <button type="button" onclick="addOptionField()"
                                class="mt-4 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            <i class="fas fa-plus-circle mr-2"></i> Add Option
                        </button>

                        <div class="mt-6 flex justify-end space-x-3">
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                <i class="fas fa-save mr-2"></i> Save Question
                            </button>
                            <a href="${pageContext.request.contextPath}/quizDetail?id=<%= parentQuiz != null ? parentQuiz.getQuizID() : ""%>"
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                <i class="fas fa-arrow-alt-circle-left mr-2"></i> Back to Quiz Details
                            </a>
                            <a href="${pageContext.request.contextPath}/quizzes"
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                <i class="fas fa-arrow-alt-circle-left mr-2"></i> Back to Quizzes
                            </a>
                        </div>
                    </form>
                </div>

            </main>

        </div>
        
    </body>
</html>