//package controller; // Hoặc package chứa Servlets của bạn
//
//import daos.UserDAO; // Đảm bảo đúng package của UserDAO
//import models.User;   // Đảm bảo đúng package của User
//
//import java.io.File;
//import java.io.IOException;
//import java.io.InputStream;
//import java.nio.file.Files; // Java NIO cho việc sao chép file
//import java.nio.file.Paths;
//import java.time.LocalDate;
//import java.util.UUID; // Để tạo tên file duy nhất
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig; // Cần annotation này
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import jakarta.servlet.http.Part; // Lớp Part để xử lý file từ MultipartRequest
//
//@WebServlet(name = "EditUserProfileServlet", urlPatterns = {"/profile/edit"})
//@MultipartConfig( // Cấu hình MultipartConfig là BẮT BUỘC khi xử lý file upload bằng API Servlet
//    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
//    maxFileSize = 1024 * 1024 * 10,     // 10MB (Kích thước file tối đa)
//    maxRequestSize = 1024 * 1024 * 50   // 50MB (Kích thước tổng request tối đa)
//)
//public class EditUserProfileServlet extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//    // Thư mục để lưu ảnh avatar, nằm trong thư mục gốc của ứng dụng web
//    private static final String UPLOAD_DIRECTORY = "assets" + File.separator + "avatars"; 
//
//    /**
//     * Handles the HTTP GET method.
//     * Displays the user profile edit form.
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
////        HttpSession session = request.getSession();
////        User currentUser = (User) session.getAttribute("loggedInUser"); // Lấy user từ session
////
//
////
////        // Truyền đối tượng User hiện tại vào request để hiển thị trên form
////        request.setAttribute("user", currentUser);
////        request.getRequestDispatcher("/web/users/editUserProfile.jsp").forward(request, response);
////    }
//     int userIdToEdit = 20; 
//        UserDAO userDAO = new UserDAO();
//        User user = null;
//        try {
//            user = userDAO.getUserById(userIdToEdit);
//        } catch (Exception e) {
//            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error retrieving user for editing (ID: 20)", e);
//            request.setAttribute("message", "Error loading user profile for editing.");
//            request.setAttribute("messageType", "error");
//        }
//
//        if (user == null) {
//            // Nếu không tìm thấy user với ID 20, có thể chuyển hướng hoặc hiển thị lỗi
//            response.sendRedirect(request.getContextPath() + "/errorPage.jsp"); // Chuyển hướng đến trang lỗi
//            return;
//        }
//
//        request.setAttribute("user", user);
//        request.getRequestDispatcher("users/editUserProfile.jsp").forward(request, response);
//    }
//    /**
//     * Handles the HTTP POST method.
//     * Processes the form submission for updating user profile.
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("loggedInUser");
//
//        if (currentUser == null) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
//
//        UserDAO userDAO = new UserDAO();
//        String message = null;
//        String messageType = null; // "success" or "error"
//
//        String firstName = null;
//        String lastName = null;
//        String phoneNumber = null;
//        String dobString = null;
//        String gender = null;
//        String address = null;
//        // Lấy URL avatar hiện tại từ user trong session, đây là đường dẫn tương đối
//        String currentAvatarUrl = currentUser.getAvatarUrl(); 
//        String newAvatarRelativePath = null; // Đường dẫn tương đối của avatar mới (nếu có)
//        
//        try {
//            // Lấy các trường text từ request bằng request.getParameter()
//            firstName = request.getParameter("firstName");
//            lastName = request.getParameter("lastName");
//            phoneNumber = request.getParameter("phoneNumber");
//            dobString = request.getParameter("dob");
//            gender = request.getParameter("gender");
//            address = request.getParameter("address");
//
//            // Xử lý upload file avatar
//            Part avatarPart = request.getPart("avatarFile"); // Lấy Part cho trường input type="file" có name="avatarFile"
//            
//            // Kiểm tra xem có file avatar mới được upload không
//            if (avatarPart != null && avatarPart.getSize() > 0) {
//                String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString(); // Lấy tên file gốc
//                String applicationPath = request.getServletContext().getRealPath(""); // Đường dẫn tuyệt đối của ứng dụng web
//                String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;
//
//                File uploadDir = new File(uploadPath);
//                if (!uploadDir.exists()) {
//                    uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
//                }
//                
//                // Tạo tên file duy nhất bằng UUID để tránh trùng lặp
//                String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
//                String filePath = uploadPath + File.separator + uniqueFileName;
//
//                // Lưu file vào server
//                try (InputStream input = avatarPart.getInputStream()) {
//                    Files.copy(input, Paths.get(filePath));
//                }
//                
//                // Cập nhật đường dẫn avatar mới (đường dẫn tương đối)
//                newAvatarRelativePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
//                newAvatarRelativePath = newAvatarRelativePath.replace("\\", "/"); // Đảm bảo đường dẫn dùng / cho URL
//                
//                // Xóa ảnh cũ nếu có ảnh mới và ảnh cũ không phải là default-avatar
//                if (currentAvatarUrl != null && !currentAvatarUrl.isEmpty() && 
//                    !currentAvatarUrl.contains("default-avatar.png")) {
//                    File oldAvatarFile = new File(applicationPath + File.separator + currentAvatarUrl);
//                    if (oldAvatarFile.exists() && oldAvatarFile.isFile()) {
//                        if (oldAvatarFile.delete()) {
//                            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.INFO, "Old avatar deleted: " + oldAvatarFile.getAbsolutePath());
//                        } else {
//                            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.WARNING, "Failed to delete old avatar: " + oldAvatarFile.getAbsolutePath());
//                        }
//                    }
//                }
//            }
//
//            // Cập nhật thông tin của người dùng trong đối tượng currentUser (lấy từ session)
//            currentUser.setFirstName(firstName);
//            currentUser.setLastName(lastName);
//            currentUser.setPhoneNumber(phoneNumber);
//            currentUser.setGender(gender);
//            currentUser.setAddress(address);
//
//            // Chuyển đổi dobString sang LocalDate
//            if (dobString != null && !dobString.isEmpty()) {
//                currentUser.setDateOfBirth(LocalDate.parse(dobString));
//            } else {
//                currentUser.setDateOfBirth(null); // Nếu dobString rỗng, set null hoặc giữ nguyên giá trị cũ
//            }
//
//            // Cập nhật URL avatar nếu có file mới được upload
//            if (newAvatarRelativePath != null) {
//                currentUser.setAvatarUrl(newAvatarRelativePath);
//            }
//            // Nếu newAvatarRelativePath là null, tức là không có file mới, avatarUrl của currentUser sẽ giữ nguyên
//            // giá trị ban đầu của currentAvatarUrl.
//
//            // Gọi DAO để cập nhật người dùng vào database
//            boolean updateSuccess = userDAO.updateUserProfile(currentUser);
//
//            if (updateSuccess) {
//                message = "Profile updated successfully!";
//                messageType = "success";
//                // Cập nhật lại user trong session để thông tin hiển thị trên các trang khác cũng mới
//                session.setAttribute("loggedInUser", currentUser);
//            } else {
//                message = "Failed to update profile. Please try again.";
//                messageType = "error";
//            }
//
//        } catch (Exception ex) {
//            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error processing profile update", ex);
//            message = "An unexpected error occurred: " + ex.getMessage();
//            messageType = "error";
//        }
//        
//        // Set message và user (đã cập nhật) vào request để forward lại JSP
//        request.setAttribute("message", message);
//        request.setAttribute("messageType", messageType);
//        // Quan trọng: Truyền lại đối tượng user sau khi đã cập nhật để form hiển thị dữ liệu mới nhất
//        request.setAttribute("user", currentUser); 
//        request.getRequestDispatcher("users/editUserProfile.jsp").forward(request, response);
//    }
//}
package controller;

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

@WebServlet(name = "EditUserProfileServlet", urlPatterns = {"/profile/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,     // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class EditUserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "assets" + File.separator + "avatars";

    /**
     * Handles the HTTP GET method.
     * Displays the user profile edit form for user ID 20.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userIdToEdit = 10; 
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
     * Handles the HTTP POST method.
     * Processes the form submission for updating user ID 20.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userIdToUpdate = 10; // Cố định ID user sẽ được cập nhật
        UserDAO userDAO = new UserDAO();
        User userFromDb = null; // Đây sẽ là đối tượng user lấy từ DB có ID = 20

        try {
            userFromDb = userDAO.getUserById(userIdToUpdate);
        } catch (Exception e) {
            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error retrieving user " + userIdToUpdate + " for POST update", e);
            request.setAttribute("message", "Error finding user to update.");
            request.setAttribute("messageType", "error");
            // Forward lại với thông báo lỗi và không có user nào để hiển thị
            request.getRequestDispatcher("/users/editUserProfile.jsp").forward(request, response);
            return;
        }

        if (userFromDb == null) {
            request.setAttribute("message", "User with ID " + userIdToUpdate + " not found for update.");
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

                if (currentAvatarUrl != null && !currentAvatarUrl.isEmpty() &&
                    !currentAvatarUrl.contains("default-avatar.png")) {
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
                    if (loggedInUser != null && loggedInUser.getUserId() == userIdToUpdate) {
                        currentSession.setAttribute("loggedInUser", userFromDb); // Cập nhật session của user 20
                    }
                }
            } else {
                message = "Failed to update profile. Please try again.";
                messageType = "error";
            }

        } catch (Exception ex) {
            Logger.getLogger(EditUserProfileServlet.class.getName()).log(Level.SEVERE, "Error processing profile update for user ID " + userIdToUpdate, ex);
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