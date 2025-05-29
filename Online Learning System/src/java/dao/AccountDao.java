package dao;

import context.context2;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Account;

public class AccountDao {
    private context2 dbConnect; // Biến lưu kết nối CSDL


    public AccountDao() {
        this.dbConnect = context2.getInstance();
    }

  
    public static Account getAccountByEmailAndPassword(String email, String password) {
        context2 dbConnect = context2.getInstance(); // Lấy thể hiện DBConnect (singleton)

        ArrayList<Account> accounts = new ArrayList<>(); // Danh sách để lưu kết quả tài khoản

        // Câu truy vấn SQL để tìm người dùng với email và mật khẩu khớp
        String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";

        // Sử dụng try-with-resources để tự động đóng kết nối
        try (Connection conn = dbConnect.getConnection();         // Mở kết nối tới CSDL
             PreparedStatement stmt = conn.prepareStatement(sql)) { // Chuẩn bị câu lệnh SQL

            // Gán giá trị tham số cho câu lệnh SQL
            stmt.setString(1, email);      // Gán email vào dấu ?
            stmt.setString(2, password);   // Gán mật khẩu vào dấu ?

            // Thực thi truy vấn và nhận kết quả
            ResultSet rs = stmt.executeQuery();

            // Duyệt qua kết quả trả về
            while (rs.next()) {
                // Tạo đối tượng Account từ dữ liệu trong CSDL
                Account account = new Account(
                    rs.getString("email"),
                    rs.getString("password")
                );
                accounts.add(account); // Thêm vào danh sách kết quả
            }

        } catch (Exception e) {
            // In lỗi nếu có vấn đề xảy ra
            e.printStackTrace();
            return null; // Trả về null nếu xảy ra lỗi
        }

        // Nếu không có kết quả nào, trả về null, ngược lại trả về tài khoản đầu tiên
        return accounts.isEmpty() ? null : accounts.get(0);
    }
}
