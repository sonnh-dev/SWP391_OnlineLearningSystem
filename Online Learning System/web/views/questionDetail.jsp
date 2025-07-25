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
        <%-- Bootstrap CSS --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <%-- Font Awesome for icons --%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f7f9fc; /* Light gray background */
                color: #333;
            }
            .main-content {
                padding-top: 2rem; /* py-8 equivalent */
                padding-bottom: 2rem; /* py-8 equivalent */
            }
            .header-bg {
                background-color: #4f46e5; /* Tailwind indigo-600 equivalent */
            }

            /* Custom styling for form controls to maintain a consistent look */
            .form-control-custom,
            .form-select-custom {
                border-radius: 0.375rem; /* rounded-md equivalent */
                box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); /* shadow-sm equivalent */
                border: 1px solid #ced4da; /* border-gray-300 equivalent */
                padding: 0.5rem 0.75rem; /* p-2 and px-3 py-2 */
            }
            .form-control-custom:focus,
            .form-select-custom:focus {
                border-color: #6610f2; /* focus:border-indigo-500 equivalent */
                box-shadow: 0 0 0 0.25rem rgba(102, 16, 242, 0.25); /* focus:ring-indigo-500 equivalent */
            }

            /* Custom button styles to match Tailwind colors */
            .btn-green-custom {
                background-color: #10b981; /* green-600 */
                border-color: #10b981;
                color: white;
            }
            .btn-green-custom:hover {
                background-color: #059669; /* green-700 */
                border-color: #059669;
            }
            .btn-indigo-custom {
                background-color: #4f46e5; /* indigo-600 */
                border-color: #4f46e5;
                color: white;
            }
            .btn-indigo-custom:hover {
                background-color: #4338ca; /* indigo-700 */
                border-color: #4338ca;
            }
            .btn-red-custom {
                background-color: #ef4444; /* red-500 */
                border-color: #ef4444;
                color: white;
            }
            .btn-red-custom:hover {
                background-color: #dc2626; /* red-600 */
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

            /* Section styling */
            .section-card {
                background-color: white;
                border-radius: 0.5rem; /* rounded-lg */
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow-sm */
                padding: 1.5rem; /* p-6 */
            }

            /* Option row styling */
            .option-row {
                margin-bottom: 1rem; /* mb-3 */
                padding: 1rem; /* p-4 */
                border: 1px solid #e2e8f0; /* border border-gray-200 */
                border-radius: 0.375rem; /* rounded-md */
                background-color: #f8f9fa; /* bg-gray-50 */
                display: flex;
                flex-wrap: wrap; /* flex-wrap for responsiveness */
                align-items: center; /* items-center */
                gap: 0.5rem; /* space-x-2 */
            }
            .option-row label {
                display: block;
                font-size: 0.875rem; /* text-sm */
                font-weight: 500; /* font-medium */
                color: #495057; /* text-gray-700 */
                margin-bottom: 0.25rem; /* mb-1 */
            }
            .option-row .form-check-input {
                /* Custom styles for checkbox to ensure visibility and size */
                height: 1rem; /* h-4 */
                width: 1rem; /* w-4 */
                color: #4f46e5; /* text-indigo-600 */
                border-color: #ced4da; /* border-gray-300 */
                border-radius: 0.25rem; /* rounded */
                margin-top: 0; /* align with text */
            }
            .option-row .form-check-label {
                margin-left: 0.5rem; /* ml-2 */
                font-size: 0.875rem; /* text-sm */
                color: #495057; /* text-gray-700 */
            }
            .option-row .btn-remove-option {
                margin-left: 0.5rem; /* ml-2 */
                /* mt-2 md:mt-0 handled by flex-wrap and align-items-center */
                padding: 0.25rem 0.75rem; /* px-3 py-1 */
                font-size: 0.875rem; /* text-sm */
                border-radius: 0.375rem; /* rounded-md */
                box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); /* shadow-sm */
            }

            /* For success/error messages */
            .alert-red-custom {
                background-color: #fee2e2; /* bg-red-100 */
                border-color: #fca5a5; /* border-red-400 */
                color: #b91c1c; /* text-red-700 */
                padding: 0.75rem 1rem; /* px-4 py-3 */
                border-radius: 0.375rem; /* rounded */
                position: relative;
                margin-bottom: 1rem; /* mb-4 */
            }
             .alert-green-custom {
                background-color: #d1fae5; /* bg-green-100 */
                border-color: #6ee7b7; /* border-green-400 */
                color: #065f46; /* text-green-700 */
                padding: 0.75rem 1rem; /* px-4 py-3 */
                border-radius: 0.375rem; /* rounded */
                position: relative;
                margin-bottom: 1rem; /* mb-4 */
            }
        </style>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <div class="flex-grow-1">
            <header class="header-bg text-white p-4 shadow-sm">
                <div class="container">
                    <%
                        Question question = (Question) request.getAttribute("question");
                        Quiz parentQuiz = (Quiz) request.getAttribute("parentQuiz");
                        String pageTitle = (question == null || question.getQuestionID() == 0) ? "Add New Question" : "Edit Question";
                    %>
                    <h1 class="h3 mb-0"><%= pageTitle%> for Quiz: "<%= parentQuiz != null ? parentQuiz.getQuizName() : "N/A"%>"</h1>
                </div>
            </header>

            <main class="container main-content">
                <%-- Display error/success messages --%>
                <% if (request.getAttribute("errorMessage") != null) {%>
                <div class="alert alert-red-custom" role="alert">
                    <%= request.getAttribute("errorMessage")%>
                </div>
                <% } %>
                <% if (request.getAttribute("successMessage") != null) {%>
                <div class="alert alert-green-custom" role="alert">
                    <%= request.getAttribute("successMessage")%>
                </div>
                <% }%>

                <div class="section-card">
                    <form action="${pageContext.request.contextPath}/questions" method="POST">
                        <input type="hidden" name="action" value="saveQuestion">
                        <input type="hidden" name="quizID" value="<%= parentQuiz != null ? parentQuiz.getQuizID() : ""%>">
                        <input type="hidden" name="questionID" value="<%= (question != null) ? question.getQuestionID() : 0%>">

                        <div class="mb-3"> <%-- mb-4 became mb-3 for Bootstrap spacing --%>
                            <label for="questionContent" class="form-label mb-1">Question Content:</label>
                            <textarea id="questionContent" name="questionContent" rows="5"
                                      class="form-control form-control-custom"
                                      required><%= (question != null && question.getQuestionContent() != null) ? question.getQuestionContent() : ""%></textarea>
                        </div>

                        <div class="mb-4"> <%-- mb-6 became mb-4 --%>
                            <label for="questionType" class="form-label mb-1">Question Type:</label>
                            <select id="questionType" name="questionType"
                                    class="form-select form-select-custom">
                                <option value="Multiple Choice" <%= (question != null && "Multiple Choice".equals(question.getQuestionType())) ? "selected" : ""%>>Multiple Choice</option>
                                <option value="True/False" <%= (question != null && "True/False".equals(question.getQuestionType())) ? "selected" : ""%>>True/False</option>
                                <option value="Short Answer" <%= (question != null && "Short Answer".equals(question.getQuestionType())) ? "selected" : ""%>>Short Answer</option>
                            </select>
                        </div>

                        <h3 class="h5 text-dark mb-3">Options:</h3> <%-- Tailwind text-lg font-semibold became Bootstrap h5 text-dark --%>
                        <div id="optionsContainer">
                            <%
                                List<QuestionOption> options = (question != null) ? question.getOptions() : null;
                                if (options != null && !options.isEmpty()) {
                                    int index = 1;
                                    for (QuestionOption opt : options) {
                            %>
                            <div class="option-row">
                                <div class="flex-grow-1 me-2"> <%-- Use flex-grow-1 and me-2 for content to expand and margin --%>
                                    <label for="optionContent<%= index%>">Option <%= index%>:</label>
                                    <input type="text" id="optionContent<%= index%>" name="optionContent<%= index%>" value="<%= opt.getOptionContent()%>" required class="form-control form-control-custom">
                                </div>
                                <div class="form-check d-flex align-items-center me-2 mt-2 mt-md-0"> <%-- d-flex align-items-center for checkbox alignment, me-2 for spacing --%>
                                    <input type="checkbox" id="isCorrect<%= index%>" name="isCorrect<%= index%>" value="true" class="form-check-input" <%= opt.isIsCorrect() ? "checked" : ""%>>
                                    <label for="isCorrect<%= index%>" class="form-check-label">Correct</label>
                                </div>
                                <button type="button" onclick="removeOptionField(this)" class="btn btn-red-custom btn-remove-option">
                                    <i class="fas fa-trash-alt me-1"></i> Remove
                                </button>
                            </div>
                            <%
                                        index++;
                                    }
                                } else {
                            %>
                            <div class="option-row">
                                <div class="flex-grow-1 me-2">
                                    <label for="optionContent1">Option 1:</label>
                                    <input type="text" id="optionContent1" name="optionContent1" required class="form-control form-control-custom">
                                </div>
                                <div class="form-check d-flex align-items-center me-2 mt-2 mt-md-0">
                                    <input type="checkbox" id="isCorrect1" name="isCorrect1" value="true" class="form-check-input">
                                    <label for="isCorrect1" class="form-check-label">Correct</label>
                                </div>
                                <button type="button" onclick="removeOptionField(this)" class="btn btn-red-custom btn-remove-option">
                                    <i class="fas fa-trash-alt me-1"></i> Remove
                                </button>
                            </div>
                            <% }%>
                        </div>
                        <button type="button" onclick="addOptionField()"
                                class="btn btn-indigo-custom mt-4 d-inline-flex align-items-center">
                            <i class="fas fa-plus-circle me-2"></i> Add Option
                        </button>

                        <div class="mt-4 d-flex justify-content-end gap-2"> <%-- mt-6, space-x-3 became mt-4, gap-2 --%>
                            <button type="submit"
                                    class="btn btn-green-custom d-inline-flex align-items-center">
                                <i class="fas fa-save me-2"></i> Save Question
                            </button>
                            <a href="${pageContext.request.contextPath}/quizDetail?id=<%= parentQuiz != null ? parentQuiz.getQuizID() : ""%>"
                               class="btn btn-outline-secondary-custom d-inline-flex align-items-center">
                                <i class="fas fa-arrow-alt-circle-left me-2"></i> Back to Quiz Details
                            </a>
                            <a href="${pageContext.request.contextPath}/quizzes"
                               class="btn btn-outline-secondary-custom d-inline-flex align-items-center">
                                <i class="fas fa-arrow-alt-circle-left me-2"></i> Back to Quizzes
                            </a>
                        </div>
                    </form>
                </div>

            </main>
        </div>
        <%-- Bootstrap JavaScript Bundle (includes Popper.js) --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function addOptionField() {
                var container = document.getElementById('optionsContainer');
                var currentOptions = container.querySelectorAll('.option-row').length;
                var newIndex = currentOptions + 1;

                var newOptionHtml = `
                    <div class="option-row">
                        <div class="flex-grow-1 me-2">
                            <label for="optionContent${newIndex}">Option ${newIndex}:</label>
                            <input type="text" id="optionContent${newIndex}" name="optionContent${newIndex}" required class="form-control form-control-custom">
                        </div>
                        <div class="form-check d-flex align-items-center me-2 mt-2 mt-md-0">
                            <input type="checkbox" id="isCorrect${newIndex}" name="isCorrect${newIndex}" value="true" class="form-check-input">
                            <label for="isCorrect${newIndex}" class="form-check-label">Correct</label>
                        </div>
                        <button type="button" onclick="removeOptionField(this)" class="btn btn-red-custom btn-remove-option">
                            <i class="fas fa-trash-alt me-1"></i> Remove
                        </button>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', newOptionHtml);
            }

            function removeOptionField(button) {
                var container = document.getElementById('optionsContainer');
                if (container.querySelectorAll('.option-row').length <= 1) {
                    alert("A question must have at least one option.");
                    return;
                }

                button.closest('.option-row').remove();
                // Update names and IDs to ensure correct order
                var optionRows = container.querySelectorAll('.option-row');
                optionRows.forEach((row, index) => {
                    var newIndex = index + 1;
                    // Update label 'for' attribute
                    const labelContent = row.querySelector('label[for^="optionContent"]');
                    if (labelContent) {
                        labelContent.setAttribute('for', `optionContent${newIndex}`);
                        labelContent.innerText = `Option ${newIndex}:`;
                    }
                    // Update optionContent input
                    const inputContent = row.querySelector('input[name^="optionContent"]');
                    if (inputContent) {
                        inputContent.setAttribute('name', `optionContent${newIndex}`);
                        inputContent.setAttribute('id', `optionContent${newIndex}`);
                    }
                    // Update isCorrect checkbox
                    const inputCorrect = row.querySelector('input[name^="isCorrect"]');
                    if (inputCorrect) {
                        inputCorrect.setAttribute('name', `isCorrect${newIndex}`);
                        inputCorrect.setAttribute('id', `isCorrect${newIndex}`);
                    }
                    // Update isCorrect label 'for' attribute
                    const labelCorrect = row.querySelector('label[for^="isCorrect"]');
                    if (labelCorrect) {
                        labelCorrect.setAttribute('for', `isCorrect${newIndex}`);
                    }
                });
            }
        </script>
        <%@include file="../includes/foot.jsp" %>
    </body>
</html>