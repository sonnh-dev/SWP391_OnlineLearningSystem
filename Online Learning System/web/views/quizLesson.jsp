<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Quiz" %>
<%@page import="model.QuizAttempt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Lesson</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind CSS + Font -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
   F
</head>
<body class="bg-gray-100 text-gray-800 font-[Inter]">

<main class="max-w-3xl mx-auto bg-white mt-16 mb-10 px-8 py-10 rounded-lg shadow-md">
    <%
        Boolean showResultSubForm = (Boolean) request.getAttribute("showResultSubForm");
        Quiz quiz = (Quiz) request.getAttribute("quiz");
        QuizAttempt lastAttempt = (QuizAttempt) request.getAttribute("lastAttempt");
        int quizId = (Integer) request.getAttribute("quizId");
    %>

    <h1 class="text-2xl sm:text-3xl font-bold text-blue-600 mb-6">Quiz: <%= quiz.getQuizName() %></h1>

    <% if (showResultSubForm != null && showResultSubForm) { %>
        <h2 class="text-xl font-semibold mb-4">📝 Your Last Attempt</h2>
        <ul class="space-y-2 text-base">
            <li><strong>Score:</strong> <%= String.format("%.2f", lastAttempt.getScore()) %></li>
            <li><strong>Status:</strong> 
                <span class="<%= lastAttempt.getIsPassed() ? "text-green-600 font-semibold" : "text-red-600 font-semibold" %>">
                    <%= lastAttempt.getIsPassed() ? "PASSED" : "FAILED" %>
                </span>
            </li>
            <li><strong>Time Taken:</strong> <%= lastAttempt.getStartTime() %> → 
                <%= (lastAttempt.getEndTime() != null ? lastAttempt.getEndTime() : "In Progress") %>
            </li>
        </ul>

        <div class="flex flex-wrap gap-4 mt-6">
            <form action="quizReview" method="GET">
                <input type="hidden" name="attemptId" value="<%= lastAttempt.getAttemptId() %>">
                <button type="submit"
                        class="bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded transition">
                    🔍 Review Attempt
                </button>
            </form>
            <form action="quizHandle" method="GET">
                <input type="hidden" name="quizId" value="<%= quiz.getQuizID() %>">
                <button type="submit"
                        class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded transition">
                    🔁 Retake Quiz
                </button>
            </form>
        </div>
    <% } else { %>
        <h2 class="text-xl font-semibold mb-4">📋 Quiz Details</h2>
        <ul class="space-y-2 text-base">
            <li><strong>Subject:</strong> <%= quiz.getSubject() %></li>
            <li><strong>Level:</strong> <%= quiz.getLevel() %></li>
            <li><strong>Number of Questions:</strong> <%= quiz.getNumQuestions() %></li>
            <li><strong>Duration:</strong> <%= quiz.getDurationMinutes() %> minutes</li>
            <li><strong>Pass Rate:</strong> <%= String.format("%.0f%%", quiz.getPassRate()) %></li>
            <li><strong>Quiz Type:</strong> <%= quiz.getQuizType() %></li>
        </ul>

        <form action="quizHandle" method="GET" class="mt-6">
            <input type="hidden" name="quizId" value="<%= quiz.getQuizID() %>">
            <button type="submit"
                    class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded transition">
                🚀 Start Quiz
            </button>
        </form>
    <% } %>

    <hr class="my-10 border-gray-300">

    <a href="<%= request.getContextPath() %>/home" class="text-blue-500 font-semibold hover:underline">
        ← Back to Home
    </a>
</main>

<%@include file="../includes/foot1.jsp" %>
</body>
</html>
