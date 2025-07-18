<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Chapter" %>
<%
    List<Chapter> topics = (List<Chapter>) request.getAttribute("topics");
    int subjectId = (int) request.getAttribute("subjectId");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lesson Details</title>
    <style>
        label { display: block; margin-top: 10px; }
        input[type="text"], select, textarea { width: 100%; padding: 6px; }
    </style>
    <script>
        function onTypeChange() {
            const type = document.getElementById("type").value;
            document.getElementById("videoSection").style.display = (type === "Lesson") ? "block" : "none";
            document.getElementById("htmlSection").style.display = (type === "Lesson") ? "block" : "none";
            document.getElementById("quizSection").style.display = (type === "Quiz") ? "block" : "none";
        }
    </script>
</head>
<body>

<h2>Lesson Details</h2>

<form action="SubmitLessonServlet" method="post">
    <input type="hidden" name="subjectId" value="<%= subjectId %>" />

    <label>Name</label>
    <input type="text" name="name" required/>

    <label>Type</label>
    <select name="type" id="type" onchange="onTypeChange()">
        <option value="Subject Topic">Subject Topic</option>
        <option value="Lesson" selected>Lesson</option>
        <option value="Quiz">Quiz</option>
    </select>

    <label>Topic</label>
    <select name="chapterId">
        <% for (Chapter topic : topics) { %>
            <option value="<%= topic.getChapterID() %>"><%= topic.getTitle() %></option>
        <% } %>
    </select>

    <label>Order</label>
    <input type="text" name="order" />

    <div id="videoSection">
        <label>Video link</label>
        <input type="text" name="videoUrl" placeholder="YouTube link" />
    </div>

    <div id="htmlSection">
        <label>HTML Content</label>
        <textarea name="docContent" rows="10" placeholder="CKEditor content"></textarea>
    </div>

    <div id="quizSection" style="display:none;">
        <label>Quiz</label>
        <select name="quizId">
            <!-- Option values sẽ được lấy từ database nếu cần -->
            <option value="1">Sample Quiz 1</option>
            <option value="2">Sample Quiz 2</option>
        </select>
    </div>

    <br/>
    <button type="submit">Submit</button>
    <button type="button" onclick="window.history.back()">Back</button>
</form>

<script>onTypeChange();</script>

</body>
</html>
