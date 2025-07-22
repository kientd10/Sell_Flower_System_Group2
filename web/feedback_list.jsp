<%-- 
    Document   : feedback_list
    Created on : Jun 27, 2025, 8:49:14 AM
    Author     : Admin
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.BouquetTemplate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="Model.BouquetTemplate" %>
<%@ page import="Model.ProductFeedback" %>
<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
    <p style="color: green;"><%= message %></p>
<%
        session.removeAttribute("message");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Danh sách đánh giá</title>
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
        body { background: #fff; }
        .feedback-list-container {
            max-width: 700px;
            margin: 60px auto 60px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 32px rgba(206,66,108,0.10);
            padding: 36px 32px 32px 32px;
        }
        .feedback-list-container h2 {
            color: #ce426c;
            font-weight: 700;
            margin-bottom: 24px;
            text-align: center;
        }
        .feedback-list-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
        }
        .feedback-list-table th, .feedback-list-table td {
            border: 1px solid #eee;
            padding: 12px 16px;
            text-align: left;
        }
        .feedback-list-table th {
            background: #f8f9fa;
            color: #ce426c;
            font-weight: 600;
        }
        .feedback-list-table tr:nth-child(even) {
            background: #fdf6f9;
        }
        .feedback-list-table tr:hover {
            background: #ffe3ef;
        }
        .feedback-list-table a {
            color: #ce426c;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s;
        }
        .feedback-list-table a:hover {
            color: #a81e4a;
            text-decoration: underline;
        }
        .feedback-list-container p {
            text-align: center;
            color: #888;
            font-size: 1.1rem;
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
                                    <li class="notification-bell" style="position:relative;"></li>
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
                    <div class="col-sm-3">
                        <div class="search_box pull-right">
                            <form action="SearchServlet" method="GET">
                                <input type="text" name="searchQuery" placeholder="Tìm kiếm mẫu hoa..." required/>
                                <button type="submit">
                                    <i class="fa fa-search" style="border: none; height: 29px; line-height: 29px;"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--/header-bottom-->
    </header><!--/header-->
    <div class="feedback-list-container">
        <h2>Sản phẩm bạn đã mua và có thể đánh giá</h2>
        <c:if test="${purchasedProducts == null || purchasedProducts.size() == 0}">
            <p>Bạn chưa có sản phẩm nào để đánh giá.</p>
        </c:if>
        <c:if test="${purchasedProducts != null && purchasedProducts.size() > 0}">
            <table class="feedback-list-table">
                <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${purchasedProducts}">
                        <tr>
                            <td>${item.templateName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${userFeedbackMap[item.templateId] != null}">
                                        <a href="feedback-form?product_id=${item.templateId}">Sửa đánh giá</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="feedback-form?product_id=${item.templateId}">Đánh giá</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
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