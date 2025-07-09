<%-- 
    Document   : emailConfirmation
    Created on : Jul 9, 2025, 10:38:49 PM
    Author     : sonpk
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Check Your Email</title>
        <%@include file="includes/head.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>    
        <div class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">
            <div class="card shadow p-4" style="max-width: 500px; width: 100%;">
                <!-- Main Content -->
                <h1 class="h4 fw-bold text-dark mb-3 text-center">Check Your Email</h1>
                <p class="text-muted mb-4 text-center">
                    We've sent you an important message. Please check your email inbox and follow the instructions provided.
                </p>
                <!-- Login Button -->
                <div class="d-grid mb-3">
                    <a href="login.jsp" class="btn btn-primary btn-lg">
                        Go to Login
                    </a>
                </div>
                <p class="text-center text-secondary small">
                    Didn't receive an email? Check your spam folder or contact support</a>.
                </p>
            </div>
        </div>
    </body>
</html>

