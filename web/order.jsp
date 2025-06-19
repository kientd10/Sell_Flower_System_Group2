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
                border-bottom: 7px solid #FE980F;
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
                background-color: #FE980F;
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
                                    <li><a href="#"><i class="fa fa-envelope"></i> kientdhe186194@fpt.edu.vn</a></li>
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
                                <a href="index.jsp"><img src="https://i.ibb.co/CsMwqtJx/logo-2.png" alt="" width="120px" height="70px" /></a>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="shop-menu pull-right">
                                <ul class="nav navbar-nav">
                                    <c:if test="${sessionScope.user != null}">
                                        <li><a href="profile"><i class="fa fa-user"></i> Account</a></li>
                                        <li><a href="checkout.jsp"><i class="fa fa-credit-card"></i> Payment</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.user == null}">
                                        <li><a href="login.jsp"><i class="fa fa-shopping-cart"></i> Shopping Cart</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.user != null}">
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Shopping Cart</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.user==null}">
                                        <li><a href="login.jsp">Login</a></li> 
                                        </c:if>
                                        <c:if test="${sessionScope.user!=null}">
                                        <li><a href="Customer?action=logout"><b>Logout</b></a></li> 
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
                                    <li><a href="${pageContext.request.contextPath}/home" class="active">Home</a></li>
                                    <li class="dropdown"><a href="#">Category<i class="fa fa-angle-down"></i></a>
                                        <ul role="menu" class="sub-menu">
                                            <c:if test="${empty categories}">
                                                <li><a href="#">Không có danh mục nào</a></li>
                                                </c:if>
                                                <c:forEach var="category" items="${categories}">
                                                <li><a href="${pageContext.request.contextPath}/bouquet?categoryId=${category.categoryId}">
                                                        ${category.categoryName}</a></li>
                                                    </c:forEach>
                                        </ul>
                                    </li>
                                    <li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                                        <ul role="menu" class="sub-menu">
                                            <li><a href="blog.jsp">Blog List</a></li>
                                            <li><a href="blog-single.jsp">Blog Single</a></li>
                                        </ul>
                                    </li>                              
                                    <li><a href="contact-us.jsp">Contact</a></li>
                                    <li><a href="404.jsp">404</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="search_box pull-right">
                                <input type="text" placeholder="Search"/>
                                <button type="submit">
                                    <i class="fa fa-eye" style="border: none; height: 29px; line-height: 29px;"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header-bottom-->        
        </header><!--/header-->

        <!-- Main Content -->
        <section style="padding: 50px 0;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Page Title -->
                        <div class="text-center" style="margin-bottom: 40px;">
                            <h2><i class="fa fa-shopping-bag"></i> Đơn hàng của tôi</h2>
                            <p class="text-muted">Theo dõi và quản lý đơn hàng của bạn</p>
                        </div>

                        <!-- Order Status Tabs -->
                        <ul class="nav nav-tabs nav-tabs-custom" role="tablist">

                            <li role="presentation">
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

                        <!-- Tab Content -->
                        <div class="tab-content">
                            <!-- Pending Orders Tab -->
                            <div role="tabpanel" class="tab-pane" id="pending">
                                <div class="empty-state">
                                    <i class="fa fa-clock-o"></i>
                                    <h4>Chờ xác nhận</h4>
                                    <p>Các đơn hàng đang chờ cửa hàng xác nhận sẽ hiển thị ở đây</p>
                                </div>
                                                                <!-- Sample Order 3 -->
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #DH003
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: 18/01/2024
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-pending">
                                                    <i class="fa fa-clock-o"></i> Chờ xác nhận
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <div class="product-row">
                                            <img src="https://via.placeholder.com/70x70/a29bfe/ffffff?text=Daisy" alt="Hoa cúc" class="product-image">
                                            <div style="flex: 1;">
                                                <h5 style="margin: 0; font-weight: bold;">Hoa cúc trắng</h5>
                                                <p style="margin: 5px 0 0 0; color: #666;">Số lượng: 1</p>
                                            </div>
                                            <div class="text-right">
                                                <strong style="color: #333; font-size: 16px;">85,000₫</strong>
                                            </div>
                                        </div>

                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        789 Võ Văn Tần, Quận 3, TP.HCM
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">85,000₫</p>
                                                    <div>
                                                        <button class="btn btn-info btn-sm" style="margin-right: 10px;">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Preparing Orders Tab -->
                            <div role="tabpanel" class="tab-pane" id="preparing">
                                <div class="empty-state">
                                    <i class="fa fa-cog"></i>
                                    <h4>Đang chuẩn bị</h4>
                                    <p>Các đơn hàng đang được chuẩn bị sẽ hiển thị ở đây</p>
                                </div>
                                                                <!-- Sample Order 4 -->
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #DH004
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: 19/01/2024
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-preparing">
                                                    <i class="fa fa-cog fa-spin"></i> Đang chuẩn bị
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <div class="product-row">
                                            <img src="https://via.placeholder.com/70x70/fd79a8/ffffff?text=Lily" alt="Hoa ly" class="product-image">
                                            <div style="flex: 1;">
                                                <h5 style="margin: 0; font-weight: bold;">Bó hoa ly trắng</h5>
                                                <p style="margin: 5px 0 0 0; color: #666;">Số lượng: 1</p>
                                            </div>
                                            <div class="text-right">
                                                <strong style="color: #333; font-size: 16px;">150,000₫</strong>
                                            </div>
                                        </div>

                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        321 Điện Biên Phủ, Quận 1, TP.HCM
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">150,000₫</p>
                                                    <div>
                                                        <button class="btn btn-info btn-sm" style="margin-right: 10px;">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </button>
                                                        <button class="btn btn-danger btn-sm">
                                                            <i class="fa fa-times"></i> Hủy đơn
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Shipping Orders Tab -->
                            <div role="tabpanel" class="tab-pane" id="shipping">
                                <div class="empty-state">
                                    <i class="fa fa-truck"></i>
                                    <h4>Chờ giao hàng</h4>
                                    <p>Các đơn hàng đang được giao sẽ hiển thị ở đây</p>
                                </div>
                                                                <!-- Sample Order 1 -->
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #DH001
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: 15/01/2024
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-shipping">
                                                    <i class="fa fa-truck"></i> Chờ giao hàng
                                                </span>
                                                <p style="margin: 5px 0 0 0; color: #666; font-size: 13px;">
                                                    Dự kiến giao: 17/01/2024
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <!-- Products -->
                                        <div class="product-row">
                                            <img src="https://via.placeholder.com/70x70/ff6b6b/ffffff?text=Rose" alt="Hoa hồng" class="product-image">
                                            <div style="flex: 1;">
                                                <h5 style="margin: 0; font-weight: bold;">Bó hoa hồng đỏ 12 bông</h5>
                                                <p style="margin: 5px 0 0 0; color: #666;">Số lượng: 1</p>
                                            </div>
                                            <div class="text-right">
                                                <strong style="color: #333; font-size: 16px;">180,000₫</strong>
                                            </div>
                                        </div>
                                        
                                        <div class="product-row">
                                            <img src="https://via.placeholder.com/70x70/4ecdc4/ffffff?text=Card" alt="Thiệp" class="product-image">
                                            <div style="flex: 1;">
                                                <h5 style="margin: 0; font-weight: bold;">Thiệp chúc mừng</h5>
                                                <p style="margin: 5px 0 0 0; color: #666;">Số lượng: 1</p>
                                            </div>
                                            <div class="text-right">
                                                <strong style="color: #333; font-size: 16px;">15,000₫</strong>
                                            </div>
                                        </div>

                                        <!-- Order Summary -->
                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        123 Nguyễn Văn Linh, Quận 7, TP.HCM
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">195,000₫</p>
                                                    <div>
                                                        <button class="btn btn-info btn-sm" style="margin-right: 10px;">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </button>
                                                        <button class="btn btn-warning btn-sm">
                                                            <i class="fa fa-phone"></i> Liên hệ
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- Completed Orders Tab -->
                            <div role="tabpanel" class="tab-pane" id="completed">
                                <div class="empty-state">
                                    <i class="fa fa-check-circle"></i>
                                    <h4>Đã mua</h4>
                                    <p>Các đơn hàng đã hoàn thành sẽ hiển thị ở đây</p>
                                </div>
                                                                <!-- Sample Order 2 -->
                                <div class="order-card">
                                    <div class="order-header">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4 style="margin: 0; color: #333;">
                                                    <i class="fa fa-file-text-o"></i> Đơn hàng #DH002
                                                </h4>
                                                <p style="margin: 5px 0 0 0; color: #666;">
                                                    Đặt ngày: 12/01/2024
                                                </p>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <span class="order-status status-completed">
                                                    <i class="fa fa-check-circle"></i> Đã mua
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="order-content">
                                        <div class="product-row">
                                            <img src="https://via.placeholder.com/70x70/f9ca24/ffffff?text=Tulip" alt="Hoa tulip" class="product-image">
                                            <div style="flex: 1;">
                                                <h5 style="margin: 0; font-weight: bold;">Bó hoa tulip vàng</h5>
                                                <p style="margin: 5px 0 0 0; color: #666;">Số lượng: 2</p>
                                            </div>
                                            <div class="text-right">
                                                <strong style="color: #333; font-size: 16px;">240,000₫</strong>
                                            </div>
                                        </div>

                                        <div style="border-top: 2px solid #f0f0f0; margin-top: 20px; padding-top: 20px;">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6><i class="fa fa-map-marker"></i> Địa chỉ giao hàng:</h6>
                                                    <p style="background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 10px 0;">
                                                        456 Lê Văn Việt, Quận 9, TP.HCM
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <h6>Tổng tiền:</h6>
                                                    <p class="order-total" style="margin: 10px 0;">240,000₫</p>
                                                    <div>
                                                        <button class="btn btn-info btn-sm" style="margin-right: 10px;">
                                                            <i class="fa fa-eye"></i> Chi tiết
                                                        </button>
                                                        <button class="btn btn-success btn-sm">
                                                            <i class="fa fa-refresh"></i> Mua lại
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer id="footer"><!--Footer-->
            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <p class="pull-left">Copyright © 2025  Flower Shop. All rights reserved</p>
                        <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Group 2</a></span></p>
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

        <c:if test="${sessionScope.user != null }">
            <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" style="width: 300px; z-index: 500000">
                <div class="toast-header">
                    <strong class="mr-auto">Notification</strong>
                    <small>just now</small>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="toast-body">
                    Welcome to your orders page
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