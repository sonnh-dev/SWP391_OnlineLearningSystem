package controller.quizz;

import dao.QuestionDAO;
import dao.QuizDAO;
import model.Question;
import model.QuestionOption;
import model.Quiz;
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

@WebServlet(name = "QuestionController", urlPatterns = {"/questionDetail", "/questions"})
public class QuestionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        QuestionDAO questionDAO = new QuestionDAO();
        QuizDAO quizDAO = new QuizDAO(); 

        if ("/questionDetail".equals(path)) {
            String questionIdStr = request.getParameter("questionId");
            String quizIdStr = request.getParameter("quizId"); 

            Quiz parentQuiz = null;
            if (quizIdStr != null && !quizIdStr.isEmpty()) {
                int quizId = Integer.parseInt(quizIdStr);
                parentQuiz = quizDAO.getQuizById(quizId);
               
                if (parentQuiz != null && !quizDAO.hasAttempts(quizId)) {
                    request.setAttribute("parentQuiz", parentQuiz);
                } else {
                 
                    response.sendRedirect(request.getContextPath() + "/quizzes?errorMessage=Cannot manage questions for this quiz.");
                    return;
                }
            } else {
               
                response.sendRedirect(request.getContextPath() + "/quizzes?errorMessage=Invalid Quiz ID for question management.");
                return;
            }

            Question question = null;
            if (questionIdStr != null && !questionIdStr.isEmpty()) {
                try {
                    int questionId = Integer.parseInt(questionIdStr);
                    question = questionDAO.getQuestionById(questionId);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            request.setAttribute("question", question);
            request.getRequestDispatcher("views/questionDetail.jsp").forward(request, response);

        } else if ("/questions".equals(path)) {
           
            String quizIdStr = request.getParameter("quizId");
            if (quizIdStr != null && !quizIdStr.isEmpty()) {
                try {
                    int quizId = Integer.parseInt(quizIdStr);
                    List<Question> questions = questionDAO.getQuestionsByQuizId(quizId);
                    request.setAttribute("questions", questions);
                    request.getRequestDispatcher("views/questionsListPartial.jsp").forward(request, response); // Ví dụ: trả về một phần HTML
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/quizzes");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        QuestionDAO questionDAO = new QuestionDAO();
        QuizDAO quizDAO = new QuizDAO(); 

        if ("saveQuestion".equals(action)) {
            int quizId = Integer.parseInt(request.getParameter("quizID"));
            
          
            if (quizDAO.hasAttempts(quizId)) {
                request.setAttribute("errorMessage", "Không thể thêm/sửa câu hỏi vì Quiz đã có lượt làm bài.");
               
                response.sendRedirect(request.getContextPath() + "/quizDetail?id=" + quizId + "&errorMessage=" + java.net.URLEncoder.encode("Không thể thêm/sửa câu hỏi vì Quiz đã có lượt làm bài.", "UTF-8"));
                return;
            }

            Question question = new Question();
            String questionIdStr = request.getParameter("questionID");
            if (questionIdStr != null && !questionIdStr.isEmpty()) {
                question.setQuestionID(Integer.parseInt(questionIdStr));
            }
            
            question.setQuizID(quizId);
            question.setQuestionContent(request.getParameter("questionContent"));
            question.setQuestionType(request.getParameter("questionType"));

            List<QuestionOption> options = new ArrayList<>();
           
            int optionIndex = 1;
            String optionContent;
            while ((optionContent = request.getParameter("optionContent" + optionIndex)) != null) {
                if (!optionContent.trim().isEmpty()) {
                    QuestionOption option = new QuestionOption();
                    option.setOptionContent(optionContent);
                    option.setIsCorrect("true".equals(request.getParameter("isCorrect" + optionIndex)));
                    options.add(option);
                }
                optionIndex++;
            }
            question.setOptions(options);

            boolean success;
            if (question.getQuestionID() == 0) { 
                try {
                    success = (questionDAO.addQuestion(question) != -1);
                    if (success) {
                        request.setAttribute("successMessage", "Câu hỏi đã được thêm mới thành công.");
                    } else {
                        request.setAttribute("errorMessage", "Thêm câu hỏi thất bại.");
                    }
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else { 
                try {
                    success = questionDAO.updateQuestion(question);
                    if (success) {
                        request.setAttribute("successMessage", "Câu hỏi đã được cập nhật thành công.");
                    } else {
                        request.setAttribute("errorMessage", "Cập nhật câu hỏi thất bại.");
                    }
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
           
            response.sendRedirect(request.getContextPath() + "/quizDetail?id=" + quizId);

        } else if ("deleteQuestion".equals(action)) {
            int questionId = Integer.parseInt(request.getParameter("questionId"));
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            
            if (quizDAO.hasAttempts(quizId)) { 
                request.setAttribute("errorMessage", "Không thể xóa câu hỏi vì Quiz đã có lượt làm bài.");
            } else {
                try {
                    questionDAO.deleteQuestion(questionId);
                    request.setAttribute("successMessage", "Câu hỏi đã được xóa thành công.");
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            response.sendRedirect(request.getContextPath() + "/quizDetail?id=" + quizId);
        } else {
            
            response.sendRedirect(request.getContextPath() + "/quizzes");
        }
    }
}