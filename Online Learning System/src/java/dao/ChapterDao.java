package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Chapter;

/**
 *
 * @author sonpk
 */
public class ChapterDao extends DBContext {
    public List<Chapter> getChaptersByCourseID(int courseID) {
        List<Chapter> chapters = new ArrayList<>();
        String sql = "SELECT * FROM Chapter WHERE CourseID = ? ORDER BY ChapterOrder";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setChapterID(rs.getInt("ChapterID"));
                chapter.setCourseID(rs.getInt("CourseID"));
                chapter.setTitle(rs.getString("Title"));
                chapter.setChapterOrder(rs.getInt("ChapterOrder"));
                chapters.add(chapter);
            }
        } catch (SQLException e) {
        }
        return chapters;
    }
}
