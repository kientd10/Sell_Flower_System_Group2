<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.FlowerRequest" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    FlowerRequest fr = (FlowerRequest) request.getAttribute("flowerRequest");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Phản hồi từ shop | Flower Shop</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    <style>
        .shop-reply-container {
            max-width: 900px;
            min-height: 380px;
            margin: 64px auto 56px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 2px 32px rgba(206,66,108,0.13);
            padding: 56px 56px 40px 56px;
            display: flex;
            gap: 48px;
            align-items: flex-start;
            flex-wrap: wrap;
        }
        .shop-reply-img {
            max-width: 400px; max-height: 320px; border-radius: 14px; box-shadow: 0 2px 16px rgba(206,66,108,0.12); margin-bottom: 0;
            flex: 1 1 260px;
        }
        .shop-reply-content {
            flex: 2 1 400px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-width: 260px;
        }
        .shop-reply-title {
            color: #ce426c;
            font-weight: bold;
            font-size: 2.2rem;
            margin-bottom: 28px;
            letter-spacing: 1px;
        }
        .shop-reply-text {
            font-size: 1.32rem;
            color: #324d7a;
            margin-bottom: 40px;
            line-height: 1.7;
        }
        .shop-reply-actions {
            display: flex;
            justify-content: flex-end;
            gap: 32px;
            margin-top: 18px;
        }
        .btn-accept, .btn-cancel {
            padding: 18px 48px;
            font-size: 1.22rem;
            font-weight: 700;
            border-radius: 11px;
            border: none;
            transition: background 0.2s;
            min-width: 180px;
        }
        .btn-accept {
            background: #0d6efd;
            color: #fff;
        }
        .btn-accept:hover { background: #0b5ed7; }
        .btn-cancel {
            background: #ce426c;
            color: #fff;
        }
        .btn-cancel:hover { background: #d44071; }
        @media (max-width: 1100px) {
            .shop-reply-container { max-width: 99vw; padding: 24px 6vw 18px 6vw; gap: 18px; }
            .shop-reply-img { max-width: 100%; margin: 0 auto 18px auto; }
            .shop-reply-content { min-width: 0; }
            .shop-reply-title { font-size: 1.4rem; }
            .btn-accept, .btn-cancel { min-width: 0; width: 100%; margin-bottom: 10px; }
            .shop-reply-actions { flex-direction: column; gap: 10px; }
        }
    </style>
</head>
<body>
<!-- HEADER BẮT ĐẦU -->
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
                                <li><a href="notificationManagement.jsp"><i class="fa fa-bell"></i> Thông báo</a></li>
                                <li><a href="orders"><i class="fa fa-truck"></i> Đơn hàng</a></li>
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
<!-- HEADER KẾT THÚC -->
<div class="shop-reply-container">
    <c:choose>
        <c:when test="${empty flowerRequest}">
            <div style="color: red; font-weight: bold; font-size: 1.2rem; margin: 0 auto;">Không tìm thấy dữ liệu yêu cầu hoặc shop chưa phản hồi!</div>
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/${flowerRequest.sampleImageUrl}" class="shop-reply-img" alt="Shop gửi" />
            <div class="shop-reply-content">
                <div class="shop-reply-title">Phản hồi từ shop về yêu cầu hoa mẫu</div>
                <div class="shop-reply-text">
                    <b>Phản hồi chi tiết:</b> ${flowerRequest.shopReply}<br/>
                    <b>Số lượng:</b> ${flowerRequest.quantity}<br/>
                    <b>Giá mong muốn:</b> <fmt:formatNumber value="${flowerRequest.suggestedPrice}" type="currency" currencySymbol="₫"/>
                </div>
                <div class="shop-reply-actions">
                    <form action="confirm-order" method="post" style="display:inline;">
                        <input type="hidden" name="requestId" value="${flowerRequest.requestId}" />
                        <button type="submit" class="btn-accept"><i class="fa fa-check"></i> Xác nhận mua</button>
                    </form>
                    <form action="cancel-request" method="post" style="display:inline;">
                        <input type="hidden" name="requestId" value="${flowerRequest.requestId}" />
                        <button type="submit" class="btn-cancel"><i class="fa fa-times"></i> Hủy yêu cầu</button>
                    </form>
                </div>
                <c:if test="${not empty errorMsg}">
                    <div style="color: red; font-weight: bold; margin-top: 18px; text-align: right; padding-right: 10px;">${errorMsg}</div>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<!-- FOOTER BẮT ĐẦU -->
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
                <p class="pull-right">Designed by <span style="color: #080101;"  ><a target="_blank" href="https://github.com/kientd10/Sell_Flower_System_Group2">Group 2</a></span></p>
            </div>
        </div>
    </div>
</footer><!--/Footer-->
<!-- FOOTER KẾT THÚC -->
</body>
</html> 