package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.course.CourseAdditional;

public class CourseAdditionalDao extends DBContext {

    public List<CourseAdditional> getCourseAdditionalByCourseID(int courseID) {
        List<CourseAdditional> courseAdditionals = new ArrayList<>();
        String sql = "SELECT * FROM CourseAdditional WHERE CourseID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseAdditional courseAdditional = new CourseAdditional();
                courseAdditional.setCourseID(rs.getInt("CourseID"));
                courseAdditional.setContentURL(rs.getString("ContentURL"));
                courseAdditional.setIsVideo(rs.getBoolean("IsVideo"));
                courseAdditional.setCaption(rs.getString("Caption"));
                courseAdditional.setContent(rs.getString("Content"));
                courseAdditionals.add(courseAdditional);
            }
        } catch (SQLException e) {
        }
        return courseAdditionals;
    }
}
