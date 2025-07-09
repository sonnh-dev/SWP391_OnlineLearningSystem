<%-- quizHandle.jsp --%>
<%@page import="model.QuestionOption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Question" %>
<%@page import="model.Option" %> <%-- Assuming model.Option is your class for quiz options --%>
<%@page import="java.util.List" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<%@page import="java.util.Collections" %> <%-- Added for Collections.emptyList() --%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Handle</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            /* Your existing CSS for quiz-container, header, timer, question-card, etc. */
            body {
                font-family: 'Inter', sans-serif;
                margin: 0;
                background-color: #f4f7fa;
                color: #333;
            }

            .quiz-container {
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

            .timer {
                font-size: 18px;
                font-weight: 600;
                color: #d9534f;
            }

            .question-card {
                background-color: #f9fafc;
                padding: 25px;
                border-radius: 10px;
                margin-bottom: 25px;
                border: 1px solid #e0e6ed;
            }

            .question-card h3 {
                margin-top: 0;
                font-weight: 600;
                color: #34495e;
            }

            .options label {
                display: block;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ddd;
                margin-bottom: 12px;
                background-color: #fff;
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .options input[type="radio"],
            .options input[type="checkbox"] {
                margin-right: 10px;
            }

            .options label:hover {
                background-color: #f0f8ff;
                border-color: #007bff;
            }

            /* Added style for textarea */
            textarea {
                width: 100%;
                padding: 10px;
                box-sizing: border-box; /* Include padding in width */
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical; /* Allow vertical resizing */
                font-family: 'Inter', sans-serif; /* Use Inter font */
                font-size: 1em;
                min-height: 100px; /* Minimum height for better appearance */
            }

            .footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 30px;
                border-top: 1px solid #e0e0e0;
                padding-top: 20px;
            }

            .navigation-buttons button,
            .footer button {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                font-weight: 600;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .navigation-buttons button:hover,
            .footer button:hover {
                background-color: #0056b3;
            }

            /* Popup */
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
            // Corrected: Ensure questions list is not null when accessed
            List<Question> questions = (List<Question>) request.getAttribute("questions");
            if (questions == null) {
                questions = Collections.emptyList(); // Initialize as empty list to prevent NPE in JSP
            }

            int currentQuestionIndex = (Integer) request.getAttribute("currentQuestionIndex");
            int totalQuestions = questions.size(); // Use questions.size() directly
            int quizId = (Integer) request.getAttribute("quizId");
            long remainingTimeMillis = (Long) request.getAttribute("remainingTimeMillis");

            Question currentQuestion = null;
            if (!questions.isEmpty() && currentQuestionIndex >= 0 && currentQuestionIndex < totalQuestions) {
                currentQuestion = questions.get(currentQuestionIndex);
            }
        %>
        <div class="quiz-container">
            <div class="header">
                <h1>Làm bài Quiz</h1>
                <div class="timer">Thời gian còn lại: <span id="countdownTimer"></span></div>
            </div>

            <% if (currentQuestion != null) {%>
            <form id="quizForm" action="quizHandle" method="POST" enctype="multipart/form-data"  >
                <input type="hidden" name="quizId" value="<%= quizId%>">
                <input type="hidden" name="qIndex" value="<%= currentQuestionIndex%>">
                <input type="hidden" name="questionId" value="<%= currentQuestion.getQuestionID()%>"> <%-- Corrected: getQuestionId() --%>
                <input type="hidden" name="questionType" value="<%= currentQuestion.getQuestionType()%>"> <%-- Added: To send question type --%>
                <input type="hidden" name="isMarked" id="isMarked" value="<%= currentQuestion.isMarked()%>">

                <div class="question-card">
                    <h3>Câu hỏi <%= currentQuestionIndex + 1%> / <%= totalQuestions%>:</h3>
                    <p><%= currentQuestion.getQuestionContent()%></p>
                    <div class="options">
                        <%
                            // Check question type to render appropriate input
                            String questionType = currentQuestion.getQuestionType();
                            if ("Multiple Choice".equals(questionType) || "True/False".equals(questionType)) {
                                // Display multiple choice / true-false options
                                // Make sure currentQuestion.getOptions() returns List<Option>
                                for (QuestionOption option : currentQuestion.getOptions()) {
                        %>
                        <label>
                            <% if ("Multiple Choice".equals(questionType)) {%>
                            <input type="checkbox" name="option_<%= currentQuestion.getQuestionID()%>" <%-- Corrected: getQuestionId() --%>
                                   value="<%= option.getOptionID()%>" <%-- Corrected: getOptionId() --%>
                                   <%= currentQuestion.isUserSelected(option.getOptionID()) ? "checked" : ""%>> <%-- Corrected: getOptionId() --%>
                            <% } else {%>
                            <input type="radio" name="option_<%= currentQuestion.getQuestionID()%>" <%-- Corrected: getQuestionId() --%>
                                   value="<%= option.getOptionID()%>" <%-- Corrected: getOptionId() --%>
                                   <%= currentQuestion.isUserSelected(option.getOptionID()) ? "checked" : ""%>> <%-- Corrected: getOptionId() --%>
                            <% }%>
                            <%= option.getOptionContent()%>
                        </label>
                        <%
                            }
                        } else if ("Short Answer".equals(questionType) || "Essay".equals(questionType)) {
                            // Display textarea for short answer/essay questions
%>
                        <textarea name="text_answer_<%= currentQuestion.getQuestionID()%>" rows="5" cols="50"
                                  placeholder="Nhập câu trả lời..."><%= (currentQuestion.getUserAnswerText() != null ? currentQuestion.getUserAnswerText() : "")%></textarea>

                        <div style="margin-top: 10px;">
                            <label>Đính kèm tệp hoặc hình ảnh:</label>
                            <input type="file" name="file_upload_<%= currentQuestion.getQuestionID()%>" accept=".jpg,.jpeg,.png,.pdf,.doc,.docx,.txt">
                            <%-- Nếu đã upload file trước đó --%>
                            <c:if test="${not empty currentQuestion.uploadedFilePath}">
                                <p>File đã tải lên: 
                                    <a href="${pageContext.request.contextPath}/uploads/${currentQuestion.uploadedFilePath}" target="_blank">Xem file</a>
                                </p>
                            </c:if>
                        </div>

                        <%
                        } else {
                            // Fallback for unsupported question types
                        %>
                        <p>Loại câu hỏi không được hỗ trợ.</p>
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="footer">
                    <button type="button" onclick="showReviewProgress()">Xem tiến độ (Review Progress)</button>
                    <button type="button" onclick="toggleMark()" id="markBtn">
                        <%= currentQuestion.isMarked() ? "Bỏ đánh dấu" : "Đánh dấu câu hỏi"%>
                    </button>

                    <div class="navigation-buttons">
                        <% if (currentQuestionIndex > 0) {%>
                        <button type="submit" formaction="quizHandle?quizId=<%= quizId%>&qIndex=<%= currentQuestionIndex - 1%>" formmethod="POST">Trước (Previous)</button>
                        <% } %>
                        <% if (currentQuestionIndex < totalQuestions - 1) {%>
                        <button type="submit" formaction="quizHandle?quizId=<%= quizId%>&qIndex=<%= currentQuestionIndex + 1%>" formmethod="POST">Tiếp (Next)</button>
                        <% } else { %>
                        <button type="button" onclick="confirmScoreExam()">Nộp bài (Score Exam)</button>
                        <% } %>
                    </div>
                </div>
            </form>
            <% } else { %>
            <p>Không tìm thấy câu hỏi.</p>
            <% } %>
        </div>

        <div id="reviewProgressPopup" class="popup-overlay">
            <div class="popup-content">
                <span class="popup-close" onclick="hideReviewProgress()">&times;</span>
                <h3>Xem tiến độ</h3>
                <div class="filter-options">
                    <button onclick="filterQuestions('all')">Tất cả</button>
                    <button onclick="filterQuestions('answered')">Đã trả lời</button>
                    <button onclick="filterQuestions('unanswered')">Chưa trả lời</button>
                    <button onclick="filterQuestions('marked')">Đánh dấu</button>
                </div>
                <div id="questionNumbers" class="question-numbers-grid">
                    <%
                        // Loop through questions list (guaranteed not null by now)
                        for (int i = 0; i < totalQuestions; i++) {
                            Question q = questions.get(i);
                            String statusClass = "";
                            String qType = q.getQuestionType(); // Get question type for accurate checking

                            boolean isAnswered = false;
                            if ("Multiple Choice".equals(qType) || "True/False".equals(qType)) {
                                isAnswered = !q.getUserSelectedOptionIds().isEmpty();
                            } else if ("Short Answer".equals(qType) || "Essay".equals(qType)) {
                                isAnswered = (q.getUserAnswerText() != null && !q.getUserAnswerText().trim().isEmpty());
                            }

                            if (isAnswered) {
                                statusClass = "answered";
                            } else {
                                statusClass = "unanswered";
                            }
                            if (q.isMarked()) {
                                statusClass += " marked";
                            }
                            // Add 'marked' if you implement that in your Question POJO and logic
                            if (i == currentQuestionIndex) {
                                statusClass += " current";
                            }
                    %>
                    <a href="quizHandle?quizId=<%= quizId%>&qIndex=<%= i%>" class="<%= statusClass%>" data-status="<%= statusClass%>"><%= i + 1%></a>
                    <% }%>
                </div>
                <button onclick="confirmScoreExam()">Nộp bài ngay</button>
            </div>
        </div>

        <div id="scoreExamConfirmationPopup" class="popup-overlay">
            <div class="popup-content">
                <span class="popup-close" onclick="hideScoreExamConfirmation()">&times;</span>
                <h3>Xác nhận nộp bài</h3>
                <p id="confirmationMessage"></p>
                <div class="popup-options">
                    <button onclick="continueTesting()">Tiếp tục làm bài</button>
                    <button onclick="submitExam()">Nộp bài & Thoát</button>
                </div>
            </div>
        </div>

        <script>
            function toggleMark() {
                const isMarkedInput = document.getElementById('isMarked');
                const markBtn = document.getElementById('markBtn');

                if (isMarkedInput.value === 'true') {
                    isMarkedInput.value = 'false';
                    markBtn.textContent = 'Đánh dấu câu hỏi';
                } else {
                    isMarkedInput.value = 'true';
                    markBtn.textContent = 'Bỏ đánh dấu';
                }
            }

            let remainingTime = <%= remainingTimeMillis%>; // milliseconds
            const quizForm = document.getElementById('quizForm');
            const totalQuestions = <%= totalQuestions%>;
            const currentQuestionIndex = <%= currentQuestionIndex%>;
            const quizId = <%= quizId%>;

            // Timer Logic
            function updateTimer() {
                if (remainingTime <= 0) {
                    document.getElementById('countdownTimer').innerText = "00:00";
                    alert("Thời gian đã hết! Bài làm sẽ tự động nộp.");
                    submitExamImmediately(); // Auto submit
                    return;
                }

                let minutes = Math.floor(remainingTime / 60000);
                let seconds = Math.floor((remainingTime % 60000) / 1000);

                document.getElementById('countdownTimer').innerText =
                        (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

                remainingTime -= 1000;
            }

            setInterval(updateTimer, 1000);
            updateTimer(); // Call initially

            // Show/Hide Pop-ups
            function showReviewProgress() {
                document.getElementById('reviewProgressPopup').style.display = 'flex';
            }
            function hideReviewProgress() {
                document.getElementById('reviewProgressPopup').style.display = 'none';
            }
            function showScoreExamConfirmation() {
                document.getElementById('scoreExamConfirmationPopup').style.display = 'flex';
            }
            function hideScoreExamConfirmation() {
                document.getElementById('scoreExamConfirmationPopup').style.display = 'none';
            }

            // Filter Questions in Review Progress Pop-up (Client-side)
            function filterQuestions(filterType) {
                const questionLinks = document.querySelectorAll('#questionNumbers a');
                questionLinks.forEach(link => {
                    const status = link.getAttribute('data-status');
                    if (filterType === 'all' || status.includes(filterType)) {
                        link.style.display = 'inline-block';
                    } else {
                        link.style.display = 'none';
                    }
                });
            }

            // Confirmation Logic for Scoring Exam
            function confirmScoreExam() {
                let answeredCount = 0;

                // Generate JSON-like data for questions on the client side
                // This avoids issues with org.json and ensures data is always available if questions is not null
                let questionsData = [
            <%
                // Use a loop to manually construct the JSON array
                if (questions != null) {
                    for (int i = 0; i < questions.size(); i++) {
                        Question q = questions.get(i);
                        // Escape single quotes in strings for valid JavaScript JSON
                        String userAnsText = (q.getUserAnswerText() != null) ? q.getUserAnswerText().replace("'", "\\'") : "";
                        String qType = q.getQuestionType();
                        List<Integer> selectedIds = (q.getUserSelectedOptionIds() != null) ? q.getUserSelectedOptionIds() : Collections.emptyList();

                        out.print("{");
                        out.print("id: " + q.getQuestionID() + ","); // Corrected: getQuestionId()
                        out.print("type: '" + qType + "',");
                        out.print("userSelectedOptionIds: " + selectedIds.toString() + ","); // Direct toString() for List<Integer>
                        out.print("userAnswerText: '" + userAnsText + "'"); // Wrap in single quotes and escape
                        out.print("}");
                        if (i < questions.size() - 1) {
                            out.print(",");
                        }
                    }
                }
            %>
                ];

                // Re-calculate answered count accurately on client-side from questionsData
                answeredCount = questionsData.filter(q => {
                    if (q.type === 'Multiple Choice' || q.type === 'True/False') {
                        return q.userSelectedOptionIds && q.userSelectedOptionIds.length > 0;
                    } else if (q.type === 'Short Answer' || q.type === 'Essay') {
                        return q.userAnswerText && q.userAnswerText.trim() !== '';
                    }
                    return false;
                }).length;


                let confirmationMessage = "";

                if (answeredCount === 0) {
                    confirmationMessage = "Bạn chưa trả lời câu nào. Bạn có muốn tiếp tục làm bài hay về trang mô tả Quiz?";
                } else if (answeredCount < totalQuestions) {
                    confirmationMessage = "Bạn có một số câu hỏi chưa trả lời. Bạn có muốn tiếp tục làm bài hay nộp bài?";
                } else {
                    confirmationMessage = "Bạn đã trả lời tất cả các câu hỏi. Bạn có muốn tiếp tục làm bài hay nộp bài?";
                }

                document.getElementById('confirmationMessage').innerText = confirmationMessage;
                showScoreExamConfirmation();
            }

            function continueTesting() {
                hideScoreExamConfirmation();
            }

            function submitExam() {
                quizForm.action = `quizHandle?action=scoreExam&quizId=${quizId}`;
                quizForm.submit();
            }

            function submitExamImmediately() {
                quizForm.action = `quizHandle?action=scoreExam&quizId=${quizId}`;
                quizForm.submit();
            }
            function toggleMark() {
                const isMarkedInput = document.getElementById('isMarked');
                const markBtn = document.getElementById('markBtn');

                if (isMarkedInput.value === 'true') {
                    isMarkedInput.value = 'false';
                    markBtn.textContent = 'Đánh dấu câu hỏi';
                } else {
                    isMarkedInput.value = 'true';
                    markBtn.textContent = 'Bỏ đánh dấu';
                }
            }

        </script>
    </body>
</html>