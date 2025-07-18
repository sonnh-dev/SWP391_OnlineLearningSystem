package controller.subjectLesson;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.LessonDao1;

/**
 *
 * @author ADMIN
 */
public class ToggleLessonStatusServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tham số từ request
        int lessonId = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int page = Integer.parseInt(request.getParameter("page"));

        // Gọi DAO để cập nhật trạng thái
        LessonDao1 lessonDao = new LessonDao1();
        try {
            lessonDao.updateLessonStatus(lessonId, status);
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi nếu cần (ví dụ: chuyển hướng đến trang lỗi)
            response.sendRedirect("error.jsp");
            return;
        }

        // Chuyển hướng lại trang danh sách với các tham số ban đầu
        response.sendRedirect("LessonListServlet?subjectId=" + subjectId + "&page=" + page);
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Toggle lesson status servlet";
    }
}