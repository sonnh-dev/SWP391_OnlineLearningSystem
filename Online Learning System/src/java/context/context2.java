/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

/**
 *
 * @author ADMIN
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class context2 {
    // Tạo một thể hiện duy nhất (singleton) để tái sử dụng trong toàn hệ thống
    private static context2 instance = new context2();

    // Logger để ghi log lỗi nếu có vấn đề xảy ra khi kết nối CSDL
    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());

    // Thông tin đăng nhập và đường dẫn đến cơ sở dữ liệu
    private String user = "sa"; // Tên đăng nhập SQL Server
    private String password = "sa"; // Mật khẩu
    private String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391DB;encrypt=false;characterEncoding=UTF-8;useUnicode=true";
    // Ghi chú: N2S\\MSSQLSERVER01 là tên máy chủ SQL Server và instance,
    // abc là tên cơ sở dữ liệu. TrustServerCertificate=true cho phép kết nối không cần chứng chỉ SSL.

    // Phương thức tĩnh trả về thể hiện duy nhất của DBConnect
    public static context2 getInstance() {
        return instance;
    }

    // Trả về một kết nối mới mỗi khi được gọi
    public Connection getConnection() {
        try {
            // Nạp trình điều khiển JDBC cho SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Thiết lập kết nối với CSDL
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            // Nếu không tìm thấy driver JDBC
            LOGGER.log(Level.SEVERE, "Không tìm thấy trình điều khiển SQL Server.", e);
        } catch (SQLException e) {
            // Nếu xảy ra lỗi trong quá trình kết nối
            LOGGER.log(Level.SEVERE, "Kết nối tới cơ sở dữ liệu thất bại.", e);
        }
        return null; // Trả về null nếu có lỗi
    }

    // Constructor riêng tư để ngăn việc tạo đối tượng từ bên ngoài (đảm bảo Singleton)
    public context2() {
        try {
            // Nạp trước driver JDBC nếu cần (tùy môi trường)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Không thể nạp driver SQL Server trong constructor.", e);
        }
    }
}

