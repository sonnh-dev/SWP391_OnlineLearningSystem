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
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.Post1;

/**
 *
 * @author ADMIN
 */
public class EditPostServlet extends HttpServlet {
   
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
            out.println("<title>Servlet EditPostServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditPostServlet at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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

        request.setCharacterEncoding("UTF-8");

        int postID = Integer.parseInt(request.getParameter("postID"));
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String briefInfo = request.getParameter("briefInfo");
        String description = request.getParameter("description");
        String postInfo = request.getParameter("postinfo");
        String status = request.getParameter("status");
        boolean featured = request.getParameter("featured") != null;

        PostDao1 dao = new PostDao1();

        Post1 post = new Post1();
        post.setPostID(postID);
        post.setTitle(title);
        post.setCategory(category);
        post.setBriefInfo(briefInfo);
        post.setDescription(description);
        post.setPostinfo(postInfo);
        post.setStatus(status);
        post.setIsFeatured(featured);

        // Đường dẫn lưu thật trên máy chủ
        String appPath = request.getServletContext().getRealPath("");

        // Tải lên các file và lưu đúng thư mục
        String thumbnail = uploadFile(request.getPart("thumbnail"), appPath, "images/post");
        String image1 = uploadFile(request.getPart("image1"), appPath, "images/post");
        String image2 = uploadFile(request.getPart("image2"), appPath, "images/post");
        String video1 = uploadFile(request.getPart("video1"), appPath, "videos");
        String video2 = uploadFile(request.getPart("video2"), appPath, "videos");

        // Gọi DAO để cập nhật các phần tương ứng nếu có file mới
        if (thumbnail != null) dao.updateThumbnail(postID, thumbnail);
        if (image1 != null) dao.updateImage(postID, 1, image1);
        if (image2 != null) dao.updateImage(postID, 2, image2);
        if (video1 != null) dao.updateVideo(postID, 1, video1);
        if (video2 != null) dao.updateVideo(postID, 2, video2);

        dao.updatePost(post);

        response.sendRedirect("postDetail.jsp?postID=" + postID);
    }

    private String uploadFile(Part part, String appPath, String folderPath) throws IOException {
        if (part != null && part.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String fullPath = appPath + File.separator + folderPath + File.separator + fileName;
            part.write(fullPath);

            // Trả về đường dẫn tương đối để lưu vào DB (ví dụ: images/post/xxx.png)
            return folderPath + "/" + fileName;
        }
        return null;
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
