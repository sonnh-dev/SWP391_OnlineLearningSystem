<%-- quizReview.jsp --%>
<%@page import="model.QuestionOption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Question" %>
<%@page import="model.Quiz" %>
<%@page import="model.QuizAttempt" %>
<%@page import="model.Option" %> <%-- Ensure your Option class is imported --%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.Collections" %>
<%@page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Review</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            /* CSS reused from quizHandle.jsp */
            body {
                font-family: 'Inter', sans-serif;
                margin: 0;
                background-color: #f4f7fa;
                color: #333;
            }

            .review-container {
                max-width: 900px;
                margin: 40px auto;
                background: #fff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .header h1 {
                font-size: 24px;
                font-weight: 700;
                color: #1e2a38;
            }

            /* Specific CSS for quizReview.jsp */
            .review-info {
                background-color: #e9ecef;
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                font-size: 1.1em;
                color: #34495e;
            }
            .review-info p {
                margin: 5px 0;
            }
            .review-info strong {
                color: #007bff;
            }
            .review-info span.pass {
                color: #28a745;
                font-weight: bold;
            }
            .review-info span.fail {
                color: #dc3545;
                font-weight: bold;
            }

            .review-question-card {
                background-color: #f9fafc;
                padding: 25px;
                border-radius: 10px;
                margin-bottom: 25px;
                border: 1px solid #e0e6ed;
            }
            .review-question-card .question-content {
                font-size: 1.15em;
                font-weight: 600;
                margin-bottom: 15px;
                color: #34495e;
            }
            .review-question-card .question-status {
                font-size: 1em;
                font-weight: 700;
                margin-left: 10px;
            }
            .review-question-card .options div.option {
                padding: 10px 15px;
                border-radius: 6px;
                border: 1px solid #ddd;
                margin-bottom: 8px;
                background-color: #fff;
                position: relative;
            }
            .review-question-card .option.correct {
                background-color: #d4edda; /* Light green */
                border-color: #28a745;
            }
            .review-question-card .option.user-selected {
                background-color: #cfe2ff; /* Light blue */
                border-color: #0d6efd;
            }
            .review-question-card .option.incorrect-selected {
                background-color: #f8d7da; /* Light red */
                border-color: #dc3545;
            }
            .review-question-card .option span {
                font-size: 0.9em;
                font-weight: 600;
                margin-left: 10px;
                color: #666;
            }
            .explanation-btn {
                margin-top: 15px;
                padding: 8px 15px;
                background-color: #6c757d;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }
            .explanation-btn:hover {
                background-color: #5a6268;
            }
            .explanation-content {
                background-color: #e2e3e5;
                padding: 15px;
                margin-top: 15px;
                border-radius: 8px;
                display: none; /* Hidden by default */
                font-size: 0.95em;
                line-height: 1.5;
                color: #34495e;
            }
            .explanation-content strong {
                color: #007bff;
            }

            /* Styles for essay answers */
            .user-text-answer, .answer-key-content {
                border: 1px dashed #a0a0a0;
                padding: 15px;
                background-color: #f0f0f0;
                border-radius: 8px;
                margin-top: 10px;
                white-space: pre-wrap; /* Preserve whitespace and line breaks */
                word-wrap: break-word; /* Break long words */
            }
            .answer-key-content {
                background-color: #e0f7fa; /* Lighter blue for answer key */
                border-color: #00bcd4;
            }

            /* Popup styles - Reused from quizHandle.jsp */
            .popup-overlay {
                display: none;
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, 0.5);
                z-index: 99;
                justify-content: center;
                align-items: center;
            }

            .popup-content {
                background: white;
                padding: 30px 40px;
                border-radius: 10px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25);
                text-align: center;
                position: relative;
                min-width: 350px;
                max-width: 90%;
            }

            .popup-close {
                position: absolute;
                top: 15px;
                right: 20px;
                font-size: 24px;
                color: #888;
                cursor: pointer;
            }

            .popup-options button {
                margin: 10px;
                padding: 10px 24px;
                border-radius: 6px;
                font-weight: 600;
                border: none;
                cursor: pointer;
            }

            .popup-options button:first-child {
                background-color: #6c757d;
                color: white;
            }

            .popup-options button:last-child {
                background-color: #28a745;
                color: white;
            }

            .question-numbers-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(42px, 1fr));
                gap: 10px;
                max-height: 300px;
                overflow-y: auto;
                margin-top: 20px;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #eee;
                background-color: #fafafa;
            }

            .question-numbers-grid a {
                display: block;
                padding: 8px 0;
                text-align: center;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
                color: #333;
                background-color: #e2e6ea;
                transition: all 0.2s;
            }

            .question-numbers-grid a:hover {
                background-color: #d6d8db;
            }

            .question-numbers-grid a.answered {
                background-color: #d4edda;
                color: #155724;
            }

            .question-numbers-grid a.unanswered {
                background-color: #f8d7da;
                color: #721c24;
            }

            .question-numbers-grid a.marked {
                background-color: #fff3cd;
                color: #856404;
            }

            .question-numbers-grid a.current {
                background-color: #007bff;
                color: #fff;
            }

            .filter-options {
                margin-bottom: 15px;
            }

            .filter-options button {
                margin: 5px;
                padding: 8px 14px;
                border: none;
                border-radius: 6px;
                background-color: #f0f0f0;
                font-weight: 600;
                cursor: pointer;
            }

            .filter-options button:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <%
            // Ensure these variables are not null to avoid NullPointerExceptions in JSP
            Quiz quiz = (Quiz) request.getAttribute("quiz");
            QuizAttempt attempt = (QuizAttempt) request.getAttribute("attempt");
            List<Question> questions = (List<Question>) request.getAttribute("questions");

            // Initialize if null (though servlet should ideally prevent this)
            if (questions == null) {
                questions = Collections.emptyList();
            }
            Map<Integer, List<Integer>> correctOptionsMap = (Map<Integer, List<Integer>>) request.getAttribute("correctOptionsMap");
            if (correctOptionsMap == null) {
                correctOptionsMap = Collections.emptyMap();
            }

            // Basic check to prevent NPE if quiz or attempt are null
            if (quiz == null || attempt == null) {
                // Redirect to a more user-friendly error page
                response.sendRedirect("error.jsp?errorMessage=Quiz or attempt information not found.");
                return; // Stop JSP processing
            }
        %>
        <div class="review-container">
            <div class="header">
                <h1>Review Quiz: <%= quiz.getQuizName()%></h1>

            </div>

            <div class="review-info">
                <p>Your Score: <strong><%= String.format("%.2f", attempt.getScore())%></strong></p>
                <p>Status:
                    <span class="<%= (attempt.getIsPassed() != null && attempt.getIsPassed()) ? "pass" : "fail"%>">
                        <%= (attempt.getIsPassed() != null && attempt.getIsPassed()) ? "PASSED" : "FAILED"%>
                    </span>
                </p>
                <p>Time Taken: <%= attempt.getStartTime()%> - <%= (attempt.getEndTime() != null ? attempt.getEndTime() : "N/A")%></p>

            </div>

            <button class="explanation-btn" onclick="showReviewResultPopup()">View Overall Result</button>

            <div id="quizReviewQuestions">
                <%
                    int qNum = 0;
                    for (Question q : questions) {
                        qNum++;
                        String questionType = q.getQuestionType();
                        List<Integer> userSelected = q.getUserSelectedOptionIds();
                        String userAnswerText = q.getUserAnswerText();
                        List<Integer> correctOptions = correctOptionsMap.getOrDefault(q.getQuestionID(), Collections.emptyList());
                        String answerKey = q.getAnswerKey();

                        boolean isCorrectlyAnswered = false; // Default to false for essay questions
                        if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) {
                            // Compare selected options with correct answers for multiple choice questions
                            List<Integer> sortedUserSelected = new ArrayList<>(userSelected);
                            List<Integer> sortedCorrectOptions = new ArrayList<>(correctOptions);
                            Collections.sort(sortedUserSelected);
                            Collections.sort(sortedCorrectOptions);
                            isCorrectlyAnswered = sortedUserSelected.equals(sortedCorrectOptions);
                        }
                        // For essay questions, correct/incorrect status needs manual grading,
                        // so it's not automatically displayed here.
                %>
                <div class="review-question-card" id="question<%= qNum%>">
                    <p class="question-content">Question <%= qNum%>: <%= q.getQuestionContent()%>
                        <% if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) {
                                if (userSelected != null && !userSelected.isEmpty()) {%>
                        <span class="question-status" style="color: <%= isCorrectlyAnswered ? "green" : "red"%>;">
                            (<%= isCorrectlyAnswered ? "Correct" : "Incorrect"%>)
                        </span>
                        <%  } else { %>
                        <span class="question-status" style="color: #6c757d;">(Not Answered)</span>
                        <%  }
                        } else { %>
                        <span class="question-status" style="color: #6c757d;">(Manual Grading Required)</span>
                        <% } %>
                    </p>

                    <div class="options">
                        <%
                            if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) {
                                // Display options and status for multiple choice questions
                                for (QuestionOption opt : q.getOptions()) {
                                    String optionClass = "option";
                                    boolean isUserSelectedThisOption = userSelected.contains(opt.getOptionID());
                                    boolean isCorrectOption = correctOptions.contains(opt.getOptionID());

                                    if (isCorrectOption) {
                                        optionClass += " correct"; // This option is the correct answer
                                    }
                                    if (isUserSelectedThisOption) { // If the user selected this option
                                        if (isCorrectOption) {
                                            optionClass += " user-selected"; // User selected correctly
                                        } else {
                                            optionClass += " incorrect-selected"; // User selected incorrectly
                                        }
                                    }
                        %>
                        <div class="<%= optionClass%>">
                            <%= opt.getOptionContent()%>
                            <% if (isCorrectOption) { %> <span>(Correct Answer)</span> <% } %>
                            <% if (isUserSelectedThisOption) { %> <span>(Your Answer)</span> <% } %>
                        </div>
                        <%
                                }
                            } else if ("Short Answer".equals(questionType) || "Essay".equals(questionType)) {
                                // Display user's essay answer
                        %>
                        <p><strong>Your Answer:</strong></p>
                        <div class="user-text-answer">
                            <%= (userAnswerText != null && !userAnswerText.trim().isEmpty() ? userAnswerText : "Not Answered")%>
                        </div>

                        <%-- ✅ Add section to display attached file if available --%>
                        <%
                            String uploadedFile = q.getUploadedFilePath();
                            if (uploadedFile != null && !uploadedFile.trim().isEmpty()) {
                        %>
                        <div style="margin-top: 10px;">
                            <strong>Attached File:</strong>
                            <% if (uploadedFile.endsWith(".jpg") || uploadedFile.endsWith(".jpeg") || uploadedFile.endsWith(".png") || uploadedFile.endsWith(".gif")) {%>
                            <div><img src="<%= request.getContextPath() + "/uploads/" + uploadedFile%>" alt="Uploaded Image" style="max-width:100%; border: 1px solid #ccc; margin-top: 8px;"/></div>
                                <% } else {%>
                            <div><a href="<%= request.getContextPath() + "/uploads/" + uploadedFile%>" target="_blank">Download file</a></div>
                            <% } %>
                        </div>
                        <%
                            }
                        %>

                        <%
                            }
                        %>
                    </div>
                    <%-- Explanation button only displays when an AnswerKey exists --%>
                    <% if (answerKey != null && !answerKey.trim().isEmpty()) {%>
                    <button class="explanation-btn" onclick="toggleExplanation(this)">View Explanation / Sample Answer</button>
                    <div class="explanation-content">
                        <strong>Sample Answer:</strong><br>
                        <%= answerKey%>
                    </div>
                    <% } %>
                </div>
                <%
                    }
                %>
            </div>

            <div class="footer">
                <a href="quizLesson?quizId=<%= quiz.getQuizID()%>">Back to Quiz Lesson page</a>
            </div>
        </div>

        <div id="reviewResultPopup" class="popup-overlay">
            <div class="popup-content">
                <span class="popup-close" onclick="hideReviewResultPopup()">&times;</span>
                <h3>View Overall Results</h3>
                <div class="filter-options">
                    <button onclick="filterReviewQuestions('all')">All</button>
                    <button onclick="filterReviewQuestions('answered')">Answered</button>
                    <button onclick="filterReviewQuestions('incorrect')">Incorrect</button>
                    <button onclick="filterReviewQuestions('marked')">Marked</button>
                </div>
                <div class="question-numbers-grid">
                    <%
                        // Loop through the list of questions to create question number links in the pop-up
                        if (questions != null) {
                            for (int i = 0; i < questions.size(); i++) {
                                Question q = questions.get(i);
                                String qType = q.getQuestionType();
                                List<Integer> userSelected = q.getUserSelectedOptionIds();
                                String userAnswerText = q.getUserAnswerText();
                                List<Integer> correctOptions = correctOptionsMap.getOrDefault(q.getQuestionID(), Collections.emptyList());

                                boolean isAnswered = false;
                                if ("Multiple Choice".equals(qType) || "True/False".equals(qType)) {
                                    isAnswered = !userSelected.isEmpty();
                                } else if ("Short Answer".equals(qType) || "Essay".equals(qType)) {
                                    isAnswered = (userAnswerText != null && !userAnswerText.trim().isEmpty());
                                }

                                // Determine if the answer is incorrect (only for multiple choice questions)
                                boolean isIncorrect = false;
                                if ("Multiple Choice".equals(qType) || "True/False".equals(qType)) {
                                    List<Integer> sortedUserSelected = new ArrayList<>(userSelected);
                                    List<Integer> sortedCorrectOptions = new ArrayList<>(correctOptions);
                                    Collections.sort(sortedUserSelected);
                                    Collections.sort(sortedCorrectOptions);

                                    if (isAnswered && !sortedUserSelected.equals(sortedCorrectOptions)) {
                                        isIncorrect = true;
                                    }
                                }
                                // Essay questions are not automatically determined as 'incorrect' here

                                String statusClass = "";
                                if (isAnswered) {
                                    statusClass += "answered ";
                                } else {
                                    statusClass += "unanswered ";
                                }
                                if (isIncorrect) {
                                    statusClass += "incorrect ";
                                }

                    %>
                    <a href="#question<%= i + 1%>"
                       onclick="navigateToQuestion(<%= i + 1%>); hideReviewResultPopup();"
                       class="<%= statusClass%>"
                       data-answered="<%= isAnswered%>"
                       data-incorrect="<%= isIncorrect%>"
                       data-marked="false"> <%-- Placeholder for marked --%>
                        <%= i + 1%>
                    </a>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>

        <script>
            // Show/hide explanation content
            function toggleExplanation(button) {
                const explanationContent = button.nextElementSibling;
                if (explanationContent.style.display === "block") {
                    explanationContent.style.display = "none";
                    button.innerText = "View Explanation / Sample Answer";
                } else {
                    explanationContent.style.display = "block";
                    button.innerText = "Hide Explanation / Sample Answer";
                }
            }

            // Pop-up functions (reused from quizHandle.jsp)
            function showReviewResultPopup() {
                document.getElementById('reviewResultPopup').style.display = 'flex';
            }
            function hideReviewResultPopup() {
                document.getElementById('reviewResultPopup').style.display = 'none';
            }

            // Filter questions in the "View Overall Results" pop-up
            function filterReviewQuestions(filterType) {
                const questionLinks = document.querySelectorAll('#reviewResultPopup .question-numbers-grid a');
                questionLinks.forEach(link => {
                    const isAnswered = link.getAttribute('data-answered') === 'true';
                    const isIncorrect = link.getAttribute('data-incorrect') === 'true';
                    const isMarked = link.getAttribute('data-marked') === 'true'; // Needs implementation for marked feature

                    let show = false;
                    if (filterType === 'all') {
                        show = true;
                    } else if (filterType === 'answered' && isAnswered) {
                        show = true;
                    } else if (filterType === 'incorrect' && isIncorrect) {
                        show = true;
                    } else if (filterType === 'marked' && isMarked) {
                        show = true;
                    }

                    if (show) {
                        link.style.display = 'inline-block';
                    } else {
                        link.style.display = 'none';
                    }
                });
            }

            // Function to scroll to a specific question (used by links in the pop-up)
            function navigateToQuestion(questionNumber) {
                const element = document.getElementById('question' + questionNumber);
                if (element) {
                    element.scrollIntoView({behavior: 'smooth', block: 'start'});
                }
                // Hide pop-up after navigation (if needed)
                // hideReviewResultPopup();
            }
        </script>
    </body>
</html>