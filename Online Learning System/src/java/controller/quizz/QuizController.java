package controller.quizz;

import dao.QuizDAO;
import dao.QuestionDAO;
import model.Question;
import model.Quiz;
import model.QuestionOption;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "QuizController", urlPatterns = {"/quizzes", "/quizDetail"})
public class QuizController extends HttpServlet {

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

        // Loại bỏ các tham số liên quan đến phân trang
        // String pageStr = request.getParameter("page"); // Không cần nữa

        String action = request.getParameter("action");
        if ("updateView".equals(action)) {
            boolean isCardView = Boolean.parseBoolean(request.getParameter("isCardView"));
            session.setAttribute("isCardView", isCardView);
            response.setStatus(HttpServletResponse.SC_OK); // Send OK response for AJAX
            return; // Stop processing, no need to render JSP
        }

       
        boolean isTableView = (Boolean) session.getAttribute("isTableView") != null ? (Boolean) session.getAttribute("isTableView") : false;

       
        List<Quiz> quizzes = quizDAO.getAllQuizzes(searchName, subject, quizType, 0, 0); // truyền offset = 0, itemsPerPage = 0 để DAO lấy tất cả
        int totalQuizzesCount = quizzes.size(); // Tổng số quiz là kích thước của danh sách đã lấy

     
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


        request.setAttribute("quizzes", quizzes);
        // Loại bỏ các thuộc tính liên quan đến phân trang
        // request.setAttribute("currentPage", currentPage);
        // request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalQuizzesCount", totalQuizzesCount); // Vẫn giữ để hiển thị tổng số lượng quiz
        request.setAttribute("searchName", searchName);
        request.setAttribute("subject", subject);
        request.setAttribute("quizType", quizType);
        // request.setAttribute("queryParams", queryParams); // Không cần nữa
        // request.setAttribute("itemsPerPage", itemsPerPage); // Không cần nữa
        // request.setAttribute("colsPerRow", colsPerRow); // Không cần nữa


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
                quiz = quizDAO.getQuizById1(quizId);

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
                request.setAttribute("quiz", quizDAO.getQuizById1(quiz.getQuizID()));
                request.setAttribute("canEdit", false); // Not editable
                request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
            } else {
                success = quizDAO.updateQuiz(quiz);
                if (success) {
                    request.setAttribute("successMessage", "Quiz đã được cập nhật thành công.");
                } else {
                    request.setAttribute("errorMessage", "Cập nhật Quiz thất bại.");
                }
                request.setAttribute("quiz", quizDAO.getQuizById1(quiz.getQuizID()));
                request.setAttribute("canEdit", !quizDAO.hasAttempts(quiz.getQuizID()));
                request.getRequestDispatcher("views/quizDetail.jsp").forward(request, response);
            }
        }
    }
}