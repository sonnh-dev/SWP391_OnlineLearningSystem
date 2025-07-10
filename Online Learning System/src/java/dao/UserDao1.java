package dao;

import context.context2;
import java.sql.*;
import java.time.LocalDate;
import model.User;

public class UserDao1 {
    private context2 dbConnect;

    public UserDao1() {
        dbConnect = context2.getInstance();
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE userID = ?";
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("userID"),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("gender"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("role"),
                    rs.getBoolean("status"),
                    rs.getString("avatarURL"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getDate("dateOfBirth").toLocalDate()
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
