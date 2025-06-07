package dal;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

public class SliderDao extends DBContext {

    public List<Slider> getAllSlider() {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM SliderImage";
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
}
