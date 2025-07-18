package dao;

import context.context2;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Chapter;

public class ChapterDao1 {

    public boolean insertChapter(Chapter chapter) {
        String sql = "INSERT INTO Chapter (CourseID, Title, ChapterOrder, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, chapter.getCourseID());
            ps.setString(2, chapter.getTitle());
            ps.setInt(3, chapter.getChapterOrder());
            ps.setBoolean(4, chapter.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Chapter> getChaptersByCourseId(int courseId) {
        List<Chapter> chapters = new ArrayList<>();
        String sql = "SELECT * FROM Chapter WHERE CourseID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setChapterID(rs.getInt("ChapterID"));
                chapter.setCourseID(rs.getInt("CourseID"));
                chapter.setTitle(rs.getString("Title"));
                chapter.setChapterOrder(rs.getInt("ChapterOrder"));
                chapter.setStatus(rs.getBoolean("Status"));
                chapters.add(chapter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return chapters;
    }

    public static Chapter getById(int chapterId) {
        String sql = "SELECT * FROM Chapter WHERE ChapterID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, chapterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setChapterID(rs.getInt("ChapterID"));
                chapter.setCourseID(rs.getInt("CourseID"));
                chapter.setTitle(rs.getString("Title"));
                chapter.setChapterOrder(rs.getInt("ChapterOrder"));
                chapter.setStatus(rs.getBoolean("Status"));
                return chapter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateChapter(Chapter chapter) {
        String sql = "UPDATE Chapter SET CourseID = ?, Title = ?, ChapterOrder = ?, Status = ? WHERE ChapterID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, chapter.getCourseID());
            ps.setString(2, chapter.getTitle());
            ps.setInt(3, chapter.getChapterOrder());
            ps.setBoolean(4, chapter.getStatus());
            ps.setInt(5, chapter.getChapterID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateChapterStatus(int chapterId, boolean newStatus) {
        String sql = "UPDATE Chapter SET Status = ? WHERE ChapterID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, newStatus);
            ps.setInt(2, chapterId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteChapter(int chapterId) {
        String sql = "DELETE FROM Chapter WHERE ChapterID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, chapterId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
