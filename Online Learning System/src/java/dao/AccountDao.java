package dao;

import context.context2;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Account;

public class AccountDao {
    private context2 dbConnect;

    public AccountDao() {
        this.dbConnect = context2.getInstance();
    }

    // ✅ Đăng nhập
// Đăng nhập
   public static Account getAccountByEmailAndPassword(String email, String password) {
    context2 dbConnect = context2.getInstance();
    String sql = "SELECT UserID, email, password FROM Users WHERE email = ? AND password = ?";

    try (Connection conn = dbConnect.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, email);
        stmt.setString(2, password);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            int id = rs.getInt("UserID");
            String e = rs.getString("email");
            String p = rs.getString("password");

            return new Account(id, e, p);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}



    // ✅ Thêm tài khoản mới
    public boolean insertUser(String fullName, String gender, String email, String phoneNumber, String password) {
        String sql = "INSERT INTO Users (firstName, gender, email, phoneNumber, password, role) "
                   + "VALUES (?, ?, ?, ?, ?, 'Students')";
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fullName);  // Lưu vào firstName
            ps.setString(2, gender);
            ps.setString(3, email);
            ps.setString(4, phoneNumber);
            ps.setString(5, password);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Kiểm tra email tồn tại
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Cập nhật mật khẩu
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

