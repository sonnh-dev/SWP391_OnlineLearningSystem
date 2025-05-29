package controller; 

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UserListServlet", urlPatterns = {"/admin/users"})
public class UserListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            
            UserDAO userDAO = new UserDAO();
            
            // 1. Lấy và xử lý các tham số phân trang
            int pageIndex = 1; // Giá trị mặc định
            int pageSize = 10; // Kích thước trang mặc định của bạn
            
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    pageIndex = Integer.parseInt(pageParam);
                    if (pageIndex < 1) {
                        pageIndex = 1;
                    }
                } catch (NumberFormatException e) {
                    Logger.getLogger(UserListServlet.class.getName()).log(Level.WARNING, "Invalid page parameter: " + pageParam, e);
                    pageIndex = 1;
                }
            }
            
            // 2. Lấy và xử lý các tham số lọc/tìm kiếm/sắp xếp
            String genderFilter = request.getParameter("genderFilter");
            String roleFilter = request.getParameter("roleFilter");
            String statusFilter = request.getParameter("statusFilter");
            String searchKeyword = request.getParameter("search");
            String searchBy = request.getParameter("searchBy");
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            
            // Đặt giá trị mặc định nếu null để JSP không bị lỗi khi hiển thị lần đầu
            if (genderFilter == null) genderFilter = "all";
            if (roleFilter == null) roleFilter = "all";
            if (statusFilter == null) statusFilter = "all"; // "true", "false", "all"
            if (searchKeyword == null) searchKeyword = "";
            if (searchBy == null) searchBy = "fullName"; // Mặc định tìm kiếm theo tên đầy đủ
            if (sortBy == null) sortBy = "userId"; // Mặc định sắp xếp theo ID
            if (sortOrder == null) sortOrder = "asc"; // Mặc định sắp xếp tăng dần
            
            
            // 3. Lấy tổng số người dùng và tính tổng số trang
            // Đây là nơi gọi UserDAO để lấy dữ liệu. Đảm bảo UserDAO.getTotalUsers() hoạt động đúng.
            int totalUsers = userDAO.getTotalUsers(genderFilter, roleFilter, statusFilter, searchKeyword, searchBy);
            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
            
            // Điều chỉnh pageIndex nếu nó vượt quá tổng số trang hợp lệ
            if (pageIndex > totalPages && totalPages > 0) {
                pageIndex = totalPages;
            } else if (totalPages == 0) { // Nếu không có người dùng nào, vẫn đảm bảo có ít nhất 1 trang (trang trống)
                totalPages = 1;
            }
            
            // 4. Lấy danh sách người dùng đã được phân trang
            // Đây là nơi gọi UserDAO để lấy danh sách người dùng cho trang hiện tại.
            List<User> users = userDAO.getPaginatedUsers(
                    genderFilter, roleFilter, statusFilter,
                    searchKeyword, searchBy,
                    sortBy, sortOrder,
                    pageIndex, pageSize
            );
            
            // 5. **CÁC DÒNG NÀY LÀ CỰC KỲ QUAN TRỌNG ĐỂ KHẮC PHỤC LỖI CỦA BẠN**
            //    Đảm bảo chúng CÓ TỒN TẠI, ĐÚNG CHÍNH TẢ và được THỰC THI.
            request.setAttribute("users", users);
            request.setAttribute("currentPage", pageIndex); // <-- Đảm bảo dòng này có
            request.setAttribute("totalPages", totalPages); // <-- Đảm bảo dòng này có
            request.setAttribute("totalUsers", totalUsers); // Tùy chọn, nhưng hữu ích để hiển thị tổng số người dùng
            
            // Truyền lại các tham số lọc/tìm kiếm/sắp xếp để duy trì trạng thái của form trên JSP
            request.setAttribute("genderFilter", genderFilter);
            request.setAttribute("roleFilter", roleFilter);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("searchBy", searchBy);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            
            // 6. Chuyển tiếp request sang JSP
            request.getRequestDispatcher("/users/userList.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserListServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}