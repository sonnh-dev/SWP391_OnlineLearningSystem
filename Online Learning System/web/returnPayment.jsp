<%-- 
    Document   : returnPayment
    Created on : Jun 25, 2025, 9:47:59 PM
    Author     : sonpk
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>return payment</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body style="background-color: #f8f9fa;">
        <div class="container py-5 text-center">
            <div>
                <i class="bi" id="status-icon" style="font-size: 3rem;"></i>
                <h2 class="fw-bold mt-3">
                    <c:choose>
                        <c:when test="${status == 'success'}">Payment successfully!</c:when>
                        <c:otherwise>Payment failure!</c:otherwise>
                    </c:choose>
                </h2>
                <p class="text-muted mb-4">
                    <c:choose>
                        <c:when test="${status == 'success'}">Thank you for choosing our course.</c:when>
                        <c:otherwise>Please try again or contact support.</c:otherwise>
                    </c:choose>
                </p>

                <div class="bg-light rounded-3 p-4 mx-auto" style="max-width: 500px;">
                    <div class="row mb-2">
                        <div class="col-6 text-start text-muted">Order code:</div>
                        <div class="col-6 text-end fw-semibold">#${orderCode}</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6 text-start text-muted">Payment day:</div>
                        <div class="col-6 text-end fw-semibold" id="current-date">--/--/----</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6 text-start text-muted">Method:</div>
                        <div class="col-6 text-end fw-semibold">VNPay - ${bankCode}</div>
                    </div>
                    <div class="row">
                        <div class="col-6 text-start text-muted">Price:</div>
                        <div class="col-6 text-end fw-bold text-primary">
                            <c:out value="${amount}" /> ₫
                        </div>
                    </div>
                </div>

                <a href="/my-courses" class="btn btn-outline-primary mt-4">Go my course</a>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const now = new Date();
                const day = String(now.getDate()).padStart(2, '0');
                const month = String(now.getMonth() + 1).padStart(2, '0');
                const year = now.getFullYear();
                const formattedDate = day + '/' + month + '/' + year;
                document.getElementById('current-date').textContent = formattedDate;

                const status = "${status}"?.toLowerCase();
                const icon = document.getElementById("status-icon");
                if (status === "success") {
                    icon.classList.add("bi-check-circle-fill");
                    icon.style.color = "#28a745";
                } else {
                    icon.classList.add("bi-x-circle-fill");
                    icon.style.color = "#dc3545";
                }
            });
        </script>
    </body>
</html>
