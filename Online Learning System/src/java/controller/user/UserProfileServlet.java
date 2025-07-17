package controller.user; // Đảm bảo package này đúng

import dao.UserDAO;
import model.Account; // Import lớp Account
import model.User;
import java.io.IOException;
import java.sql.SQLException;

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
    // private static final String DATE_FORMAT = "yyyy-MM-dd"; // Không cần thiết nếu dùng LocalDate.parse()
    private UserDAO userDAO = new UserDAO(); // Khởi tạo UserDAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false); // Lấy session hiện có, không tạo mới

        // --- Bắt đầu sửa đổi để lấy userId từ session ---
        if (session == null || session.getAttribute("auth") == null) {
            // Nếu không có session hoặc người dùng chưa đăng nhập (không có "auth" attribute)
            response.sendRedirect(request.getContextPath() + "/login.jsp"); // Chuyển hướng về trang đăng nhập
            return;
        }

        // Lấy đối tượng Account từ session
        Account loggedInAccount = (Account) session.getAttribute("auth");
        int userId = loggedInAccount.getId(); // Lấy userId từ đối tượng Account đã lưu trong session
        // --- Kết thúc sửa đổi ---

        try {
            User user = userDAO.getUserById(userId); // Lấy thông tin user dựa vào ID
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            } else {
                LOGGER.log(Level.WARNING, "User with ID {0} not found in DB. Session might be invalid or data inconsistency.", userId);
                // Xử lý trường hợp không tìm thấy user, có thể do lỗi dữ liệu hoặc session cũ
                session.invalidate(); // Vô hiệu hóa session để yêu cầu đăng nhập lại
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=UserNotFound");
            }
        } catch (ClassNotFoundException ex) { // Bắt cả SQLException và ClassNotFoundException
            LOGGER.log(Level.SEVERE, "Database or Class Not Found error fetching user profile for ID: " + userId, ex);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải hồ sơ. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/error.jsp").forward(request, response); // Chuyển hướng đến trang lỗi
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Đảm bảo đọc tiếng Việt

        HttpSession session = request.getSession(false);

        // --- Bắt đầu sửa đổi để lấy userId từ session và kiểm tra đăng nhập ---
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Account loggedInAccount = (Account) session.getAttribute("auth");
        int userId = loggedInAccount.getId(); // Lấy ID của người dùng đang đăng nhập từ Account
        // --- Kết thúc sửa đổi ---

        // Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String avatarURL = request.getParameter("avatarURL");
        String address = request.getParameter("address");
        String dobString = request.getParameter("dateOfBirth");
        
        User userToUpdate = null; // Khởi tạo null để bắt lỗi nếu không tìm thấy
        try {
            // Lấy thông tin user hiện tại từ DB để giữ nguyên email, role, status
            userToUpdate = userDAO.getUserById(userId);
            if (userToUpdate == null) {
                LOGGER.log(Level.WARNING, "User with ID {0} not found in DB during profile update.", userId);
                session.invalidate(); // Vô hiệu hóa session
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=UserNotFound");
                return;
            }
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Database or Class Not Found error during profile update setup for ID: " + userId, ex);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            return;
        }

        // Cập nhật thông tin từ form vào đối tượng userToUpdate đã lấy từ DB
        userToUpdate.setUserId(userId); // Đảm bảo ID được thiết lập đúng
        userToUpdate.setFirstName(firstName);
        userToUpdate.setLastName(lastName);
        userToUpdate.setGender(gender);
        userToUpdate.setPhoneNumber(phoneNumber);
        userToUpdate.setAvatarUrl(avatarURL);
        userToUpdate.setAddress(address);
       

        // Chuyển đổi ngày sinh
        try {
            if (dobString != null && !dobString.isEmpty()) {
                LocalDate dateOfBirth = LocalDate.parse(dobString);
                userToUpdate.setDateOfBirth(dateOfBirth);
            } else {
                userToUpdate.setDateOfBirth(null); // Nếu rỗng, đặt là null
            }
        } catch (DateTimeParseException e) {
            LOGGER.log(Level.WARNING, "Invalid date format for dateOfBirth: " + dobString, e);
            request.setAttribute("errorMessage", "Định dạng ngày sinh không hợp lệ. Vui lòng sử dụng YYYY-MM-DD.");
            request.setAttribute("user", userToUpdate); // Để hiển thị dữ liệu đã nhập lại form
            request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            return;
        }

        try {
            boolean success = userDAO.updateUserProfile(userToUpdate); // Gọi phương thức DAO để cập nhật
            if (success) {
               
                session.setAttribute("user", userToUpdate); // Cập nhật đối tượng User trong session
                request.setAttribute("successMessage", "Hồ sơ đã được cập nhật thành công!");
                request.setAttribute("user", userToUpdate); // Để hiển thị thông tin mới nhất trên form
                request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Cập nhật hồ sơ thất bại. Vui lòng thử lại.");
                request.setAttribute("user", userToUpdate); // Để hiển thị dữ liệu đã nhập lại form
                request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
            }
        } catch (SQLException e) { // Bắt cả SQLException và ClassNotFoundException
            LOGGER.log(Level.SEVERE, "Lỗi cơ sở dữ liệu khi cập nhật hồ sơ người dùng cho ID: " + userId, e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi cơ sở dữ liệu khi cập nhật hồ sơ. Vui lòng thử lại.");
            request.setAttribute("user", userToUpdate); // Để hiển thị dữ liệu đã nhập lại form
            request.getRequestDispatcher("/users/userProfile.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý hồ sơ người dùng";
    }
}