<%-- quizLesson.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz" %>
<%@page import="model.QuizAttempt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quiz Lesson</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Bài Quiz: ${quiz.quizName}</h1>
    
    <%
        Boolean showResultSubForm = (Boolean) request.getAttribute("showResultSubForm");
        Quiz quiz = (Quiz) request.getAttribute("quiz");
        QuizAttempt lastAttempt = (QuizAttempt) request.getAttribute("lastAttempt");
    %>

    <% if (showResultSubForm != null && showResultSubForm) { %>
        <h2>Kết quả lần làm bài gần nhất</h2>
        <p>Điểm của bạn: **<%= String.format("%.2f", lastAttempt.getScore()) %>**</p>
        <p>Trạng thái: **<%= (lastAttempt.getIsPassed() != null && lastAttempt.getIsPassed()) ? "ĐẠT" : "CHƯA ĐẠT" %>**</p>
        <p>Thời gian làm bài: <%= lastAttempt.getStartTime() %> - <%= (lastAttempt.getEndTime() != null ? lastAttempt.getEndTime() : "Đang làm dở") %></p>
        
        <form action="quizReview" method="GET" style="display:inline-block;">
            <input type="hidden" name="attemptId" value="<%= lastAttempt.getAttemptId() %>">
            <button type="submit">Xem lại bài (Review Test)</button>
        </form>
        <form action="quizHandle" method="GET" style="display:inline-block;">
            <input type="hidden" name="quizId" value="<%= quiz.getQuizID() %>">
            <button type="submit">Làm lại bài (Redo Test)</button>
        </form>
    <% } else { %>
        <h2>Chi tiết Quiz</h2>
        <p>Tên Quiz: **<%= quiz.getQuizName() %>**</p>
        <p>Chủ đề: <%= quiz.getSubject() %></p>
        <p>Mức độ: <%= quiz.getLevel() %></p>
        <p>Số câu hỏi: **<%= quiz.getNumQuestions() %>**</p>
        <p>Thời lượng: **<%= quiz.getDurationMinutes() %> phút**</p>
        <p>Tỷ lệ đạt: **<%= String.format("%.0f%%", quiz.getPassRate()) %>**</p>
        <p>Loại Quiz: <%= quiz.getQuizType() %></p>

        <form action="quizHandle" method="GET">
            <input type="hidden" name="quizId" value="${quizId}">
            <button type="submit">Bắt đầu làm bài (Start Test)</button>
        </form>
    <% } %>
    
    <hr>
    <a href="index.jsp">Về trang chủ</a>
</body>
</html>