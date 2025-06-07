package blog.reponsitory;

import model.Blog;
import config.context2;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    context2 db = new context2(); // Khởi tạo đối tượng kết nối CSDL

    //  Lấy tất cả bài viết (không phân trang)
    public List<Blog> getAllPosts() {
        List<Blog> posts = new ArrayList<>();
        String sql = "SELECT * FROM Blog ORDER BY Date DESC";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Blog post = new Blog();
                post.setBlogID(rs.getInt("BlogID"));
                post.setUserID(rs.getInt("UserID"));
                post.setTitle(rs.getString("Title"));
                post.setDate(rs.getDate("Date"));
                post.setCategory(rs.getString("Category"));
                post.setImageURL(rs.getString("ImageURL"));
                post.setTotalView(rs.getInt("TotalView"));
                post.setSummary(rs.getString("Summary"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    //  Đếm tổng số bài viết (dùng để phân trang)
    public int countPosts() {
        String sql = "SELECT COUNT(*) FROM Blog";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    //  Lấy bài viết theo phân trang
    public List<Blog> getPostsByPage(int offset, int pageSize) {
        List<Blog> posts = new ArrayList<>();
        String sql = "SELECT * FROM Blog ORDER BY Date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, offset);     // vị trí bắt đầu
            ps.setInt(2, pageSize);   // số lượng bài viết mỗi trang

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog post = new Blog();
                post.setBlogID(rs.getInt("BlogID"));
                post.setUserID(rs.getInt("UserID"));
                post.setTitle(rs.getString("Title"));
                post.setDate(rs.getDate("Date"));
                post.setCategory(rs.getString("Category"));
                post.setImageURL(rs.getString("ImageURL"));
                post.setTotalView(rs.getInt("TotalView"));
                post.setSummary(rs.getString("Summary"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;
    }

    //  Lấy bài viết theo phân trang và theo category
    public List<Blog> getPostsByPageAndCategory(int offset, int pageSize, String category) {
        List<Blog> posts = new ArrayList<>();
        String sql = "SELECT * FROM Blog ";
        if (category != null && !category.equalsIgnoreCase("all")) {
            sql += "WHERE Category = ? ";
        }
        sql += "ORDER BY Date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            if (category != null && !category.equalsIgnoreCase("all")) {
                ps.setString(paramIndex++, category);
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog post = new Blog();
                post.setBlogID(rs.getInt("BlogID"));
                post.setUserID(rs.getInt("UserID"));
                post.setTitle(rs.getString("Title"));
                post.setDate(rs.getDate("Date"));
                post.setCategory(rs.getString("Category"));
                post.setImageURL(rs.getString("ImageURL"));
                post.setTotalView(rs.getInt("TotalView"));
                post.setSummary(rs.getString("Summary"));
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;
    }

    // Đếm số lượng bài viết theo Category
    public int countPostsByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM Blog";
        if (category != null && !category.equalsIgnoreCase("all")) {
            sql += " WHERE Category = ?";
        }

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (category != null && !category.equalsIgnoreCase("all")) {
                ps.setString(1, category);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    //  Lấy các bài viết mới nhất (dùng cho sidebar)
    public List<Blog> getLatestPosts(int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Blog ORDER BY Date DESC";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit); // số lượng bài viết muốn lấy
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog p = new Blog();
                    p.setBlogID(rs.getInt("BlogID"));
                    p.setUserID(rs.getInt("UserID"));
                    p.setTitle(rs.getString("Title"));
                    p.setDate(rs.getDate("Date"));
                    p.setCategory(rs.getString("Category"));
                    p.setImageURL(rs.getString("ImageURL"));
                    p.setTotalView(rs.getInt("TotalView"));
                    p.setSummary(rs.getString("Summary"));
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm số bài viết theo từ khóa tìm kiếm
    public int countPostsBySearch(String keyword) {
        String sql = "SELECT COUNT(*) FROM Blog WHERE Title LIKE ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy danh sách bài viết theo từ khóa tìm kiếm và phân trang
    public List<Blog> getPostsBySearch(int offset, int pageSize, String keyword) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blog WHERE Title LIKE ? ORDER BY Date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog p = new Blog();
                p.setBlogID(rs.getInt("BlogID"));
                p.setUserID(rs.getInt("UserID"));
                p.setTitle(rs.getString("Title"));
                p.setDate(rs.getDate("Date"));
                p.setCategory(rs.getString("Category"));
                p.setImageURL(rs.getString("ImageURL"));
                p.setTotalView(rs.getInt("TotalView"));
                p.setSummary(rs.getString("Summary"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
