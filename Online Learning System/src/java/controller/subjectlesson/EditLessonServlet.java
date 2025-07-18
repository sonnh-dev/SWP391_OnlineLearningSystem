package controller.subjectLesson;

import dao.LessonHierarchyDao;
import dao.LessonHierarchyDao.LessonItem;
import model.Lesson;
import model.LessonContent;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EditLessonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String type = request.getParameter("type");
        int lessonId = 0;

        try {
            lessonId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid lesson ID.");
            request.getRequestDispatcher("lessonList.jsp").forward(request, response);
            return;
        }

        LessonHierarchyDao dao = new LessonHierarchyDao();
        Lesson lesson = dao.getLessonById(lessonId);
        LessonContent lessonContent = dao.getLessonContentById(lessonId);

        if (lesson != null && lessonContent != null) {
            request.setAttribute("lesson", lesson);
            request.setAttribute("lessonContent", lessonContent);
            request.setAttribute("type", type);
            request.getRequestDispatcher("/editLesson.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Lesson not found.");
            request.getRequestDispatcher("lessonList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        String title = request.getParameter("title");
        String videoURL = request.getParameter("videoURL");
        String docContent = request.getParameter("docContent");
        Boolean status = Boolean.valueOf(request.getParameter("status"));

        Lesson lesson = new Lesson();
        lesson.setLessonID(lessonId);
        lesson.setTitle(title);
        lesson.setStatus(status);

        LessonContent lessonContent = new LessonContent();
        lessonContent.setLessonID(lessonId);
        lessonContent.setVideoURL(videoURL);
        lessonContent.setDocContent(docContent);

        LessonHierarchyDao dao = new LessonHierarchyDao();
        boolean updateSuccess = dao.updateLesson(lesson) && dao.updateLessonContent(lessonContent);

        if (updateSuccess) {
            response.sendRedirect("LessonListServlet?subjectId=" + lesson.getChapterID());
        } else {
            request.setAttribute("error", "Failed to update lesson.");
            request.getRequestDispatcher("editLesson.jsp").forward(request, response);
        }
    }
}