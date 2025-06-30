package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

public class SliderDao extends DBContext {

    public List<Slider> getAllSlider() {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM SliderImage WHERE Status = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderID(rs.getInt("sliderID"));
                slider.setCourseID(rs.getInt("courseID"));
                slider.setSliderTitle(rs.getString("sliderTitle"));
                slider.setSliderContent(rs.getString("sliderContent"));
                slider.setSliderURL(rs.getString("sliderURL"));
                list.add(slider);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public void changedSlider(Slider slider) {
        String sql = "UPDATE SliderImage SET courseID = ?, sliderTitle = ?, sliderContent = ?, sliderURL = ? WHERE sliderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, slider.getCourseID());
            ps.setString(2, slider.getSliderTitle());
            ps.setString(3, slider.getSliderContent());
            ps.setString(4, slider.getSliderURL());
            ps.setInt(5, slider.getSliderID());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
       public List<Slider> getAllSliders1() {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM SliderImage ORDER BY SliderID ASC";

        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                Slider s = new Slider();
                s.setSliderID(rs.getInt("SliderID"));
                s.setSliderTitle(rs.getString("SliderTitle"));
                s.setSliderContent(rs.getString("SliderContent"));
                s.setSliderURL(rs.getString("SliderURL"));
                s.setStatus(rs.getInt("Status"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Slider> searchSliders(String keyword) {
    List<Slider> list = new ArrayList<>();
    String sql = "SELECT * FROM SliderImage WHERE SliderTitle LIKE ? OR SliderURL LIKE ?";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        String searchTerm = "%" + keyword + "%";
        ps.setString(1, searchTerm);
        ps.setString(2, searchTerm);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Slider s = new Slider();
            s.setSliderID(rs.getInt("SliderID"));
            s.setSliderTitle(rs.getString("SliderTitle"));
            s.setSliderContent(rs.getString("SliderContent"));
            s.setSliderURL(rs.getString("SliderURL"));
            s.setStatus(rs.getInt("Status"));
            list.add(s);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
    public List<Slider> filterSliders(String keyword, String statusFilter) {
    List<Slider> list = new ArrayList<>();
    String sql = "SELECT * FROM SliderImage WHERE (SliderTitle LIKE ? OR SliderURL LIKE ?)";
    
    if (!statusFilter.equals("all")) {
        sql += " AND Status = ?";
    }

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        String searchTerm = "%" + keyword + "%";
        ps.setString(1, searchTerm);
        ps.setString(2, searchTerm);

        if (!statusFilter.equals("all")) {
            ps.setInt(3, statusFilter.equals("active") ? 1 : 0);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Slider s = new Slider();
            s.setSliderID(rs.getInt("SliderID"));
            s.setSliderTitle(rs.getString("SliderTitle"));
            s.setSliderContent(rs.getString("SliderContent"));
            s.setSliderURL(rs.getString("SliderURL"));
            s.setStatus(rs.getInt("Status"));
            list.add(s);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    

    return list;
}

// Trong SliderDAO.java
public void updateSlider(int id, String title, String content, String url, int status) {
    // Đảm bảo tên cột ID khớp với cơ sở dữ liệu của bạn, thường là SliderID
    String sql = "UPDATE SliderImage SET SliderTitle = ?, SliderContent = ?, SliderURL = ?, Status = ? WHERE SliderID = ?"; // <-- Đã sửa từ ID thành SliderID
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, title);
        stmt.setString(2, content);
        stmt.setString(3, url);
        stmt.setInt(4, status);
        stmt.setInt(5, id);
        stmt.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }
}
  
public Slider getSliderById(int id) {
    Slider slider = null;
    try {
        Connection conn = getConnection();
       
        String sql = "SELECT * FROM SliderImage WHERE SliderID = ?"; // Đã chỉnh sửa từ Slider thành SliderImage
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            slider = new Slider();
            slider.setSliderID(rs.getInt("SliderID"));
            slider.setSliderTitle(rs.getString("SliderTitle"));
            slider.setSliderContent(rs.getString("SliderContent"));
            slider.setSliderURL(rs.getString("SliderURL"));
            slider.setStatus(rs.getInt("Status"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return slider;
}
}
