/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import dao.CourseDao;
import dao.CoursePackageDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
        Integer packageId = (Integer) request.getAttribute("packageId");
        int price = (int) Double.parseDouble(request.getParameter("price"));
        
        CourseDao courseDao = new CourseDao();
        CoursePackageDao packageDao = new CoursePackageDao();
        request.setAttribute("courseName", courseDao.getCourseByID(courseId));
        request.setAttribute("packageName", packageDao.getCoursePackagesByPackageID(packageId));

        request.setAttribute("userId", userId);
        request.setAttribute("courseId", courseId);
        request.setAttribute("packageId", packageId);
        request.setAttribute("price", price);
        request.getRequestDispatcher("prepayment.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
