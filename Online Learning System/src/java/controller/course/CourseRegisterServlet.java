/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dao.CoursePackageDao;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.course.CoursePackage;
import model.User;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "CourseRegisterServlet", urlPatterns = {"/CourseRegister"})
public class CourseRegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        Account auth = (Account) session.getAttribute("auth");
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        List<CoursePackage> coursePackage = new CoursePackageDao().getCoursePackagesByCourseID(courseID);
        request.setAttribute("coursePackage", coursePackage);
        if (auth != null) {
            User user = new UserDAO().getLoginUser(auth);
            request.setAttribute("user", user);
        }
        request.getRequestDispatcher("courseRegister.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");

        Map<String, String> errors = new HashMap<>();

        // Simple validations
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.put("firstName", "First name is required.");
        }

        if (lastName == null || lastName.trim().isEmpty()) {
            errors.put("lastName", "Last name is required.");
        }

        if (email == null || !email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            errors.put("email", "Invalid email format.");
        }

        if (mobile == null || !mobile.matches("\\d{10,15}")) {
            errors.put("mobile", "Invalid mobile number.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("mobile", mobile);
            request.setAttribute("gender", gender);
            request.getRequestDispatcher("courseRegister.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("courseRegister.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
