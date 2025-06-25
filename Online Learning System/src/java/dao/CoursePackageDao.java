package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.course.Course;
import model.course.CoursePackage;

public class CoursePackageDao extends DBContext {

    public List<CoursePackage> getCoursePackagesByCourseID(int courseID) {
        List<CoursePackage> packages = new ArrayList<>();
        String sql = "SELECT * FROM CoursePackage WHERE CourseID = ? ORDER BY OriginalPrice ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CoursePackage coursePackage = new CoursePackage(
                        rs.getInt("PackageID"),
                        rs.getInt("CourseID"),
                        rs.getString("PackageName"),
                        rs.getDouble("OriginalPrice"),
                        rs.getInt("SaleRate"),
                        rs.getString("Description")
                );
                packages.add(coursePackage);
            }
        } catch (SQLException e) {
        }
        return packages;
    }

    public CoursePackage getCheapestCoursePackagesByCourse(Course course) {
        String sql = "SELECT TOP 1 * FROM CoursePackage WHERE CourseID = ? ORDER BY OriginalPrice ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, course.getCourseID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new CoursePackage(
                        rs.getInt("PackageID"),
                        rs.getInt("CourseID"),
                        rs.getString("PackageName"),
                        rs.getDouble("OriginalPrice"),
                        rs.getInt("SaleRate"),
                        rs.getString("Description")
                );
            }
        } catch (SQLException e) {
        }
        return null;
    }
}
