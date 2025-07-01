package servlet;

import com.google.gson.Gson;
import dao.LessonHierarchyDao;
import model.Chapter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class LessonHierarchyServlet extends HttpServlet {

    private final LessonHierarchyDao dao = new LessonHierarchyDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Lấy courseId
            String courseIdParam = request.getParameter("courseId");
            if (courseIdParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Missing courseId\"}");
                return;
            }

            int courseId;
            try {
                courseId = Integer.parseInt(courseIdParam);
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Invalid courseId\"}");
                return;
            }

            // Lấy các tham số lọc
            String chapterIdParam = request.getParameter("chapterId");
            Integer chapterId = null;
            if (chapterIdParam != null && !chapterIdParam.equalsIgnoreCase("All")) {
                try {
                    chapterId = Integer.parseInt(chapterIdParam);
                } catch (NumberFormatException e) {
                    // Ignore invalid chapterId
                }
            }

            String status = request.getParameter("status");
            if (status != null && status.trim().equalsIgnoreCase("All")) {
                status = null;
            }

            String search = request.getParameter("search");

            // Gọi DAO có lọc
            List<Chapter> chapters = dao.getLessonHierarchyByCourse(courseId, chapterId, status, search);

            // Trả về JSON
            String json = new Gson().toJson(chapters);
            out.print(json);
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

    @Override
    public String getServletInfo() {
        return "LessonHierarchyServlet - Trả JSON theo courseId, chapterId, status, search";
    }
}
