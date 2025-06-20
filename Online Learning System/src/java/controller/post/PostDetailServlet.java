/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.post;

import dao.PostDao1;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post1;
import model.PostImage;
import model.PostVideo;

/**
 *
 * @author ADMIN
 */
public class PostDetailServlet extends HttpServlet {
   
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
            out.println("<title>Servlet PostDetailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostDetailServlet at " + request.getContextPath () + "</h1>");
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

    int postId = 1; // default ID
    String idParam = request.getParameter("id");
    if (idParam != null) {
        try {
            postId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
            return;
        }
    }

    PostDao1 dao = new PostDao1();
    Post1 post = dao.getPost(postId);
    if (post == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found with ID: " + postId);
        return;
    }

    List<PostImage> images = dao.getImages(postId);
    List<PostVideo> videos = dao.getVideos(postId);

    request.setAttribute("post", post);
    request.setAttribute("images", images);
    request.setAttribute("videos", videos);

    request.getRequestDispatcher("postDetail.jsp").forward(request, response);
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

    String postIdParam = request.getParameter("postID");
    String featuredParam = request.getParameter("featured");

    if (postIdParam == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing post ID");
        return;
    }

    try {
        int postId = Integer.parseInt(postIdParam);
        boolean isFeatured = featuredParam != null;

        PostDao1 dao = new PostDao1();
        dao.updateFeatured(postId, isFeatured); // You'll define this in DAO

        // Redirect back to view post after update
        response.sendRedirect("PostDetailServlet?id=" + postId);

    } catch (NumberFormatException e) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
    }
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
