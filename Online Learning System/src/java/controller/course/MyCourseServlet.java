package controller.course;

import dao.CourseDao;
import dao.UserCourseDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.course.Course;
import model.course.UserCourse;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "MyCourseServlet", urlPatterns = {"/MyCourse"})
public class MyCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt( request.getParameter("userID"));
        UserCourseDao userCourseDao = new UserCourseDao();
        List<UserCourse> userCourse = userCourseDao.getUserCoursesByUserIDPayed(userID);
        CourseDao courseDao = new CourseDao();
        for (UserCourse uc : userCourse) {
            Course course = courseDao.getCourseByID(uc.getCourseID());
            uc.setTitle(course.getTitle());
            uc.setImageURL(course.getImageURL());
            uc.setDescription(course.getCourseShortDescription());
        }
        request.setAttribute("userCourse", userCourse);
        request.getRequestDispatcher("myCourse.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
