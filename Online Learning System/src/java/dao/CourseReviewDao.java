package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.course.CourseReview;

public class CourseReviewDao extends DBContext {

    public List<CourseReview> getReviewsByCourseId(int courseId) {
        List<CourseReview> reviews = new ArrayList<>();
        String sql = "SELECT * FROM CourseReview WHERE CourseID = ? ORDER BY CreatedAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseReview review = new CourseReview();
                review.setReviewID(rs.getInt("ReviewID"));
                review.setUserID(rs.getInt("UserID"));
                review.setCourseID(rs.getInt("CourseID"));
                review.setRecommended(rs.getBoolean("IsRecommended"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getDate("CreatedAt"));
                reviews.add(review);
            }
        } catch (SQLException e) {
        }
        return reviews;
    }

    public int addReviewAndGetReviewID(CourseReview review) {
        String sql = "INSERT INTO CourseReview (UserID, CourseID, IsRecommended, Comment) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, review.getUserID());
            ps.setInt(2, review.getCourseID());
            ps.setBoolean(3, review.isRecommended());
            ps.setString(4, review.getComment());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return -1;
    }

    public List<CourseReview> getReviewsByCourseIdAndFilter(int courseId, String filter, int page, int pageSize) {
        List<CourseReview> reviews = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM CourseReview WHERE CourseID = ?");

        if ("recommended".equalsIgnoreCase(filter)) {
            sql.append(" AND IsRecommended = 1");
        } else if ("not_recommended".equalsIgnoreCase(filter)) {
            sql.append(" AND IsRecommended = 0");
        }

        sql.append(" ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, courseId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(extractReview(rs));
                }
            }
        } catch (SQLException e) {
        }
        return reviews;
    }

    // Đếm tổng số review theo courseId + filter
    public int countReviewsByCourseIdAndFilter(int courseId, String filter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM CourseReview WHERE CourseID = ?");

        if ("recommended".equalsIgnoreCase(filter)) {
            sql.append(" AND IsRecommended = 1");
        } else if ("not_recommended".equalsIgnoreCase(filter)) {
            sql.append(" AND IsRecommended = 0");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public int getCourseRatingByCourseId(int courseId) {
        String sql = "SELECT AVG(CAST(CASE WHEN IsRecommended = 1 THEN 1 ELSE 0 END AS FLOAT)) * 100 AS Rating FROM CourseReview WHERE CourseID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Rating");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    private CourseReview extractReview(ResultSet rs) throws SQLException {
        CourseReview review = new CourseReview();
        review.setReviewID(rs.getInt("ReviewID"));
        review.setUserID(rs.getInt("UserID"));
        review.setCourseID(rs.getInt("CourseID"));
        review.setRecommended(rs.getBoolean("IsRecommended"));
        review.setComment(rs.getString("Comment"));
        review.setCreatedAt(rs.getDate("CreatedAt"));
        return review;
    }
}
