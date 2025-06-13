package controller.quizz;

import dao.QuizDAO;
import dao.QuestionDAO;
import model.Question;
import model.Quiz;
import model.QuestionOption; // Make sure this is imported if used for saveQuiz
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "QuizController", urlPatterns = {"/quizzes", "/quizDetail"})
public class QuizController extends HttpServlet {

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/quizzes".equals(path)) {
            handleQuizList(request, response);
        } else if ("/quizDetail".equals(path)) {
            try {
                handleQuizDetailView(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(QuizController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        QuizDAO quizDAO = new QuizDAO();

        if ("delete".equals(action)) {
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            if (quizDAO.hasAttempts(quizId)) {
                request.setAttribute("errorMessage", "Không thể xóa Quiz này vì đã có lượt làm bài.");
            } else {
                quizDAO.deleteQuiz(quizId);
                request.setAttribute("successMessage", "Quiz đã được xóa thành công.");
            }
            handleQuizList(request, response);
        } else if ("save".equals(action)) {
            saveQuiz(request, response);
        } else {
            handleQuizList(request, response);
        }
    }

    private void handleQuizList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizDAO quizDAO = new QuizDAO();

        String searchName = request.getParameter("searchName");
        String subject = request.getParameter("subject");
        String quizType = request.getParameter("quizType");
        String pageStr = request.getParameter("page");

        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
        int offset = (currentPage - 1) * PAGE_SIZE;

        List<Quiz> quizzes = quizDAO.getAllQuizzes(searchName, subject, quizType, offset, PAGE_SIZE);
        int totalQuizzes = quizDAO.getTotalQuizCount(searchName, subject, quizType);
        int totalPages = (int) Math.ceil((double) totalQuizzes / PAGE_SIZE);

        request.setAttribute("quizzes", quizzes);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchName", searchName);
        request.setAttribute("subject", subject);
        request.setAttribute("quizType", quizType);

        request.getRequestDispatcher("views/quizList.jsp").forward(request, response);
    }

    private void handleQuizDetailView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        String quizIdStr = request.getParameter("id");
        QuizDAO quizDAO = new QuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();

        Quiz quiz = null;
        boolean canEdit = true; // **IMPORTANT: Initialize to true for new quizzes or when no ID is provided**

        if (quizIdStr != null && !quizIdStr.isEmpty()) {
            try {
                int quizId = Integer.parseInt(quizIdStr);
                quiz = quizDAO.getQuizById(quizId);
                
                if (quiz != null) {
                    canEdit = !quizDAO.hasAttempts(quizId); // Check if attempts exist for an existing quiz
                    if (canEdit) { // Only load questions if the quiz can be edited
                        List<Question> questions = questionDAO.getQuestionsByQuizId(quizId);
                        request.setAttribute("questions", questions);
                    }
                } else {
                    // If an ID was provided but no quiz was found, it might be an invalid ID.
                    // You could redirect or show an error. For now, we'll treat it like adding a new quiz.
                    // Or, better, redirect to the list with an error message:
                    response.sendRedirect(request.getContextPath() + "/quizzes?errorMessage=" + java.net.URLEncoder.encode("Quiz not found.", "UTF-8"));
                    return; // Stop further processing
                }
            } catch (NumberFormatException e) {
                // Handle cases where 'id' parameter is not a valid integer
                response.sendRedirect(request.getContextPath() + "/quizzes?errorMessage=" + java.net.URLEncoder.encode("Invalid Quiz ID format.", "UTF-8"));
                return;
            }
        }
        
        // **ALWAYS set the 'quiz' and 'canEdit' attributes before forwarding**
        request.setAttribute("quiz", quiz);
        request.setAttribute("canEdit", canEdit);
        request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
    }

    private void saveQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizDAO quizDAO = new QuizDAO();
        Quiz quiz = new Quiz();
        
        String quizIdStr = request.getParameter("quizID");
        if (quizIdStr != null && !quizIdStr.isEmpty()) {
            quiz.setQuizID(Integer.parseInt(quizIdStr));
        }

        // Basic parameter parsing and setting (add validation as needed)
        quiz.setQuizName(request.getParameter("quizName"));
        quiz.setSubject(request.getParameter("subject"));
        quiz.setLevel(request.getParameter("level"));
        quiz.setNumQuestions(Integer.parseInt(request.getParameter("numQuestions")));
        quiz.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
        quiz.setPassRate(Double.parseDouble(request.getParameter("passRate")));
        quiz.setQuizType(request.getParameter("quizType"));
        
        // Handle nullable Integer fields correctly
        String lessonIdStr = request.getParameter("lessonID");
        quiz.setLessonID(lessonIdStr != null && !lessonIdStr.isEmpty() ? Integer.parseInt(lessonIdStr) : null);
        
        String courseIdStr = request.getParameter("courseID");
        quiz.setCourseID(courseIdStr != null && !courseIdStr.isEmpty() ? Integer.parseInt(courseIdStr) : null);
        
        String questionOrderStr = request.getParameter("questionOrder");
        quiz.setQuestionOrder(questionOrderStr != null && !questionOrderStr.isEmpty() ? Integer.parseInt(questionOrderStr) : null);

        boolean success = false;
        if (quiz.getQuizID() == 0) { // Add new quiz
            int newId = quizDAO.addQuiz(quiz);
            success = (newId != -1);
            if (success) {
                // Redirect to the edit page of the newly created quiz
                response.sendRedirect(request.getContextPath() + "/quizDetail?id=" + newId + "&successMessage=" + java.net.URLEncoder.encode("Quiz đã được thêm mới thành công.", "UTF-8"));
                return; // Important: Stop further processing after redirect
            } else {
                request.setAttribute("errorMessage", "Thêm Quiz mới thất bại.");
                request.setAttribute("quiz", quiz); // Keep entered data
                request.setAttribute("canEdit", true); // Still editable for a new quiz
                request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
            }
        } else { // Update existing quiz
            // Re-check edit condition before attempting to update
            if (quizDAO.hasAttempts(quiz.getQuizID())) {
                request.setAttribute("errorMessage", "Không thể cập nhật Quiz này vì đã có lượt làm bài.");
                // Load original quiz data to prevent displaying partial updates
                request.setAttribute("quiz", quizDAO.getQuizById(quiz.getQuizID())); 
                request.setAttribute("canEdit", false); // Not editable
                request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
            } else {
                success = quizDAO.updateQuiz(quiz);
                if (success) {
                    request.setAttribute("successMessage", "Quiz đã được cập nhật thành công.");
                } else {
                    request.setAttribute("errorMessage", "Cập nhật Quiz thất bại.");
                }
                // Load the updated quiz data (or original if update failed)
                request.setAttribute("quiz", quizDAO.getQuizById(quiz.getQuizID())); 
                request.setAttribute("canEdit", !quizDAO.hasAttempts(quiz.getQuizID()));
                request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
            }
        }
    }
}