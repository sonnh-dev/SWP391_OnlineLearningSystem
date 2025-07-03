// src/com/yourcompany/controller/QuizReviewServlet.java
package controller.quizz; // Ensure this matches your actual package structure

import dao.QuizDAO;
import model.Question;
import model.Quiz;
import model.QuizAttempt;
import model.QuizAttemptDetail; // Import QuizAttemptDetail for detailed user answers
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections; // Needed for Collections.emptyList()
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "QuizReviewServlet", urlPatterns = {"/quizReview"})
public class QuizReviewServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        // Simulate userID for testing. In production, always redirect if null.
        if (userID == null) {
            userID = 1; // Simulate userID 1
            session.setAttribute("userID", userID);
            System.out.println("DEBUG: UserID is null, set to 1 for testing.");
        }

        // --- Start processing attemptId parameter ---
        String attemptIdStr = request.getParameter("attemptId");
        int attemptId;

        if (attemptIdStr != null && !attemptIdStr.trim().isEmpty()) {
            try {
                attemptId = Integer.parseInt(attemptIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID bài làm không hợp lệ. Vui lòng cung cấp một số nguyên.");
                // Ensure this path is correct for your error.jsp
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                System.err.println("ERROR: NumberFormatException for attemptId: " + attemptIdStr);
                return;
            }
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ID bài làm. Vui lòng cung cấp ID bài làm.");
            // Ensure this path is correct for your error.jsp
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            System.err.println("ERROR: Missing attemptId parameter.");
            return;
        }
        // --- End processing attemptId parameter ---

        QuizDAO quizDAO = new QuizDAO();

        try {
            // Corrected: Call the right DAO method to get QuizAttempt by attemptId
            QuizAttempt attempt = quizDAO.getQuizAttemptById(attemptId);
            
            if (attempt == null) {
                request.setAttribute("errorMessage", "Không tìm thấy kết quả bài làm với ID: " + attemptId + " hoặc không thuộc về người dùng này.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                System.err.println("ERROR: QuizAttempt not found for attemptId=" + attemptId + " and userID=" + userID);
                return;
            }
            
            // Corrected: Use getQuizById (assuming you've refactored your DAO to remove getQuizById2)
            // Use quiz.getQuizId() for the getter
            Quiz quiz = quizDAO.getQuizById2(attempt.getQuizId()); 
            if (quiz == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin Quiz liên quan đến bài làm.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                System.err.println("ERROR: Quiz not found for quizId=" + attempt.getQuizId() + " from attemptId=" + attemptId);
                return;
            }

            // Corrected: Use quiz.getQuizId() for the getter
            List<Question> questions = quizDAO.getQuestionsForQuiz(quiz.getQuizID());
            if (questions == null || questions.isEmpty()) {
                request.setAttribute("errorMessage", "Không tìm thấy câu hỏi cho Quiz này.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                System.err.println("ERROR: No questions found for quizId=" + quiz.getQuizID());
                return;
            }

            // Load detailed user answers from DB
            List<QuizAttemptDetail> userAttemptDetails = quizDAO.getQuizAttemptDetailsForAttempt(attemptId);
            // Get correct answers for the quiz
            // Corrected: Use quiz.getQuizId() for the getter
            Map<Integer, List<Integer>> correctAnswers = quizDAO.getCorrectAnswersForQuiz(quiz.getQuizID());

            // Assign user answers (both selected options and text) to each Question object
            for (Question q : questions) {
                // Initialize/reset answers for the current question object
                q.setUserSelectedOptionIds(new ArrayList<>()); 
                q.setUserAnswerText(null); // Reset text answer

                // Find and assign the correct attempt details for this question
                for (QuizAttemptDetail detail : userAttemptDetails) {
                    // Corrected: Use q.getQuestionId() for the getter
                    if (detail.getQuestionId() == q.getQuestionID()) {
                        if (detail.getSelectedOptionId() != null) {
                            q.addUserSelectedOptionId(detail.getSelectedOptionId());
                        }
                        if (detail.getUserAnswerText() != null) {
                            q.setUserAnswerText(detail.getUserAnswerText());
                        }
                        // You can also load isMarked here if you implement it for review
                        break; // Found details for this question, move to the next question object
                    }
                }
            }

            request.setAttribute("quiz", quiz);
            request.setAttribute("attempt", attempt);
            request.setAttribute("questions", questions);
            request.setAttribute("correctAnswers", correctAnswers); // Pass correct answers for comparison in JSP
            
            // Ensure this path is correct for your quizReview.jsp
            request.getRequestDispatcher("/views/quizReview.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Print stack trace to server console for debugging
            throw new ServletException("Lỗi truy cập cơ sở dữ liệu khi xem lại Quiz: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}