// File: src/main/java/com/yourcompany/yourproject/controller/AddUserServlet.java
package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID; // Dùng để tạo mật khẩu ngẫu nhiên
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

@WebServlet(name = "AddUserServlet", urlPatterns = {"/admin/addUsers"})
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang thêm người dùng
        request.getRequestDispatcher("/users/addUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận tiếng Việt
            
            // Lấy thông tin từ form
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String role = request.getParameter("role");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String avatarUrl = request.getParameter("avatarUrl");
            String address = request.getParameter("address");
            String dobString = request.getParameter("dateOfBirth");
            LocalDate dateOfBirth = null;
            if (dobString != null && !dobString.isEmpty()) {
                try {
                    dateOfBirth = LocalDate.parse(dobString);
                } catch (DateTimeParseException e) {
                    request.setAttribute("errorMessage", "Invalid Date of Birth format. Please use YYYY-MM-DD.");
                    request.getRequestDispatcher("/users/addUsers.jsp").forward(request, response);
                    return;
                }
            }
            
            // Tạo mật khẩu ngẫu nhiên cho người dùng mới
            String generatedPassword = UUID.randomUUID().toString().substring(0, 8); // Mật khẩu 8 ký tự
            // Trong thực tế, bạn sẽ băm mật khẩu này và lưu băm vào DB
            // String hashedPassword = HashUtil.hashPassword(generatedPassword);
            
            User newUser = new User(firstName, lastName, gender, email, phoneNumber, role, status, avatarUrl, address, dateOfBirth);
            newUser.setPassword(generatedPassword); // Đặt mật khẩu đã tạo
            
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.addUser(newUser);
            
            if (success) {
                // Gửi email mật khẩu cho người dùng (cần triển khai logic gửi email)
                // sendEmail(newUser.getEmail(), "Your New Account Password", "Your password is: " + generatedPassword);
                request.setAttribute("successMessage", "User added successfully. Password for " + newUser.getEmail() + " is: " + generatedPassword + ". (In real app, this would be emailed).");
                response.sendRedirect("users?message=User added successfully and password generated.");
            } else {
                request.setAttribute("errorMessage", "Failed to add user. Email might already exist or other database error.");
                request.getRequestDispatcher("/users/addUsers.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    // Một phương thức giả định để gửi email (cần triển khai thực tế với JavaMail API)
    // private void sendEmail(String toEmail, String subject, String content) {
    //    // Implement email sending logic here using JavaMail API
    //    System.out.println("Sending email to: " + toEmail + " with subject: " + subject + " and content: " + content);
    // }
}