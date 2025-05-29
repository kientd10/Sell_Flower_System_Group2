<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flower Shop - Verify Code</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="form-container">
        <h2>Verify Code</h2>
        <p class="subtitle">Enter the 6-digit code sent to your email.</p>
        <form action="reset-password" method="post">
            <div class="input-group">
                <i class="fas fa-key"></i>
                <input typemuốn gửi email cho mình nhé type="email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" readonly>
            </div>
            <div class="input-group">
                <i class="fas fa-key"></i>
                <input type="text" name="code" placeholder="Enter 6-digit code" maxlength="6" required>
            </div>
            <input type="submit" value="VERIFY CODE">
        </form>
        <div class="links">
            <a href="forgot-password.jsp">Back to Forgot Password</a>
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