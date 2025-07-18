package controller.user;

import dao.UserDAO;
import model.User;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Vẫn cần cho logger hoặc nếu sau này đổi lại logic session
import jakarta.servlet.http.Part;
import model.Account;

@WebServlet(name = "EditUserProfileServlet", urlPatterns = {"/profile/edit"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditUserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "assets" + File.separator + "avatars";

    /**
     * Handles the HTTP GET method. Displays the user profile edit form for user
     * ID 20.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Account loggedInAccount = (Account) session.getAttribute("auth");
        int userIdToEdit = loggedInAccount.getId();

        UserDAO userDAO = new UserDAO();
        User user = null;
        try {
            user = userDAO.getUserById(userIdToEdit);
        } catch (Exception e) {
            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error retrieving user for editing (ID: " + userIdToEdit + ")", e);
            request.setAttribute("message", "Error loading user profile for editing.");
            request.setAttribute("messageType", "error");
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/errorPage.jsp"); // Chuyển hướng nếu không tìm thấy user
            return;
        }

        request.setAttribute("user", user);
        // Sửa đường dẫn JSP: luôn bắt đầu bằng / để là đường dẫn tuyệt đối từ context root
        request.getRequestDispatcher("/users/editUserProfile.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP POST method. Processes the form submission for updating
     * user ID 20.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("auth") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Account loggedInAccount = (Account) session.getAttribute("auth");
        int userIdToEdit = loggedInAccount.getId();

        UserDAO userDAO = new UserDAO();
        User userFromDb = null; // Đây sẽ là đối tượng user lấy từ DB có ID = 20

        try {
            userFromDb = userDAO.getUserById(userIdToEdit);
        } catch (Exception e) {
            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error retrieving user " + userIdToEdit + " for POST update", e);
            request.setAttribute("message", "Error finding user to update.");
            request.setAttribute("messageType", "error");
            // Forward lại với thông báo lỗi và không có user nào để hiển thị
            request.getRequestDispatcher("/users/editUserProfile.jsp").forward(request, response);
            return;
        }

        if (userFromDb == null) {
            request.setAttribute("message", "User with ID " + userIdToEdit + " not found for update.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/users/editUserProfile.jsp").forward(request, response);
            return;
        }

        String message = null;
        String messageType = null;
        String currentAvatarUrl = userFromDb.getAvatarUrl(); // Lấy URL avatar hiện tại từ đối tượng DB
        String newAvatarRelativePath = null;

        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phoneNumber = request.getParameter("phoneNumber");
            String dobString = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");

            Part avatarPart = request.getPart("avatarFile");

            if (avatarPart != null && avatarPart.getSize() > 0) {
                String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
                String filePath = uploadPath + File.separator + uniqueFileName;

                try (InputStream input = avatarPart.getInputStream()) {
                    Files.copy(input, Paths.get(filePath));
                }

                newAvatarRelativePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
                newAvatarRelativePath = newAvatarRelativePath.replace("\\", "/");

                if (currentAvatarUrl != null && !currentAvatarUrl.isEmpty()
                        && !currentAvatarUrl.contains("default-avatar.png")) {
                    File oldAvatarFile = new File(applicationPath + File.separator + currentAvatarUrl);
                    if (oldAvatarFile.exists() && oldAvatarFile.isFile()) {
                        if (oldAvatarFile.delete()) {
                            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.INFO, "Old avatar deleted: " + oldAvatarFile.getAbsolutePath());
                        } else {
                            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.WARNING, "Failed to delete old avatar: " + oldAvatarFile.getAbsolutePath());
                        }
                    }
                }
            }

            // Cập nhật thông tin trên đối tượng userFromDb (user ID 20)
            userFromDb.setFirstName(firstName);
            userFromDb.setLastName(lastName);
            userFromDb.setPhoneNumber(phoneNumber);
            userFromDb.setGender(gender);
            userFromDb.setAddress(address);

            if (dobString != null && !dobString.isEmpty()) {
                userFromDb.setDateOfBirth(LocalDate.parse(dobString));
            } else {
                userFromDb.setDateOfBirth(null);
            }

            if (newAvatarRelativePath != null) {
                userFromDb.setAvatarUrl(newAvatarRelativePath);
            }

            boolean updateSuccess = userDAO.updateUserProfile(userFromDb);

            if (updateSuccess) {
                message = "Profile updated successfully!";
                messageType = "success";
                // Nếu user ID 20 là user đang đăng nhập, hãy cập nhật session của họ
                HttpSession currentSession = request.getSession(false);
                if (currentSession != null) {
                    User loggedInUser = (User) currentSession.getAttribute("loggedInUser");
                    if (loggedInUser != null && loggedInUser.getUserId() == userIdToEdit) {
                        currentSession.setAttribute("loggedInUser", userFromDb); // Cập nhật session của user 20
                    }
                }
            } else {
                message = "Failed to update profile. Please try again.";
                messageType = "error";
            }

        } catch (Exception ex) {
            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error processing profile update for user ID " + userIdToEdit, ex);
            message = "An unexpected error occurred: " + ex.getMessage();
            messageType = "error";
        }

        // Set message và user (đã cập nhật) vào request để forward lại JSP
        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.setAttribute("user", userFromDb); // Quan trọng: truyền userFromDb để JSP hiển thị dữ liệu mới nhất của user 20
        request.getRequestDispatcher("/users/editUserProfile.jsp").forward(request, response);
    }
}
