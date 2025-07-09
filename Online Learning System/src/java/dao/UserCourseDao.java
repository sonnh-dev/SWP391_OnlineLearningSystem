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
        String sql = "INSERT INTO UserCourse (UserID, CourseID, PackageName, Price,  Progress, Status, ValidFrom, ValidTo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userCourse.getUserID());
            ps.setInt(2, userCourse.getCourseID());
            ps.setString(3, userCourse.getPkgName());
            ps.setDouble(4, userCourse.getPrice());
            ps.setDouble(5, userCourse.getProgress());
            ps.setString(6, userCourse.getStatus());
            ps.setString(7, userCourse.getValidFrom());
            ps.setString(8, userCourse.getValidTo());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public boolean updateUserCourse(UserCourse userCourse) {
        String sql = "UPDATE UserCourse SET PackageName = ?, Price = ?, Progress = ?, Status = ?, ValidFrom = ?, ValidTo = ? "
                + "WHERE UserID = ? AND CourseID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userCourse.getPkgName());
            ps.setDouble(2, userCourse.getPrice());
            ps.setDouble(3, userCourse.getProgress());
            ps.setString(4, userCourse.getStatus());
            ps.setString(5, userCourse.getValidFrom());
            ps.setString(6, userCourse.getValidTo());
            ps.setInt(7, userCourse.getUserID());
            ps.setInt(8, userCourse.getCourseID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public List<UserCourse> getUserCoursesByUserID(int userID) {
        List<UserCourse> userCourses = new ArrayList<>();
        String sql = "SELECT uc.*, c.Title FROM UserCourse uc JOIN Course c ON uc.CourseID = c.CourseID WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserCourse userCourse = new UserCourse();
                userCourse.setUserID(rs.getInt("UserID"));
                userCourse.setCourseID(rs.getInt("CourseID"));
                userCourse.setPkgName(rs.getString("PackageName"));
                userCourse.setPrice(rs.getDouble("Price"));
                userCourse.setEnrollDate(rs.getDate("EnrollDate"));
                userCourse.setProgress(rs.getDouble("Progress"));
                userCourse.setStatus(rs.getString("Status"));
                userCourse.setValidFrom(rs.getString("ValidFrom"));
                userCourse.setValidTo(rs.getString("ValidTo"));
                userCourse.setTitle(rs.getString("Title"));
                userCourses.add(userCourse);
            }
        } catch (SQLException e) {
        }
        return userCourses;
    }

    public UserCourse getUserCourse(int userID, int CourseID) {
        String sql = "SELECT uc.*, c.Title FROM UserCourse uc JOIN Course c ON uc.CourseID = c.CourseID WHERE uc.UserID = ? AND uc.CourseID = ?";
        
        UserCourse userCourse = new UserCourse();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, CourseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                userCourse.setUserID(rs.getInt("UserID"));
                userCourse.setCourseID(rs.getInt("CourseID"));
                userCourse.setPkgName(rs.getString("PackageName"));
                userCourse.setPrice(rs.getDouble("Price"));
                userCourse.setEnrollDate(rs.getDate("EnrollDate"));
                userCourse.setProgress(rs.getDouble("Progress"));
                userCourse.setStatus(rs.getString("Status"));
                userCourse.setValidFrom(rs.getString("ValidFrom"));
                userCourse.setValidTo(rs.getString("ValidTo"));
                userCourse.setTitle(rs.getString("Title"));
            }
        } catch (SQLException e) {
        }
        return userCourse;
    }

    public List<UserCourse> getUserCoursesByUserIDPayed(int userID) {
        List<UserCourse> userCourses = new ArrayList<>();
        String sql = "SELECT * FROM UserCourse WHERE UserID = ? AND Status = 'SUCCESS' ";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserCourse userCourse = new UserCourse();
                userCourse.setUserID(rs.getInt("UserID"));
                userCourse.setCourseID(rs.getInt("CourseID"));
                userCourse.setPkgName(rs.getString("PackageName"));
                userCourse.setProgress(rs.getDouble("Price"));
                userCourse.setEnrollDate(rs.getDate("EnrollDate"));
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

    public void deleteUserCourse(int userID, int courseID) {
        String sql = "DELETE FROM UserCourse WHERE UserID = ? AND CourseID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
