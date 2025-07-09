/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import dao.CourseDao;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "PrePaymentServlet", urlPatterns = {"/prePayment"})
public class PrePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getAttribute("userId");
        Integer courseId = (Integer) request.getAttribute("courseId");
        String packageName = (String) request.getAttribute("packageName");
        double price = (Double) request.getAttribute("price");
        int useTime = (Integer) request.getAttribute("useTime");
        CourseDao courseDao = new CourseDao();
        UserDAO userDao = new UserDAO();

        try {
            request.setAttribute("user", userDao.getUserById(userId).getFullName());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PrePaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("userId", userId);
        request.setAttribute("courseId", courseId);
        request.setAttribute("courseName", courseDao.getCourseByID(courseId).getTitle());
        request.setAttribute("packageName", packageName);
        request.setAttribute("price", price);
        request.setAttribute("useTime", useTime);
        
        request.getRequestDispatcher("prepayment.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
