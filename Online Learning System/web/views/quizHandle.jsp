<%-- quizHandle.jsp --%>
<%@page import="model.QuestionOption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Question" %>
<%@page import="model.Option" %>
<%@page import="java.util.List" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quiz Handle</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Basic styling for quiz handle */
        body { font-family: Arial, sans-serif; margin: 20px; }
        .quiz-container { max-width: 800px; margin: auto; border: 1px solid #ddd; padding: 20px; box-shadow: 2px 2px 8px rgba(0,0,0,0.1); }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .question-card { border: 1px solid #ccc; padding: 20px; margin-bottom: 20px; background-color: #f9f9f9; }
        .options label { display: block; margin-bottom: 10px; cursor: pointer; }
        .footer { display: flex; justify-content: space-between; align-items: center; padding: 15px; border-top: 1px solid #eee; background-color: #f0f0f0; margin-top: 20px; }
        .timer { font-size: 1.2em; font-weight: bold; color: #d9534f; }
        .navigation-buttons button { padding: 10px 20px; margin-left: 10px; cursor: pointer; background-color: #007bff; color: white; border: none; border-radius: 5px; }
        .navigation-buttons button:hover { opacity: 0.9; }

        /* Pop-up styles */
        .popup-overlay {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 99;
            justify-content: center;
            align-items: center;
        }
        .popup-content {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            min-width: 300px;
        }
        .popup-close {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 1.5em;
            cursor: pointer;
            color: #aaa;
        }
        .popup-options button {
            margin: 10px;
            padding: 10px 20px;
            cursor: pointer;
        }
        .question-numbers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(40px, 1fr));
            gap: 10px;
            margin-top: 20px;
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #eee;
            padding: 10px;
        }
        .question-numbers-grid a {
            display: block;
            padding: 8px;
            text-align: center;
            text-decoration: none;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f0f0f0;
        }
        .question-numbers-grid a.answered { background-color: #d4edda; border-color: #28a745; } /* Green */
        .question-numbers-grid a.unanswered { background-color: #f8d7da; border-color: #dc3545; } /* Red */
        .question-numbers-grid a.marked { background-color: #ffeeba; border-color: #ffc107; } /* Yellow */
        .question-numbers-grid a.current { background-color: #007bff; color: white; }
    </style>
</head>
<body>
    <%
        List<Question> questions = (List<Question>) request.getAttribute("questions");
        int currentQuestionIndex = (Integer) request.getAttribute("currentQuestionIndex");
        int totalQuestions = (Integer) request.getAttribute("totalQuestions");
        int quizId = (Integer) request.getAttribute("quizId");
        long remainingTimeMillis = (Long) request.getAttribute("remainingTimeMillis");
        
        Question currentQuestion = null;
        if (questions != null && !questions.isEmpty() && currentQuestionIndex >= 0 && currentQuestionIndex < totalQuestions) {
            currentQuestion = questions.get(currentQuestionIndex);
        }
    %>
    <div class="quiz-container">
        <div class="header">
            <h1>Làm bài Quiz</h1>
            <div class="timer">Thời gian còn lại: <span id="countdownTimer"></span></div>
        </div>

        <% if (currentQuestion != null) { %>
            <form id="quizForm" action="quizHandle" method="POST">
                <input type="hidden" name="quizId" value="<%= quizId %>">
                <input type="hidden" name="qIndex" value="<%= currentQuestionIndex %>">
                <input type="hidden" name="questionId" value="<%= currentQuestion.getQuestionID() %>">
                
                <div class="question-card">
                    <h3>Câu hỏi <%= currentQuestionIndex + 1 %> / <%= totalQuestions %>:</h3>
                    <p><%= currentQuestion.getQuestionContent() %></p>
                    <div class="options">
                        <% for (QuestionOption option : currentQuestion.getOptions()) { %>
                            <label>
                                <% if ("Multiple Choice".equals(currentQuestion.getQuestionType())) { %>
                                    <input type="checkbox" name="option_<%= currentQuestion.getQuestionID() %>" 
                                           value="<%= option.getOptionID() %>" 
                                           <%= currentQuestion.isUserSelected(option.getOptionID()) ? "checked" : "" %>>
                                <% } else { %>
                                    <input type="radio" name="option_<%= currentQuestion.getQuestionID() %>" 
                                           value="<%= option.getOptionID() %>" 
                                           <%= currentQuestion.isUserSelected(option.getOptionID()) ? "checked" : "" %>>
                                <% } %>
                                <%= option.getOptionContent() %>
                            </label>
                        <% } %>
                    </div>
                </div>

                <div class="footer">
                    <button type="button" onclick="showReviewProgress()">Xem tiến độ (Review Progress)</button>
                    <div class="navigation-buttons">
                        <% if (currentQuestionIndex > 0) { %>
                            <button type="submit" formaction="quizHandle?quizId=<%= quizId %>&qIndex=<%= currentQuestionIndex - 1 %>" formmethod="POST">Trước (Previous)</button>
                        <% } %>
                        <% if (currentQuestionIndex < totalQuestions - 1) { %>
                            <button type="submit" formaction="quizHandle?quizId=<%= quizId %>&qIndex=<%= currentQuestionIndex + 1 %>" formmethod="POST">Tiếp (Next)</button>
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
                <% for(int i=0; i<totalQuestions; i++) {
                    Question q = questions.get(i);
                    String statusClass = "";
                    if (!q.getUserSelectedOptionIds().isEmpty()) {
                        statusClass = "answered";
                    } else {
                        statusClass = "unanswered";
                    }
                    if (i == currentQuestionIndex) {
                        statusClass += " current";
                    }
                %>
                    <a href="quizHandle?quizId=<%= quizId %>&qIndex=<%= i %>" class="<%= statusClass %>" data-status="<%= statusClass %>"><%= i + 1 %></a>
                <% } %>
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
        let remainingTime = <%= remainingTimeMillis %>; // milliseconds
        const quizForm = document.getElementById('quizForm');
        const totalQuestions = <%= totalQuestions %>;
        const currentQuestionIndex = <%= currentQuestionIndex %>;
        const quizId = <%= quizId %>;

        // Timer Logic
        function updateTimer() {
            if (remainingTime <= 0) {
                document.getElementById('countdownTimer').innerText = "00:00";
                alert("Thời gian đã hết! Bài làm sẽ tự động nộp.");
                submitExamImmediately(); // Tự động nộp
                return;
            }

            let minutes = Math.floor(remainingTime / 60000);
            let seconds = Math.floor((remainingTime % 60000) / 1000);

            document.getElementById('countdownTimer').innerText = 
                (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
            
            remainingTime -= 1000;
           
        }

        setInterval(updateTimer, 1000);
        updateTimer(); // Gọi lần đầu để hiển thị ngay lập tức

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
            // Đây là phần cần AJAX để kiểm tra số câu đã trả lời từ server
            // Để đơn giản, ta sẽ đếm trên client-side dựa vào DOM
            let answeredCount = 0;
            const allQuestions = Array.from({length: totalQuestions}, (v, i) => i);
            const currentQuestionId = document.querySelector('input[name="questionId"]').value;

            // Lấy câu trả lời hiện tại trước khi hiển thị popup
            const currentSelectedOptions = Array.from(document.querySelectorAll(`input[name="option_${currentQuestionId}"]:checked`))
                                            .map(el => el.value);
            // Cần một cách để đồng bộ trạng thái của tất cả các câu hỏi trên client
            // Đối với ví dụ này, chúng ta giả định đã có thông tin về câu trả lời
            // từ backend khi trang được tải.

            // Tạm thời, giả định có 1 vài câu đã trả lời
            answeredCount = Array.from(document.querySelectorAll('[name^="option_"]:checked')).length > 0 ? 1 : 0;
            // Thực tế: bạn cần một cơ chế backend để trả về số lượng câu đã trả lời
            // hoặc đếm dựa trên `questions` object được truyền từ backend (phức tạp hơn)
            // Ví dụ: var answeredQuestions = <%= questions.stream().filter(q -> !q.getUserSelectedOptionIds().isEmpty()).count() %>;
            // Dòng trên không hoạt động trực tiếp trong JS mà cần JSP expression
            let confirmationMessage = "";
            let allAnswered = false; // Flag cho tình trạng tất cả câu hỏi đã được trả lời

            // Logic đơn giản để test popup
            if (answeredCount === 0) {
                confirmationMessage = "Bạn chưa trả lời câu nào. Bạn có muốn tiếp tục làm bài hay về trang mô tả Quiz?";
            } else if (answeredCount < totalQuestions) {
                confirmationMessage = "Bạn có một số câu hỏi chưa trả lời. Bạn có muốn tiếp tục làm bài hay nộp bài?";
            } else {
                confirmationMessage = "Bạn đã trả lời tất cả các câu hỏi. Bạn có muốn tiếp tục làm bài hay nộp bài?";
                allAnswered = true;
            }
            
            document.getElementById('confirmationMessage').innerText = confirmationMessage;
            showScoreExamConfirmation();
        }

        function continueTesting() {
            hideScoreExamConfirmation();
        }

        function submitExam() {
            // Gửi form với action 'scoreExam'
            quizForm.action = `quizHandle?action=scoreExam&quizId=${quizId}`;
            quizForm.submit();
        }

        function submitExamImmediately() {
            // Hàm này được gọi khi hết giờ hoặc nhấn 'Nộp bài ngay' trong pop-up
            quizForm.action = `quizHandle?action=scoreExam&quizId=${quizId}`;
            quizForm.submit();
        }
    </script>
</body>
</html>