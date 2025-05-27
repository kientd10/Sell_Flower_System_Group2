<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flower Shop - Forgot Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <i class="fas fa-flower-daffodil header-icon"></i>
            <h2>Forgot Your Password?</h2>
            <p class="subtitle">Enter your email to receive a password reset link.</p>
        </div>
        <form action="forgot-password" method="post">
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>
            <input type="submit" value="SEND RESET LINK">
        </form>
        <div class="links">
            <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to Login</a>
        </div>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error-message"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="success-message"><i class="fas fa-check-circle"></i> <%= request.getAttribute("message") %></p>
        <% } %>
    </div>
</body>
</html>