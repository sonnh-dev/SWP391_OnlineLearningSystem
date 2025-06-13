package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.course.Course;

public class CourseDao extends DBContext {

    public List<Course> get3HotestCoursesofDifferentCategories() {
        List<Course> courses = new ArrayList<>();
        String sql = "WITH bestCourse AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY Category ORDER BY TotalEnrollment DESC) AS num FROM Course) SELECT TOP 3 * FROM bestCourse WHERE num = 1 ORDER BY  TotalEnrollment DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseID(rs.getInt("courseID"));
                course.setTitle(rs.getString("title"));
                course.setCategory(rs.getString("category"));
                course.setLectures(rs.getInt("lectures"));
                course.setImageURL(rs.getString("imageURL"));
                course.setCourseShortDescription(rs.getString("CourseShortDescription"));
                course.setDescription(rs.getString("description"));
                course.setTotalEnrollment(rs.getInt("totalEnrollment"));
                courses.add(course);
            }
        } catch (SQLException e) {
        }
        return courses;
    }

    public List<Course> get4HotestCoursesofDifferentCategories() {
        List<Course> courses = new ArrayList<>();
        String sql = "WITH bestCourse AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY Category ORDER BY TotalEnrollment DESC) AS num FROM Course) SELECT TOP 4 * FROM bestCourse WHERE num = 1 ORDER BY  TotalEnrollment DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseID(rs.getInt("courseID"));
                course.setTitle(rs.getString("title"));
                course.setCategory(rs.getString("category"));
                course.setLectures(rs.getInt("lectures"));
                course.setImageURL(rs.getString("imageURL"));
                course.setCourseShortDescription(rs.getString("CourseShortDescription"));
                course.setDescription(rs.getString("description"));
                course.setTotalEnrollment(rs.getInt("totalEnrollment"));
                courses.add(course);
            }
        } catch (SQLException e) {
        }
        return courses;
    }

    public Course getCourseByID(int courseID) {
        Course course = new Course();
        String sql = "SELECT * FROM Course WHERE courseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                course.setCourseID(rs.getInt("courseID"));
                course.setTitle(rs.getString("title"));
                course.setCategory(rs.getString("category"));
                course.setLectures(rs.getInt("lectures"));
                course.setImageURL(rs.getString("imageURL"));
                course.setCourseShortDescription(rs.getString("CourseShortDescription"));
                course.setDescription(rs.getString("description"));
                course.setTotalEnrollment(rs.getInt("totalEnrollment"));
            }
        } catch (SQLException e) {
        }
        return course;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM Course";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
        }
        return categories;
    }
}
