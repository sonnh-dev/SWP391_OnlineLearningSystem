<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Prepayment Confirmation</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">
        <div class="card shadow rounded-4" style="max-width: 700px; width: 100%;">
            <div class="card-body p-4">
                <form id="paymentForm" method="post" action="create-payment">
                    <!-- Course Information -->
                    <div class="mb-4">
                        <h5>Course Information</h5>
                        <div class="bg-light p-3 rounded mb-2">
                            <p class="mb-1"><strong>Course:</strong> ${courseName}</p>
                            <p class="mb-1"><strong>Package:</strong> ${packageName}</p>
                            <p class="mb-1"><strong>Customer name:</strong> ${user}</p>
                            <p class="mb-0 text-primary fw-bold fs-5">
                                Price: <fmt:formatNumber value="${price}" type="number" groupingUsed="true"/> ₫
                            </p>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div class="mb-4">
                        <h5 class="mb-3">Payment Method</h5>
                        <div class="form-check border rounded-4 p-3 bg-white d-flex align-items-center" style="min-height: 60px;">
                            <input class="form-check-input me-3 ms-3" type="radio" name="paymentMethod" id="vnpay" value="vnpay" checked>
                            <label class="form-check-label d-flex align-items-center justify-content-between w-100" for="vnpay" style="cursor: pointer;">
                                <span class="fw-semibold">Pay with VNPAY</span>
                                <img src="https://stcd02206177151.cloud.edgevnpay.vn/assets/images/logo-icon/logo-primary.svg"
                                     alt="VNPAY" style="height: 32px;">
                            </label>
                        </div>
                    </div>
                    <!-- Buttons -->
                    <div class="d-flex justify-content-between mt-4">
                        <a href="#" class="btn btn-outline-secondary" id="cancelBtn">Cancel</a>
                        <button type="button" class="btn btn-primary" id="proceedBtn">Proceed to Payment</button>
                    </div>  
                </form>
            </div>
        </div>
        <script>
            // Button event
            document.getElementById("cancelBtn").addEventListener("click", (e) => {
                e.preventDefault();
                window.parent.postMessage({
                    action: "toMyRegister",
                    redirectUrl: "myRegistration",
                    userId: ${userId}
                }, "*");
            });
            document.getElementById("proceedBtn").addEventListener("click", () => {
                const data = {
                    action: "proceedToPayment",
                    userId: "${userId}",
                    courseId: "${courseId}",
                    packageName: "${packageName}",
                    price: "${price}",
                    useTime: "${useTime}"
                };
                // send Data to CourseDetails
                window.parent.postMessage(data, "*");
            });
        </script>
    </body>
</html>
