package controller; // Đảm bảo package này đúng

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/user/profile"})
public class UserProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UserProfileServlet.class.getName());
    private static final String DATE_FORMAT = "yyyy-MM-dd"; // Định dạng ngày tháng
    private UserDAO userDAO = new UserDAO(); // Khởi tạo UserDAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false); // Lấy session hiện có, không tạo mới

        if (session == null || session.getAttribute("loggedInUser") == null) {
            // Người dùng chưa đăng nhập, chuyển hướng về trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login.jsp"); // Thay bằng URL trang login của bạn
            return;
        }

        // Lấy thông tin người dùng từ session
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            // Lấy thông tin người dùng đầy đủ từ DB (đảm bảo là thông tin mới nhất)
            User user = userDAO.getUserById(loggedInUser.getUserId());
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            } else {
                // Không tìm thấy user trong DB (có thể do lỗi dữ liệu)
                LOGGER.log(Level.WARNING, "Logged in user with ID {0} not found in DB.", loggedInUser.getUserId());
                response.sendRedirect(request.getContextPath() + "/error.jsp"); // Chuyển hướng về trang lỗi
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Đảm bảo đọc tiếng Việt

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        int userId = loggedInUser.getUserId(); // Lấy ID của người dùng đang đăng nhập

        // Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String avatarURL = request.getParameter("avatarURL");
        String address = request.getParameter("address");
        String dobString = request.getParameter("dateOfBirth");
        // Email và Role KHÔNG được phép thay đổi từ form, nhưng có thể đọc từ session/DB
        // String email = loggedInUser.getEmail(); 
        // String role = loggedInUser.getRole();

        // Tạo đối tượng User để cập nhật
        User userToUpdate = new User();
        userToUpdate.setUserId(userId);
        userToUpdate.setFirstName(firstName);
        userToUpdate.setLastName(lastName);
        userToUpdate.setGender(gender);
        userToUpdate.setPhoneNumber(phoneNumber);
        userToUpdate.setAvatarURL(avatarURL);
        userToUpdate.setAddress(address);
        userToUpdate.setEmail(loggedInUser.getEmail()); // Giữ nguyên email
        userToUpdate.setRole(loggedInUser.getRole()); // Giữ nguyên role
        userToUpdate.setStatus(loggedInUser.isStatus()); // Giữ nguyên status

        // Chuyển đổi ngày sinh
        try {
            if (dobString != null && !dobString.isEmpty()) {
                // Chuyển đổi String sang LocalDate
                LocalDate dateOfBirth = LocalDate.parse(dobString);
                userToUpdate.setDateOfBirth(dateOfBirth);
            } else {
                userToUpdate.setDateOfBirth(null); // Nếu rỗng, đặt là null
            }
        } catch (DateTimeParseException e) {
            LOGGER.log(Level.WARNING, "Invalid date format for dateOfBirth: " + dobString, e);
            request.setAttribute("errorMessage", "Invalid date of birth format. Please use YYYY-MM-DD.");
            request.setAttribute("user", userToUpdate);
            request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            return;
        }

        try {
            boolean success = userDAO.updateUserProfile(userToUpdate); // Gọi phương thức DAO để cập nhật
            if (success) {
                // Cập nhật lại thông tin user trong session sau khi update thành công
                // Điều này quan trọng để thông tin trên trang khác được đồng bộ
                session.setAttribute("loggedInUser", userToUpdate);
                request.setAttribute("successMessage", "Profile updated successfully!");
                request.setAttribute("user", userToUpdate); // Để hiển thị thông tin mới nhất trên form
                request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
                request.setAttribute("user", userToUpdate); // Để hiển thị dữ liệu đã nhập lại form
                request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error updating user profile for ID: " + userId, e);
            request.setAttribute("errorMessage", "Database error occurred while updating profile. Please try again.");
            request.setAttribute("user", userToUpdate); // Để hiển thị dữ liệu đã nhập lại form
            request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
        }
    }
}
