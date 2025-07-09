package controller.course;

import dao.CourseDao;
import dao.CoursePackageDao;
import dao.UserCourseDao;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.course.Course;
import model.course.CoursePackage;
import model.course.UserCourse;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "MyRegistrationServlet", urlPatterns = {"/myRegistration"})
public class MyRegistrationServlet extends HttpServlet {

    private final CourseDao courseDao = new CourseDao();
    private final CoursePackageDao coursePackageDao = new CoursePackageDao();
    private final UserCourseDao userCourseDao = new UserCourseDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        request.setAttribute("userID", userID);
        //Kiểm tra có phải xóa course không
        String delete = request.getParameter("delete");
        String courseDelete = request.getParameter("courseID");
        if ("true".equals(delete) && courseDelete != null && !courseDelete.isEmpty()) {
            int courseID = Integer.parseInt(courseDelete);
            userCourseDao.deleteUserCourse(userID, courseID);
        }
        // Hiển thị list User Course
        List<UserCourse> userCourse = userCourseDao.getUserCoursesByUserID(userID);
        request.setAttribute("userCourses", userCourse);
        // Featured courses
        List<Course> featuredSubjects = courseDao.get4HotestCoursesofDifferentCategories();
        request.setAttribute("category", courseDao.getAllCategories());
        request.setAttribute("featuredSubjects", featuredSubjects);
        Map<Integer, CoursePackage> minPackage = new HashMap<>();
        for (Course c : featuredSubjects) {
            minPackage.put(c.getCourseID(), coursePackageDao.getCheapestCoursePackagesByCourse(c));
        }
        request.setAttribute("minPackage", minPackage);

        request.getRequestDispatcher("myRegistration.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
