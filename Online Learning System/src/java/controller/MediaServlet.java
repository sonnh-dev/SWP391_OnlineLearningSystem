package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "MediaServlet", urlPatterns = {"/media/*"})
public class MediaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String basePath = new File(getServletContext()
        .getRealPath("/")).getParentFile().getParentFile().getParentFile()
        .toPath().resolve("MediaFeature").toAbsolutePath().toString();
        String path = request.getPathInfo();
        
        if (path == null || path.contains("..")) {
            response.sendError(400); return;
        }

        File file = new File(basePath, path);
        if (!file.exists() || file.isDirectory()) {
            response.sendError(404); return;
        }

        response.setContentType(getServletContext().getMimeType(file.getName()));
        response.setContentLengthLong(file.length());

        try (InputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            in.transferTo(out);
        }
    }
}
