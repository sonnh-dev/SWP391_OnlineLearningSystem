package auth.controller;

import auth.reponsitory.AccountDao;
import auth.reponsitory.EmailSender;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import model.TokenStorage;

public class VerifyEmailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyEmailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyEmailServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private String generateTemporaryPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        // Xóa token hết hạn
        TokenStorage.cleanUpExpiredTokens();

        String token = request.getParameter("token");
        TokenStorage.TokenEntry entry = TokenStorage.tokenMap.get(token);

        String message;

        if (entry != null) {
            long currentTime = System.currentTimeMillis();
            long age = currentTime - entry.createdAt;

            if (age <= 10 * 60 * 1000) { // Trong 10 phút
                try {
                    // Tạo mật khẩu tạm thời
                    String tempPassword = generateTemporaryPassword(10);

                    AccountDao dao = new AccountDao();
                    boolean success;

                    //  Kiểm tra email đã tồn tại
                    if (dao.emailExists(entry.email)) {
                        success = dao.updatePassword(entry.email, tempPassword);
                    } else {
                        // Chèn tài khoản mới
                       success = dao.insertUser(entry.fullName, entry.gender, entry.email, entry.mobile, tempPassword);

                        success = true;
                    }

                    if (success) {
    // Send email with temporary password
    String subject = "Your Temporary Password";
    String content = "Hello,\n\n"
            + "Your account has been successfully verified.\n"
            + "Here is your temporary password:\n\n"
            + tempPassword + "\n\n"
            + "Please log in and change your password immediately to ensure your security.\n\n"
            + "Best regards.";

    EmailSender.sendEmail(entry.email, subject, content);
    message = "Email " + entry.email + " has been verified. A temporary password has been sent to your email.";
} else {
    message = "Unable to update password. Please try again.";
}

} catch (Exception e) {
    message = "An error occurred during verification: " + e.getMessage();
    e.printStackTrace();
}

// Remove token after verification
TokenStorage.tokenMap.remove(token);

} else {
    message = "The verification link has expired. Please register again.";
    TokenStorage.tokenMap.remove(token);
}
} else {
    message = "Invalid or expired verification link.";
}

request.setAttribute("message", message);
RequestDispatcher rd = request.getRequestDispatcher("verify.jsp");
rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Verify email, update password or create new account.";
    }
}
