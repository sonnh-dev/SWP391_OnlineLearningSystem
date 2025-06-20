<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/head.jsp" %>
        <%@ include file="/includes/auth.jsp" %>
    </head>
    <body>
        <div class="bg-white rounded shadow p-4 p-md-5">
            <!-------------------------------------------------------->
            <!-- Registration Form -->
            <form id="registrationForm" method="post" action="CourseRegister">    
                <input type="hidden" name="courseID" id="courseID" value="${courseID}">
                <div class="mb-5">
                    <h3 class="fs-5 fw-semibold text-dark mb-4">Select Package</h3>
                    <div class="row">
                        <!-- Package -->
                        <c:forEach var="p" items="${coursePackage}" varStatus="loop">
                            <c:set var="discountPrice" value="${(p.originalPrice * (100 - p.saleRate)) / 100}" />
                            <div class="col-sm-4">
                                <label class="package-card card h-100 border shadow-sm p-3 rounded-4 w-100">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <h5 class="fs-5 fw-semibold">${p.packageName}</h5>
                                        <input type="radio" class="form-check-input mt-0 fs-5" name="packageID" data-name="${p.packageName}" 
                                               data-price="${discountPrice}" value="${p.packageID}"  <c:if test="${loop.first}">checked</c:if> > 
                                        </div>
                                        <h3 class="fs-4 fw-bold mb-2" style="color: #4f46e5;">
                                        <fmt:formatNumber value="${discountPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        <c:if test="${p.saleRate > 0}">
                                            <span class="text-decoration-line-through text-secondary fs-6">
                                                <fmt:formatNumber value="${p.originalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </c:if>
                                    </h3>
                                    <ul class="list-unstyled mt-1">
                                        <c:forEach var="feature" items="${fn:split(p.description, ',')}">
                                            <li class="d-flex align-items-center
                                                ${fn:contains(feature, 'No') ? 'text-muted' : 'text-success'} mb-2">
                                                <i class="bi
                                                   ${fn:contains(feature, 'No') ? 'bi-x-circle-fill' : 'bi-check-circle-fill'} me-2"></i>
                                                ${feature}
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- User Information Section (for logged out users) -->
                <c:if test="${empty auth}">
                    <div class="mb-4">
                        <h3 class="fs-5 fw-semibold text-dark mb-3">Personal Information</h3>
                        <div class="row g-3">
                            <!-- First Name -->
                            <div class="col-sm-6">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" class="form-control" placeholder="First Name" name="firstName" value="${firstName}" required>
                                <small class="text-danger">${errors.firstName}</small>
                            </div>
                            <!-- Last Name -->
                            <div class="col-sm-6">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" class="form-control" placeholder="Last Name" name="lastName" value="${lastName}" required>
                                <small class="text-danger">${errors.lastName}</small>
                            </div>
                            <!-- Email -->
                            <div class="col-sm-6">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" placeholder="Email" name="email" value="${email}" required>
                                <small class="text-danger">${errors.email}</small>
                            </div>
                            <!-- Mobile Number -->
                            <div class="col-sm-6">
                                <label for="mobile" class="form-label">Mobile Number</label>
                                <input type="tel" class="form-control" placeholder="Mobile Number" name="mobile" value="${mobile}" required>
                                <small class="text-danger">${errors.mobile}</small>
                            </div>
                            <!-- Gender -->
                            <div class="col-12">
                                <label class="form-label d-block">Gender</label>
                                <div class="d-flex gap-4 ms-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender"  value="male" required>
                                        <label class="form-check-label" for="male">Male</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" value="female">
                                        <label class="form-check-label" for="female">Female</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="gender" value="other">
                                        <label class="form-check-label" for="other">Other</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- Logged In User Info -->
                <c:if test="${not empty auth}">
                    <div id="loginUser" class="mb-4">
                        <div class="bg-light p-3 rounded d-flex align-items-center shadow-sm">
                            <!-- User Icon -->
                            <div class="bg-primary bg-opacity-25 rounded-circle d-flex justify-content-center align-items-center me-3"
                                 style="width: 48px; height: 48px; overflow: hidden;">
                                <img src="${user.avatarUrl}" alt="Avatar" 
                                     style="width: 100%; height: 100%; object-fit: cover; display: block;">
                            </div>
                            <!-- User Info -->
                            <div>
                                <p class="mb-1 fw-semibold text-dark">
                                    Logged in as <span class="text-primary">${user.firstName} ${user.lastName}</span>
                                </p>
                                <p class="mb-0 text-muted small">${user.email} | ${user.phoneNumber}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- Order Summary -->
                <div class="bg-light p-4 rounded mb-4">
                    <h3 class="fs-5 fw-semibold text-dark mb-3">Payment Summary</h3>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-secondary">Package:</span>
                        <span class="fw-medium" id="summaryPackage"></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-secondary">Price:</span>
                        <span class="fw-medium" id="packagePrice"></span>
                    </div>
                    <hr class="my-3">
                    <div class="d-flex justify-content-between">
                        <span class="fw-medium">Total:</span>
                        <span class="fw-bold fs-4" style="color: #4f46e5;" id="summaryPrice"></span>
                    </div>
                </div>

                <!-- Terms and Conditions -->
                <div class="mb-4">
                    <div class="form-check">
                        <input class="form-checkbox h-5 w-5" type="checkbox" id="termsCheck" name="terms" required>
                        <label class="form-check-label" for="termsCheck">
                            <span class="ml-2 text-gray-700">I agree to the <a href="#" class="hover:underline"
                                                                               style="color: #4f46e5;">Terms and Conditions</a> and <a href="#" class="hover:underline"
                                                                               style="color: #4f46e5;">Privacy Policy</a>
                            </span>
                        </label>
                    </div>
                </div>
                <!-- Submit Button -->
                <div class="d-flex justify-content-end">
                    <button type="submit"
                            class="text-white font-bold py-3 px-6 rounded-3 shadow-lg border-0"
                            style=" background-color: #4f46e5;">
                        Complete Registration
                    </button>
                </div>
            </form>
        </div>
        <script>
            //Đổi giá tiền tương ứng với package
            const updatePackageInfo = (radio) => {
                const name = radio.dataset.name;
                const price = Number(radio.dataset.price).toLocaleString('vi-VN') + '₫';
                document.getElementById('summaryPackage').textContent = name;
                document.getElementById('packagePrice').textContent = price;
                document.getElementById('summaryPrice').textContent = price;
            };
            // Gắn sự kiện cho từng radio
            document.querySelectorAll('input[name="package"]').forEach(radio => {
                radio.addEventListener('change', () => updatePackageInfo(radio));
            });
            // Cập nhật thông tin mặc định lúc trang load
            window.addEventListener('DOMContentLoaded', () => {
                updatePackageInfo(document.querySelector('input[name="package"]:checked'));
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("registrationForm");
                form.addEventListener("submit", function (e) {
                    e.preventDefault();
                    const formData = new FormData(form);
                    fetch("./CourseRegister", {
                        method: "POST",
                        body: formData
                    })
                            .then(response => {
                                if (!response.ok)
                                    throw new Error("Submit failed");
                                alert("Register successfully");
                                window.parent.postMessage({action: "closeModalAndRedirect"}, "*");
                            })
                            .catch(error => {
                                console.error(error);
                                alert("Failed to register. Please try again.");
                            });
                });
            });
        </script>
    </body>
</html>
