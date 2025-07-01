package dao;

/**
 *
 * @author sonpk
 */
import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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

    public List<UserCourse> getUserCoursesByUserID(int userID) {
        List<UserCourse> userCourses = new ArrayList<>();
        String sql = "SELECT * FROM UserCourse WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserCourse userCourse = new UserCourse();
                userCourse.setUserID(rs.getInt("UserID"));
                userCourse.setCourseID(rs.getInt("CourseID"));
                userCourse.setPackageID(rs.getInt("PackageID"));
                userCourse.setProgress(rs.getDouble("Progress"));
                userCourse.setStatus(rs.getString("Status"));
                userCourse.setValidFrom(rs.getString("ValidFrom"));
                userCourse.setValidTo(rs.getString("ValidTo"));
                userCourses.add(userCourse);
            }
        } catch (SQLException e) {
        }
        return userCourses;
    }
}
