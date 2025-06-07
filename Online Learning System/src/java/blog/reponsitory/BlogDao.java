package blog.reponsitory;

import config.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Blog;

public class BlogDao extends DBContext {

    public List<Blog> getAllBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blog ORDER BY date DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlogID(rs.getInt("blogID"));
                b.setUserID(rs.getInt("userID"));
                b.setTitle(rs.getString("title"));
                b.setDate(rs.getDate("Date"));
                b.setCategory(rs.getString("category"));
                b.setImageURL(rs.getString("ImageURL"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> get3HotBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM Blog ORDER BY totalView DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlogID(rs.getInt("blogID"));
                b.setUserID(rs.getInt("userID"));
                b.setTitle(rs.getString("title"));
                b.setDate(rs.getDate("Date"));
                b.setCategory(rs.getString("category"));
                b.setImageURL(rs.getString("ImageURL"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> get5LatestPost() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM Blog ORDER BY date DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlogID(rs.getInt("blogID"));
                b.setUserID(rs.getInt("userID"));
                b.setTitle(rs.getString("title"));
                b.setDate(rs.getDate("Date"));
                b.setCategory(rs.getString("category"));
                b.setImageURL(rs.getString("ImageURL"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Blog getBlogByID(int blogID) {
        Blog b = new Blog();
        String sql = "SELECT * FROM Blog WHERE blogID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, blogID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                b.setBlogID(rs.getInt("blogID"));
                b.setUserID(rs.getInt("userID"));
                b.setTitle(rs.getString("title"));
                b.setDate(rs.getDate("Date"));
                b.setCategory(rs.getString("category"));
                b.setImageURL(rs.getString("ImageURL"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
            }
        } catch (SQLException e) {
        }
        return b;
    }

    public void increaseView(int blogID) {
        String sql = "UPDATE Blog SET totalView = totalView + 1 WHERE blogID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, blogID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
        
    public String getContentByBlogID(int blogID) {
        String content = "";
        String sql = "SELECT content FROM BlogContent WHERE blogID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, blogID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                content = rs.getString("content");
            }
        } catch (SQLException e) {
        }
        return content;
    }

    public Map<String, Integer> getCategory() {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as total FROM Blog GROUP BY category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String category = rs.getString("category");
                int count = rs.getInt("total");
                map.put(category, count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}
