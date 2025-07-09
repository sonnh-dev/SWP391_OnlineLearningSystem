package dao;

import context.DBContext;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.PaymentTransaction;

/**
 *
 * @author sonpk
 */
public class PaymentDAO extends DBContext {

    public int insertPaymentTransaction(PaymentTransaction trans) {
        String sql = "INSERT INTO PaymentTransaction (UserID, CourseID, PackageName, UseTime, OrderCode, Amount, Status, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, trans.getUserId());
            ps.setInt(2, trans.getCourseId());
            ps.setString(3, trans.getPackageName());
            ps.setInt(4, trans.getUseTime());
            ps.setString(5, trans.getOrderCode());
            ps.setDouble(6, trans.getAmount());
            ps.setString(7, trans.getStatus());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return -1;
    }

    public boolean updateTransactionInfo(PaymentTransaction trans) {
        String sql = "UPDATE PaymentTransaction SET "
                + "Vnp_TransactionNo = ?, Vnp_ResponseCode = ?, Vnp_OrderInfo = ?, Status = ?, PaidAt = ? "
                + "WHERE TransactionId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, trans.getVnpTransactionNo());
            ps.setString(2, trans.getVnpResponseCode());
            ps.setString(3, trans.getVnpOrderInfo());
            ps.setString(4, trans.getStatus());
            ps.setTimestamp(5, trans.getPaidAt());
            ps.setInt(6, trans.getTransactionId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean updateUserCourseStatus(PaymentTransaction trans) {
        String sql = "UPDATE UserCourse SET Status = ?, ValidFrom = ?, ValidTo = ? "
                + "WHERE UserID = ? AND CourseID = ?";

        Timestamp validFrom = trans.getPaidAt();
        int useTime = trans.getUseTime();
        Timestamp validTo = null;
        if (useTime > 0) {
            validTo = Timestamp.valueOf(validFrom.toLocalDateTime().plusDays(useTime));
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, trans.getStatus());
            ps.setTimestamp(2, validFrom);
            if (validTo != null) {
                ps.setTimestamp(3, validTo);
            } else {
                ps.setNull(3, java.sql.Types.TIMESTAMP);
            }
            ps.setInt(4, trans.getUserId());
            ps.setInt(5, trans.getCourseId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean updatePaymentTransaction(PaymentTransaction trans) {
        return updateTransactionInfo(trans) && updateUserCourseStatus(trans);
    }

    public PaymentTransaction getPaymentTransactionByOrderCode(String orderCode) {
        String sql = "SELECT * FROM PaymentTransaction WHERE OrderCode = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PaymentTransaction transaction = new PaymentTransaction();
                transaction.setTransactionId(rs.getInt("TransactionId"));
                transaction.setUserId(rs.getInt("UserID"));
                transaction.setCourseId(rs.getInt("CourseID"));
                transaction.setPackageName(rs.getString("PackageName"));
                transaction.setUseTime(rs.getInt("UseTime"));
                transaction.setOrderCode(rs.getString("OrderCode"));
                transaction.setAmount(rs.getDouble("Amount"));
                transaction.setVnpTransactionNo(rs.getString("Vnp_TransactionNo"));
                transaction.setVnpResponseCode(rs.getString("Vnp_ResponseCode"));
                transaction.setVnpOrderInfo(rs.getString("Vnp_OrderInfo"));
                transaction.setStatus(rs.getString("Status"));
                transaction.setCreatedAt(rs.getTimestamp("CreatedAt"));
                transaction.setPaidAt(rs.getTimestamp("PaidAt"));
                return transaction;
            }
        } catch (SQLException e) {
        }
        return null;
    }
}
