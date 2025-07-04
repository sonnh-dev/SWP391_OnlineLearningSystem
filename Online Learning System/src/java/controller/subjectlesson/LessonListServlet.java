package controller.subjectLesson;

import dao.LessonHierarchyDao;
import dao.LessonHierarchyDao.LessonItem;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LessonListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Lấy status lọc (active, inactive, all)
        String statusFilter = request.getParameter("statusFilter");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "all";
        }

        // Lấy keyword tìm kiếm
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }

        // Lấy lesson group lọc (chapter title)
        String lessonGroup = request.getParameter("lessonGroup");
        if (lessonGroup == null || lessonGroup.equals("all")) {
            lessonGroup = "";
        }

        // Lấy subjectId
        String subjectIdParam = request.getParameter("subjectId");
        int subjectId = 0;
        try {
            subjectId = Integer.parseInt(subjectIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid subject ID.");
            request.getRequestDispatcher("/lessonList.jsp").forward(request, response);
            return;
        }

        // Gọi DAO để lấy dữ liệu đã lọc
        LessonHierarchyDao dao = new LessonHierarchyDao();
        List<LessonItem> filteredLessons = dao.getFilteredLessonHierarchy(subjectId, statusFilter, search, lessonGroup);

        // Lấy danh sách lesson group (chapter title) cho dropdown
        List<String> lessonGroups = dao.getLessonGroups(subjectId);

        // Gửi attribute sang JSP
        request.setAttribute("lessonList", filteredLessons);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("search", search);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("subjectName", dao.getSubjectName(subjectId)); // cần có method này
        request.setAttribute("lessonGroups", lessonGroups);
        request.setAttribute("lessonGroupSelected", lessonGroup);

        // Forward đến JSP
        request.getRequestDispatcher("/lessonList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        doGet(request, response);
    }
}
