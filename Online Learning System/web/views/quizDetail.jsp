<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz"%>
<%@page import="model.Question"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <% 
            Quiz quiz = (Quiz) request.getAttribute("quiz");
            boolean canEdit = (Boolean) request.getAttribute("canEdit");
            String pageTitle = (quiz == null || quiz.getQuizID() == 0) ? "Add New Quiz" : "Edit Quiz";
        %>
        <h1><%= pageTitle %></h1>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/quizzes" method="POST">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="quizID" value="<%= (quiz != null) ? quiz.getQuizID() : 0 %>">
            
            <p>
                <label for="quizName">Quiz Name:</label><br>
                <input type="text" id="quizName" name="quizName" value="<%= (quiz != null && quiz.getQuizName() != null) ? quiz.getQuizName() : "" %>" <%= canEdit ? "" : "readonly" %> required><br>
            </p>
            <p>
                <label for="subject">Subject:</label><br>
                <input type="text" id="subject" name="subject" value="<%= (quiz != null && quiz.getSubject() != null) ? quiz.getSubject() : "" %>" <%= canEdit ? "" : "readonly" %>><br>
            </p>
            <p>
                <label for="level">Level:</label><br>
                <select id="level" name="level" <%= canEdit ? "" : "disabled" %>>
                    <option value="Dễ" <%= (quiz != null && "Dễ".equals(quiz.getLevel())) ? "selected" : "" %>>Dễ</option>
                    <option value="Trung bình" <%= (quiz != null && "Trung bình".equals(quiz.getLevel())) ? "selected" : "" %>>Trung bình</option>
                    <option value="Khó" <%= (quiz != null && "Khó".equals(quiz.getLevel())) ? "selected" : "" %>>Khó</option>
                </select><br>
            </p>
            <p>
                <label for="numQuestions">Number of Questions:</label><br>
                <input type="number" id="numQuestions" name="numQuestions" value="<%= (quiz != null) ? quiz.getNumQuestions() : 0 %>" <%= canEdit ? "" : "readonly" %> required><br>
            </p>
            <p>
                <label for="durationMinutes">Duration (minutes):</label><br>
                <input type="number" id="durationMinutes" name="durationMinutes" value="<%= (quiz != null) ? quiz.getDurationMinutes() : 0 %>" <%= canEdit ? "" : "readonly" %> required><br>
            </p>
            <p>
                <label for="passRate">Pass Rate (%):</label><br>
                <input type="number" step="0.01" id="passRate" name="passRate" value="<%= (quiz != null) ? quiz.getPassRate() : 0.0 %>" <%= canEdit ? "" : "readonly" %> required><br>
            </p>
            <p>
                <label for="quizType">Quiz Type:</label><br>
                <select id="quizType" name="quizType" <%= canEdit ? "" : "disabled" %>>
                    <option value="Luyện tập" <%= (quiz != null && "Luyện tập".equals(quiz.getQuizType())) ? "selected" : "" %>>Luyện tập</option>
                    <option value="Kiểm tra" <%= (quiz != null && "Kiểm tra".equals(quiz.getQuizType())) ? "selected" : "" %>>Kiểm tra</option>
                    <option value="Thi cuối khóa" <%= (quiz != null && "Thi cuối khóa".equals(quiz.getQuizType())) ? "selected" : "" %>>Thi cuối khóa</option>
                </select><br>
            </p>
            <p>
                <label for="lessonID">Lesson ID (optional):</label><br>
                <input type="number" id="lessonID" name="lessonID" value="<%= (quiz != null && quiz.getLessonID() != null) ? quiz.getLessonID() : "" %>" <%= canEdit ? "" : "readonly" %>><br>
            </p>
            <p>
                <label for="courseID">Course ID (optional):</label><br>
                <input type="number" id="courseID" name="courseID" value="<%= (quiz != null && quiz.getCourseID() != null) ? quiz.getCourseID() : "" %>" <%= canEdit ? "" : "readonly" %>><br>
            </p>
            <p>
                <label for="questionOrder">Question Order (optional):</label><br>
                <input type="number" id="questionOrder" name="questionOrder" value="<%= (quiz != null && quiz.getQuestionOrder() != null) ? quiz.getQuestionOrder() : "" %>" <%= canEdit ? "" : "readonly" %>><br>
            </p>

            <% if (canEdit) { %>
                <button type="submit">Save Quiz</button>
            <% } else { %>
                <p style="color: blue;">Cannot edit this quiz as tests have already been taken.</p>
            <% } %>
            <a href="${pageContext.request.contextPath}/quizzes">Back to List</a>
        </form>

        <%-- Phần quản lý câu hỏi (chỉ hiển thị khi là chỉnh sửa Quiz và có thể chỉnh sửa) --%>
        <% if (quiz != null && quiz.getQuizID() > 0 && canEdit) { %>
            <hr>
            <h2>Questions for this Quiz</h2>
            <p><a href="${pageContext.request.contextPath}/questionDetail?quizId=<%= quiz.getQuizID() %>">Add New Question</a></p>
            
  
            <div id="questionsList">
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Content</th>
                            <th>Type</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<Question> questions = (List<Question>) request.getAttribute("questions");
                        if (questions != null && !questions.isEmpty()) {
                            for (Question q : questions) {
                        %>
                            <tr>
                                <td><%= q.getQuestionID() %></td>
                                <td><%= q.getQuestionContent() %></td>
                                <td><%= q.getQuestionType() %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/questionDetail?questionId=<%= q.getQuestionID() %>&quizId=<%= quiz.getQuizID() %>">Edit</a> |
                                    <form action="${pageContext.request.contextPath}/questions" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this question and its options?');">
                                        <input type="hidden" name="action" value="deleteQuestion">
                                        <input type="hidden" name="questionId" value="<%= q.getQuestionID() %>">
                                        <input type="hidden" name="quizId" value="<%= quiz.getQuizID() %>">
                                        <button type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <%
                            }
                        } else {
                        %>
                            <tr>
                                <td colspan="4">No questions added yet.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
                <p>Loading questions...</p>
              
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Content</th>
                            <th>Type</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                       
                        <%-- Ví dụ:
                        List<Question> questions = (List<Question>) request.getAttribute("questions");
                        if (questions != null && !questions.isEmpty()) {
                            for (Question q : questions) {
                        %>
                            <tr>
                                <td><%= q.getQuestionID() %></td>
                                <td><%= q.getQuestionContent() %></td>
                                <td><%= q.getQuestionType() %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/questionDetail?questionId=<%= q.getQuestionID() %>&quizId=<%= quiz.getQuizID() %>">Edit</a> |
                                    <form action="${pageContext.request.contextPath}/questions" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this question and its options?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="questionId" value="<%= q.getQuestionID() %>">
                                        <input type="hidden" name="quizId" value="<%= quiz.getQuizID() %>">
                                        <button type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <%
                            }
                        } else {
                        %>
                            <tr>
                                <td colspan="4">No questions added yet.</td>
                            </tr>
                        <% } %>
                        --%>
                    </tbody>
                </table>
            </div>
        <% } else if (quiz != null && quiz.getQuizID() > 0 && !canEdit) { %>
            <hr>
            <p style="color: orange;">Questions for this quiz cannot be managed because tests have already been taken.</p>
        <% } %>
    </body>
</html>