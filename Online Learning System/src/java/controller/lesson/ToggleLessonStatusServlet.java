package servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.LessonDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

public class ToggleLessonStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            BufferedReader reader = request.getReader();
            Gson gson = new Gson();
            JsonObject json = gson.fromJson(reader, JsonObject.class);

            if (!json.has("type") || !json.has("id") || !json.has("status")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("message", "Missing required fields.");
                out.print(jsonResponse.toString());
                return;
            }

            String type = json.get("type").getAsString();    
            int id = json.get("id").getAsInt();
            String status = json.get("status").getAsString(); // "active" / "inactive"

            // ✅ Sử dụng status gửi từ client, không đảo ngược nữa
            String newStatus = status.equalsIgnoreCase("active") ? "active" : "inactive";

            boolean success = false;

            if ("lesson".equalsIgnoreCase(type)) {
                success = LessonDao.updateLessonStatus(id, newStatus);
            } else if ("quiz".equalsIgnoreCase(type)) {
                success = LessonDao.updateQuizStatus(id, newStatus);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.addProperty("message", "Invalid type provided.");
                out.print(jsonResponse.toString());
                return;
            }

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.addProperty("message", "Status updated successfully.");
                jsonResponse.addProperty("newStatus", newStatus);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.addProperty("message", "Failed to update status.");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.addProperty("message", "Server error: " + e.getMessage());
            e.printStackTrace();
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
}
