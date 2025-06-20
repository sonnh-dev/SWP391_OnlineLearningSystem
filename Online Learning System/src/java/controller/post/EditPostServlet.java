/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.post;

import dao.PostDao1;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.nio.charset.StandardCharsets;

import java.util.List;

import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.jakarta.JakartaServletFileUpload;
import org.apache.commons.fileupload2.jakarta.JakartaServletRequestContext;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 50 * 1024 * 1024,
    maxRequestSize = 100 * 1024 * 1024
)
public class EditPostServlet extends HttpServlet {
    private final String UPLOAD_DIR = "uploads"; 
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
        response.setCharacterEncoding("UTF-8");

        if (!JakartaServletFileUpload.isMultipartContent(request)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Form must have enctype=multipart/form-data.");
            return;
        }

        final String UPLOAD_DIRECTORY = "uploads/posts"; // Change if needed
        DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
        JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);

        int postID = 0;
        String title = "", category = "", briefInfo = "", description = "", postInfo = "";
        String thumbnailURL = "";
        boolean featured = false;
        String image1URL = "", image2URL = "", video1URL = "", video2URL = "";
        String status = "";

        try {
            JakartaServletRequestContext ctx = new JakartaServletRequestContext(request);
            List<FileItem> formItems = upload.parseRequest(ctx);

            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString(StandardCharsets.UTF_8);

                    switch (fieldName) {
                        case "postID":
                            postID = Integer.parseInt(fieldValue);
                            break;
                        case "title":
                            title = fieldValue;
                            break;
                        case "category":
                            category = fieldValue;
                            break;
                        case "briefInfo":
                            briefInfo = fieldValue;
                            break;
                        case "description":
                            description = fieldValue;
                            break;
                        case "postinfo":
                            postInfo = fieldValue;
                            break;
                        case "status":
                            status = fieldValue;
                            break;
                        case "featured":
                            featured = true;
                            break;
                    }
                } else {
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        String appPath = request.getServletContext().getRealPath("");
                        String uploadPath = appPath + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs();

                        String savedName = System.currentTimeMillis() + "_" + new File(fileName).getName();
                        String filePath = uploadPath + File.separator + savedName;
                        item.write(new File(filePath).toPath()); // ✅ đúng với phiên bản 2.x

                        String relativePath = UPLOAD_DIRECTORY + "/" + savedName;
                        String field = item.getFieldName();
                        switch (field) {
                            case "thumbnail": thumbnailURL = relativePath; break;
                            case "image1": image1URL = relativePath; break;
                            case "image2": image2URL = relativePath; break;
                            case "video1": video1URL = relativePath; break;
                            case "video2": video2URL = relativePath; break;
                        }
                    }
                }
            }

            if (postID <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID.");
                return;
            }

            PostDao1 dao = new PostDao1();
            dao.updatePost(postID, title, category, briefInfo, description, postInfo, thumbnailURL, image1URL, image2URL, video1URL, video2URL, status, featured);

           response.sendRedirect("postDetail?id=" + postID); // Or redirect back to list

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating post: " + e.getMessage());
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
