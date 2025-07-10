package controller.auth;

import java.util.HashMap;
import java.util.Map;
import dao.AccountDao;
import dao.UserDao1;
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
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    private Map<String, Integer> failedAttempts = new HashMap<>();
    private Map<String, Long> lockoutTime = new HashMap<>();

    private static final int LOCK_TIME_5_ATTEMPTS = 30 * 1000;
    private static final int LOCK_TIME_10_ATTEMPTS = 5 * 60 * 1000;
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Email và mật khẩu không được để trống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!isValidEmail(email)) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng email!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (lockoutTime.containsKey(email)) {
            long unlockTime = lockoutTime.get(email);
            long now = System.currentTimeMillis();

            if (now < unlockTime) {
                long remainingSeconds = (unlockTime - now) / 1000;
                request.setAttribute("error", "Tài khoản bị khóa. Vui lòng thử lại sau " + remainingSeconds + " giây.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } else {
                lockoutTime.remove(email);
            }
        }

        try {
            Account account = AccountDao.getAccountByEmailAndPassword(email, password);

            if (account == null) {
                int attempts = failedAttempts.getOrDefault(email, 0) + 1;
                failedAttempts.put(email, attempts);

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
                failedAttempts.remove(email);
                lockoutTime.remove(email);

                // ✅ Lấy User từ UserDao
                UserDao1 userDao = new UserDao1();
                User user = userDao.getUserById(account.getId());

                HttpSession session = request.getSession();
                session.setAttribute("account", account); // lưu Account riêng
                session.setAttribute("user", user);        // lưu User riêng
                session.setAttribute("userEmail", email);
                session.setAttribute("userID", account.getId());

                response.sendRedirect("home");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đăng nhập với email: " + email, e);
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

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
