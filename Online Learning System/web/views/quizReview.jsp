<%-- quizReview.jsp --%>
<%@page import="model.QuestionOption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz" %>
<%@page import="model.QuizAttempt" %>
<%@page import="model.Question" %>
<%@page import="model.Option" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quiz Review</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .review-container { max-width: 800px; margin: auto; padding: 20px; border: 1px solid #ddd; box-shadow: 2px 2px 8px rgba(0,0,0,0.1); }
        .review-question-card { border: 1px solid #eee; padding: 15px; margin-bottom: 15px; background-color: #fcfcfc; }
        .review-question-card .question-content { font-weight: bold; margin-bottom: 10px; }
        .review-question-card .option { margin-bottom: 5px; padding: 5px; border-radius: 3px; }
        .review-question-card .option.correct { background-color: #d4edda; color: #155724; } /* Green for correct */
        .review-question-card .option.user-selected { background-color: #cfe2ff; border: 1px solid #0d6efd; } /* Blue for user selection */
        .review-question-card .option.incorrect-selected { background-color: #f8d7da; color: #721c24; } /* Red for incorrect user selection */
        .explanation-btn { margin-top: 10px; padding: 8px 15px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .explanation-content { background-color: #e2e3e5; padding: 10px; margin-top: 10px; border-radius: 4px; display: none; }
    </style>
</head>
<body>
    <%
        Quiz quiz = (Quiz) request.getAttribute("quiz");
        QuizAttempt attempt = (QuizAttempt) request.getAttribute("attempt");
        List<Question> questions = (List<Question>) request.getAttribute("questions");
        Map<Integer, List<Integer>> correctAnswersMap = (Map<Integer, List<Integer>>) request.getAttribute("correctAnswers");
    %>
    <div class="review-container">
        <h1>Xem lại bài Quiz: <%= quiz.getQuizName() %></h1>
        <p>Điểm của bạn: **<%= String.format("%.2f", attempt.getScore()) %>**</p>
        <p>Trạng thái: **<%= (attempt.getIsPassed() != null && attempt.getIsPassed()) ? "ĐẠT" : "CHƯA ĐẠT" %>**</p>
        <hr>
        
        <button onclick="showReviewResultPopup()">Xem kết quả (Review Result)</button>
        
        <div id="quizReviewQuestions">
            <% if (questions != null) {
                int qNum = 0;
                for (Question q : questions) {
                    qNum++;
                    List<Integer> userSelected = q.getUserSelectedOptionIds();
                    List<Integer> correctOptions = correctAnswersMap.getOrDefault(q.getQuestionID(), Collections.emptyList());
                    
                    boolean isCorrectlyAnswered = userSelected.size() == correctOptions.size() &&
                                                  userSelected.containsAll(correctOptions) &&
                                                  correctOptions.containsAll(userSelected);
            %>
                    <div class="review-question-card" id="question<%= qNum %>">
                        <p class="question-content">Câu hỏi <%= qNum %>: <%= q.getQuestionContent() %> 
                        <% if (isCorrectlyAnswered) { %>
                            <span style="color: green;">(Đúng)</span>
                        <% } else { %>
                            <span style="color: red;">(Sai)</span>
                        <% } %>
                        </p>
                        <div class="options">
                            <% for (QuestionOption opt : q.getOptions()) {
                                String optionClass = "option";
                                boolean isUserSelected = userSelected.contains(opt.getOptionID());
                                boolean isCorrectOption = correctOptions.contains(opt.getOptionID());

                                if (isCorrectOption) {
                                    optionClass += " correct";
                                }
                                if (isUserSelected && !isCorrectOption) {
                                    optionClass += " incorrect-selected"; // User chọn sai
                                } else if (isUserSelected && isCorrectOption) {
                                    optionClass += " user-selected"; // User chọn đúng (có thể là trùng với correct)
                                }
                            %>
                                <div class="<%= optionClass %>">
                                    <%= opt.getOptionContent() %>
                                    <% if (isCorrectOption) { %> (Đáp án đúng) <% } %>
                                    <% if (isUserSelected) { %> (Lựa chọn của bạn) <% } %>
                                </div>
                            <% } %>
                        </div>
                        <%-- Giả sử Explanation có trong Question object, cần thêm vào CSDL và POJO --%>
                        <%-- if (q.getExplanation() != null && !q.getExplanation().isEmpty()) { --%>
                            <button class="explanation-btn" onclick="toggleExplanation(this)">Xem giải thích</button>
                            <div class="explanation-content">
                                Đây là giải thích cho câu hỏi <%= qNum %>.
                            </div>
                        <%-- } --%>
                    </div>
            <%  }
            } else { %>
                <p>Không có câu hỏi nào để xem lại.</p>
            <% } %>
        </div>

        <hr>
        <a href="quizLesson?quizId=<%= quiz.getQuizID() %>">Quay lại trang Quiz Lesson</a>
    </div>

    <div id="reviewResultPopup" class="popup-overlay">
        <div class="popup-content">
            <span class="popup-close" onclick="hideReviewResultPopup()">&times;</span>
            <h3>Xem lại kết quả</h3>
            <div class="filter-options">
                <button onclick="filterReviewQuestions('all')">Tất cả</button>
                <button onclick="filterReviewQuestions('answered')">Đã trả lời</button>
                <button onclick="filterReviewQuestions('incorrect')">Sai</button>
                <button onclick="filterReviewQuestions('marked')">Đánh dấu</button>
            </div>
            <div class="question-numbers-grid">
                 <% if (questions != null) {
                    for(int i=0; i<questions.size(); i++) {
                        Question q = questions.get(i);
                        List<Integer> userSelected = q.getUserSelectedOptionIds();
                        List<Integer> correctOptions = correctAnswersMap.getOrDefault(q.getQuestionID(), Collections.emptyList());
                        boolean isCorrect = userSelected.size() == correctOptions.size() &&
                                            userSelected.containsAll(correctOptions) &&
                                            correctOptions.containsAll(userSelected);

                        String statusClass = "";
                        if (!userSelected.isEmpty()) {
                            statusClass += "answered ";
                            if (!isCorrect) {
                                statusClass += "incorrect ";
                            }
                        } else {
                            statusClass += "unanswered "; // Có thể là câu chưa trả lời
                        }
                        // Add 'marked' class if question is marked in QuizAttemptDetails
                %>
                        <a href="#question<%= i + 1 %>" onclick="navigateToQuestion(<%= i + 1 %>); hideReviewResultPopup();" class="<%= statusClass %>" 
                           data-review-status="<%= (isCorrect ? "correct" : "incorrect") %>" 
                           data-answered="<%= (!userSelected.isEmpty() ? "true" : "false") %>"><%= i + 1 %></a>
                <% }
                } %>
            </div>
        </div>
    </div>

    <script>
        function toggleExplanation(button) {
            const explanationContent = button.nextElementSibling;
            if (explanationContent.style.display === "block") {
                explanationContent.style.display = "none";
                button.innerText = "Xem giải thích";
            } else {
                explanationContent.style.display = "block";
                button.innerText = "Ẩn giải thích";
            }
        }

        function showReviewResultPopup() {
            document.getElementById('reviewResultPopup').style.display = 'flex';
        }
        function hideReviewResultPopup() {
            document.getElementById('reviewResultPopup').style.display = 'none';
        }

        function filterReviewQuestions(filterType) {
            const questionLinks = document.querySelectorAll('#reviewResultPopup .question-numbers-grid a');
            questionLinks.forEach(link => {
                const isAnswered = link.getAttribute('data-answered') === 'true';
                const isCorrect = link.getAttribute('data-review-status') === 'correct';
                const isIncorrect = link.getAttribute('data-review-status') === 'incorrect';
                // const isMarked = link.getAttribute('data-marked') === 'true'; // Cần thêm data-marked từ backend

                let show = false;
                if (filterType === 'all') {
                    show = true;
                } else if (filterType === 'answered' && isAnswered) {
                    show = true;
                } else if (filterType === 'incorrect' && isIncorrect) {
                    show = true;
                } else if (filterType === 'marked' /* && isMarked */) { // Placeholder for marked
                    show = true;
                }

                if (show) {
                    link.style.display = 'inline-block';
                } else {
                    link.style.display = 'none';
                }
            });
        }
        
        function navigateToQuestion(questionNumber) {
            const element = document.getElementById('question' + questionNumber);
            if (element) {
                element.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }
    </script>
</body>
</html>