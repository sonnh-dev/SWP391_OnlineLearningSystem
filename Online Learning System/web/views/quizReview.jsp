<%-- quizReview.jsp --%>
<%@page import="model.QuestionOption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Question" %>
<%@page import="model.Quiz" %>
<%@page import="model.QuizAttempt" %>
<%@page import="model.Option" %> <%-- Đảm bảo import class Option của bạn --%>
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
        /* CSS được sử dụng lại từ quizHandle.jsp */
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

        /* CSS riêng cho quizReview.jsp */
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
        .review-info span.pass { color: #28a745; font-weight: bold; }
        .review-info span.fail { color: #dc3545; font-weight: bold; }

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
            background-color: #d4edda; /* Màu xanh lá nhạt */
            border-color: #28a745;
        }
        .review-question-card .option.user-selected {
            background-color: #cfe2ff; /* Màu xanh lam nhạt */
            border-color: #0d6efd;
        }
        .review-question-card .option.incorrect-selected {
            background-color: #f8d7da; /* Màu đỏ nhạt */
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
            display: none; /* Mặc định ẩn */
            font-size: 0.95em;
            line-height: 1.5;
            color: #34495e;
        }
        .explanation-content strong {
            color: #007bff;
        }

        /* Styles cho câu trả lời tự luận */
        .user-text-answer, .answer-key-content {
            border: 1px dashed #a0a0a0;
            padding: 15px;
            background-color: #f0f0f0;
            border-radius: 8px;
            margin-top: 10px;
            white-space: pre-wrap; /* Giữ khoảng trắng và xuống dòng */
            word-wrap: break-word; /* Ngắt từ dài */
        }
        .answer-key-content {
            background-color: #e0f7fa; /* Màu xanh lam nhạt hơn cho đáp án */
            border-color: #00bcd4;
        }

        /* Popup styles - Tái sử dụng từ quizHandle.jsp */
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
        // Đảm bảo các biến này không null để tránh lỗi NullPointerException trong JSP
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

        // Kiểm tra cơ bản để ngăn NPE nếu quiz hoặc attempt là null
        if (quiz == null || attempt == null) {
            // Chuyển hướng về trang lỗi thân thiện hơn
            response.sendRedirect("error.jsp?errorMessage=Không tìm thấy thông tin quiz hoặc bài làm.");
            return; // Dừng xử lý JSP
        }
    %>
    <div class="review-container">
        <div class="header">
            <h1>Xem lại bài Quiz: <%= quiz.getQuizName() %></h1>
        </div>

        <div class="review-info">
            <p>Điểm của bạn: <strong><%= String.format("%.2f", attempt.getScore()) %></strong></p>
            <p>Trạng thái:
                <span class="<%= (attempt.getIsPassed() != null && attempt.getIsPassed()) ? "pass" : "fail" %>">
                    <%= (attempt.getIsPassed() != null && attempt.getIsPassed()) ? "ĐẠT" : "CHƯA ĐẠT" %>
                </span>
            </p>
            <p>Thời gian làm bài: <%= attempt.getStartTime() %> - <%= (attempt.getEndTime() != null ? attempt.getEndTime() : "N/A") %></p>
        </div>

        <button class="explanation-btn" onclick="showReviewResultPopup()">Xem tổng quan kết quả (Review Result)</button>
        
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
                    
                    boolean isCorrectlyAnswered = false; // Mặc định là false cho tự luận
                    if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) {
                        // So sánh các lựa chọn đã chọn với đáp án đúng cho câu trắc nghiệm
                        List<Integer> sortedUserSelected = new ArrayList<>(userSelected);
                        List<Integer> sortedCorrectOptions = new ArrayList<>(correctOptions);
                        Collections.sort(sortedUserSelected);
                        Collections.sort(sortedCorrectOptions);
                        isCorrectlyAnswered = sortedUserSelected.equals(sortedCorrectOptions);
                    }
                    // Đối với câu tự luận, trạng thái đúng/sai cần chấm thủ công,
                    // nên không hiển thị "Đúng/Sai" tự động ở đây.
            %>
                    <div class="review-question-card" id="question<%= qNum %>">
                        <p class="question-content">Câu hỏi <%= qNum %>: <%= q.getQuestionContent() %>
                            <% if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) { %>
                                <span class="question-status" style="color: <%= isCorrectlyAnswered ? "green" : "red" %>;">
                                    (<%= isCorrectlyAnswered ? "Đúng" : "Sai" %>)
                                </span>
                            <% } else { %>
                                <span class="question-status" style="color: #6c757d;">(Chấm điểm thủ công)</span>
                            <% } %>
                        </p>
                        <div class="options">
                            <%
                                if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) {
                                    // Hiển thị lựa chọn và trạng thái cho câu hỏi trắc nghiệm
                                    for (QuestionOption opt : q.getOptions()) {
                                        String optionClass = "option";
                                        boolean isUserSelectedThisOption = userSelected.contains(opt.getOptionID());
                                        boolean isCorrectOption = correctOptions.contains(opt.getOptionID());

                                        if (isCorrectOption) {
                                            optionClass += " correct"; // Lựa chọn này là đáp án đúng
                                        }
                                        if (isUserSelectedThisOption) { // Nếu người dùng đã chọn lựa chọn này
                                            if (isCorrectOption) {
                                                optionClass += " user-selected"; // Người dùng chọn đúng
                                            } else {
                                                optionClass += " incorrect-selected"; // Người dùng chọn sai
                                            }
                                        }
                            %>
                                        <div class="<%= optionClass %>">
                                            <%= opt.getOptionContent() %>
                                            <% if (isCorrectOption) { %> <span>(Đáp án đúng)</span> <% } %>
                                            <% if (isUserSelectedThisOption) { %> <span>(Lựa chọn của bạn)</span> <% } %>
                                        </div>
                            <%
                                    }
                                } else if ("Short Answer".equals(questionType) || "Essay".equals(questionType)) {
                                    // Hiển thị câu trả lời tự luận của người dùng
                            %>
                                    <p><strong>Câu trả lời của bạn:</strong></p>
                                    <div class="user-text-answer">
                                        <%= (userAnswerText != null && !userAnswerText.trim().isEmpty() ? userAnswerText : "Chưa trả lời") %>
                                    </div>
                            <%
                                }
                            %>
                        </div>
                        <%-- Nút giải thích chỉ hiển thị khi có AnswerKey --%>
                        <% if (answerKey != null && !answerKey.trim().isEmpty()) { %>
                            <button class="explanation-btn" onclick="toggleExplanation(this)">Xem giải thích / Đáp án mẫu</button>
                            <div class="explanation-content">
                                <strong>Đáp án mẫu:</strong><br>
                                <%= answerKey %>
                            </div>
                        <% } %>
                    </div>
D            <%
                }
            %>
        </div>

        <div class="footer">
            <a href="quizLesson?quizId=<%= quiz.getQuizID() %>">Quay lại trang Quiz Lesson</a>
        </div>
    </div>

    <div id="reviewResultPopup" class="popup-overlay">
        <div class="popup-content">
            <span class="popup-close" onclick="hideReviewResultPopup()">&times;</span>
            <h3>Xem tổng quan kết quả</h3>
            <div class="filter-options">
                <button onclick="filterReviewQuestions('all')">Tất cả</button>
                <button onclick="filterReviewQuestions('answered')">Đã trả lời</button>
                <button onclick="filterReviewQuestions('incorrect')">Sai</button>
                <button onclick="filterReviewQuestions('marked')">Đánh dấu</button>
            </div>
            <div class="question-numbers-grid">
                 <%
                    // Lặp qua danh sách câu hỏi để tạo các liên kết số câu hỏi trong pop-up
                    if (questions != null) {
                        for(int i=0; i<questions.size(); i++) {
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

                            // Xác định nếu câu trả lời sai (chỉ cho câu trắc nghiệm)
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
                            // Câu tự luận không tự động xác định là 'sai' ở đây

                            String statusClass = "";
                            if (isAnswered) {
                                statusClass += "answered ";
                            } else {
                                statusClass += "unanswered ";
                            }
                            if (isIncorrect) {
                                statusClass += "incorrect ";
                            }
                            // Thêm class 'current' nếu đây là câu hỏi đang được xem
                            // (Mặc dù review popup không có khái niệm "câu hỏi hiện tại",
                            // bạn có thể dùng để đánh dấu câu hỏi đang được hiển thị trên main view
                            // nếu bạn kết hợp AJAX và điều hướng.)
                            // statusClass += (i == currentQuestionIndex) ? "current " : ""; // currentQuestionIndex không có ở đây

                            // Để JavaScript có thể lọc, lưu trữ trạng thái vào data attributes
                %>
                        <a href="#question<%= i + 1 %>"
                           onclick="navigateToQuestion(<%= i + 1 %>); hideReviewResultPopup();"
                           class="<%= statusClass %>"
                           data-answered="<%= isAnswered %>"
                           data-incorrect="<%= isIncorrect %>"
                           data-marked="false"> <%-- Placeholder for marked --%>
                           <%= i + 1 %>
                        </a>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </div>

    <script>
        // Hiển thị/ẩn nội dung giải thích (Explanation)
        function toggleExplanation(button) {
            const explanationContent = button.nextElementSibling;
            if (explanationContent.style.display === "block") {
                explanationContent.style.display = "none";
                button.innerText = "Xem giải thích / Đáp án mẫu";
            } else {
                explanationContent.style.display = "block";
                button.innerText = "Ẩn giải thích / Đáp án mẫu";
            }
        }

        // Chức năng Pop-up (tái sử dụng từ quizHandle.jsp)
        function showReviewResultPopup() {
            document.getElementById('reviewResultPopup').style.display = 'flex';
        }
        function hideReviewResultPopup() {
            document.getElementById('reviewResultPopup').style.display = 'none';
        }

        // Lọc câu hỏi trong Pop-up "Xem tổng quan kết quả"
        function filterReviewQuestions(filterType) {
            const questionLinks = document.querySelectorAll('#reviewResultPopup .question-numbers-grid a');
            questionLinks.forEach(link => {
                const isAnswered = link.getAttribute('data-answered') === 'true';
                const isIncorrect = link.getAttribute('data-incorrect') === 'true';
                const isMarked = link.getAttribute('data-marked') === 'true'; // Cần triển khai tính năng đánh dấu

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
        
        // Hàm cuộn đến câu hỏi cụ thể (được sử dụng bởi các liên kết trong pop-up)
        function navigateToQuestion(questionNumber) {
            const element = document.getElementById('question' + questionNumber);
            if (element) {
                element.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
            // Ẩn pop-up sau khi điều hướng (nếu cần)
            // hideReviewResultPopup();
        }
    </script>
</body>
</html>