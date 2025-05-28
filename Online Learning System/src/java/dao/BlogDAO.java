package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
                b.setDate(rs.getString("date"));
                b.setCategory(rs.getString("category"));
                b.setImageUrl(rs.getString("imageUrl"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
                b.setDate(rs.getString("date"));
                b.setCategory(rs.getString("category"));
                b.setImageUrl(rs.getString("imageUrl"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
                b.setDate(rs.getString("date"));
                b.setCategory(rs.getString("category"));
                b.setImageUrl(rs.getString("imageUrl"));
                b.setTotalView(rs.getInt("totalView"));
                b.setSummary(rs.getString("summary"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
