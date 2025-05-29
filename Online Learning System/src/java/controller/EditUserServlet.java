// File: src/main/java/com/yourcompany/yourproject/controller/EditUserServlet.java
package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

@WebServlet(name = "EditUserServlet", urlPatterns = {"/admin/editUser"})
public class EditUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = 0;
            try {
                userId = Integer.parseInt(request.getParameter("userId"));
            } catch (NumberFormatException e) {
                response.sendRedirect("users");
                return;
            }
            
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/users/editUser.jsp").forward(request, response);
            } else {
                response.sendRedirect("users?error=User not found for editing.");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận tiếng Việt
            
            int userId = 0;
            try {
                userId = Integer.parseInt(request.getParameter("userId"));
            } catch (NumberFormatException e) {
                response.sendRedirect("users?error=Invalid User ID.");
                return;
            }
            
            // Theo yêu cầu: "The admin can only edit/update the role and status of the user"
            String role = request.getParameter("role");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateRoleAndStatus(userId, role, status);
            
            if (success) {
                response.sendRedirect("userDetails?userId=" + userId + "&message=User role/status updated successfully.");
            } else {
                User user = userDAO.getUserById(userId); // Lấy lại user để hiển thị lại form
                request.setAttribute("user", user);
                request.setAttribute("errorMessage", "Failed to update user role/status.");
                request.getRequestDispatcher("/users/editUser.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}