package controller.quizz;

import dao.QuizDAO;
import dao.QuestionDAO;
import model.Question;
import model.Quiz;
import model.QuestionOption; // Make sure this is imported if used for saveQuiz
import java.io.IOException;
import java.net.URLEncoder; // Added for URL encoding
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "QuizController", urlPatterns = {"/quizzes", "/quizDetail"})
public class QuizController extends HttpServlet {

    // Removed PAGE_SIZE as it will now be dynamic
    // private static final int PAGE_SIZE = 5;

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
            
            if (request.getAttribute("errorMessage") != null) {
                request.getSession().setAttribute("errorMessage", request.getAttribute("errorMessage"));
            } else if (request.getAttribute("successMessage") != null) {
                request.getSession().setAttribute("successMessage", request.getAttribute("successMessage"));
            }
            response.sendRedirect(request.getContextPath() + "/quizzes");
        } else if ("save".equals(action)) {
            saveQuiz(request, response);
        } else {
            
            response.sendRedirect(request.getContextPath() + "/quizzes");
        }
    }

    private void handleQuizList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        QuizDAO quizDAO = new QuizDAO();

        String searchName = request.getParameter("searchName");
        String subject = request.getParameter("subject");
        String quizType = request.getParameter("quizType");
        String pageStr = request.getParameter("page");

        String action = request.getParameter("action");
        if ("updateView".equals(action)) {
            boolean isCardView = Boolean.parseBoolean(request.getParameter("isCardView"));
            session.setAttribute("isCardView", isCardView);
            response.setStatus(HttpServletResponse.SC_OK); // Send OK response for AJAX
            return; // Stop processing, no need to render JSP
        }
        // --- END NEW ---

        // Get view preference from session or set default
        boolean isTableView = (Boolean) session.getAttribute("isTableView") != null ? (Boolean) session.getAttribute("isTableView") : false; // Default to table view
        boolean isCardView = !isTableView;
        // Determine itemsPerPage and colsPerRow dynamically based on view type and quizType
        int itemsPerPage;
        int colsPerRow; // Used for card view

  
        if (isCardView) {
            // Configuration for Card View
            if ("Luyện tập".equals(quizType)) {
                colsPerRow = 4; // 4 columns for "Luyện tập"
                itemsPerPage = 8; // 2 rows * 4 columns
            } else if ("Kiểm tra".equals(quizType)) {
                colsPerRow = 3; // 3 columns for "Kiểm tra"
                itemsPerPage = 9; // 3 rows * 3 columns
            } else {
                // Default for card view if no specific quizType or other types
                colsPerRow = 5;
                itemsPerPage = 8; // 2 rows * 5 columns
            }
        } else {
           
            itemsPerPage = 8; 
            colsPerRow = 0; 
        }

        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
        int offset = (currentPage - 1) * itemsPerPage; // Use dynamic itemsPerPage

        // Retrieve messages from session if redirected from POST
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }


        List<Quiz> quizzes = quizDAO.getAllQuizzes(searchName, subject, quizType, offset, itemsPerPage); // Use dynamic itemsPerPage
        int totalQuizzesCount = quizDAO.getTotalQuizCount(searchName, subject, quizType); // Renamed for clarity and consistency with JSP

        int totalPages = (int) Math.ceil((double) totalQuizzesCount / itemsPerPage);
        if (totalPages == 0) totalPages = 1; 

        // Adjust currentPage if it's out of bounds
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }
        if (currentPage < 1) {
            currentPage = 1;
        }

        // Build queryParams for pagination links
        StringBuilder queryParamsBuilder = new StringBuilder();
        if (searchName != null && !searchName.isEmpty()) {
            queryParamsBuilder.append("&searchName=").append(URLEncoder.encode(searchName, "UTF-8"));
        }
        if (subject != null && !subject.isEmpty()) {
            queryParamsBuilder.append("&subject=").append(URLEncoder.encode(subject, "UTF-8"));
        }
        if (quizType != null && !quizType.isEmpty()) {
            queryParamsBuilder.append("&quizType=").append(URLEncoder.encode(quizType, "UTF-8"));
        }
        String queryParams = queryParamsBuilder.toString();


        request.setAttribute("quizzes", quizzes);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalQuizzesCount", totalQuizzesCount);
        request.setAttribute("searchName", searchName);
        request.setAttribute("subject", subject);
        request.setAttribute("quizType", quizType);
        request.setAttribute("queryParams", queryParams);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("colsPerRow", colsPerRow); 
        request.setAttribute("isCardView", isCardView); 


        request.getRequestDispatcher("views/quizList.jsp").forward(request, response);
    }

    private void handleQuizDetailView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        String quizIdStr = request.getParameter("id");
        QuizDAO quizDAO = new QuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();

        Quiz quiz = null;
        boolean canEdit = true; 

        if (quizIdStr != null && !quizIdStr.isEmpty()) {
            try {
                int quizId = Integer.parseInt(quizIdStr);
                quiz = quizDAO.getQuizById(quizId);

                if (quiz != null) {
                    canEdit = !quizDAO.hasAttempts(quizId); 
                    if (canEdit) { 
                        List<Question> questions = questionDAO.getQuestionsByQuizId(quizId);
                        request.setAttribute("questions", questions);
                    }
                } else {
                    
                    response.sendRedirect(request.getContextPath() + "/quizzes?errorMessage=" + URLEncoder.encode("Quiz not found.", "UTF-8"));
                    return;
                }
            } catch (NumberFormatException e) {
               
                response.sendRedirect(request.getContextPath() + "/quizzes?errorMessage=" + URLEncoder.encode("Invalid Quiz ID format.", "UTF-8"));
                return;
            }
        }

        
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

        
        quiz.setQuizName(request.getParameter("quizName"));
        quiz.setSubject(request.getParameter("subject"));
        quiz.setLevel(request.getParameter("level"));
        quiz.setNumQuestions(Integer.parseInt(request.getParameter("numQuestions")));
        quiz.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
        quiz.setPassRate(Double.parseDouble(request.getParameter("passRate")));
        quiz.setQuizType(request.getParameter("quizType"));

        
        String lessonIdStr = request.getParameter("lessonID");
        quiz.setLessonID(lessonIdStr != null && !lessonIdStr.isEmpty() ? Integer.parseInt(lessonIdStr) : null);

        String courseIdStr = request.getParameter("courseID");
        quiz.setCourseID(courseIdStr != null && !courseIdStr.isEmpty() ? Integer.parseInt(courseIdStr) : null);

        String questionOrderStr = request.getParameter("questionOrder");
        quiz.setQuestionOrder(questionOrderStr != null && !questionOrderStr.isEmpty() ? Integer.parseInt(questionOrderStr) : null);

        boolean success = false;
        if (quiz.getQuizID() == 0) { 
            int newId = quizDAO.addQuiz(quiz);
            success = (newId != -1);
            if (success) {
                
                response.sendRedirect(request.getContextPath() + "/quizDetail?id=" + newId + "&successMessage=" + URLEncoder.encode("Quiz đã được thêm mới thành công.", "UTF-8"));
                return; 
            } else {
                request.setAttribute("errorMessage", "Thêm Quiz mới thất bại.");
                request.setAttribute("quiz", quiz); 
                request.setAttribute("canEdit", true); 
                request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
            }
        } else { 
          
            if (quizDAO.hasAttempts(quiz.getQuizID())) {
                request.setAttribute("errorMessage", "Không thể cập nhật Quiz này vì đã có lượt làm bài.");
                
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