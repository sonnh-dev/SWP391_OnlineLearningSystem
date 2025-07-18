package controller.course;

import config.EmailSender;
import config.PasswordGenerator;
import dao.CoursePackageDao;
import dao.UserCourseDao;
import dao.UserDAO;
import jakarta.mail.MessagingException;
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

        // Get course information.
        CoursePackage coursePkg = new CoursePackageDao().getCoursePackagesByPackageID(packageId);
        Double price = coursePkg.getOriginalPrice() - coursePkg.getOriginalPrice() * coursePkg.getSaleRate() / 100;
        Map<String, String> errors = new HashMap<>();

        //  Validations
        if (auth == null) {
            if (firstName == null || firstName.trim().isEmpty()) {
                errors.put("firstName", "First name is required.");
            }
            if (lastName == null || lastName.trim().isEmpty()) {
                errors.put("lastName", "Last name is required.");
            }
            if (email == null || !email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
                errors.put("email", "Invalid email format.");
            }
            if (userDAO.isEmailExists(email)) {
                errors.put("email", "This email is already registered.");
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
            String password = PasswordGenerator.generatePassword();
            try {
                EmailSender.sendPassword(email, password);
            } catch (MessagingException ex) {
                Logger.getLogger(CourseRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            user = new User(0, firstName, lastName, gender, email, mobile, "User", true, "media/users/user_1.png", password, null, null);
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
        // Add course into userCourse
        UserCourseDao userCourseDao = new UserCourseDao();
        UserCourse userCourse = new UserCourse();
        userCourse.setUserID(user.getUserId());
        userCourse.setCourseID(courseId);
        userCourse.setPkgName(coursePkg.getPackageName());
        userCourse.setPrice(price);
        userCourse.setProgress(0.0);
        userCourse.setStatus("Pending");
        userCourse.setValidFrom(null);
        userCourse.setValidTo(null);
        if (!userCourseDao.updateUserCourse(userCourse)) {
            userCourseDao.addUserCourse(userCourse);
        }
        // Forward to prePayment
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("courseId", courseId);
        request.setAttribute("packageName", coursePkg.getPackageName());
        request.setAttribute("price", price);
        request.setAttribute("useTime", coursePkg.getUseTime());
        request.getRequestDispatcher("/prePayment").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
