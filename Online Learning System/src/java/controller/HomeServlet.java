package controller;

import dao.BlogDao;
import dao.CourseDao;
import dao.CoursePackageDao;
import dao.SliderDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Blog;
import model.Course;
import model.CoursePackage;
import model.Slider;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        BlogDao blogDao = new BlogDao();
        SliderDao sliderDao = new SliderDao();
        CourseDao courseDao = new CourseDao();
        CoursePackageDao coursePackageDao = new CoursePackageDao();
        List<Blog> latestBlogs = blogDao.get5LatestPost();
        List<Blog> hotBlogs = blogDao.get3HotBlog();
        List<Slider> slider = sliderDao.getAllSlider();
        List<Course> featuredCourse = courseDao.get3HotestCoursesofDifferentCategories();
        Map<Integer, CoursePackage> minPackage = new HashMap<>();

        for (Course c : featuredCourse) {
            minPackage.put(c.getCourseID(), coursePackageDao.getCheapestCoursePackagesByCourse(c));
        }

        request.setAttribute("latestBlogs", latestBlogs);
        request.setAttribute("hotBlogs", hotBlogs);
        request.setAttribute("slider", slider);
        request.setAttribute("featuredCourse", featuredCourse);
        request.setAttribute("minPackage", minPackage);
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
        return "Short description";
    }// </editor-fold>
}
