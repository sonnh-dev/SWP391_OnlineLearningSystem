// File: src/main/java/com/yourcompany/yourproject/dao/UserDAO.java
package dao;

import context.DBContext2;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

public class UserDAO extends DBContext2 {

    public List<User> getPaginatedUsers(
            String genderFilter, String roleFilter, String statusFilter,
            String searchKeyword, String searchBy,
            String sortBy, String sortOrder,
            int pageIndex, int pageSize) throws ClassNotFoundException {

        List<User> users = new ArrayList<>();
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            StringBuilder sql = new StringBuilder(
                    "SELECT userId, firstName, lastName, gender, email, phoneNumber, role, status FROM Users WHERE 1=1 "
            );

            // Filtering
            if (genderFilter != null && !genderFilter.equals("all")) {
                sql.append(" AND gender = ? ");
            }
            if (roleFilter != null && !roleFilter.equals("all")) {
                sql.append(" AND role = ? ");
            }
            if (statusFilter != null && !statusFilter.equals("all")) {
                sql.append(" AND status = ? ");
            }

            // Searching
            String likeKeyword = "%" + searchKeyword.toLowerCase() + "%";
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                switch (searchBy) {
                    case "fullName":
                        sql.append(" AND (LOWER(CONCAT(firstName, ' ', lastName)) COLLATE Vietnamese_CI_AI LIKE ? ");
                        sql.append(" OR LOWER(CONCAT(lastName, ' ', firstName)) COLLATE Vietnamese_CI_AI LIKE ?) ");
                        break;
                    case "firstName":
                        sql.append(" AND LOWER(firstName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        break;
                    case "lastName":
                        sql.append(" AND LOWER(lastName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        break;
                    case "email":
                        sql.append(" AND LOWER(email) LIKE ? ");
                        break;
                    case "mobile":
                        sql.append(" AND phoneNumber LIKE ? ");
                        break;
                    default:
                        sql.append(" AND (LOWER(firstName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        sql.append(" OR LOWER(lastName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        sql.append(" OR LOWER(email) LIKE ? ");
                        sql.append(" OR phoneNumber LIKE ?) ");
                        break;
                }
            }

            // Sorting
            sql.append(" ORDER BY ").append(sortBy != null ? sortBy : "userId");
            sql.append(" ").append("desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");

            // Pagination
            sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

            ps = con.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Set filter params
            if (!genderFilter.equals("all")) {
                ps.setString(paramIndex++, genderFilter);
            }
            if (!roleFilter.equals("all")) {
                ps.setString(paramIndex++, roleFilter);
            }
            if (!statusFilter.equals("all")) {
                ps.setBoolean(paramIndex++, Boolean.parseBoolean(statusFilter));
            }

            // Set search params
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                switch (searchBy) {
                    case "fullName":
                        ps.setString(paramIndex++, likeKeyword);
                        ps.setString(paramIndex++, likeKeyword);
                        break;
                    case "firstName":
                    case "lastName":
                    case "email":
                    case "mobile":
                        ps.setString(paramIndex++, likeKeyword);
                        break;
                    default:
                        ps.setString(paramIndex++, likeKeyword);
                        ps.setString(paramIndex++, likeKeyword);
                        ps.setString(paramIndex++, likeKeyword);
                        ps.setString(paramIndex++, likeKeyword);
                        break;
                }
            }

            // Set pagination params
            ps.setInt(paramIndex++, (pageIndex - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("userId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("gender"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("role"),
                        rs.getBoolean("status")
                );
                users.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return users;
    }

    public int getTotalUsers(String genderFilter, String roleFilter, String statusFilter,
            String searchKeyword, String searchBy) throws ClassNotFoundException {
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int totalUsers = 0;

        try {
            con = db.getConnection();
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Users WHERE 1=1 ");

            // Filtering
            if (genderFilter != null && !genderFilter.isEmpty() && !genderFilter.equals("all")) {
                sql.append(" AND gender = ? ");
            }
            if (roleFilter != null && !roleFilter.isEmpty() && !roleFilter.equals("all")) {
                sql.append(" AND role = ? ");
            }
            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("all")) {
                sql.append(" AND status = ? ");
            }

            // Searching
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                // Chuyển searchKeyword thành chữ thường một lần duy nhất và thêm ký tự wildcard
                String likeKeyword = "%" + searchKeyword.toLowerCase() + "%";

                switch (searchBy) {
                    case "fullName":
                        // Tìm kiếm theo tên đầy đủ (firstName + lastName HOẶC lastName + firstName)
                        // Sử dụng LOWER và COLLATE Vietnamese_CI_AI để tìm kiếm không phân biệt hoa/thường, không dấu
                        sql.append(" AND (LOWER(CONCAT(firstName, ' ', lastName)) COLLATE Vietnamese_CI_AI LIKE ? ");
                        sql.append(" OR LOWER(CONCAT(lastName, ' ', firstName)) COLLATE Vietnamese_CI_AI LIKE ?) ");
                        break;
                    case "firstName":
                        sql.append(" AND LOWER(firstName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        break;
                    case "lastName":
                        sql.append(" AND LOWER(lastName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        break;
                    case "email":
                        sql.append(" AND LOWER(email) LIKE ? "); // Email thường không có dấu
                        break;
                    case "mobile":
                        sql.append(" AND phoneNumber LIKE ? "); // Số điện thoại không có dấu
                        break;
                    default:
                        // Tìm kiếm trên tất cả các trường có thể, áp dụng cho các trường tên và email
                        sql.append(" AND (LOWER(firstName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        sql.append(" OR LOWER(lastName) COLLATE Vietnamese_CI_AI LIKE ? ");
                        sql.append(" OR LOWER(email) LIKE ? ");
                        sql.append(" OR phoneNumber LIKE ?) "); // Phone number không cần LOWER hoặc COLLATE
                        break;
                }
            }

            ps = con.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Set filter parameters
            if (genderFilter != null && !genderFilter.isEmpty() && !genderFilter.equals("all")) {
                ps.setString(paramIndex++, genderFilter);
            }
            if (roleFilter != null && !roleFilter.isEmpty() && !roleFilter.equals("all")) {
                ps.setString(paramIndex++, roleFilter);
            }
            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("all")) {
                // Giả sử status được lưu dưới dạng boolean (true/false) trong DB
                // Nếu là int (0/1), bạn cần parse thành int
                ps.setBoolean(paramIndex++, Boolean.parseBoolean(statusFilter));
            }

            // Set search parameters
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                // Chuyển searchKeyword thành chữ thường một lần duy nhất và thêm ký tự wildcard
                String likeKeyword = "%" + searchKeyword.toLowerCase() + "%";

                switch (searchBy) {
                    case "fullName":
                        ps.setString(paramIndex++, likeKeyword); // Cho CONCAT(firstName, ' ', lastName)
                        ps.setString(paramIndex++, likeKeyword); // Cho CONCAT(lastName, ' ', firstName)
                        break;
                    case "firstName":
                    case "lastName":
                    case "email":
                    case "mobile":
                        ps.setString(paramIndex++, likeKeyword);
                        break;
                    default:
                        ps.setString(paramIndex++, likeKeyword); // firstName
                        ps.setString(paramIndex++, likeKeyword); // lastName
                        ps.setString(paramIndex++, likeKeyword); // email
                        ps.setString(paramIndex++, likeKeyword); // phoneNumber
                        break;
                }
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                totalUsers = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Đóng ResultSet, PreparedStatement và Connection để giải phóng tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return totalUsers;
    }

    public User getUserById(int userId) throws ClassNotFoundException {
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;
        try {
            con = db.getConnection();
            String sql = "SELECT userId, firstName, lastName, gender, email, phoneNumber, role, status, avatarUrl, address, dateOfBirth FROM Users WHERE userId = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("userId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("gender"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("role"),
                        rs.getBoolean("status"),
                        rs.getString("avatarUrl"),
                        // No password for security reasons when retrieving details
                        null,
                        rs.getString("address"),
                        rs.getDate("dateOfBirth") != null ? rs.getDate("dateOfBirth").toLocalDate() : null
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return user;
    }

    public User getUserByEmail(String mail) throws ClassNotFoundException {
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;
        try {
            con = db.getConnection();
            String sql = "SELECT userId, firstName, lastName, gender, email, phoneNumber, role, status, avatarUrl, address, dateOfBirth FROM Users WHERE email = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, mail);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("userId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("gender"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getString("role"),
                        rs.getBoolean("status"),
                        rs.getString("avatarUrl"),
                        // No password for security reasons when retrieving details
                        null,
                        rs.getString("address"),
                        rs.getDate("dateOfBirth") != null ? rs.getDate("dateOfBirth").toLocalDate() : null
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return user;
    }

    public boolean addUser(User user) throws ClassNotFoundException {
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = db.getConnection();
            // password sẽ được tạo tự động và gửi email
            String sql = "INSERT INTO Users (firstName, lastName, gender, email, phoneNumber, role, status, avatarUrl, password, address, dateOfBirth) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getRole());
            ps.setBoolean(7, user.isStatus());
            ps.setString(8, user.getAvatarUrl());
            ps.setString(9, user.getPassword()); // password đã được tạo trước khi gọi phương thức này
            ps.setString(10, user.getAddress());
            ps.setDate(11, user.getDateOfBirth() != null ? java.sql.Date.valueOf(user.getDateOfBirth()) : null);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // Admin chỉ có thể edit/update role và status của user
    public boolean updateRoleAndStatus(int userId, String role, boolean status) throws ClassNotFoundException {
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = db.getConnection();
            String sql = "UPDATE Users SET role = ?, status = ? WHERE userId = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, role);
            ps.setBoolean(2, status);
            ps.setInt(3, userId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // Phương thức này có thể được dùng cho người dùng tự cập nhật thông tin cá nhân (nếu có)
    // hoặc cho admin cập nhật toàn bộ thông tin (nếu được phép)
    public boolean updateUser(User user) throws ClassNotFoundException {
        DBContext2 db = new DBContext2();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = db.getConnection();
            String sql = "UPDATE Users SET firstName = ?, lastName = ?, gender = ?, email = ?, phoneNumber = ?, avatarUrl = ?, address = ?, dateOfBirth = ? WHERE userId = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getAvatarUrl());
            ps.setString(7, user.getAddress());
            ps.setDate(8, user.getDateOfBirth() != null ? java.sql.Date.valueOf(user.getDateOfBirth()) : null);
            ps.setInt(9, user.getUserId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean updateUserProfile(User user) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean success = false;

        try {
            con = DBContext2.getConnection();
            String sql = "UPDATE Users SET "
                    + "FirstName = ?, "
                    + "LastName = ?, "
                    + "Gender = ?, "
                    + "PhoneNumber = ?, "
                    + "AvatarURL = ?, " // Cột AvatarURL
                    + "Address = ?, " // Cột Address
                    + "DateOfBirth = ? " // Cột DateOfBirth
                    + "WHERE UserId = ?";

            stm = con.prepareStatement(sql);
            int i = 1;
            stm.setString(i++, user.getFirstName());
            stm.setString(i++, user.getLastName());
            stm.setString(i++, user.getGender());
            stm.setString(i++, user.getPhoneNumber());
            stm.setString(i++, user.getAvatarUrl()); // Set AvatarURL
            stm.setString(i++, user.getAddress());    // Set Address

            // Xử lý DateOfBirth: chuyển java.util.Date sang java.sql.Date
            if (user.getDateOfBirth() != null) {
                // Chuyển java.time.LocalDate sang java.sql.Date
                stm.setDate(i++, java.sql.Date.valueOf(user.getDateOfBirth()));
            } else {
                stm.setNull(i++, java.sql.Types.DATE);
            }

            stm.setInt(i++, user.getUserId());

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return success;
    }

    // Giả định bạn có một bảng Users trong database của mình
    // SQL DDL cho bảng Users (ví dụ cho SQL Server)
    /*
    CREATE TABLE Users (
        userId INT PRIMARY KEY IDENTITY(1,1),
        firstName NVARCHAR(50) NOT NULL,
        lastName NVARCHAR(50) NOT NULL,
        gender NVARCHAR(10),
        email NVARCHAR(100) UNIQUE NOT NULL,
        phoneNumber NVARCHAR(20),
        role NVARCHAR(20) DEFAULT 'User' NOT NULL,
        status BIT DEFAULT 1 NOT NULL, -- 1 for active, 0 for inactive
        avatarUrl NVARCHAR(255),
        password NVARCHAR(255) NOT NULL,
        address NVARCHAR(255),
        dateOfBirth DATE
    );
     */
    public User getLoginUser(Account account) {
        String sql = "SELECT UserID, FirstName, LastName, Email, PhoneNumber, AvatarUrl FROM Users WHERE email = ? AND password = ?";
        try (Connection con = DBContext2.getConnection(); PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, account.getEmail());
            stm.setString(2, account.getPassword());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAvatarUrl(rs.getString("AvatarUrl"));
                return user;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT 1 FROM Users WHERE Email = ?";
        try (Connection con = DBContext2.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
        }
        return false;
    }
}
