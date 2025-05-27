package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

public class BlogDAO extends DBContext {

    public List<Blog> getAllBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog order by date desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog o = new Blog();
                BlogDAO udao = new BlogDAO();
                o.setId(rs.getInt("id"));
                o.setTitle(rs.getString("title"));
                o.setSummary(rs.getString("summary"));
                o.setContent(rs.getString("content"));
                o.setAuthorID(rs.getInt("authorID"));
                o.setDate(rs.getString("date"));
                o.setTags(rs.getString("tags"));
                o.setImageUrl(rs.getString("imageUrl"));
                o.setTotalView(rs.getInt("totalView"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Blog> get3HotBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM Blog ORDER BY totalView DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog o = new Blog();
                o.setId(rs.getInt("id"));
                o.setTitle(rs.getString("title"));
                o.setSummary(rs.getString("summary"));
                o.setContent(rs.getString("content"));
                o.setAuthorID(rs.getInt("authorID"));
                o.setDate(rs.getString("date"));
                o.setTags(rs.getString("tags"));
                o.setImageUrl(rs.getString("imageUrl"));
                o.setTotalView(rs.getInt("totalView"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<Blog> get5LatestPost() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM Blog ORDER BY date DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog o = new Blog();
                o.setId(rs.getInt("id"));
                o.setTitle(rs.getString("title"));
                o.setSummary(rs.getString("summary"));
                o.setContent(rs.getString("content"));
                o.setAuthorID(rs.getInt("authorID"));
                o.setDate(rs.getString("date"));
                o.setTags(rs.getString("tags"));
                o.setImageUrl(rs.getString("imageUrl"));
                o.setTotalView(rs.getInt("totalView"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
}
