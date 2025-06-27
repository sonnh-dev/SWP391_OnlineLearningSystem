package controller.course;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.course.Course;
import model.course.CourseList;
import model.course.CoursePackage;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "CourseListServlet", urlPatterns = {"/CourseList"})
public class CourseListServlet extends HttpServlet {

    private final CourseDao courseDao = new CourseDao();
    private final CoursePackageDao coursePackageDao = new CoursePackageDao();
    private final CourseListDAO courseListDAO = new CourseListDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Course info
        List<CourseList> listofCourse = courseListDAO.getAllCourseList();
        request.setAttribute("listofCourse", listofCourse);
        //Course config
        List<String> fieldLabels = new ArrayList<>();

        for (Field field : CourseList.class.getDeclaredFields()) {
            String name = field.getName();
            if (!name.equals("courseID")) {
                // Tách camelCase thành dạng có khoảng trắng + viết hoa chữ đầu
                String label = name.replaceAll("([a-z])([A-Z])", "$1 $2");
                label = label.substring(0, 1).toUpperCase() + label.substring(1);
                fieldLabels.add(label);
            }
        }
        
        request.setAttribute("fieldLabels", fieldLabels);
        // Featured courses
        List<Course> featuredSubjects = courseDao.get4HotestCoursesofDifferentCategories();
        request.setAttribute("category", courseDao.getAllCategories());
        request.setAttribute("featuredSubjects", featuredSubjects);
        Map<Integer, CoursePackage> minPackage = new HashMap<>();
        for (Course c : featuredSubjects) {
            minPackage.put(c.getCourseID(), coursePackageDao.getCheapestCoursePackagesByCourse(c));
        }
        request.setAttribute("minPackage", minPackage);

        //request tới trang jsp
        request.getRequestDispatcher("courseList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
