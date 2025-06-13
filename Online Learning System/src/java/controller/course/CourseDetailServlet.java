package controller.course;

import dao.ChapterDao;
import dao.CourseAdditionalDao;
import dao.CourseDao;
import dao.CoursePackageDao;
import dao.LessonDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Chapter;
import model.Lesson;
import model.course.Course;
import model.course.CourseAdditional;
import model.course.CoursePackage;

@WebServlet(name = "CourseDetails", urlPatterns = {"/CourseDetail"})
public class CourseDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CourseDetails</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CourseDetails at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        CourseDao courseDao = new CourseDao();
        ChapterDao chapterDao = new ChapterDao();
        LessonDao lessonDao = new LessonDao();
        CoursePackageDao coursePackagedao = new CoursePackageDao();
        CourseAdditionalDao courseAdditionalDao = new CourseAdditionalDao();
        Course course = courseDao.getCourseByID(courseID);
        List<CourseAdditional> listCourseAdditional = courseAdditionalDao.getCourseAdditionalByCourseID(courseID);
        List<Chapter> chapters = chapterDao.getChaptersByCourseID(courseID);
        Map<Integer, List<Lesson>> lessonMap = new HashMap<>();
        for (Chapter chapter : chapters) {
            List<Lesson> lessons = lessonDao.getLessonsByChapterID(chapter.getChapterID());
            lessonMap.put(chapter.getChapterID(), lessons);
        }
        List<Course> featuredSubjects = courseDao.get4HotestCoursesofDifferentCategories();
        Map<Integer, CoursePackage> minPackage = new HashMap<>();
        for (Course c : featuredSubjects) {
            minPackage.put(c.getCourseID(), coursePackagedao.getCheapestCoursePackagesByCourse(c));
        }
        request.setAttribute("courseAdditional", listCourseAdditional);
        request.setAttribute("course", course);
        request.setAttribute("chapters", chapters);
        request.setAttribute("lessonMap", lessonMap);
        request.setAttribute("category", courseDao.getAllCategories());
        request.setAttribute("featuredSubjects", featuredSubjects);
        request.setAttribute("minPackage", minPackage);
        request.setAttribute("price", coursePackagedao.getCheapestCoursePackagesByCourse(course));
        request.getRequestDispatcher("courseDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
