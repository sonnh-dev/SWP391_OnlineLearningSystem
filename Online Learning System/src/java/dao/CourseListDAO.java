package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.course.CourseList;

/**
 *
 * @author sonpk
 */
public class CourseListDAO extends DBContext {

    public List<CourseList> getAllCourseList() {
        List<CourseList> courseList = new ArrayList<>();

        String sql = "SELECT c.CourseID, c.Title, c.Category, c.Lectures, c.ImageURL, c.CourseShortDescription, c.UpdateDate, c.TotalEnrollment,"
                + " ISNULL(CAST(SUM(CASE WHEN cr.IsRecommended = 1 THEN 1 ELSE 0 END) AS FLOAT) * 100 / NULLIF(COUNT(cr.ReviewID), 0), 0) AS RatingPercent "
                + "FROM Course c LEFT JOIN CourseReview cr ON c.CourseID = cr.CourseID "
                + "GROUP BY c.CourseID, c.Title, c.Category, c.Lectures, c.ImageURL, c.CourseShortDescription, c.UpdateDate, c.TotalEnrollment"
                + " ORDER BY c.UpdateDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CourseList course = new CourseList();
                course.setCourseID(rs.getInt("CourseID"));
                course.setTitle(rs.getString("Title"));
                course.setCategory(rs.getString("Category"));
                course.setLectures(rs.getInt("Lectures"));
                course.setImageURL(rs.getString("ImageURL"));
                course.setCourseShortDescription(rs.getString("CourseShortDescription"));
                course.setUpdateDate(rs.getDate("UpdateDate"));
                course.setTotalEnrollment(rs.getInt("TotalEnrollment"));
                int ratingPercent = (int) Math.round(rs.getDouble("RatingPercent"));
                course.setRating(ratingPercent);
                course.setCoursePackage(new CoursePackageDao().getCoursePackagesByCourseID(course.getCourseID()));
                courseList.add(course);
            }

        } catch (SQLException e) {
        }
        return courseList;
    }
}
