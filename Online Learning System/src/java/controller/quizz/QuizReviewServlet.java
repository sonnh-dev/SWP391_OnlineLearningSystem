/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.quizz;


import dao.QuizDAO;
import model.Question;
import model.Quiz;
import model.QuizAttempt;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet(name = "QuizReviewServlet", urlPatterns = {"/quizReview"})
public class QuizReviewServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        // Giả lập userID
        if (userID == null) {
            userID = 1;
            session.setAttribute("userID", userID);
        }

        int attemptId = Integer.parseInt(request.getParameter("attemptId"));
        QuizDAO quizDAO = new QuizDAO();

        try {
            QuizAttempt attempt = quizDAO.getLastQuizAttempt(userID, attemptId); // Cần sửa DAO để lấy theo attemptId
            if (attempt == null) {
                // Nếu attemptId không hợp lệ hoặc không thuộc về user này
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy kết quả bài làm.");
                return;
            }
            
            Quiz quiz = quizDAO.getQuizById2(attempt.getQuizId());
            if (quiz == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thông tin Quiz.");
                return;
            }

            List<Question> questions = quizDAO.getQuestionsForQuiz(quiz.getQuizID());
            Map<Integer, List<Integer>> userAnswers = quizDAO.getUserAnswersForAttempt(attemptId);
            Map<Integer, List<Integer>> correctAnswers = quizDAO.getCorrectAnswersForQuiz(quiz.getQuizID());

            // Gán câu trả lời của người dùng và đáp án đúng vào từng Question object
            for (Question q : questions) {
                q.setUserSelectedOptionIds(userAnswers.getOrDefault(q.getQuestionID(), new ArrayList<>()));
                // Bạn có thể thêm List<Integer> correctOptionIds vào Question POJO để dễ hiển thị
                // Hoặc đơn giản hóa bằng cách kiểm tra trực tiếp trong JSP
            }

            request.setAttribute("quiz", quiz);
            request.setAttribute("attempt", attempt);
            request.setAttribute("questions", questions);
            request.setAttribute("correctAnswers", correctAnswers); // Gửi đáp án đúng để so sánh trong JSP
            
            request.getRequestDispatcher("quizReview.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error accessing database for Quiz Review", e);
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
