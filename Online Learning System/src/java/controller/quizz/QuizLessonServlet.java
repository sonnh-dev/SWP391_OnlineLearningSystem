/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.quizz;
import dao.QuizDAO;
import model.Quiz;
import model.QuizAttempt;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet(name = "QuizLessonServlet", urlPatterns = {"/quizLesson"})
public class QuizLessonServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    HttpSession session = request.getSession();
    Integer userID = (Integer) session.getAttribute("userID");
 

    // Lấy tham số quizId từ request
    String quizIdStr = request.getParameter("quizId");
    int quizId;
    if (quizIdStr != null && !quizIdStr.trim().isEmpty()) {
        try {
            quizId = Integer.parseInt(quizIdStr);
        } catch (NumberFormatException e) {
            // Xử lý trường hợp quizId không phải là số hợp lệ
            request.setAttribute("errorMessage", "ID Quiz không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
    } else {
        // Trường hợp quizId bị thiếu trong URL
        request.setAttribute("errorMessage", "Không tìm thấy ID Quiz. Vui lòng cung cấp ID Quiz.");
        request.getRequestDispatcher("error.jsp").forward(request, response);
        return;
    }
    request.setAttribute("quizId", quizId); // Để truyền sang JSP
        QuizDAO quizDAO = new QuizDAO();
        try {
            Quiz quiz = quizDAO.getQuizById2(quizId);
            if (quiz == null) {
                request.setAttribute("errorMessage", "Không tìm thấy Quiz với ID: " + quizId);
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("quiz", quiz);
            QuizAttempt lastAttempt = quizDAO.getLastQuizAttempt(userID, quizId);
            // Kiểm tra xem attempt cuối cùng đã hoàn thành chưa
            if (lastAttempt != null && lastAttempt.getEndTime() != null) {
                request.setAttribute("showResultSubForm", true);
                request.setAttribute("lastAttempt", lastAttempt);
            } else {
                request.setAttribute("showResultSubForm", false);
            }
            request.getRequestDispatcher("/views/quizLesson.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error accessing database for Quiz Lesson", e);
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
