package dao;

import context.context2;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class LessonStatusDao extends context2 {

    public void updateLessonStatus(int lessonId, boolean newStatus) throws Exception {
        String sql = "UPDATE Lesson SET Status = ? WHERE LessonID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, newStatus);
            ps.setInt(2, lessonId);
            ps.executeUpdate();
        }
    }
}
