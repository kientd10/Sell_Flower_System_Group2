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
                padding: 7px 14px;
                border-radius: 16px;
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

            .status-cancelled {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .order-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 1.5px 7px rgba(0,0,0,0.07);
                margin-bottom: 18px;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .order-card:hover {
                box-shadow: 0 3.5px 14px rgba(0,0,0,0.11);
                transform: translateY(-1.5px);
            }

            .order-header {
                background: linear-gradient(135deg, #f8bebe 0%, #ffb6b6 100%);
                padding: 14px 18px;
                border-bottom: 1px solid #dee2e6;
            }

            .order-header h4 {
                color: #333 !important;
                margin: 0;
                font-weight: 600;
                font-size: 17px;
            }

            .order-header p {
                color: #666 !important;
                margin: 4px 0 0 0;
                font-size: 13px;
            }

            .order-content {
                padding: 14px 18px;
            }

            .product-row {
                display: flex;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .product-row:last-child {
                border-bottom: none;
            }

            .product-image {
                width: 46px;
                height: 46px;
                object-fit: cover;
                border-radius: 7px;
                margin-right: 14px;
                box-shadow: 0 1.5px 3.5px rgba(0,0,0,0.1);
            }

            .order-total {
                font-size: 17px;
                font-weight: bold;
                color: #28a745;
                margin: 0;
            }

            .nav-tabs-custom {
                border-bottom: 5px solid #c44d58;
                margin-bottom: 28px;
            }

            .nav-tabs-custom > li > a {
                color: #666;
                font-weight: 500;
                border: none;
                border-radius: 0;
                padding: 11px 18px;
                font-size: 15px;
            }

            .nav-tabs-custom > li.active > a,
            .nav-tabs-custom > li.active > a:hover,
            .nav-tabs-custom > li.active > a:focus {
                background-color: #c44d58;
                color: white;
                border: none;
                border-radius: 12px 12px 0 0;
            }

            .empty-state {
                text-align: center;
                padding: 45px 20px;
                color: #6c757d;
            }

            .empty-state i {
                font-size: 65px;
                margin-bottom: 18px;
                color: #dee2e6;
            }

            .empty-state h4 {
                font-size: 19px;
                margin-bottom: 9px;
            }

            .empty-state p {
                font-size: 15px;
            }

            .order-info-section {
                background: #f8f9fa;
                border-radius: 7px;
                padding: 12px 14px;
                margin: 14px 0;
            }

            .order-info-item {
                display: flex;
                align-items: center;
                margin-bottom: 7px;
                font-size: 13px;
            }

            .order-info-item:last-child {
                margin-bottom: 0;
            }

            .order-info-item i {
                width: 17px;
                margin-right: 9px;
                color: #28a745;
                font-size: 13px;
            }

            .order-info-item strong {
                color: #333;
                margin-right: 7px;
                min-width: 85px;
                font-size: 13px;
            }

            .order-info-item span {
                color: #666;
                flex: 1;
                font-size: 13px;
            }

            .btn-custom {
                border-radius: 16px;
                padding: 7px 18px;
                font-size: 12px;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
                margin: 2px;
            }

            .btn-custom:hover {
                transform: translateY(-1px);
                box-shadow: 0 2.5px 9px rgba(0,0,0,0.15);
            }

            .btn-reorder {
                background-color: #28a745;
                color: white;
            }

            .btn-reorder:hover {
                background-color: #218838;
                color: white;
            }

            .btn-cancel {
                background-color: #dc3545;
                color: white;
            }

            .btn-cancel:hover {
                background-color: #c82333;
                color: white;
            }

            /* Tăng kích thước cho tiêu đề trang */
            .text-center h2 {
                font-size: 26px;
                margin-bottom: 9px;
            }

            .text-center p {
                font-size: 15px;
            }

            /* Tăng kích thước cho tên sản phẩm */
            .product-row h5 {
                font-size: 15px;
                margin-bottom: 4px;
            }

            .product-row p {
                font-size: 13px;
            }

            /* Tăng kích thước cho giá */
            .product-row strong {
                font-size: 17px;
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
                        <!-- Hiển thị thông báo -->
                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert alert-success alert-dismissible fade in" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <i class="fa fa-check-circle"></i> ${sessionScope.message}
                            </div>
                            <c:remove var="message" scope="session"/>
                        </c:if>

                        <c:if test="${not empty sessionScope.error}">
                            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <i class="fa fa-exclamation-circle"></i> ${sessionScope.error}
                            </div>
                            <c:remove var="error" scope="session"/>
                        </c:if>

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
                            <li role="presentation">
                                <a href="#cancelled" aria-controls="cancelled" role="tab" data-toggle="tab">
                                    <i class="fa fa-times-circle"></i> Đã hủy
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
                                                    <span class="order-status status-pending status-badge">
                                                        <i class="fa fa-clock-o"></i> ${order.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-content">
                                            <c:forEach var="item" items="${order.items}">
                                                <div class="product-row">
                                                    <a href="bouquet-detail?templateId=${item.templateId}" style="text-decoration: none;" title="Click để xem chi tiết sản phẩm">
                                                        <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'" style="cursor: pointer;">
                                                    </a>
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
                                            <div style="margin-top:5px; padding-top: 5px;">
                                                <div class="order-info-section">
                                                    <div class="order-info-item">
                                                        <i class="fa fa-map-marker"></i>
                                                        <strong>Địa chỉ giao hàng:</strong>
                                                        <span>${order.deliveryAddress}</span>
                                                    </div>
                                                    <div class="order-info-item">
                                                        <i class="fa fa-phone"></i>
                                                        <strong>Số điện thoại:</strong>
                                                        <span>${order.deliveryPhone}</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 text-right">
                                                        <h6 style="color: #333; font-weight: 600; margin-bottom: 10px; display: inline-block; margin-right: 0px; font-size: 14px;">
                                                            <i class="fa fa-money" ></i> Tổng tiền  :
                                                        </h6>
                                                        <p class="order-total" style="margin: 10px 10px; display: inline-block;">
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                        <div style="margin-top: 10px;">
                                  
                                                            <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-custom" style="margin-right: 10px;">
                                                                <i class="fa fa-eye"></i> Chi tiết
                                                            </a>
                                                            <a href="https://www.facebook.com/tran.uc.kien.588942" class="btn btn-warning btn-custom" style="margin-right: 10px;">
                                                                <i class="fa fa-phone"></i> Liên hệ
                                                            </a>
                                                            <form method="post" action="orders" style="display: inline;">
                                                                <input type="hidden" name="action" value="cancelOrder">
                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                <button type="submit" class="btn btn-cancel btn-custom" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                                                    <i class="fa fa-times"></i> Hủy đơn
                                                                </button>
                                                            </form>
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
                                                    <span class="order-status status-preparing status-badge">
                                                        <i class="fa fa-cog fa-spin"></i> ${order.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-content">
                                            <c:forEach var="item" items="${order.items}">
                                                <div class="product-row">
                                                    <a href="bouquet-detail?templateId=${item.templateId}" style="text-decoration: none;" title="Click để xem chi tiết sản phẩm">
                                                        <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'" style="cursor: pointer;">
                                                    </a>
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
                                            <div style="margin-top:5px; padding-top: 5px;">
                                                <div class="order-info-section">
                                                    <div class="order-info-item">
                                                        <i class="fa fa-map-marker"></i>
                                                        <strong>Địa chỉ giao hàng:</strong>
                                                        <span>${order.deliveryAddress}</span>
                                                    </div>
                                                    <div class="order-info-item">
                                                        <i class="fa fa-phone"></i>
                                                        <strong>Số điện thoại:</strong>
                                                        <span>${order.deliveryPhone}</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 text-right">
                                                        <h6 style="color: #333; font-weight: 600; margin-bottom: 10px; display: inline-block; margin-right: 0px; font-size: 14px;">
                                                            <i class="fa fa-money"></i> Tổng tiền  :
                                                        </h6>
                                                        <p class="order-total" style="margin: 10px 10px; display: inline-block;">
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                        <div style="margin-top: 10px;">
                                                            <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-custom" style="margin-right: 10px;">
                                                                <i class="fa fa-eye"></i> Chi tiết
                                                            </a>
                                                            <a href="https://www.facebook.com/tran.uc.kien.588942" class="btn btn-warning btn-custom">
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
                                                    <span class="order-status status-shipping status-badge">
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
                                                    <a href="bouquet-detail?templateId=${item.templateId}" style="text-decoration: none;" title="Click để xem chi tiết sản phẩm">
                                                        <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'" style="cursor: pointer;">
                                                    </a>
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
                                            <div style="margin-top:5px; padding-top: 5px;">
                                                <div class="order-info-section">
                                                    <div class="order-info-item">
                                                        <i class="fa fa-map-marker"></i>
                                                        <strong>Địa chỉ giao hàng:</strong>
                                                        <span>${order.deliveryAddress}</span>
                                                    </div>
                                                    <div class="order-info-item">
                                                        <i class="fa fa-phone"></i>
                                                        <strong>Số điện thoại:</strong>
                                                        <span>${order.deliveryPhone}</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 text-right">
                                                        <h6 style="color: #333; font-weight: 600; margin-bottom: 10px; display: inline-block; margin-right: 0px; font-size: 14px;">
                                                            <i class="fa fa-money"></i> Tổng tiền  :
                                                        </h6>
                                                        <p class="order-total" style="margin: 10px 10px; display: inline-block;">
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                        <div style="margin-top: 10px;">
                                                            <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-custom" style="margin-right: 10px;">
                                                                <i class="fa fa-eye"></i> Chi tiết
                                                            </a>
                                                            <a href="https://www.facebook.com/tran.uc.kien.588942" class="btn btn-warning btn-custom">
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
                                                    <span class="order-status status-completed status-badge">
                                                        <i class="fa fa-check-circle"></i> ${order.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-content">
                                            <c:forEach var="item" items="${order.items}">
                                                <div class="product-row">
                                                    <a href="bouquet-detail?templateId=${item.templateId}" style="text-decoration: none;" title="Click để xem chi tiết sản phẩm">
                                                        <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'" style="cursor: pointer;">
                                                    </a>
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
                                            <div style="margin-top:5px; padding-top: 5px;">
                                                <div class="order-info-section">
                                                    <div class="order-info-item">
                                                        <i class="fa fa-map-marker"></i>
                                                        <strong>Địa chỉ giao hàng:</strong>
                                                        <span>${order.deliveryAddress}</span>
                                                    </div>
                                                    <div class="order-info-item">
                                                        <i class="fa fa-phone"></i>
                                                        <strong>Số điện thoại:</strong>
                                                        <span>${order.deliveryPhone}</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 text-right">
                                                        <h6 style="color: #333; font-weight: 600; margin-bottom: 10px; display: inline-block; margin-right: 0px; font-size: 14px;">
                                                            <i class="fa fa-money"></i> Tổng tiền  :
                                                        </h6>
                                                        <p class="order-total" style="margin: 10px 10px; display: inline-block;">
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                        <div style="margin-top: 10px;">
                                                            <c:forEach var="item" items="${order.items}">
                                                                <a href="feedback-form?product_id=${item.templateId}" class="btn btn-success btn-custom" style="margin-right: 10px;">
                                                                    <i class="fa fa-star"></i> Đánh giá ${item.productName}
                                                                </a>
                                                            </c:forEach>
                                                            <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-custom" style="margin-right: 10px;">
                                                                <i class="fa fa-eye"></i> Chi tiết
                                                            </a>
                                                            <a href="reorder?orderId=${order.orderId}" class="btn btn-success btn-custom">
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

                            <!-- Cancelled Orders Tab -->
                            <div role="tabpanel" class="tab-pane" id="cancelled">
                                <c:if test="${empty cancelledOrders}">
                                    <div class="empty-state">
                                        <i class="fa fa-times-circle"></i>
                                        <h4>Đã hủy</h4>
                                        <p>Các đơn hàng đã hủy sẽ hiển thị ở đây</p>
                                    </div>
                                </c:if>
                                <c:forEach var="order" items="${cancelledOrders}">
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
                                                    <span class="order-status status-cancelled status-badge">
                                                        <i class="fa fa-times-circle"></i> ${order.status}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-content">
                                            <c:forEach var="item" items="${order.items}">
                                                <div class="product-row">
                                                    <a href="bouquet-detail?templateId=${item.templateId}" style="text-decoration: none;" title="Click để xem chi tiết sản phẩm">
                                                        <img src="${item.imageUrl}" alt="${item.productName}" class="product-image" onerror="this.src='https://via.placeholder.com/70x70'" style="cursor: pointer;">
                                                    </a>
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
                                            <div style="margin-top:5px; padding-top: 5px;">
                                                <div class="order-info-section">
                                                    <div class="order-info-item">
                                                        <i class="fa fa-map-marker"></i>
                                                        <strong>Địa chỉ giao hàng:</strong>
                                                        <span>${order.deliveryAddress}</span>
                                                    </div>
                                                    <div class="order-info-item">
                                                        <i class="fa fa-phone"></i>
                                                        <strong>Số điện thoại:</strong>
                                                        <span>${order.deliveryPhone}</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 text-right">
                                                        <h6 style="color: #333; font-weight: 600; margin-bottom: 10px; display: inline-block; margin-right: 0px; font-size: 14px;">
                                                            <i class="fa fa-money"></i> Tổng tiền  :
                                                        </h6>
                                                        <p class="order-total" style="margin: 10px 10px; display: inline-block;">
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                        <div style="margin-top: 10px;">
                                                            <a href="orderDetails?orderId=${order.orderId}" class="btn btn-info btn-custom" style="margin-right: 10px;">
                                                                <i class="fa fa-eye"></i> Chi tiết
                                                            </a>
                                                            <a href="reorder?orderId=${order.orderId}" class="btn btn-success btn-custom">
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