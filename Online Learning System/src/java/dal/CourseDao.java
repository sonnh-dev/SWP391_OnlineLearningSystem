package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;

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
                course.setDescription(rs.getString("description"));
                course.setTotalEnrollment(rs.getInt("totalEnrollment"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
}
    