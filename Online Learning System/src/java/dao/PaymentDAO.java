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
        String sql = "INSERT INTO PaymentTransaction (UserID, CourseID, PackageID, OrderCode, Amount, Status, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, trans.getUserId());
            ps.setInt(2, trans.getCourseId());
            ps.setInt(3, trans.getPackageId());
            ps.setString(4, trans.getOrderCode());
            ps.setDouble(5, trans.getAmount());
            ps.setString(6, trans.getStatus());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return -1;
    }

    public boolean updatePaymentTransaction(PaymentTransaction trans) {
        String updateTransactionSQL = "UPDATE PaymentTransaction SET "
                + "Vnp_TransactionNo = ?, Vnp_ResponseCode = ?, Vnp_OrderInfo = ?, Status = ?, PaidAt = ? "
                + "WHERE TransactionId = ?";

        String updateUserCourseSQL = "UPDATE UserCourse SET Status = ?, ValidFrom = ?, ValidTo = ? "
                + "WHERE UserID = ? AND CourseID = ?";

        try (
                PreparedStatement ps1 = connection.prepareStatement(updateTransactionSQL); PreparedStatement ps2 = connection.prepareStatement(updateUserCourseSQL)) {

            Timestamp validFrom = trans.getPaidAt();
            int useTime = getUseTimeFromCoursePackage(trans.getCourseId(), trans.getPackageId());
            Timestamp validTo = null;
            if (useTime > 0) {
                validTo = Timestamp.valueOf(validFrom.toLocalDateTime().plusDays(useTime));
            }
            
            ps1.setString(1, trans.getVnpTransactionNo());
            ps1.setString(2, trans.getVnpResponseCode());
            ps1.setString(3, trans.getVnpOrderInfo());
            ps1.setString(4, trans.getStatus());
            ps1.setTimestamp(5, validFrom);
            ps1.setInt(6, trans.getTransactionId());
            int rows1 = ps1.executeUpdate();
            ps2.setString(1, trans.getStatus());
            ps2.setTimestamp(2, validFrom);
            if (validTo != null) {
                ps2.setTimestamp(3, validTo);
            } else {
                ps2.setNull(3, java.sql.Types.TIMESTAMP);
            }
            ps2.setInt(4, trans.getUserId());
            ps2.setInt(5, trans.getCourseId());
            int rows2 = ps2.executeUpdate();
            return rows1 > 0 && rows2 > 0;
        } catch (SQLException e) {
        }
        return false;
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
                transaction.setPackageId(rs.getInt("PackageID"));
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

    public int getUseTimeFromCoursePackage(int courseId, int packageId) {
        String sql = "SELECT UseTime FROM CoursePackage WHERE CourseID = ? AND PackageID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setInt(2, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("UseTime");
                }
            }
        } catch (SQLException e) {
        }
        return 0;
    }
}
