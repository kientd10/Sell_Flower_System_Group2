<%-- 
    Document   : orderDetails
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
    <title>Chi tiết đơn hàng | Flower Shop</title>
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
    .order-details-container {
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.06);
        margin: 20px 0;
        overflow: hidden;
    }
    
    .order-header {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        padding: 20px;
        border-bottom: 1px solid #dee2e6;
    }
    
    .order-code {
        font-size: 22px;
        font-weight: bold;
        color: #333;
        margin-bottom: 8px;
    }
    
    .order-status {
        padding: 6px 12px;
        border-radius: 15px;
        font-size: 11px;
        font-weight: 600;
        display: inline-block;
        text-transform: uppercase;
        letter-spacing: 0.5px;
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
    
    .order-info-section {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-radius: 8px;
        padding: 18px;
        margin: 15px 0;
        border-left: 3px solid #28a745;
    }
    
    .order-info-item {
        display: flex;
        align-items: center;
        margin-bottom: 12px;
        padding: 8px 0;
    }
    
    .order-info-item i {
        width: 20px;
        margin-right: 12px;
        color: #28a745;
        font-size: 14px;
    }
    
    .order-info-item strong {
        color: #333;
        margin-right: 8px;
        min-width: 100px;
    }
    
    .order-info-item span {
        color: #666;
        flex: 1;
    }
    
    .product-detail-card {
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 18px;
        margin-bottom: 15px;
        background: linear-gradient(135deg, #ffffff 0%, #fafafa 100%);
        box-shadow: 0 1px 5px rgba(0,0,0,0.04);
        transition: all 0.3s ease;
    }
    
    .product-detail-card:hover {
        box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        transform: translateY(-1px);
    }
    
    .product-image-large {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        margin-right: 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.08);
    }
    
    .product-info {
        flex: 1;
    }
    
    .product-name {
        font-size: 16px;
        font-weight: bold;
        color: #333;
        margin-bottom: 8px;
    }
    
    .product-price {
        font-size: 15px;
        color: #28a745;
        font-weight: 600;
    }
    
    .order-summary {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 20px;
        margin-top: 20px;
    }
    
    .total-amount {
        font-size: 22px;
        font-weight: bold;
        color: #28a745;
        text-align: right;
        margin-bottom: 15px;
    }
    
    .action-buttons {
        text-align: right;
        margin-top: 15px;
    }
    
    .btn-custom {
        border-radius: 20px;
        padding: 8px 20px;
        font-weight: 500;
        transition: all 0.3s ease;
        border: none;
        margin: 0 5px;
        font-size: 12px;
        min-width: 100px;
        text-align: center;
        display: inline-block;
        border: 2px solid transparent;
    }
    
    .btn-custom:hover {
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(0,0,0,0.12);
    }
    
    .btn-back {
        background-color: #c44d58;
        color: white;
        padding: 8px 20px;
        font-size: 12px;
        min-width: 100px;
        text-align: center;
        display: inline-block;
        border: 2px solid #c44d58;
        border-radius: 20px;
    }
    
    .btn-back:hover {
        background-color: #a03d4a;
        color: white;
        border-color: #a03d4a;
    }
    
    .btn-reorder {
        background-color: #28a745;
        color: white;
        padding: 8px 20px;
        font-size: 12px;
        min-width: 100px;
        text-align: center;
        display: inline-block;
        border: 2px solid #28a745;
        border-radius: 20px;
    }
    
    .btn-reorder:hover {
        background-color: #218838;
        color: white;
        border-color: #218838;
    }
    
    .btn-contact {
        background-color: #ffc107;
        color: #212529;
        padding: 8px 20px;
        font-size: 12px;
        min-width: 100px;
        text-align: center;
        display: inline-block;
        border: 2px solid #ffc107;
        border-radius: 20px;
    }
    
    .btn-contact:hover {
        background-color: #e0a800;
        color: #212529;
        border-color: #e0a800;
    }
    
    .timeline {
        position: relative;
        padding: 15px 0;
    }
    
    .timeline-item {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        position: relative;
    }
    
    .timeline-item:not(:last-child)::after {
        content: '';
        position: absolute;
        left: 12px;
        top: 30px;
        width: 2px;
        height: 20px;
        background: #dee2e6;
    }
    
    .timeline-icon {
        width: 25px;
        height: 25px;
        border-radius: 50%;
        background: #28a745;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
        font-size: 10px;
    }
    
    .timeline-content {
        flex: 1;
    }
    
    .timeline-title {
        font-weight: 600;
        color: #333;
        margin-bottom: 3px;
        font-size: 13px;
    }
    
    .timeline-date {
        color: #666;
        font-size: 12px;
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
                        <h2><i class="fa fa-file-text-o"></i> Chi tiết đơn hàng</h2>
                        <p class="text-muted">Xem thông tin chi tiết về đơn hàng của bạn</p>
                    </div>

                    <div class="order-details-container">
                        <!-- Order Header -->
                        <div class="order-header">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="order-code">
                                        <i class="fa fa-file-text-o"></i> ${order.orderCode}
                                    </div>
                                    <p style="margin: 5px 0 0 0; color: #666;">
                                        Đặt ngày: <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </p>
                                </div>
                                <div class="col-md-4 text-right">
                                    <span class="order-status status-${order.status == 'Chờ xác nhận' ? 'pending' : order.status == 'Đang chuẩn bị' ? 'preparing' : order.status == 'Chờ giao hàng' ? 'shipping' : 'completed'}">
                                        <i class="fa fa-${order.status == 'Chờ xác nhận' ? 'clock-o' : order.status == 'Đang chuẩn bị' ? 'cog' : order.status == 'Chờ giao hàng' ? 'truck' : 'check-circle'}"></i> ${order.status}
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Order Information -->
                        <div style="padding: 30px;">
                            <div class="order-info-section">
                                <h4 style="color: #333; margin-bottom: 20px;">
                                    <i class="fa fa-info-circle"></i> Thông tin giao hàng
                                </h4>
                                <div class="order-info-item">
                                    <i class="fa fa-map-marker"></i>
                                    <strong>Địa chỉ:</strong>
                                    <span>${order.deliveryAddress}</span>
                                </div>
                                <div class="order-info-item">
                                    <i class="fa fa-phone"></i>
                                    <strong>Số điện thoại:</strong>
                                    <span>${order.deliveryPhone}</span>
                                </div>
                                <c:if test="${userRole == 3 || userRole == 2 || userRole == 4}">
                                    <div class="order-info-item">
                                        <i class="fa fa-user"></i>
                                        <strong>Khách hàng:</strong>
                                        <span>${order.customerName}</span>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Products -->
                            <h4 style="color: #333; margin: 30px 0 20px 0;">
                                <i class="fa fa-shopping-bag"></i> Sản phẩm đã đặt
                            </h4>
                            
                            <c:forEach var="item" items="${order.items}">
                                <div class="product-detail-card">
                                    <div style="display: flex; align-items: center;">
                                        <a href="bouquet-detail?templateId=${item.templateId}" style="text-decoration: none;">
                                            <img src="${item.imageUrl}" alt="${item.productName}" class="product-image-large" onerror="this.src='https://via.placeholder.com/120x120'">
                                        </a>
                                        <div class="product-info">
                                            <div class="product-name">${item.productName}</div>
                                            <div style="margin-bottom: 10px;">
                                                <strong>Số lượng:</strong> ${item.quantity}
                                            </div>
                                            <div class="product-price">
                                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/> / sản phẩm
                                            </div>
                                        </div>
                                        <div style="text-align: right; margin-left: auto;">
                                            <div style="font-size: 18px; font-weight: bold; color: #28a745; margin-bottom: 8px;">
                                                <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" currencySymbol="₫"/>
                                            </div>
                                            <c:if test="${order.status == 'Đã mua'}">
                                                <a href="bouquet-detail?templateId=${item.templateId}" class="btn btn-reorder">
                                                    <i class="fa fa-refresh"></i> Mua lại
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Order Summary -->
                            <div class="order-summary">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h5 style="color: #333; margin-bottom: 15px;">
                                            <i class="fa fa-calendar"></i> Timeline đơn hàng
                                        </h5>
                                        <div class="timeline">
                                            <div class="timeline-item">
                                                <div class="timeline-icon">
                                                    <i class="fa fa-check"></i>
                                                </div>
                                                <div class="timeline-content">
                                                    <div class="timeline-title">Đơn hàng đã được đặt</div>
                                                    <div class="timeline-date">
                                                        <fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
                                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${order.status != 'Chờ xác nhận'}">
                                                <div class="timeline-item">
                                                    <div class="timeline-icon">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">Đơn hàng đã được xác nhận</div>
                                                        <div class="timeline-date">Đang xử lý...</div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${order.status == 'Đang chuẩn bị' || order.status == 'Chờ giao hàng' || order.status == 'Đã mua'}">
                                                <div class="timeline-item">
                                                    <div class="timeline-icon">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">Đang chuẩn bị đơn hàng</div>
                                                        <div class="timeline-date">Đang xử lý...</div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${order.status == 'Chờ giao hàng' || order.status == 'Đã mua'}">
                                                <div class="timeline-item">
                                                    <div class="timeline-icon">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">Đơn hàng đang được giao</div>
                                                        <div class="timeline-date">Đang xử lý...</div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${order.status == 'Đã mua'}">
                                                <div class="timeline-item">
                                                    <div class="timeline-icon">
                                                        <i class="fa fa-check"></i>
                                                    </div>
                                                    <div class="timeline-content">
                                                        <div class="timeline-title">Đơn hàng đã hoàn thành</div>
                                                        <div class="timeline-date">Đã giao thành công</div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="total-amount">
                                            Tổng tiền: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                        </div>
                                        <div class="action-buttons">
                                            <a href="orders" class="btn btn-back">
                                                <i class="fa fa-arrow-left"></i> Quay lại
                                            </a>
                                            <c:if test="${order.status == 'Đã mua'}">
                                                <a href="reorder?orderId=${order.orderId}" class="btn btn-reorder">
                                                    <i class="fa fa-refresh"></i> Mua lại
                                                </a>
                                            </c:if>
                                            <c:if test="${order.status == 'Chờ giao hàng'}">
                                                <a href="contactSupport?orderId=${order.orderId}" class="btn btn-warning btn-contact">
                                                    <i class="fa fa-phone"></i> Liên hệ
                                                </a>
                                            </c:if>
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
</body>
</html>
