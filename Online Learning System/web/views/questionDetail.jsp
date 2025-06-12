<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Question"%>
<%@page import="model.QuestionOption"%>
<%@page import="model.Quiz"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <script>
            function addOptionField() {
                var container = document.getElementById('optionsContainer');
                var currentOptions = container.querySelectorAll('.option-row').length;
                var newIndex = currentOptions + 1;

                var newOptionHtml = `
                    <div class="option-row">
                        <label for="optionContent${newIndex}">Option ${newIndex}:</label>
                        <input type="text" id="optionContent${newIndex}" name="optionContent${newIndex}" required>
                        <input type="checkbox" id="isCorrect${newIndex}" name="isCorrect${newIndex}" value="true">
                        <label for="isCorrect${newIndex}">Correct</label>
                        <button type="button" onclick="removeOptionField(this)">Remove</button>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', newOptionHtml);
            }

            function removeOptionField(button) {
                button.closest('.option-row').remove();
                // Cập nhật lại tên và ID để đảm bảo đúng thứ tự (quan trọng khi gửi form)
                var container = document.getElementById('optionsContainer');
                var optionRows = container.querySelectorAll('.option-row');
                optionRows.forEach((row, index) => {
                    var newIndex = index + 1;
                    row.querySelector('label[for^="optionContent"]').setAttribute('for', `optionContent${newIndex}`);
                    row.querySelector('label[for^="optionContent"]').innerText = `Option ${newIndex}:`;
                    row.querySelector('input[name^="optionContent"]').setAttribute('name', `optionContent${newIndex}`);
                    row.querySelector('input[name^="optionContent"]').setAttribute('id', `optionContent${newIndex}`);
                    row.querySelector('input[name^="isCorrect"]').setAttribute('name', `isCorrect${newIndex}`);
                    row.querySelector('input[name^="isCorrect"]').setAttribute('id', `isCorrect${newIndex}`);
                    row.querySelector('label[for^="isCorrect"]').setAttribute('for', `isCorrect${newIndex}`);
                });
            }
        </script>
    </head>
    <body>
        <% 
            Question question = (Question) request.getAttribute("question");
            Quiz parentQuiz = (Quiz) request.getAttribute("parentQuiz");
            String pageTitle = (question == null || question.getQuestionID() == 0) ? "Add New Question" : "Edit Question";
        %>
        <h1><%= pageTitle %> for Quiz: "<%= parentQuiz != null ? parentQuiz.getQuizName() : "N/A" %>"</h1>

        <%-- Hiển thị thông báo lỗi/thành công --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/questions" method="POST">
            <input type="hidden" name="action" value="saveQuestion">
            <input type="hidden" name="quizID" value="<%= parentQuiz != null ? parentQuiz.getQuizID() : "" %>">
            <input type="hidden" name="questionID" value="<%= (question != null) ? question.getQuestionID() : 0 %>">

            <p>
                <label for="questionContent">Question Content:</label><br>
                <textarea id="questionContent" name="questionContent" rows="5" cols="50" required><%= (question != null && question.getQuestionContent() != null) ? question.getQuestionContent() : "" %></textarea><br>
            </p>
            <p>
                <label for="questionType">Question Type:</label><br>
                <select id="questionType" name="questionType">
                    <option value="Multiple Choice" <%= (question != null && "Multiple Choice".equals(question.getQuestionType())) ? "selected" : "" %>>Multiple Choice</option>
                    <option value="True/False" <%= (question != null && "True/False".equals(question.getQuestionType())) ? "selected" : "" %>>True/False</option>
                    <option value="Short Answer" <%= (question != null && "Short Answer".equals(question.getQuestionType())) ? "selected" : "" %>>Short Answer</option>
                </select><br>
            </p>

            <h3>Options:</h3>
            <div id="optionsContainer">
                <% 
                    List<QuestionOption> options = (question != null) ? question.getOptions() : null;
                    if (options != null && !options.isEmpty()) {
                        int index = 1;
                        for (QuestionOption opt : options) {
                %>
                <div class="option-row">
                    <label for="optionContent<%= index %>">Option <%= index %>:</label>
                    <input type="text" id="optionContent<%= index %>" name="optionContent<%= index %>" value="<%= opt.getOptionContent() %>" required>
                    <input type="checkbox" id="isCorrect<%= index %>" name="isCorrect<%= index %>" value="true" <%= opt.isIsCorrect() ? "checked" : "" %>>
                    <label for="isCorrect<%= index %>">Correct</label>
                    <button type="button" onclick="removeOptionField(this)">Remove</button>
                </div>
                <% 
                            index++;
                        }
                    } else {
                %>
                <div class="option-row">
                    <label for="optionContent1">Option 1:</label>
                    <input type="text" id="optionContent1" name="optionContent1" required>
                    <input type="checkbox" id="isCorrect1" name="isCorrect1" value="true">
                    <label for="isCorrect1">Correct</label>
                    <button type="button" onclick="removeOptionField(this)">Remove</button>
                </div>
                <% } %>
            </div>
            <button type="button" onclick="addOptionField()">Add Option</button>
            <br><br>

            <button type="submit">Save Question</button>
            <a href="${pageContext.request.contextPath}/quizDetail?id=<%= parentQuiz != null ? parentQuiz.getQuizID() : "" %>">Back to Quiz Details</a>
        </form>
    </body>
</html>