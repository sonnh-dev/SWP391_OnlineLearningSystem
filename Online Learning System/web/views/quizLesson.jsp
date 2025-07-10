<%-- quizLesson.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz" %>
<%@page import="model.QuizAttempt" %>
<!DOCTYPE html>
<html>
<head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quiz Lesson</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f8fc;
            color: #2c3e50;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #007bff;
        }

        h2 {
            font-size: 22px;
            font-weight: 600;
            margin-top: 20px;
            color: #34495e;
        }

        p {
            font-size: 16px;
            margin: 10px 0;
        }

        strong {
            font-weight: 600;
        }

        form {
            display: inline-block;
            margin-right: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        a {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            color: #007bff;
            font-weight: 600;
        }

        hr {
            margin: 30px 0;
        }
    </style>
    <%@include file="../includes/head.jsp" %>
</head>
<body>
     <%@include file="../includes/navbar.jsp" %>
    <div class="container">
        <h1>Bài Quiz: ${quiz.quizName}</h1>

        <%
            Boolean showResultSubForm = (Boolean) request.getAttribute("showResultSubForm");
            Quiz quiz = (Quiz) request.getAttribute("quiz");
            QuizAttempt lastAttempt = (QuizAttempt) request.getAttribute("lastAttempt");
        %>

        <% if (showResultSubForm != null && showResultSubForm) { %>
            <h2>Kết quả lần làm bài gần nhất</h2>
            <p>Điểm của bạn: <strong><%= String.format("%.2f", lastAttempt.getScore()) %></strong></p>
            <p>Trạng thái: <strong><%= (lastAttempt.getIsPassed() != null && lastAttempt.getIsPassed()) ? "ĐẠT" : "CHƯA ĐẠT" %></strong></p>
            <p>Thời gian làm bài: <strong><%= lastAttempt.getStartTime() %> - <%= (lastAttempt.getEndTime() != null ? lastAttempt.getEndTime() : "Đang làm dở") %></strong></p>
            
            <form action="quizReview" method="GET">
                <input type="hidden" name="attemptId" value="<%= lastAttempt.getAttemptId() %>">
                <button type="submit">Xem lại bài (Review Test)</button>
            </form>
            <form action="quizHandle" method="GET">
                <input type="hidden" name="quizId" value="<%= quiz.getQuizID() %>">
                <button type="submit">Làm lại bài (Redo Test)</button>
            </form>
        <% } else { %>
            <h2>Chi tiết Quiz</h2>
            <p><strong>Tên Quiz:</strong> <%= quiz.getQuizName() %></p>
            <p><strong>Chủ đề:</strong> <%= quiz.getSubject() %></p>
            <p><strong>Mức độ:</strong> <%= quiz.getLevel() %></p>
            <p><strong>Số câu hỏi:</strong> <%= quiz.getNumQuestions() %></p>
            <p><strong>Thời lượng:</strong> <%= quiz.getDurationMinutes() %> phút</p>
            <p><strong>Tỷ lệ đạt:</strong> <%= String.format("%.0f%%", quiz.getPassRate()) %></p>
            <p><strong>Loại Quiz:</strong> <%= quiz.getQuizType() %></p>

            <form action="quizHandle" method="GET">
                <input type="hidden" name="quizId" value="${quizId}">
                <button type="submit">Bắt đầu làm bài (Start Test)</button>
            </form>
        <% } %>

        <hr>
        <a href="index.jsp">← Về trang chủ</a>
    </div>
        <%@include file="../includes/foot.jsp" %>
</body>
</html>
