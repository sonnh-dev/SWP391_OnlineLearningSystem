package controller.blog;

import dal.BlogDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import model.Blog;

@WebServlet(name = "BlogDetail", urlPatterns = {"/BlogDetail"})
public class BlogDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogID = Integer.parseInt(request.getParameter("blogID"));
        BlogDao blogDao = new BlogDao();
        Blog blog = blogDao.getBlogByID(blogID);
        List<Blog> latestBlogs = blogDao.get5LatestPost();
        Map<String, Integer> map = blogDao.getCategory();
        String content = blogDao.getContentByBlogID(blogID);
        blogDao.increaseView(blogID);
        request.setAttribute("blogDetail", blog);
        request.setAttribute("categoryMap", map);
        request.setAttribute("content", content);
        request.setAttribute("latestBlogs", latestBlogs);
        request.getRequestDispatcher("blogDetails.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
