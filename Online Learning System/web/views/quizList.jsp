<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Quiz"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quizzes List</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <h1>Quizzes List</h1>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

       
        <form action="${pageContext.request.contextPath}/quizzes" method="GET">
            <input type="text" name="searchName" placeholder="Search by name" value="${searchName != null ? searchName : ''}">
            <select name="subject">
                <option value="">All Subjects</option>
                <option value="Leadership" <%= "Leadership".equals(request.getAttribute("subject")) ? "selected" : "" %>>Leadership</option>
                <option value="Time Management" <%= "Time Management".equals(request.getAttribute("subject")) ? "selected" : "" %>>Time Management</option>
                <option value="Problem Solving" <%= "Problem Solving".equals(request.getAttribute("subject")) ? "selected" : "" %>>Problem Solving</option>
                <option value="Emotional Intelligence" <%= "Emotional Intelligence".equals(request.getAttribute("subject")) ? "selected" : "" %>>Emotional Intelligence</option>
                <option value="Communication" <%= "Communication".equals(request.getAttribute("subject")) ? "selected" : "" %>>Communication</option>
                <%-- Thêm các Subject khác từ DB hoặc tĩnh --%>
            </select>
            <select name="quizType">
                <option value="">All Types</option>
                <option value="Luyện tập" <%= "Luyện tập".equals(request.getAttribute("quizType")) ? "selected" : "" %>>Luyện tập</option>
                <option value="Kiểm tra" <%= "Kiểm tra".equals(request.getAttribute("quizType")) ? "selected" : "" %>>Kiểm tra</option>
                 <%-- Thêm các QuizType khác từ DB hoặc tĩnh --%>
            </select>
            <button type="submit">Filter/Search</button>
        </form>
        <br>
        
        <%-- Nút thêm mới --%>
        <p><a href="${pageContext.request.contextPath}/quizDetail">Add New Quiz</a></p>

        <%-- Bảng hiển thị danh sách Quiz --%>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Subject</th>
                    <th>Level</th>
                    <th># Questions</th>
                    <th>Duration (min)</th>
                    <th>Pass Rate (%)</th>
                    <th>Quiz Type</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
                    if (quizzes != null && !quizzes.isEmpty()) {
                        for (Quiz quiz : quizzes) {
                %>
                <tr>
                    <td><%= quiz.getQuizID() %></td>
                    <td><%= quiz.getQuizName() %></td>
                    <td><%= quiz.getSubject() %></td>
                    <td><%= quiz.getLevel() %></td>
                    <td><%= quiz.getNumQuestions() %></td>
                    <td><%= quiz.getDurationMinutes() %></td>
                    <td><%= String.format("%.2f", quiz.getPassRate()) %></td>
                    <td><%= quiz.getQuizType() %></td>
                    <td>
                        <%-- Link đến trang chỉnh sửa (chưa triển khai chi tiết) --%>
                        <a href="${pageContext.request.contextPath}/quizDetail?id=<%= quiz.getQuizID() %>">Edit</a> | 
                        
                        <%-- Form xóa Quiz --%>
                        <form action="${pageContext.request.contextPath}/quizzes" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this quiz?');">
                            <input type="hidden" name="action" value="delete">
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
                    <td colspan="9">No quizzes found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <%-- Phân trang --%>
        <div class="pagination">
            <% 
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");
                String searchName = (String) request.getAttribute("searchName");
                String subject = (String) request.getAttribute("subject");
                String quizType = (String) request.getAttribute("quizType");

                String queryParams = "";
                if (searchName != null && !searchName.isEmpty()) queryParams += "&searchName=" + searchName;
                if (subject != null && !subject.isEmpty()) queryParams += "&subject=" + subject;
                if (quizType != null && !quizType.isEmpty()) queryParams += "&quizType=" + quizType;

                for (int i = 1; i <= totalPages; i++) {
            %>
            <a href="${pageContext.request.contextPath}/quizzes?page=<%= i %><%= queryParams %>"
               class="<%= (i == currentPage) ? "active" : "" %>">
                <%= i %>
            </a>
            <% } %>
        </div>
    </body>
</html>