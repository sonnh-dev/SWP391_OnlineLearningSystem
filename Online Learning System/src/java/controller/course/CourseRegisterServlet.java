/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dao.CoursePackageDao;
import dao.UserCourseDao;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.course.CoursePackage;
import model.User;
import model.course.UserCourse;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "CourseRegisterServlet", urlPatterns = {"/CourseRegister"})
@MultipartConfig
public class CourseRegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account auth = (Account) session.getAttribute("auth");
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        List<CoursePackage> coursePackage = new CoursePackageDao().getCoursePackagesByCourseID(courseID);
        request.setAttribute("coursePackage", coursePackage);
        if (auth != null) {
            User user = new UserDAO().getLoginUser(auth);
            request.setAttribute("user", user);
        }
        request.setAttribute("courseID", courseID);
        request.getRequestDispatcher("courseRegister.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account auth = (Account) session.getAttribute("auth");
        UserDAO userDAO = new UserDAO();
        User user;
        int courseId = Integer.parseInt(request.getParameter("courseID"));
        int packageId = Integer.parseInt(request.getParameter("packageID"));

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");

        Map<String, String> errors = new HashMap<>();

        //  Validations
        if (auth == null) {
            if (firstName == null || firstName.trim().isEmpty()) {
                errors.put("firstName", "First name is required.");
            }
            if (lastName == null || lastName.trim().isEmpty()) {
                errors.put("lastName", "Last name is required.");
            }
            if (email == null || userDAO.isEmailExists(email) || !email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
                errors.put("email", "Invalid email format or this email is already registered.");
            }
            if (mobile == null || !mobile.matches("\\d{10,15}")) {
                errors.put("mobile", "Invalid mobile number.");
            }
        }
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("mobile", mobile);
            request.setAttribute("gender", gender);
            int courseID = Integer.parseInt(request.getParameter("courseID"));
            List<CoursePackage> coursePackage = new CoursePackageDao().getCoursePackagesByCourseID(courseID);
            request.setAttribute("coursePackage", coursePackage);
            request.setAttribute("courseID", courseID);
            request.getRequestDispatcher("courseRegister.jsp").forward(request, response);
            return;
        }
        if (auth != null) {
            user = userDAO.getLoginUser(auth);
        } else {
            user = new User(0, firstName, lastName, gender, email, mobile, "user", true, "default.png", null, null, null);
            try {
                userDAO.addUser(user);
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script>window.parent.postMessage({"
                        + "action: 'notifyAccountCreated', "
                        + "message: 'Account created, please check your email to further process.'"
                        + "}, '*');</script>");
                return;
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(CourseRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        UserCourseDao userCourseDao = new UserCourseDao();
        userCourseDao.addUserCourse(new UserCourse(user.getUserId(), courseId, packageId,"","","", null, 0.0, "Pending", null, null));
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("courseId", courseId);
        request.setAttribute("packageId", packageId);
        double price = Double.parseDouble(request.getParameter("price"));
        request.setAttribute("price", price);
        request.getRequestDispatcher("/prePayment").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
