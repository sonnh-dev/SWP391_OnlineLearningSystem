package controller.payment;

import config.PaymentConfig;
import dao.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PaymentTransaction;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.util.*;

@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpay-return"})
public class VnpayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Begin process return from VNPAY
        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = PaymentConfig.hashAllFields(fields);

        String status;
        String orderCode = request.getParameter("vnp_TxnRef");
        String amount = request.getParameter("vnp_Amount");
        String bankCode = request.getParameter("vnp_BankCode");
        String payDate = request.getParameter("vnp_PayDate");
        String transactionNo = request.getParameter("vnp_TransactionNo");
        String orderInfo = request.getParameter("vnp_OrderInfo");

        if (signValue.equals(vnp_SecureHash)) {
            String responseCode = (String) fields.get("vnp_ResponseCode");
            PaymentDAO dao = new PaymentDAO();
            PaymentTransaction transaction = dao.getPaymentTransactionByOrderCode(orderCode);
            if (transaction != null) {
                if ("00".equals(responseCode)) {
                    transaction.setStatus("SUCCESS");
                    transaction.setPaidAt(new Timestamp(System.currentTimeMillis()));
                    status = "success";
                } else {
                    transaction.setStatus("FAILED");
                    status = "failed";
                }
                transaction.setVnpTransactionNo(transactionNo);
                transaction.setVnpResponseCode(responseCode);
                transaction.setVnpOrderInfo(orderInfo);
                dao.updatePaymentTransaction(transaction);
            } else {
                status = "not_found";
            }
        } else {
            status = "invalid_signature";
        }
        request.setAttribute("status", status);
        request.setAttribute("orderCode", orderCode);
        request.setAttribute("amount", amount);
        request.setAttribute("bankCode", bankCode);
        request.setAttribute("payDate", payDate);
        request.setAttribute("transactionNo", transactionNo);
        request.setAttribute("orderInfo", orderInfo);
        request.getRequestDispatcher("returnPayment.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Vnpay Return Servlet";
    }
}
