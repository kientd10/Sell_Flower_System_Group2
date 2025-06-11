<%-- 
    Document   : staff
    Created on : Jun 5, 2025, 9:36:24 PM
    Author     : tuanh
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Login | Flower Shop</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    </head>
<body>
    <div class="container mt-5">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-success">Xin chào, <%= user.getFullName() %>!</h2>
            <p class="lead">Bạn đang đăng nhập với quyền <strong>Nhân viên</strong>. Vui lòng chọn chức năng:</p>
        </div>

        <div class="row row-cols-1 row-cols-md-2 g-4">
            <div class="col">
                <a href="staffbouquetservlet?action=view" class="card h-100 text-decoration-none text-dark shadow-sm">
                    <div class="card-body text-center">
                        <i class="fa fa-leaf fa-2x mb-3 text-success"></i>
                        <h5 class="card-title">Quản lý sản phẩm</h5>
                        <p class="card-text">Xem và cập nhật danh sách sản phẩm hoa.</p>
                    </div>
                </a>
            </div>
            <div class="col">
                <a href="order?action=pending" class="card h-100 text-decoration-none text-dark shadow-sm">
                    <div class="card-body text-center">
                        <i class="fa fa-list-alt fa-2x mb-3 text-warning"></i>
                        <h5 class="card-title">Xác nhận đơn hàng</h5>
                        <p class="card-text">Xem và xử lý các đơn hàng đang chờ xác nhận.</p>
                    </div>
                </a>
            </div>
            <div class="col">
                <a href="order?action=confirmed" class="card h-100 text-decoration-none text-dark shadow-sm">
                    <div class="card-body text-center">
                        <i class="fa fa-check-square fa-2x mb-3 text-primary"></i>
                        <h5 class="card-title">Đơn hàng đã xác nhận</h5>
                        <p class="card-text">Xem danh sách các đơn hàng đã được xử lý.</p>
                    </div>
                </a>
            </div>
            <div class="col">
                <a href="delivery?action=assign" class="card h-100 text-decoration-none text-dark shadow-sm">
                    <div class="card-body text-center">
                        <i class="fa fa-truck fa-2x mb-3 text-danger"></i>
                        <h5 class="card-title">Giao đơn cho shipper</h5>
                        <p class="card-text">Chọn đơn hàng để giao cho đơn vị vận chuyển.</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="Customer?action=logout" class="btn btn-outline-danger">Đăng xuất</a>
        </div>
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>