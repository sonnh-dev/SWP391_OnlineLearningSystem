package controller;

import java.util.HashMap;
import java.util.Map;
import dao.AccountDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.regex.Pattern;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;


@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {
    // Map lưu số lần đăng nhập sai theo email
    private Map<String, Integer> failedAttempts = new HashMap<>();
    // Map lưu thời gian khóa tài khoản tạm thời
    private Map<String, Long> lockoutTime = new HashMap<>();

    // Thời gian khóa khi sai 5 lần: 30 giây
    private static final int LOCK_TIME_5_ATTEMPTS = 30 * 1000;
    // Thời gian khóa khi sai 10 lần: 5 phút
    private static final int LOCK_TIME_10_ATTEMPTS = 5 * 60 * 1000;

    // Logger dùng để ghi log khi có lỗi xảy ra
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    // Xử lý khi truy cập GET, hiển thị trang login
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Xử lý yêu cầu POST (người dùng gửi form đăng nhập)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Kiểm tra input trống
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Email và mật khẩu không được để trống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng email
        if (!isValidEmail(email)) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng email!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra nếu tài khoản đang bị khóa tạm thời
        if (lockoutTime.containsKey(email)) {
            long unlockTime = lockoutTime.get(email);
            long now = System.currentTimeMillis();

            if (now < unlockTime) {
                // Nếu chưa hết thời gian khóa, báo lại cho người dùng
                long remainingSeconds = (unlockTime - now) / 1000;
                request.setAttribute("error", "Tài khoản bị khóa. Vui lòng thử lại sau " + remainingSeconds + " giây.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } else {
                // Nếu hết thời gian khóa → xóa khóa (giữ nguyên số lần sai)
                lockoutTime.remove(email);
            }
        }

        try {
            // Kiểm tra tài khoản trong database
            Account account = AccountDao.getAccountByEmailAndPassword(email, password);

            if (account == null) {
                // Nếu sai tài khoản/mật khẩu → tăng số lần sai
                int attempts = failedAttempts.getOrDefault(email, 0) + 1;
                failedAttempts.put(email, attempts);    

                // Áp dụng hình phạt tương ứng
                if (attempts == 5) {
                    lockoutTime.put(email, System.currentTimeMillis() + LOCK_TIME_5_ATTEMPTS);
                    request.setAttribute("error", "Sai 5 lần. Tài khoản bị khóa 30 giây.");
                } else if (attempts >= 10) {
                    lockoutTime.put(email, System.currentTimeMillis() + LOCK_TIME_10_ATTEMPTS);
                    request.setAttribute("error", "Sai 10 lần. Tài khoản bị khóa 5 phút.");
                } else {
                    request.setAttribute("error", "Email hoặc mật khẩu không đúng! Số lần sai: " + attempts + ".");
                }

                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Nếu đúng thông tin đăng nhập → reset đếm và mở khóa
                failedAttempts.remove(email);
                lockoutTime.remove(email);

                // Tạo session cho người dùng đăng nhập
                HttpSession session = request.getSession();
                session.setAttribute("user", account);
                session.setAttribute("userEmail", email);

                // Chuyển hướng đến trang chủ sau đăng nhập
                response.sendRedirect("/Online_Learning_System/home");
            }

        } catch (Exception e) {
            // Ghi log nếu có lỗi trong quá trình xử lý
            LOGGER.log(Level.SEVERE, "Lỗi khi đăng nhập với email: " + email, e);
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Hàm kiểm tra định dạng email
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return email != null && pattern.matcher(email).matches();
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập người dùng";
    }
}
