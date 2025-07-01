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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "QuizHandleServlet", urlPatterns = {"/quizHandle"})
public class QuizHandleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        // Giả lập userID nếu chưa có session
        if (userID == null) {
            userID = 1;
            session.setAttribute("userID", userID);
        }

        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int currentQuestionIndex = 0; // Mặc định là câu hỏi đầu tiên
        if (request.getParameter("qIndex") != null) {
            currentQuestionIndex = Integer.parseInt(request.getParameter("qIndex"));
        }

        QuizDAO quizDAO = new QuizDAO();
        
        try {
            Quiz quiz = quizDAO.getQuizById2(quizId);
            if (quiz == null) {
                request.setAttribute("errorMessage", "Quiz không tồn tại.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // Lấy hoặc tạo QuizAttempt mới
            Integer attemptId = (Integer) session.getAttribute("currentAttemptId_" + quizId + "_" + userID);
            Long quizStartTimeMillis = (Long) session.getAttribute("quizStartTimeMillis_" + quizId + "_" + userID);
            
            // Lấy danh sách câu hỏi và đáp án đã chọn từ session hoặc DB
            List<Question> questions = (List<Question>) session.getAttribute("quizQuestions_" + quizId + "_" + userID);

            if (attemptId == null) { // Bắt đầu làm bài mới
                attemptId = quizDAO.createNewQuizAttempt(userID, quizId);
                session.setAttribute("currentAttemptId_" + quizId + "_" + userID, attemptId);
                
                // Lấy tất cả câu hỏi cho quiz này và lưu vào session
                questions = quizDAO.getQuestionsForQuiz(quizId);
                session.setAttribute("quizQuestions_" + quizId + "_" + userID, questions);

                // Lưu thời gian bắt đầu vào session
                quizStartTimeMillis = System.currentTimeMillis();
                session.setAttribute("quizStartTimeMillis_" + quizId + "_" + userID, quizStartTimeMillis);

            } else { // Tiếp tục làm bài (có thể do refresh hoặc quay lại từ Review Progress)
                // Tải lại câu trả lời đã lưu từ DB và cập nhật vào list questions trong session
                Map<Integer, List<Integer>> userAnswers = quizDAO.getUserAnswersForAttempt(attemptId);
                if (questions != null) {
                    for (Question q : questions) {
                        q.setUserSelectedOptionIds(userAnswers.getOrDefault(q.getQuestionID(), Collections.emptyList()));
                    }
                }
            }
            
            // Xử lý lưu câu trả lời từ POST request (khi nhấn Next/Previous/Score Exam)
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String questionIdStr = request.getParameter("questionId");
                if (questionIdStr != null) {
                    int submittedQuestionId = Integer.parseInt(questionIdStr);
                    String[] selectedOptions = request.getParameterValues("option_" + submittedQuestionId);
                    
                    List<Integer> selectedOptionIds = new ArrayList<>();
                    if (selectedOptions != null) {
                        for (String optId : selectedOptions) {
                            selectedOptionIds.add(Integer.parseInt(optId));
                        }
                    }
                    // Lưu câu trả lời vào DB
                    quizDAO.saveUserAnswers(attemptId, submittedQuestionId, selectedOptionIds);
                    
                    // Cập nhật câu trả lời vào đối tượng Question trong session
                    if (questions != null) {
                        for (Question q : questions) {
                            if (q.getQuestionID() == submittedQuestionId) {
                                q.setUserSelectedOptionIds(selectedOptionIds);
                                break;
                            }
                        }
                    }
                }
            }
            
            // Xử lý nút "Score Exam"
            String action = request.getParameter("action");
            if ("scoreExam".equals(action)) {
                // Chấm điểm
                int totalAnswered = 0;
                if (questions != null) {
                    for (Question q : questions) {
                        if (!q.getUserSelectedOptionIds().isEmpty()) {
                            totalAnswered++;
                        }
                    }
                }
                
                // Logic xác nhận nộp bài phức tạp (bây giờ đơn giản hóa)
                // Nếu chưa trả lời câu nào: yêu cầu tiếp tục hoặc về trang Lesson (SubForm 1)
                // Nếu có câu chưa trả lời: yêu cầu tiếp tục hoặc nộp (về SubForm 2)
                // Nếu tất cả đã trả lời: yêu cầu tiếp tục hoặc nộp (về SubForm 2)
                
                // Ở đây, chúng ta sẽ chấm điểm và lưu kết quả ngay
                double score = calculateScore(quizDAO, attemptId, questions);
                boolean isPassed = score >= quiz.getPassRate();
                quizDAO.updateQuizAttemptResult(attemptId, score, isPassed);

                // Xóa trạng thái quiz khỏi session sau khi nộp
                session.removeAttribute("currentAttemptId_" + quizId + "_" + userID);
                session.removeAttribute("quizStartTimeMillis_" + quizId + "_" + userID);
                session.removeAttribute("quizQuestions_" + quizId + "_" + userID);
                
                response.sendRedirect("quizLesson?quizId=" + quizId); // Quay về SubForm 2
                return;
            }

            request.setAttribute("quizId", quizId);
            request.setAttribute("currentQuestionIndex", currentQuestionIndex);
            request.setAttribute("questions", questions); // Gửi list questions đã có câu trả lời của user
            request.setAttribute("totalQuestions", questions.size());
            request.setAttribute("attemptId", attemptId); // Dùng cho JavaScript và form submit
            
            // Tính thời gian còn lại
            long elapsedMillis = System.currentTimeMillis() - quizStartTimeMillis;
            long remainingTimeMillis = (long)quiz.getDurationMinutes() * 60 * 1000 - elapsedMillis;
            if (remainingTimeMillis < 0) remainingTimeMillis = 0;
            request.setAttribute("remainingTimeMillis", remainingTimeMillis);

            request.getRequestDispatcher("/views/quizHandle.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error handling Quiz", e);
        }
    }

    private double calculateScore(QuizDAO quizDAO, int attemptId, List<Question> questions) throws SQLException, ClassNotFoundException {
        if (questions == null || questions.isEmpty()) {
            return 0.0;
        }
        
        int correctCount = 0;
        // Lấy tất cả đáp án đúng của quiz
       Map<Integer, List<Integer>> correctOptionsMap = quizDAO.getCorrectAnswersForQuiz(questions.get(0).getQuestionID()); // Lấy quizId từ câu hỏi đầu tiên
        // Lấy tất cả câu trả lời của người dùng
        Map<Integer, List<Integer>> userAnswersMap = quizDAO.getUserAnswersForAttempt(attemptId);

        for (Question q : questions) {
            List<Integer> userSelected = userAnswersMap.getOrDefault(q.getQuestionID(), Collections.emptyList());
            List<Integer> correct = correctOptionsMap.getOrDefault(q.getQuestionID(), Collections.emptyList());

            // So sánh danh sách các lựa chọn đã chọn của người dùng với danh sách đáp án đúng
            // Cần sắp xếp để so sánh chính xác nếu có nhiều đáp án đúng
            Collections.sort(userSelected);
            Collections.sort(correct);

            if (userSelected.equals(correct)) {
                correctCount++;
            }
        }
        
        return (double) correctCount / questions.size() * 100;
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
