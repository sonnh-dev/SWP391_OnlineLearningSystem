package model;

import java.sql.Timestamp;

/**
 *
 * @author sonpk
 */
public class PaymentTransaction {
    private int transactionId;
    private int userId;
    private int courseId;
    private int packageId;
    private String orderCode;
    private double amount;
    private String vnpTransactionNo;
    private String vnpResponseCode;
    private String vnpOrderInfo;
    private String status;
    private Timestamp createdAt;
    private Timestamp paidAt;
    private Timestamp validFrom;
    private Timestamp validTo;

    public PaymentTransaction() {
    }

    public PaymentTransaction(int transactionId, int userId, int courseId, int packageId, String orderCode, double amount, String vnpTransactionNo, String vnpResponseCode, String vnpOrderInfo, String status, Timestamp createdAt, Timestamp paidAt, Timestamp validFrom, Timestamp validTo) {
        this.transactionId = transactionId;
        this.userId = userId;
        this.courseId = courseId;
        this.packageId = packageId;
        this.orderCode = orderCode;
        this.amount = amount;
        this.vnpTransactionNo = vnpTransactionNo;
        this.vnpResponseCode = vnpResponseCode;
        this.vnpOrderInfo = vnpOrderInfo;
        this.status = status;
        this.createdAt = createdAt;
        this.paidAt = paidAt;
        this.validFrom = validFrom;
        this.validTo = validTo;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getVnpTransactionNo() {
        return vnpTransactionNo;
    }

    public void setVnpTransactionNo(String vnpTransactionNo) {
        this.vnpTransactionNo = vnpTransactionNo;
    }

    public String getVnpResponseCode() {
        return vnpResponseCode;
    }

    public void setVnpResponseCode(String vnpResponseCode) {
        this.vnpResponseCode = vnpResponseCode;
    }

    public String getVnpOrderInfo() {
        return vnpOrderInfo;
    }

    public void setVnpOrderInfo(String vnpOrderInfo) {
        this.vnpOrderInfo = vnpOrderInfo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    public Timestamp getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Timestamp validFrom) {
        this.validFrom = validFrom;
    }

    public Timestamp getValidTo() {
        return validTo;
    }

    public void setValidTo(Timestamp validTo) {
        this.validTo = validTo;
    }

}
