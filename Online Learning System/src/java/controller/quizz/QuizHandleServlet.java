/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.quizz; // Ensure this package name matches your folder structure

import dao.QuizDAO;
import model.Question;
import model.Quiz;
import model.QuizAttempt;
import model.QuizAttemptDetail; 
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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

        
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 20 * 1024 * 1024
)
@WebServlet(name = "QuizHandleServlet", urlPatterns = {"/quizHandle"})
public class QuizHandleServlet extends HttpServlet {
    
   private static final Logger LOGGER = Logger.getLogger(QuizHandleServlet.class.getName());
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         HttpSession session = request.getSession();
        
        // --- SỬA ĐỔI CHỦ YẾU Ở ĐÂY: Lấy userID từ session ---
        Integer userID = null;
        Object authObject = session.getAttribute("auth"); // Lấy đối tượng 'auth' từ session (đã lưu trong LoginServlet)
        if (authObject instanceof Account) { // Kiểm tra xem đối tượng có phải là Account không
            userID = ((Account) authObject).getId(); // Lấy ID từ đối tượng Account
        }

        // Nếu userID vẫn là null, tức là người dùng chưa đăng nhập hoặc session đã hết hạn
        if (userID == null) {
            
            LOGGER.log(Level.WARNING, "User not logged in. Redirecting to login page for quizHandle.");
            // Chuyển hướng đến trang đăng nhập, kèm theo các tham số để quay lại trang này sau khi đăng nhập thành công
            String originalQuizId = request.getParameter("quizId");
            response.sendRedirect(request.getContextPath() + "/LoginServlet?redirect=quizHandle&quizId=" + (originalQuizId != null ? originalQuizId : ""));
            return; // Dừng xử lý
        }

        String quizIdStr = request.getParameter("quizId");
        int quizId;
        if (quizIdStr != null && !quizIdStr.trim().isEmpty()) {
            try {
                quizId = Integer.parseInt(quizIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID Quiz không hợp lệ.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("errorMessage", "ID Quiz bị thiếu.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        int currentQuestionIndex = 0;
        if (request.getParameter("qIndex") != null) {
            try {
                currentQuestionIndex = Integer.parseInt(request.getParameter("qIndex"));
            } catch (NumberFormatException e) {
                // If qIndex is invalid, default to 0
                currentQuestionIndex = 0;
            }
        }

        QuizDAO quizDAO = new QuizDAO();

        try {
            // Corrected: Use getQuizById (assuming you've refactored your DAO)
            Quiz quiz = quizDAO.getQuizById2(quizId); // Changed from getQuizById2
            if (quiz == null) {
                request.setAttribute("errorMessage", "Quiz không tồn tại.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }

            Integer attemptId = (Integer) session.getAttribute("currentAttemptId_" + quizId + "_" + userID);
            Long quizStartTimeMillis = (Long) session.getAttribute("quizStartTimeMillis_" + quizId + "_" + userID);
            List<Question> questions = (List<Question>) session.getAttribute("quizQuestions_" + quizId + "_" + userID);

            // --- Logic to load or initialize questions and attempt details ---
            // If questions list is NOT in session, or if attemptId is null (new attempt)
            // or if quizStartTimeMillis is null (session expired for timer)
            if (questions == null || attemptId == null || quizStartTimeMillis == null) {
                // This block covers new attempts or scenarios where session data is incomplete/missing
                System.out.println("DEBUG: (Re)initializing quiz state for QuizID=" + quizId + ", UserID=" + userID);

                // 1. Fetch questions from DB
                List<Question> fetchedQuestions = quizDAO.getQuestionsForQuiz(quizId);
                if (fetchedQuestions == null || fetchedQuestions.isEmpty()) {
                    request.setAttribute("errorMessage", "Không tìm thấy câu hỏi nào cho bài Quiz này.");
                    request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                    return;
                }
                questions = fetchedQuestions;
                session.setAttribute("quizQuestions_" + quizId + "_" + userID, questions);

                // 2. Initialize or retrieve current attempt
                if (attemptId == null) {
                    attemptId = quizDAO.createNewQuizAttempt(userID, quizId);
                    session.setAttribute("currentAttemptId_" + quizId + "_" + userID, attemptId);
                    quizStartTimeMillis = System.currentTimeMillis();
                    session.setAttribute("quizStartTimeMillis_" + quizId + "_" + userID, quizStartTimeMillis);
                }
                // If attemptId was null, new attempt created. If it was not null but quizStartTimeMillis was, we proceed.

                // 3. Load user answers for current questions from DB (for both new/resumed attempts)
                List<QuizAttemptDetail> userAttemptDetails = quizDAO.getQuizAttemptDetailsForAttempt(attemptId);
                for (Question q : questions) {
                    q.setUserSelectedOptionIds(new ArrayList<>()); // Reset before loading
                    q.setUserAnswerText(null); // Reset before loading

                    for (QuizAttemptDetail detail : userAttemptDetails) {
                        if (detail.getQuestionId() == q.getQuestionID()) { // Corrected: use getQuestionId()
                            if (detail.getSelectedOptionId() != null) {
                                q.addUserSelectedOptionId(detail.getSelectedOptionId());
                            }
                            if (detail.getUserAnswerText() != null) {
                                q.setUserAnswerText(detail.getUserAnswerText());
                            }
                            break; // Found answers for this question, move to next question
                        }
                    }
                }

            } else { // 'questions' list, attemptId, and quizStartTimeMillis were all found in session
                // This is a navigation within an active quiz session (Next/Previous/Refresh)
                // Load user answers from DB to ensure they are up-to-date (important for persistence across page loads)
                List<QuizAttemptDetail> userAttemptDetails = quizDAO.getQuizAttemptDetailsForAttempt(attemptId);
                for (Question q : questions) {
                    q.setUserSelectedOptionIds(new ArrayList<>()); // Reset current answers in POJO
                    q.setUserAnswerText(null);

                    for (QuizAttemptDetail detail : userAttemptDetails) {
                        if (detail.getQuestionId() == q.getQuestionID()) { // Corrected: use getQuestionId()
                            if (detail.getSelectedOptionId() != null) {
                                q.addUserSelectedOptionId(detail.getSelectedOptionId());
                            }
                            if (detail.getUserAnswerText() != null) {
                                q.setUserAnswerText(detail.getUserAnswerText());
                            }
                            break;
                        }
                    }
                }
            }
            // 'questions' is now guaranteed not to be null if we reached this point.
            // 'attemptId' and 'quizStartTimeMillis' are also guaranteed to be set.

            // --- Handle saving answers from POST request (when clicking Next/Previous/Score Exam) ---
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String questionIdParam = request.getParameter("questionId");
                if (questionIdParam != null) {
                    int submittedQuestionId = Integer.parseInt(questionIdParam);

                    Question submittedQuestion = null;
                    if (questions != null) {
                        for (Question q : questions) {
                            if (q.getQuestionID() == submittedQuestionId) {
                                submittedQuestion = q;
                                break;
                            }
                        }
                    }

                    if (submittedQuestion != null) {
                        List<Integer> selectedOptionIds = null;
                        String userAnswerText = null;
                        String fileName = null; // ✅ Thêm để lưu tên file (nếu có)

                        // ✅ đọc trạng thái đánh dấu
                        String isMarkedStr = request.getParameter("isMarked");
                        boolean isMarked = "true".equals(isMarkedStr);
                        submittedQuestion.setMarked(isMarked);

                        if ("Multiple Choice".equals(submittedQuestion.getQuestionType()) || "True/False".equals(submittedQuestion.getQuestionType())) {
                            String[] options = request.getParameterValues("option_" + submittedQuestionId);
                            if (options != null) {
                                selectedOptionIds = new ArrayList<>();
                                for (String optId : options) {
                                    selectedOptionIds.add(Integer.parseInt(optId));
                                }
                            } else {
                                selectedOptionIds = new ArrayList<>();
                            }
                        } else if ("Short Answer".equals(submittedQuestion.getQuestionType()) || "Essay".equals(submittedQuestion.getQuestionType())) {
                            userAnswerText = request.getParameter("text_answer_" + submittedQuestionId);
                        }

                        // ✅ Xử lý file upload (nếu có)
                        Part filePart = request.getPart("file_upload_" + submittedQuestionId);
                        if (filePart != null && filePart.getSize() > 0) {
                            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdir();
                            }

                            String filePath = uploadPath + File.separator + fileName;
                            filePart.write(filePath);

                            submittedQuestion.setUploadedFilePath(fileName); // Gán vào model nếu cần hiển thị
                        }

                        // ✅ Lưu vào DB
                        quizDAO.saveUserAnswers(attemptId, submittedQuestionId, selectedOptionIds, userAnswerText, fileName);

                        // ✅ Cập nhật session
                        for (Question q : questions) {
                            if (q.getQuestionID() == submittedQuestionId) {
                                q.setUserSelectedOptionIds(selectedOptionIds != null ? selectedOptionIds : new ArrayList<>());
                                q.setUserAnswerText(userAnswerText);
                                q.setUploadedFilePath(fileName); // Gán file vào session (nếu cần hiển thị ở Review)
                                q.setMarked(isMarked);
                                break;
                            }
                        }
                    }
                }
            }

            // --- Handle "Score Exam" button ---
            String action = request.getParameter("action");
            if ("scoreExam".equals(action)) {
                // Corrected: Use quiz.getQuizId() for the getter
                double score = calculateScore(quizDAO, attemptId, questions, quiz.getQuizID());
                boolean isPassed = score >= quiz.getPassRate();
                quizDAO.updateQuizAttemptResult(attemptId, score, isPassed);

                // Clear quiz state from session after submission
                session.removeAttribute("currentAttemptId_" + quizId + "_" + userID);
                session.removeAttribute("quizStartTimeMillis_" + quizId + "_" + userID);
                session.removeAttribute("quizQuestions_" + quizId + "_" + userID);

                response.sendRedirect("quizLesson?quizId=" + quizId); // Redirect to Quiz Lesson (SubForm 2)
                return;
            }

            request.setAttribute("quizId", quizId);
            request.setAttribute("currentQuestionIndex", currentQuestionIndex);
            request.setAttribute("questions", questions); // Send questions list with user answers
            request.setAttribute("totalQuestions", questions.size());
            request.setAttribute("attemptId", attemptId);

            // Calculate remaining time
            long elapsedMillis = System.currentTimeMillis() - quizStartTimeMillis;
            long remainingTimeMillis = (long) quiz.getDurationMinutes() * 60 * 1000 - elapsedMillis;
            if (remainingTimeMillis < 0) {
                remainingTimeMillis = 0;
            }
            request.setAttribute("remainingTimeMillis", remainingTimeMillis);

            // Forward to JSP
            request.getRequestDispatcher("/views/quizHandle.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Print to server console for debugging
            throw new ServletException("Error handling Quiz: " + e.getMessage(), e);
        }
    }

    // --- calculateScore method (updated for camelCase consistency) ---
    // Trong QuizHandleServlet.java
    private double calculateScore(QuizDAO quizDAO, int attemptId, List<Question> questions, int quizId) throws SQLException, ClassNotFoundException {
        if (questions == null || questions.isEmpty()) {
            return 0.0;
        }

        int correctCount = 0;
        int scoredQuestionsCount = 0; // Đếm số câu hỏi có thể chấm điểm tự động (chỉ trắc nghiệm/True-False)

        Map<Integer, List<Integer>> correctOptionsMap = quizDAO.getCorrectAnswersForQuiz(quizId);

        List<QuizAttemptDetail> userAttemptDetails = quizDAO.getQuizAttemptDetailsForAttempt(attemptId);

        // Chuyển chi tiết bài làm của người dùng thành một Map để dễ dàng tra cứu các lựa chọn
        Map<Integer, List<Integer>> userSelectedOptionsMap = new java.util.HashMap<>();

        for (QuizAttemptDetail detail : userAttemptDetails) {
            // Chỉ quan tâm các lựa chọn đã chọn (SelectedOptionID) cho câu trắc nghiệm
            if (detail.getSelectedOptionId() != null) {
                userSelectedOptionsMap.computeIfAbsent(detail.getQuestionId(), k -> new ArrayList<>()).add(detail.getSelectedOptionId());
            }
        }

        for (Question q : questions) {
            // Chỉ chấm điểm tự động cho câu hỏi Multiple Choice hoặc True/False
            if ("Multiple Choice".equals(q.getQuestionType()) || "True/False".equals(q.getQuestionType())) {

                List<Integer> userSelected = userSelectedOptionsMap.getOrDefault(q.getQuestionID(), Collections.emptyList());
                List<Integer> correct = correctOptionsMap.getOrDefault(q.getQuestionID(), Collections.emptyList());

                Collections.sort(userSelected);
                Collections.sort(correct);

                if (!userSelected.isEmpty() && userSelected.equals(correct)) {
                    correctCount++;
                }

                scoredQuestionsCount++;
            }

        }

        if (scoredQuestionsCount == 0) {
            return 0.0;
        }

        // Trả về điểm phần trăm
        return (double) correctCount / scoredQuestionsCount * 100;
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
