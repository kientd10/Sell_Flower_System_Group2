<%-- 
    Document   : staff
    Created on : Jun 5, 2025, 9:36:24 PM
    Author     : tuanh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRoleId() != 2) { // 2 = Staff
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bảng điều khiển Nhân viên</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="mb-3">Chào mừng, <%= user.getFullName() %>!</h2>
        <p>Bạn đang đăng nhập với quyền <strong>Nhân viên</strong>. Vui lòng chọn tác vụ:</p>

        <div class="list-group mb-3">
            <!-- ✅ Sửa lại đúng servlet -->
            <a href="staffbouquetservlet?action=view" class="list-group-item list-group-item-action">
                🛍️ Quản lý sản phẩm
            </a>
            <a href="order?action=pending" class="list-group-item list-group-item-action">
                📋 Xác nhận đơn hàng
            </a>
            <a href="order?action=confirmed" class="list-group-item list-group-item-action">
                📦 Đơn hàng đã xác nhận
            </a>
            <a href="delivery?action=assign" class="list-group-item list-group-item-action">
                🚚 Giao đơn cho shipper
            </a>
        </div>

        <a href="Customer?action=logout" class="btn btn-danger">Đăng xuất</a>
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>