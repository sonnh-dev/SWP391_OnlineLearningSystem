<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz"%>
<%@page import="model.Question"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quiz Details</title>

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
            .form-control-custom.bg-disabled,
            .form-select-custom.bg-disabled {
                background-color: #e9ecef; /* bg-gray-100 equivalent */
                cursor: not-allowed;
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
            .btn-outline-secondary-custom {
                background-color: white;
                border-color: #ced4da; /* gray-300 */
                color: #495057; /* gray-700 */
            }
            .btn-outline-secondary-custom:hover {
                background-color: #f8f9fa; /* gray-50 */
            }
            .btn-text-blue {
                color: #2563eb; /* blue-600 */
                font-weight: 500; /* font-medium */
                font-size: 0.875rem; /* text-sm */
            }

            /* Section styling */
            .section-card {
                background-color: white;
                border-radius: 0.5rem; /* rounded-lg */
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow-sm */
                padding: 1.5rem; /* p-6 */
                margin-bottom: 1.5rem; /* mb-6 */
            }

            /* Tooltip */
            .tooltip-custom {
                position: relative;
                display: inline-block;
            }
            .tooltip-custom .tooltiptext {
                visibility: hidden;
                width: 140px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1050; /* Higher z-index for Bootstrap modals */
                bottom: 125%; /* Tooltip above the button */
                left: 50%;
                margin-left: -70px;
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

            /* Tabs */
            .nav-tabs .nav-link {
                color: #6c757d; /* text-gray-500 */
                border: none;
                border-bottom: 2px solid transparent;
                padding: 1rem 0.5rem; /* py-4 px-1 */
                font-weight: 500; /* font-medium */
                font-size: 0.875rem; /* text-sm */
            }
            .nav-tabs .nav-link:hover {
                color: #495057; /* hover:text-gray-700 */
                border-color: #e9ecef; /* hover:border-gray-300 */
            }
            .nav-tabs .nav-link.active {
                color: #4f46e5; /* text-indigo-600 */
                border-color: #4f46e5; /* border-indigo-500 */
            }
            .tab-pane {
                display: none; /* Hidden by default */
            }
            .tab-pane.active {
                display: block; /* Shown when active */
            }

            /* Table styling for questions */
            .table-questions th, .table-questions td {
                padding: 0.75rem; /* px-6 py-4 (approx) */
                vertical-align: top;
                border-top: 1px solid #dee2e6; /* divide-y divide-gray-200 */
            }
            .table-questions th {
                background-color: #f8f9fa; /* bg-gray-50 */
                font-weight: 600;
                text-align: left;
                font-size: 0.75rem; /* text-xs */
                text-transform: uppercase;
                letter-spacing: 0.05em; /* tracking-wider */
                color: #6c757d; /* text-gray-500 */
            }
            .table-questions tbody tr:hover {
                background-color: #f8f9fa; /* hover:bg-gray-50 */
            }
            .table-questions tbody td:first-child {
                font-weight: 500; /* font-medium */
                color: #212529; /* text-gray-900 */
            }
            .table-questions tbody td:not(:first-child) {
                color: #6c757d; /* text-gray-500 */
            }
            .table-questions tbody td:last-child {
                font-weight: 500; /* font-medium */
            }
            /* Specific style for delete button in question table */
            .table-questions .btn-delete-question {
                color: #dc3545; /* red-600 */
            }
            .table-questions .btn-delete-question:hover {
                color: #c82333; /* red-900 */
            }

            /* Modal styling (Bootstrap classes naturally handle most of it) */
            .modal-icon-wrapper {
                margin: auto;
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 3rem;
                width: 3rem;
                border-radius: 9999px; /* rounded-full */
                background-color: #fee2e2; /* bg-red-100 */
                margin-bottom: 0.75rem;
            }
            .modal-icon {
                color: #ef4444; /* text-red-600 */
            }
            .modal-title-text {
                font-size: 1.125rem;
                line-height: 1.75rem;
                font-weight: 500;
                color: #1a202c;
            }
            .modal-description-text {
                margin-top: 0.5rem;
                font-size: 0.875rem;
                color: #6b7280;
            }
        </style>
        <%-- Include your head1.jsp if it contains common meta tags or links.
             Ensure it does NOT include Tailwind CSS, only Bootstrap or generic HTML. --%>
        <%@include file="../includes/head1.jsp"%>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100"> <%-- Use bg-light for consistency, flex-column min-vh-100 to push footer down --%>

        <div class="flex-grow-1"> <%-- This div expands to push the footer to the bottom --%>
            <header class="header-bg text-white p-4 shadow-sm">
                <div class="container">
                    <%
                        Quiz quiz = (Quiz) request.getAttribute("quiz");
                        Boolean canEditObj = (Boolean) request.getAttribute("canEdit");
                        boolean canEdit = (canEditObj != null) ? canEditObj : false; // avoid NullPointerException
                        String pageTitle = (quiz == null || quiz.getQuizID() == 0) ? "Add New Quiz" : "Edit Quiz";
                    %>

                    <h1 class="h3 mb-0"><%= pageTitle%></h1> <%-- Using Bootstrap h3 for consistent font size, mb-0 for no bottom margin --%>
                </div>
            </header>

            <main class="container main-content">
                <%-- Display error/success messages --%>
                <% if (request.getAttribute("errorMessage") != null) {%>
                <div class="alert alert-danger mb-4" role="alert">
                    <%= request.getAttribute("errorMessage")%>
                </div>
                <% } %>
                <% if (request.getAttribute("successMessage") != null) {%>
                <div class="alert alert-success mb-4" role="alert">
                    <%= request.getAttribute("successMessage")%>
                </div>
                <% }%>

                <div class="mb-4"> <%-- mb-6 becomes mb-4 (Bootstrap spacing) --%>
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="details-tab" data-bs-toggle="tab" data-bs-target="#tab-details" type="button" role="tab" aria-controls="tab-details" aria-selected="true">
                                <i class="fas fa-info-circle me-2"></i>Quiz Details
                            </button>
                        </li>
                        <% if (quiz != null && quiz.getQuizID() > 0) { %>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="questions-tab" data-bs-toggle="tab" data-bs-target="#tab-questions" type="button" role="tab" aria-controls="tab-questions" aria-selected="false">
                                <i class="fas fa-question-circle me-2"></i>Manage Questions
                            </button>
                        </li>
                        <% }%>
                    </ul>
                </div>

                <div class="tab-content"> <%-- Bootstrap's tab-content container --%>
                    <div class="tab-pane fade show active section-card" id="tab-details" role="tabpanel" aria-labelledby="details-tab">
                        <form action="${pageContext.request.contextPath}/quizzes" method="POST">
                            <input type="hidden" name="action" value="save">
                            <input type="hidden" name="quizID" value="<%= (quiz != null) ? quiz.getQuizID() : 0%>">

                            <div class="row g-3"> <%-- Bootstrap grid system --%>
                                <div class="col-md-6">
                                    <label for="quizName" class="form-label mb-1">Quiz Name:</label>
                                    <input type="text" id="quizName" name="quizName"
                                           class="form-control form-control-custom <%= canEdit ? "" : "bg-disabled"%>"
                                           value="<%= (quiz != null && quiz.getQuizName() != null) ? quiz.getQuizName() : ""%>"
                                           <%= canEdit ? "" : "readonly"%> required>
                                </div>
                                <div class="col-md-6">
                                    <label for="subject" class="form-label mb-1">Subject:</label>
                                    <select name="subject" id="subject" class="form-select form-select-custom <%= canEdit ? "" : "bg-disabled"%>"
                                            <%= canEdit ? "" : "disabled"%>>
                                        <option value="">All Subjects</option>
                                        <option value="Leadership" <%= (quiz != null && "Leadership".equals(quiz.getSubject())) ? "selected" : ""%>>Leadership</option>
                                        <option value="Time Management" <%= (quiz != null && "Time Management".equals(quiz.getSubject())) ? "selected" : ""%>>Time Management</option>
                                        <option value="Problem Solving" <%= (quiz != null && "Problem Solving".equals(quiz.getSubject())) ? "selected" : ""%>>Problem Solving</option>
                                        <option value="Emotional Intelligence" <%= (quiz != null && "Emotional Intelligence".equals(quiz.getSubject())) ? "selected" : ""%>>Emotional Intelligence</option>
                                        <option value="Communication" <%= (quiz != null && "Communication".equals(quiz.getSubject())) ? "selected" : ""%>>Communication</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="level" class="form-label mb-1">Level:</label>
                                    <select id="level" name="level"
                                            class="form-select form-select-custom <%= canEdit ? "" : "bg-disabled"%>"
                                            <%= canEdit ? "" : "disabled"%>>
                                        <option value="Beginner" <%= (quiz != null && "Beginner".equals(quiz.getLevel())) ? "selected" : ""%>>Beginner</option>
                                        <option value="Intermediate" <%= (quiz != null && "Intermediate".equals(quiz.getLevel())) ? "selected" : ""%>>Intermediate</option>
                                        <option value="Advanced" <%= (quiz != null && "Advanced".equals(quiz.getLevel())) ? "selected" : ""%>>Advanced</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="numQuestions" class="form-label mb-1">Number of Questions:</label>
                                    <input type="number" id="numQuestions" name="numQuestions"
                                           class="form-control form-control-custom <%= canEdit ? "" : "bg-disabled"%>"
                                           value="<%= (quiz != null) ? quiz.getNumQuestions() : 0%>"
                                           <%= canEdit ? "" : "readonly"%> required>
                                </div>
                                <div class="col-md-6">
                                    <label for="durationMinutes" class="form-label mb-1">Duration (minutes):</label>
                                    <input type="number" id="durationMinutes" name="durationMinutes"
                                           class="form-control form-control-custom <%= canEdit ? "" : "bg-disabled"%>"
                                           value="<%= (quiz != null) ? quiz.getDurationMinutes() : 0%>"
                                           <%= canEdit ? "" : "readonly"%> required>
                                </div>
                                <div class="col-md-6">
                                    <label for="passRate" class="form-label mb-1">Pass Rate (%):</label>
                                    <input type="number" step="0.01" id="passRate" name="passRate"
                                           class="form-control form-control-custom <%= canEdit ? "" : "bg-disabled"%>"
                                           value="<%= (quiz != null) ? quiz.getPassRate() : 0.0%>"
                                           <%= canEdit ? "" : "readonly"%> required>
                                </div>
                                <div class="col-md-6">
                                    <label for="quizType" class="form-label mb-1">Quiz Type:</label>
                                    <select id="quizType" name="quizType"
                                            class="form-select form-select-custom <%= canEdit ? "" : "bg-disabled"%>"
                                            <%= canEdit ? "" : "disabled"%>>
                                        <option value="Course Assessment" <%= (quiz != null && "Course Assessment".equals(quiz.getQuizType())) ? "selected" : ""%>>Course Assessment</option>
                                        <option value="Practice" <%= (quiz != null && "Practice".equals(quiz.getQuizType())) ? "selected" : ""%>>Practice</option>
                                        <option value="Learn" <%= (quiz != null && "Learn".equals(quiz.getQuizType())) ? "selected" : ""%>>Learn</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label for="questionOrder" class="form-label mb-1">QuestionOrder</label>
                                    <select id="questionOrder" name="questionOrder"
                                            class="form-select form-select-custom <%= canEdit ? "" : "bg-disabled"%>"
                                            <%= canEdit ? "" : "disabled"%>>
                                        <option value="0" <%= (quiz != null && "0".equals(String.valueOf(quiz.getQuestionOrder()))) ? "selected" : ""%>>Not Attempted</option>
                                        <option value="1" <%= (quiz != null && "1".equals(String.valueOf(quiz.getQuestionOrder()))) ? "selected" : ""%>>Attempted</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mt-4 d-flex justify-content-end gap-2"> <%-- Using Bootstrap spacing and flex --%>
                                <% if (canEdit) { %>
                                <button type="submit"
                                        class="btn btn-green-custom d-inline-flex align-items-center">
                                    <i class="fas fa-save me-2"></i> Save Quiz
                                </button>
                                <% } else { %>
                                <p class="text-info d-inline-flex align-items-center me-2"> <%-- Bootstrap text-info for blue --%>
                                    <i class="fas fa-info-circle me-1"></i> Cannot edit this quiz as tests have already been taken.
                                </p>
                                <% } %>
                                <a href="${pageContext.request.contextPath}/quizzes"
                                   class="btn btn-outline-secondary-custom d-inline-flex align-items-center">
                                    <i class="fas fa-arrow-alt-circle-left me-2"></i> Back to List
                                </a>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane fade section-card" id="tab-questions" role="tabpanel" aria-labelledby="questions-tab">
                        <% if (quiz != null && quiz.getQuizID() > 0 && canEdit) {%>
                        <h2 class="h4 text-dark mb-4">Questions for this Quiz</h2> <%-- Bootstrap h4, text-dark --%>
                        <p class="mb-4">
                            <a href="${pageContext.request.contextPath}/questionDetail?quizId=<%= quiz.getQuizID()%>"
                               class="btn btn-indigo-custom d-inline-flex align-items-center">
                                <i class="fas fa-plus-circle me-2"></i> Add New Question
                            </a>
                        </p>

                        <%-- Table to display the list of questions for this Quiz --%>
                        <div class="table-responsive"> <%-- Bootstrap for responsive tables --%>
                            <table class="table table-hover table-striped table-questions mb-0"> <%-- Bootstrap table classes, custom for fine-tuning --%>
                                <thead class="bg-light">
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Content</th>
                                        <th scope="col">Type</th>
                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Question> questions = (List<Question>) request.getAttribute("questions");
                                        if (questions != null && !questions.isEmpty()) {
                                            for (Question q : questions) {
                                    %>
                                    <tr>
                                        <td><%= q.getQuestionID()%></td>
                                        <td><%= q.getQuestionContent()%></td>
                                        <td>
                                            <%= q.getQuestionType()%>
                                            <%-- Display question options if needed (Bootstrap list-unstyled might be suitable for ul) --%>
                                            <%--
                                            <% if (q.getOptions() != null && !q.getOptions().isEmpty()) { %>
                                                <ul class="list-unstyled small mt-1 text-muted">
                                                    <% for (Option opt : q.getOptions()) { %>
                                                        <li><%= opt.getOptionContent()%> <%= opt.isCorrect() ? "(Correct)" : ""%></li>
                                                    <% } %>
                                                </ul>
                                            <% } %>
                                            --%>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2 align-items-center">
                                                <a href="${pageContext.request.contextPath}/questionDetail?questionId=<%= q.getQuestionID()%>&quizId=<%= quiz.getQuizID()%>"
                                                   class="text-primary"> <%-- Bootstrap text-primary for blue --%>
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <button type="button" onclick="showDeleteQuestionModal('<%= q.getQuestionID()%>', '<%= quiz.getQuizID()%>')"
                                                        class="btn btn-link text-danger btn-delete-question p-0 border-0">
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
                                        <td colspan="4" class="text-center text-muted">No questions added yet.</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } else if (quiz != null && quiz.getQuizID() > 0 && !canEdit) { %>
                        <p class="text-warning mb-0"> <%-- Bootstrap text-warning for orange --%>
                            <i class="fas fa-exclamation-triangle me-1"></i> Questions for this quiz cannot be managed because tests have already been taken.
                        </p>
                        <% } else { %>
                        <p class="text-muted mb-0">
                            <i class="fas fa-info-circle me-1"></i> Please save the quiz details first to manage questions.
                        </p>
                        <% }%>
                    </div>
                </div>
            </main>
        </div>

        <%-- Delete Question Confirmation Modal (using Bootstrap classes) --%>
        <div class="modal fade" id="deleteQuestionModal" tabindex="-1" aria-labelledby="modal-title" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header d-flex flex-column align-items-center border-0 pb-0">
                        <div class="modal-icon-wrapper mb-3">
                            <i class="fas fa-exclamation-triangle modal-icon fa-2x"></i>
                        </div>
                        <h5 class="modal-title text-center modal-title-text" id="modal-title">Delete Question</h5>
                    </div>
                    <div class="modal-body text-center pt-0">
                        <p class="modal-description-text">
                            Are you sure you want to delete this question and all its options? This action cannot be undone.
                        </p>
                    </div>
                    <div class="modal-footer justify-content-end border-0 pt-0">
                        <form id="deleteQuestionForm" action="${pageContext.request.contextPath}/questions" method="POST" class="d-inline-block">
                            <input type="hidden" name="action" value="deleteQuestion">
                            <input type="hidden" name="questionId" id="modalQuestionId">
                            <input type="hidden" name="quizId" id="modalQuizIdForQuestionDelete">
                            <button type="submit" class="btn btn-danger">
                                Delete
                            </button>
                        </form>
                        <button type="button" id="cancelQuestionDelete" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Bootstrap JavaScript Bundle (includes Popper.js) --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Initialize Bootstrap Tabs
            var triggerTabList = [].slice.call(document.querySelectorAll('#myTab button'));
            triggerTabList.forEach(function (triggerEl) {
                var tabTrigger = new bootstrap.Tab(triggerEl);
                triggerEl.addEventListener('click', function (event) {
                    event.preventDefault();
                    tabTrigger.show();
                });
            });

            // JavaScript for Delete Question Confirmation Modal
            const deleteQuestionModalElement = document.getElementById('deleteQuestionModal');
            const deleteQuestionModal = new bootstrap.Modal(deleteQuestionModalElement);
            const modalQuestionId = document.getElementById('modalQuestionId');
            const modalQuizIdForQuestionDelete = document.getElementById('modalQuizIdForQuestionDelete');

            function showDeleteQuestionModal(questionId, quizId) {
                modalQuestionId.value = questionId;
                modalQuizIdForQuestionDelete.value = quizId;
                deleteQuestionModal.show();
            }

            // The 'cancelQuestionDeleteBtn' click listener is replaced by data-bs-dismiss="modal" on the button
            // The form submission logic needs to be attached to the modal's submit button, not the table's delete button
            // This is already handled by the form's type="submit" in the modal.

            // Set the active tab on page load based on logic
            document.addEventListener('DOMContentLoaded', () => {
                const quizID = <%= (quiz != null) ? quiz.getQuizID() : 0%>;
                const canEdit = <%= canEdit%>;

                if (quizID > 0 && canEdit) {
                    // If it's an editable quiz, default to "Manage Questions" tab
                    document.getElementById('questions-tab').click();
                } else {
                    // Otherwise, default to "Quiz Details" tab
                    document.getElementById('details-tab').click();
                }
            });
        </script>
        <%@include file="../includes/foot1.jsp" %>
    </body>
</html>