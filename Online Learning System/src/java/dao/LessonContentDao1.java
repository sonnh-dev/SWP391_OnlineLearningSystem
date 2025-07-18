package dao;

import context.context2;
import java.sql.*;
import model.LessonContent;

public class LessonContentDao1 {

    public boolean insertLessonContent(LessonContent content) {
        String sql = "INSERT INTO LessonContent (LessonID, DocContent, VideoURL) VALUES (?, ?, ?)";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, content.getLessonID());
            ps.setString(2, content.getDocContent());
            ps.setString(3, content.getVideoURL());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static LessonContent getByLessonId(int lessonId) {
        String sql = "SELECT * FROM LessonContent WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LessonContent content = new LessonContent();
                content.setLessonID(rs.getInt("LessonID"));
                content.setDocContent(rs.getString("DocContent"));
                content.setVideoURL(rs.getString("VideoURL"));
                return content;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateLessonContent(LessonContent content) {
        String sql = "UPDATE LessonContent SET DocContent = ?, VideoURL = ? WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, content.getDocContent());
            ps.setString(2, content.getVideoURL());
            ps.setInt(3, content.getLessonID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteByLessonId(int lessonId) {
        String sql = "DELETE FROM LessonContent WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
