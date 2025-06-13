/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.blog;

import dao.PostDao;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;

@WebServlet(name = "BlogList", urlPatterns = {"/blogList"})
public class BlogListServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    final int pageSize = 5;
    int pageIndex = 1;

    // Lấy chỉ số trang từ request
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        try {
            pageIndex = Integer.parseInt(pageParam);
            if (pageIndex < 1) pageIndex = 1;
        } catch (NumberFormatException e) {
            pageIndex = 1;
        }
    }

    // Lấy category và keyword tìm kiếm từ request
    String category = request.getParameter("category");
    if (category == null || category.trim().isEmpty()) {
        category = "all"; // Mặc định nếu không chọn category
    }

    String keyword = request.getParameter("search");

    PostDao dao = new PostDao();
    List<Blog> posts;
    int totalPosts = 0;

    // Xử lý tìm kiếm
    if (keyword != null && !keyword.trim().isEmpty()) {
        totalPosts = dao.countPostsBySearch(keyword);
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        pageIndex = Math.min(pageIndex, totalPages);

        int offset = (pageIndex - 1) * pageSize;
        posts = dao.getPostsBySearch(offset, pageSize, keyword);

        request.setAttribute("search", keyword);
        request.setAttribute("category", "all"); // reset category khi tìm kiếm
        request.setAttribute("totalPages", totalPages);
    } else {
        // Xử lý lọc theo category
        totalPosts = dao.countPostsByCategory(category);
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        pageIndex = Math.min(pageIndex, totalPages);

        int offset = (pageIndex - 1) * pageSize;
        posts = dao.getPostsByPageAndCategory(offset, pageSize, category);

        request.setAttribute("category", category);
        request.setAttribute("search", null); // reset từ khóa khi lọc theo category
        request.setAttribute("totalPages", totalPages);
    }

    // Bài viết mới nhất (sidebar)
    List<Blog> latestPosts = dao.getLatestPosts(3);

    // Gửi dữ liệu sang JSP
    request.setAttribute("posts", posts);
    request.setAttribute("currentPage", pageIndex);
    request.setAttribute("latestPosts", latestPosts);

    RequestDispatcher dispatcher = request.getRequestDispatcher("blogList.jsp");
    dispatcher.forward(request, response);
}



    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
