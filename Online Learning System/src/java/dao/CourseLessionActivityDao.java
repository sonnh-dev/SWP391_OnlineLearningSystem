package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author sonpk
 */
public class CourseLessionActivityDao extends DBContext {

    public int getProcessByUserAndCourse(int userID, int courseID) {
        String sql = "SELECT COUNT(*) FROM CourseLessionActivity WHERE UserID = ? AND CourseID = ? AND IsCompleted = true";
        int completedCount = 0;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                completedCount = rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return completedCount;
    }

    public void updateProgressForUserCourse(int userID, int courseID) {
        String countCompletedSql = "SELECT COUNT(*) FROM CourseLessionActivity WHERE UserID = ? AND CourseID = ? AND IsCompleted = 1";
        String countTotalSql = "SELECT COUNT(*) FROM Lesson l JOIN Chapter c ON l.ChapterID = c.ChapterID WHERE c.CourseID = ?";
        String updateSql = "UPDATE UserCourse SET Progress = ? WHERE UserID = ? AND CourseID = ?";

        int completed = 0;
        int total = 0;

        try (
            PreparedStatement ps1 = connection.prepareStatement(countCompletedSql);
            PreparedStatement ps2 = connection.prepareStatement(countTotalSql);
            PreparedStatement ps3 = connection.prepareStatement(updateSql)) {
            ps1.setInt(1, userID);
            ps1.setInt(2, courseID);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                completed = rs1.getInt(1);
            }
            ps2.setInt(1, courseID);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                total = rs2.getInt(1);
            }
            double progress = 0;
            if (total > 0) {
                progress = ((double) completed / total) * 100.0;
            }
            ps3.setDouble(1, progress);
            ps3.setInt(2, userID);
            ps3.setInt(3, courseID);
            ps3.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
