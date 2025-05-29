<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flower Shop - Reset Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="form-container">
        <h2>Reset Password</h2>
        <form action="reset-password" method="post">
            <input type="hidden" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : request.getParameter("email") %>">
            <input type="hidden" name="code" value="<%= request.getAttribute("code") != null ? request.getAttribute("code") : request.getParameter("code") %>">
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="New Password" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            </div>
            <input type="submit" value="RESET PASSWORD">
        </form>
        <div class="links">
            <a href="login.jsp">Back to Login</a>
        </div>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error-message"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="success-message"><%= request.getAttribute("message") %></p>
        <% } %>
    </div>
</body>
</html>