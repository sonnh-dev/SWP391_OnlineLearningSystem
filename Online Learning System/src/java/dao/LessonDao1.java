package dao;

import context.context2;
import java.sql.*;
import model.Lesson;

public class LessonDao1 {

    public int insertLesson(Lesson lesson) {
        String sql = "INSERT INTO Lesson (ChapterID, Title, IsFree, LessonOrder, Status) OUTPUT INSERTED.LessonID VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lesson.getChapterID());
            ps.setString(2, lesson.getTitle());
            ps.setBoolean(3, lesson.isIsFree());
            ps.setInt(4, lesson.getLessonOrder());
            ps.setBoolean(5, lesson.getStatus());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static Lesson getById(int lessonId) {
        String sql = "SELECT * FROM Lesson WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonID(rs.getInt("LessonID"));
                lesson.setChapterID(rs.getInt("ChapterID"));
                lesson.setTitle(rs.getString("Title"));
                lesson.setIsFree(rs.getBoolean("IsFree"));
                lesson.setLessonOrder(rs.getInt("LessonOrder"));
                lesson.setStatus(rs.getBoolean("Status"));
                return lesson;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateLesson(Lesson lesson) {
        String sql = "UPDATE Lesson SET ChapterID = ?, Title = ?, IsFree = ?, LessonOrder = ?, Status = ? WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lesson.getChapterID());
            ps.setString(2, lesson.getTitle());
            ps.setBoolean(3, lesson.isIsFree());
            ps.setInt(4, lesson.getLessonOrder());
            ps.setBoolean(5, lesson.getStatus());
            ps.setInt(6, lesson.getLessonID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteLesson(int lessonId) {
        String sql = "DELETE FROM Lesson WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

 public void updateLessonStatus(int lessonId, int status) throws Exception {
        String sql = "UPDATE Lesson SET Status = ? WHERE LessonID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status); // Trạng thái mới (0 hoặc 1)
            ps.setInt(2, lessonId); // ID của bài học
            ps.executeUpdate();
        }
    }
    }

