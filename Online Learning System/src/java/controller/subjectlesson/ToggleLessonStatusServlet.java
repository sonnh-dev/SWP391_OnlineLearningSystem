package controller.subjectLesson;

import dao.LessonHierarchyDao;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;


public class ToggleLessonStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);  // Cho phép GET hoạt động
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String type = request.getParameter("type");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));

        LessonHierarchyDao dao = new LessonHierarchyDao();
        dao.toggleStatus(id, type);

        // Quay lại trang danh sách
        response.sendRedirect("LessonListServlet?subjectId=" + subjectId);
    }
}
