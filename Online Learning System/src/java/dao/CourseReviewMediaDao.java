package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.course.CourseReviewMedia;

/**
 *
 * @author sonpk
 */
public class CourseReviewMediaDao extends DBContext {

    public List<CourseReviewMedia> getMediaByReviewId(int reviewId) {
        List<CourseReviewMedia> list = new ArrayList<>();
        String sql = "SELECT * FROM CourseReviewMedia WHERE ReviewID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseReviewMedia media = new CourseReviewMedia();
                media.setMediaID(rs.getInt("MediaID"));
                media.setReviewID(rs.getInt("ReviewID"));
                media.setMediaURL(rs.getString("MediaURL"));
                media.setVideo(rs.getBoolean("IsVideo"));
                media.setCaption(rs.getString("Caption"));
                list.add(media);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public void addMediaToReview(CourseReviewMedia media) {
        String sql = "INSERT INTO CourseReviewMedia (ReviewID, MediaURL, IsVideo, Caption) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, media.getReviewID());
            ps.setString(2, media.getMediaURL());
            ps.setBoolean(3, media.isVideo());
            ps.setString(4, media.getCaption());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
