<%-- 
    Document   : orders
    Created on : Jan 19, 2025, 10:30:00 AM
    Author     : PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>My Orders | Flower Shop</title>
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
    
<style>
    .order-status {
        padding: 8px 15px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
        display: inline-block;
    }
    .status-pending { 
        background-color: #fff3cd; 
        color: #856404; 
        border: 1px solid #ffeaa7;
    }
    .status-preparing { 
        background-color: #d1ecf1; 
        color: #0c5460; 
        border: 1px solid #bee5eb;
    }
    .status-shipping { 
        background-color: #ffe6cc; 
        color: #cc7a00; 
        border: 1px solid #ffcc99;
    }
    .status-completed { 
        background-color: #d4edda; 
        color: #155724; 
        border: 1px solid #c3e6cb;
    }
    
    .order-card {
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        margin-bottom: 25px;
        background: white;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        overflow: hidden;
    }
    
    .order-header {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        padding: 20px;
        border-bottom: 1px solid #dee2e6;
    }
    
    .order-content {
        padding: 20px;
    }
    
    .product-row {
        display: flex;
        align-items: center;
        padding: 15px;
        border: 1px solid #f0f0f0;
        border-radius: 8px;
        margin-bottom: 10px;
        background-color: #fafafa;
    }
    
    .product-image {
        width: 70px;
        height: 70px;
        object-fit: cover;
        border-radius: 8px;
        margin-right: 15px;
    }
    
    .order-total {
        font-size: 20px;
        font-weight: bold;
        color: #28a745;
    }
    
    .nav-tabs-custom {
        border-bottom: 7px solid #c44d58;
        margin-bottom: 30px;
    }
    
    .nav-tabs-custom > li > a {
        color: #666;
        font-weight: 500;
        border: none;
        border-radius: 0;
        padding: 12px 20px;
    }
    
    .nav-tabs-custom > li.active > a,
    .nav-tabs-custom > li.active > a:hover,
    .nav-tabs-custom > li.active > a:focus {
        background-color: #c44d58;
        color: white;
        border: none;
        border-radius: 15px 15px 0 0;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #6c757d;
    }
    
    .empty-state i {
        font-size: 80px;
        margin-bottom: 20px;
        color: #dee2e6;
    }
</style>

</head>

    <body>
        
        <header id="header"><!--header-->
            <div class="header_top"><!--header_top-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="contactinfo">
                                <ul class="nav nav-pills">
                                    <li><a href="#"><i class="fa fa-phone"></i> 0123456789</a></li>
                                    <li><a href="#"><i class="fa fa-envelope"></i> Group2@fpt.edu.vn</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="social-icons pull-right">
                                <ul class="nav navbar-nav">
                                    <li><a href="https://github.com/kientd10/Sell_Flower_System_Group2"><i class="fa fa-brands fa-github"></i></a></li>
                                    <li><a href="https://www.facebook.com/share/16ohs8HR5g/?mibextid=wwXIfr"><i class="fa fa-facebook"></i></a></li>                                   
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header_top-->


            <div class="header-middle"><!--header-middle-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <a href="${pageContext.request.contextPath}/home?pageNum=1" ><img src="https://i.ibb.co/CsMwqtJx/logo-2.png" alt="" width="120px" height="70px" /></a>
                            </div>
                        </div>

                        <div class="col-sm-8">
                            <div class="shop-menu pull-right">
                                <ul class="nav navbar-nav">
                                    <c:if test="${sessionScope.user != null}">
                                        <li><a href="profile"><i class="fa fa-user"></i> Hồ sơ</a></li>
                                        <li><a href="orders"><i class="fa fa-truck"></i> Đơn mua</a></li>
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>
                                        <li><a href="Customer?action=logout"><b>Đăng xuất</b></a></li> 
                                        </c:if> 
                                        <c:if test="${sessionScope.user == null}">
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>
                                        <li><a href="login.jsp"><b>Đăng nhập</b></a></li> 
                                        </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header-middle-->

            <div class="header-bottom"><!--header-bottom-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="mainmenu pull-left">
                                <ul class="nav navbar-nav collapse navbar-collapse">
                                    <li><a href="${pageContext.request.contextPath}/home?pageNum=1" class="active">Trang chủ</a></li>                            
                                    <li><a href="contact-us.jsp">Liên hệ</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header-bottom-->        
        </header><!--/header-->

    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center" style="margin-bottom: 40px;">
                        <h2><i class="fa fa-shopping-bag"></i> Đơn hàng </h2>
                        <p class="text-muted">Theo dõi và quản lý đơn hàng của bạn</p>
                    </div>

                    <ul class="nav nav-tabs nav-tabs-custom" role="tablist">
                        <li role="presentation" class="active">
                            <a href="#pending" aria-controls="pending" role="tab" data-toggle="tab">
                                <i class="fa fa-clock-o"></i> Chờ xác nhận
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#preparing" aria-controls="preparing" role="tab" data-toggle="tab">
                                <i class="fa fa-cog"></i> Đang chuẩn bị
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#shipping" aria-controls="shipping" role="tab" data-toggle="tab">
                                <i class="fa fa-truck"></i> Chờ giao hàng
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#completed" aria-controls="completed" role="tab" data-toggle="tab">
                                <i class="fa fa-check-circle"></i> Đã mua
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <!-- Pending Orders Tab -->
                        <div role="tabpanel" class="tab-pane active" id="pending">
                            <c:if test="${empty pendingOrders}">
                                <div class="empty-state">
                                    <i class="fa fa-clock-o"></i>
                                    <h4>Chờ xác nhận</h4>
                                    <p>Các đơn hàng đang chờ cửa hàng xác nhận sẽ hiển thị ở đây</p>                                   
                                </div>
                            </c:if>
                            <c:forEach var="order" items="${pendingOrders}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #${order.orderCode}
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-pending">
                                                    <i class="fa fa-clock-o"></i> ${order.status}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="product-row">
                                                <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'">
                                                <div style="flex: 1;">
                                                    <h5 style="margin: 0; font-weight: bold;">${item.productName}</h5>
                                                    <p style="margin: 5px 0 0 0; color: #666;">Số lượng: ${item.quantity}</p>
                                                </div>
                                                <div class="text-right">
                                                    <strong style="color: #333; font-size: 16px;">
                                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                                                    </strong>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        ${order.deliveryAddress}
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                    </p>
                                                    <div>
                                                        <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-sm">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Preparing Orders Tab -->
                        <div role="tabpanel" class="tab-pane" id="preparing">
                            <c:if test="${empty preparingOrders}">
                                <div class="empty-state">
                                    <i class="fa fa-cog"></i>
                                    <h4>Đang chuẩn bị</h4>
                                    <p>Các đơn hàng đang được chuẩn bị sẽ hiển thị ở đây</p>
                                </div>
                            </c:if>
                            <c:forEach var="order" items="${preparingOrders}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #${order.orderCode}
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-preparing">
                                                    <i class="fa fa-cog fa-spin"></i> ${order.status}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="product-row">
                                                <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'">
                                                <div style="flex: 1;">
                                                    <h5 style="margin: 0; font-weight: bold;">${item.productName}</h5>
                                                    <p style="margin: 5px 0 0 0; color: #666;">Số lượng: ${item.quantity}</p>
                                                </div>
                                                <div class="text-right">
                                                    <strong style="color: #333; font-size: 16px;">
                                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                                                    </strong>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        ${order.deliveryAddress}
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                    </p>
                                                    <div>
                                                        <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-sm">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Shipping Orders Tab -->
                        <div role="tabpanel" class="tab-pane" id="shipping">
                            <c:if test="${empty shippingOrders}">
                                <div class="empty-state">
                                    <i class="fa fa-truck"></i>
                                    <h4>Chờ giao hàng</h4>
                                    <p>Các đơn hàng đang được giao sẽ hiển thị ở đây</p>
                                </div>
                            </c:if>
                            <c:forEach var="order" items="${shippingOrders}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #${order.orderCode}
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-shipping">
                                                    <i class="fa fa-truck"></i> ${order.status}
                                                </span>
                                                <p style="margin: 5px 0 0 0; color: #666; font-size: 13px;">
                                                    Dự kiến giao: <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="product-row">
                                                <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'">
                                                <div style="flex: 1;">
                                                    <h5 style="margin: 0; font-weight: bold;">${item.productName}</h5>
                                                    <p style="margin: 5px 0 0 0; color: #666;">Số lượng: ${item.quantity}</p>
                                                </div>
                                                <div class="text-right">
                                                    <strong style="color: #333; font-size: 16px;">
                                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                                                    </strong>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        ${order.deliveryAddress}
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                    </p>
                                                    <div>
                                                        <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-sm" style="margin-right: 10px;">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </a>
                                                        <a href="contactSupport?orderId=${order.orderId}" class="btn btn-warning btn-sm">
                                                            <i class="fa fa-phone"></i> Liên hệ
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Completed Orders Tab -->
                        <div role="tabpanel" class="tab-pane" id="completed">
                            <c:if test="${empty completedOrders}">
                                <div class="empty-state">
                                    <i class="fa fa-check-circle"></i>
                                    <h4>Đã hoàn thành</h4>
                                    <p>Các đơn hàng đã hoàn thành sẽ hiển thị ở đây</p>
                                </div>
                            </c:if>
                            <c:forEach var="order" items="${completedOrders}">
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #${order.orderCode}
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-completed">
                                                    <i class="fa fa-check-circle"></i> ${order.status}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="product-row">
                                                <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'">
                                                <div style="flex: 1;">
                                                    <h5 style="margin: 0; font-weight: bold;">${item.productName}</h5>
                                                    <p style="margin: 5px 0 0 0; color: #666;">Số lượng: ${item.quantity}</p>
                                                </div>
                                                <div class="text-right">
                                                    <strong style="color: #333; font-size: 16px;">
                                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                                                    </strong>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        ${order.deliveryAddress}
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                    </p>
                                                    <div>
                                                        <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-sm" style="margin-right: 10px;">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </a>
                                                        <a href="reorder?orderId=${order.orderId}" class="btn btn-success btn-sm">
                                                            <i class="fa fa-refresh"></i> Mua lại
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer id="footer"><!--Footer-->
            <div class="footer-widget">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="single-widget">
                                <h2>Dịch vụ</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="orders">Xem đơn mua</a></li>
                                    <li><a href="profile">Thay đổi hồ sơ</a></li>
                                    <li><a href="#">Giỏ hoa theo yêu cầu</a></li>
                                    <li><a href="${pageContext.request.contextPath}/home?pageNum=1">Tiếp tục mua sắm</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="single-widget">
                                <h2>Liên hệ </h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="https://www.facebook.com/tran.uc.kien.588942">Facebook</a></li>
                                    <li><a href="https://github.com/kientd10/Sell_Flower_System_Group2">Github</a></li>
                                    <li><a href="https://accounts.google.com/v3/signin/identifier?ifkv=AdBytiMmsOAuql232UmLNKelOUNWSkE5R7zTjDiG1c2Eh9s_g4WpAUxqvRqKj9gMYsdypUFg84Mr&service=mail&flowName=GlifWebSignIn&flowEntry=ServiceLogin&dsh=S1730468177%3A1750350775108616">kientdhe186194@fpt.edu.vn</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3 col-sm-offset-1">
                            <div class="single-widget">
                                <h2>Về chúng tôi</h2>
                                <form action="#" class="searchform">
                                    <input type="text" placeholder="Nhập email" />
                                    <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                                    <p>Đăng kí để nhận được các thông báo <br />Ưu đãi và sản phẩm mới nhất...</p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <p class="pull-left">Copyright © 2025  Flower Shop. All rights reserved</p>
                        <p class="pull-right">Designed by <span><a target="_blank" href="https://github.com/kientd10/Sell_Flower_System_Group2">Group 2</a></span></p>
                    </div>
                </div>
            </div>
        </footer><!--/Footer-->

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/price-range.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>

    <c:if test="${sessionScope.user != null}">
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" style="width: 300px; z-index: 500000">
            <div class="toast-header">
                <strong class="mr-auto">Thông báo</strong>
                <small>...</small>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="toast-body">
                Chào mừng bạn đến với trang giỏ hàng
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $('.toast').toast({
                    delay: 3500
                });
                $('.toast').toast('show');
            });
        </script>
        <style>
            .toast {
                position: fixed;
                bottom: 20px;
                right: 20px;
            }
        </style>
    </c:if>
</body>
</html>