package dao;

/**
 *
 * @author sonpk
 */
import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.course.UserCourse;

public class UserCourseDao extends DBContext {

    public void addUserCourse(UserCourse userCourse) {
        String sql = "INSERT INTO UserCourse (UserID, CourseID, PackageID,  Progress, Status, ValidFrom, ValidTo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userCourse.getUserID());
            ps.setInt(2, userCourse.getCourseID());
            ps.setInt(3, userCourse.getPackageID());
            ps.setDouble(4, userCourse.getProgress());
            ps.setString(5, userCourse.getStatus());
            ps.setString(6, userCourse.getValidFrom());
            ps.setString(7, userCourse.getValidTo());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
