package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.LessonContent;


/**
 *
 * @author sonpk
 */
public class LessonContentDao extends DBContext {

    public LessonContent getLessonContentByLessonID(int lessonID) {
        LessonContent lessonContent = null;
        String sql = "SELECT * FROM LessonContent WHERE LessonID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, lessonID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lessonContent = new LessonContent();
                lessonContent.setLessonID(rs.getInt("LessonID"));
                lessonContent.setDocContent(rs.getString("DocContent"));
                lessonContent.setVideoURL(rs.getString("VideoURL"));
            }
        } catch (SQLException e) {
        }
        return lessonContent;
    }
}
