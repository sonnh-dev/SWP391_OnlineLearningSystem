// File: src/main/java/com/yourcompany/yourproject/controller/AddUserServlet.java
package controller.user;

import config.EmailSender;
import config.PasswordGenerator;
import controller.course.CourseRegisterServlet;
import dao.UserDAO;
import jakarta.mail.MessagingException;
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

// Tạo 1 mật khẩu ngẫu nhiên duy nhất (có thể dùng PasswordGenerator hoặc UUID)
            String password = PasswordGenerator.generatePassword(); // 8–10 ký tự

// Gửi mật khẩu qua email
            try {
                EmailSender.sendPassword(email, password);
            } catch (MessagingException ex) {
                Logger.getLogger(AddUserServlet.class.getName()).log(Level.SEVERE, "Failed to send password email", ex);
            }

// Tạo user và set mật khẩu thô
            User newUser = new User(firstName, lastName, gender, email, phoneNumber, role, status, avatarUrl, address, dateOfBirth);
            newUser.setPassword(password); // Không hash, lưu thẳng

            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.addUser(newUser);

            if (success) {
                response.sendRedirect("users?message=User added successfully and password sent.");
            } else {
                request.setAttribute("errorMessage", "Failed to add user. Email may already exist.");
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
