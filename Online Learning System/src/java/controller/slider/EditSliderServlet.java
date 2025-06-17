/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.slider;


import dao.SliderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.jakarta.JakartaServletFileUpload;
import org.apache.commons.fileupload2.jakarta.JakartaServletRequestContext;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class EditSliderServlet extends HttpServlet {
   
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
            out.println("<title>Servlet EditSliderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditSliderServlet at " + request.getContextPath () + "</h1>");
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

        final String UPLOAD_DIRECTORY = "images/sliders";
         DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
        JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);

        int sliderID = 0;
        String sliderTitle = "";
        String sliderContent = "";
        String sliderURL = "";
        int status = 0;
        String newImageFileName = null;

        try {
            JakartaServletRequestContext ctx = new JakartaServletRequestContext(request);
            List<FileItem> formItems = upload.parseRequest(ctx);

            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString(StandardCharsets.UTF_8);

                    switch (fieldName) {
                        case "sliderID":
                            sliderID = Integer.parseInt(fieldValue);
                            break;
                        case "sliderTitle":
                            sliderTitle = fieldValue;
                            break;
                        case "sliderContent":
                            sliderContent = fieldValue;
                            break;
                        case "sliderURL":
                            sliderURL = fieldValue;
                            break;
                        case "status":
                            status = Integer.parseInt(fieldValue);
                            break;
                    }
                } else {
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        String applicationPath = request.getServletContext().getRealPath("");
                        String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;

                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        newImageFileName = System.currentTimeMillis() + "_" + new File(fileName).getName();
                        String filePath = uploadPath + File.separator + newImageFileName;
                        File storeFile = new File(filePath);

                        item.write(storeFile.toPath());
                        sliderURL = UPLOAD_DIRECTORY + "/" + newImageFileName;
                    }
                }
            }

            if (sliderID <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid slider ID.");
                return;
            }

            SliderDao sliderDAO = new SliderDao();
            sliderDAO.updateSlider(sliderID, sliderTitle, sliderContent, sliderURL, status);

            HttpSession session = request.getSession();
            String searchKeyword = (String) session.getAttribute("lastSearchKeyword");
            String searchStatus = (String) session.getAttribute("lastSearchStatus");

            String redirectURL = "slider-list";
            boolean firstParam = true;

            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                redirectURL += "?search=" + URLEncoder.encode(searchKeyword, StandardCharsets.UTF_8.name());
                firstParam = false;
            }
            if (searchStatus != null && !searchStatus.isEmpty()) {
                redirectURL += (firstParam ? "?" : "&") + "status=" + searchStatus;
            }

            response.sendRedirect(redirectURL);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing slider update: " + e.getMessage());
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
