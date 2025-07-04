package controller.subjectLesson;

import dao.LessonHierarchyDao;
import dao.LessonHierarchyDao.LessonItem;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LessonHierarchyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy subjectId từ request parameter
        String subjectIdRaw = request.getParameter("subjectId");
        int subjectId = 0;

        try {
            subjectId = Integer.parseInt(subjectIdRaw);
        } catch (Exception e) {
            request.setAttribute("error", "Invalid subject ID.");
            request.getRequestDispatcher("lessonList.jsp").forward(request, response);
            return;
        }

        // Gọi DAO để lấy dữ liệu hierarchy
        LessonHierarchyDao dao = new LessonHierarchyDao();
        List<LessonItem> lessonList = dao.getLessonHierarchyBySubjectId(subjectId);

        // Gửi dữ liệu sang JSP
        request.setAttribute("lessonList", lessonList);
        request.setAttribute("subjectId", subjectId);
        request.getRequestDispatcher("lessonList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // cho phép POST hoạt động tương tự GET
    }

    @Override
    public String getServletInfo() {
        return "Lesson Hierarchy Servlet";
    }
}
