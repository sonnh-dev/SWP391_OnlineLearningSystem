/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.AccountDao;
import dao.EmailSender;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.TokenStorage;


/**
 *
 * @author ADMIN
 */
public class RegisterServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Xóa các token hết hạn
        TokenStorage.cleanUpExpiredTokens();

        // Lấy thông tin người dùng từ form
       // Lấy thông tin người dùng từ form
String fullName = request.getParameter("fullName");
String gender = request.getParameter("gender");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String password = request.getParameter("password"); // cần dòng này nếu chưa có

// Tạo token xác thực
String token = UUID.randomUUID().toString();
TokenStorage.tokenMap.put(token, new TokenStorage.TokenEntry(email, fullName, gender, mobile, password));


        String verifyLink = "http://localhost:8080/OLS/verify?token=" + token;

        StringBuilder emailContent = new StringBuilder();
        emailContent.append("Hi ").append(fullName).append(",\n\n");
        emailContent.append("Please verify your account by clicking the link below:\n");
        emailContent.append(verifyLink).append("\n\n");
        emailContent.append("Thank you!");

        try {
            // Gọi DAO để lưu người dùng vào database
            AccountDao dao = new AccountDao();
            dao.insertUser(fullName, gender, email, mobile, password);

            // Gửi email xác thực
            EmailSender.sendEmail(email, "Verify Your Account", emailContent.toString());

            response.getWriter().println("Registration successful. Please check your email to verify.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Registration failed: " + e.getMessage());
        }
    }


    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
