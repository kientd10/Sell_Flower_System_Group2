<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Home | Flower Shop</title>
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
    </head><!--/head-->

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
                                        <li class="notification-bell" style="position:relative;">
                                            <a href="javascript:void(0);" id="notifBell" onclick="toggleNotifDropdown()">
                                                <i class="fa fa-bell"></i> Thông báo
                                                <span class="notification-badge"></span>
                                            </a>
                                            <ul id="notifDropdown" class="notif-dropdown-menu">
                                                <c:choose>
                                                    <c:when test="${not empty shopReplies}">
                                                        <c:forEach var="reply" items="${shopReplies}">
                                                            <li>
                                                                <a href="viewShopReply?requestId=${reply.requestId}">
                                                                    <img src="${pageContext.request.contextPath}/${reply.sampleImageUrl}" class="notif-img-mini" alt="Shop gửi" />
                                                                    <span class="notif-dot"></span>
                                                                    <c:out value="${fn:substring(reply.shopReply, 0, 40)}" />...
                                                                </a>
                                                            </li>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="notif-empty">Không có thông báo mới</li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </li>
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

        <section id="slider"><!--slider-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h2 class="title text-center">Sản Phẩm Nổi Bật</h2>
                        <c:choose>
                            <c:when test="${not empty featuredBouquets}">
                                <div id="slider-carousel" class="carousel slide" data-ride="carousel">

                                    <ol class="carousel-indicators">
                                        <c:forEach var="item" items="${featuredBouquets}" varStatus="loop">
                                            <li data-target="#slider-carousel" data-slide-to="${loop.index}" class="${loop.first ? 'active' : ''}"></li>
                                            </c:forEach>
                                    </ol>

                                    <div class="carousel-inner">
                                        <c:forEach var="item" items="${featuredBouquets}" varStatus="loop">
                                            <div class="item ${loop.first ? 'active' : ''}">
                                                <div class="row" style="margin-top: 20px;">
                                                    <div class="col-sm-6" style="margin-top: 65px;">
                                                        <h2>${item.templateName}</h2>
                                                        <p>${item.description}</p>
                                                        <a href="bouquet-detail?templateId=${item.templateId}" class="btn btn-default get" style="border-radius: 5px;">Mua ngay</a>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <img src="${item.imageUrl}" class="girl img-responsive" alt="${item.templateName}" />
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                                        <i class="fa fa-angle-left"></i>
                                    </a>
                                    <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p style="text-align: center; font-weight: bold; color: black;">...</p>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </section><!--/slider-->

        <section>                                        <!--/left-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <h2>DANH MỤC HOA</h2>
                            <div class="panel-group category-products" id="accordian" style=" padding: 10px; border: 2px solid #aeafb0; border-radius: 5px; max-width: 250px; margin: auto;"><!--category-product--> 
                                <c:forEach var="category" items="${categories}">
                                    <div class="panel panel-default" >
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a href="${pageContext.request.contextPath}/bouquet?categoryId=${category.categoryId}" style="color: #324d7a">
                                                    <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                        ${category.categoryName}
                                                </a>
                                            </h4>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div><!--/category-products-->

                            <!-- Nút Hoa mẫu theo yêu cầu đặt ngay dưới phần danh mục, trên phần lọc giá -->
                            <div style="margin: 16px 0; text-align: center; max-width: 250px; margin-left: auto; margin-right: auto;">
                                <c:choose>
                                    <c:when test="${sessionScope.user == null}">
                                        <a href="login.jsp" class="btn btn-custom-request" style="background: #ce426c; color: #fff; font-weight: bold; padding: 12px 0; border-radius: 8px; font-size: 1.08rem; box-shadow: 0 2px 8px rgba(233,30,99,0.15); transition: background 0.2s; width: 100%; display: inline-block; letter-spacing: 0.5px;">
                                            <i class="fa fa-magic"></i> Hoa mẫu theo yêu cầu
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="flowerRequestForm.jsp" class="btn btn-custom-request" style="background: #ce426c; color: #fff; font-weight: bold; padding: 12px 0; border-radius: 8px; font-size: 1.08rem; box-shadow: 0 2px 8px rgba(233,30,99,0.15); transition: background 0.2s; width: 100%; display: inline-block; letter-spacing: 0.5px;">
                                            <i class="fa fa-magic"></i> Hoa mẫu theo yêu cầu
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <style>
                                .btn-custom-request {
                                    width: 100%;
                                    max-width: 220px;
                                    font-size: 1.08rem;
                                    padding: 12px 0;
                                    letter-spacing: 0.5px;
                                }
                                .btn-custom-request:hover {
                                    background: #d44071;
                                    color: #fff;
                                    text-decoration: none;
                                }
                            </style>
                            <div class="price-range"><!--/Filter-->
                                <h2 style="text-align: center; color: #c44d58;">KHOẢNG GIÁ</h2>
                                <div style="display: flex; flex-direction: column; align-items: center; padding: 10px; border: 2px solid #aeafb0; border-radius: 5px; max-width: 250px; margin: auto;">
                                    <input type="number" id="minPrice" placeholder="Giá từ (vnđ)"
                                           value="${minPrice != null ? minPrice : ''}"
                                           style="width: 100%; padding: 6px 10px; margin-bottom: 10px; border: 1px solid #aeafb0; border-radius: 3px;" />
                                    <input type="number" id="maxPrice" placeholder="Giá đến (vnđ)"
                                           value="${maxPrice != null ? maxPrice : ''}"
                                           style="width: 100%; padding: 6px 10px; margin-bottom: 10px; border: 1px solid #aeafb0; border-radius: 3px;" />
                                    <button id="priceFilterBtn"
                                            style="background-color: #c44d58; color: white; border: none; padding: 8px 18px; border-radius: 3px; cursor: pointer;">
                                        Lọc giá
                                    </button>
                                </div>
                            </div>

                            <script>
                                document.getElementById("priceFilterBtn").addEventListener("click", function (event) {
                                    event.preventDefault(); // ngăn form submit nếu có
                                    const minPrice = document.getElementById("minPrice").value.trim();
                                    const maxPrice = document.getElementById("maxPrice").value.trim();

                                    console.log("minPrice:", minPrice);
                                    console.log("maxPrice:", maxPrice);

                                    const urlParams = new URLSearchParams(window.location.search);
                                    const categoryId = urlParams.get("categoryId");

                                    const params = new URLSearchParams();

                                    if (minPrice !== "")
                                        params.append("minPrice", minPrice);
                                    if (maxPrice !== "")
                                        params.append("maxPrice", maxPrice);
                                    if (categoryId)
                                        params.append("categoryId", categoryId);

                                    params.append("pageNum", "1");

                                    console.log("Redirect URL:", "bouquet?" + params.toString());

                                    window.location.href = "bouquet?" + params.toString();
                                });
                            </script>

                            <div ><!--shipping-->
                                <img style="width:264px ; height: 430px ; margin-top:40px; border-radius: 5px " src="https://4kwallpapers.com/images/wallpapers/teddy-bear-rose-cute-toy-gift-valentines-day-5k-2160x3840-441.jpg" alt="" />
                            </div><!--/shipping-->
                        </div>

                    </div>
                    <div class="col-sm-9 padding-right">                       
                        <div class="features_items"> <!--features_items-->
                            <h2 class="title text-center st" style="font-size: 20px; padding: 5px 10px;">
                                <c:choose>
                                    <c:when test="${page == 'filter'}">
                                        Kết quả lọc giá sản phẩm
                                    </c:when>
                                    <c:when test="${page == 'search'}">
                                        Kết quả tìm kiếm cho "<c:out value='${searchQuery}'/>"
                                    </c:when>
                                    <c:otherwise>
                                        Danh sách sản phẩm
                                    </c:otherwise>
                                </c:choose>
                            </h2>

                            <c:choose>
                                <c:when test="${empty bouquets}">
                                    <h4 style="text-align:center; color:#ff6f61;">
                                        <c:choose>
                                            <c:when test="${page == 'filter'}">
                                                Không có sản phẩm nào phù hợp với bộ lọc!
                                            </c:when>
                                            <c:when test="${page == 'search'}">
                                                Không tìm thấy mẫu hoa nào phù hợp với từ khóa của bạn!
                                            </c:when>
                                            <c:otherwise>
                                                Không có sản phẩm nào!
                                            </c:otherwise>
                                        </c:choose>
                                    </h4>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="bou" items="${bouquets}">
                                        <div class="col-sm-3">
                                            <div class="product-image-wrapper">
                                                <div class="single-products">
                                                    <div class="productinfo text-center">
                                                        <a href="${pageContext.request.contextPath}/bouquet-detail?templateId=${bou.templateId}">
                                                            <img src="${bou.imageUrl}" alt="${bou.templateName}" style="height:200px;" />
                                                        </a>
                                                        <h2><fmt:formatNumber value="${bou.basePrice}" type="currency" currencySymbol="₫"/></h2>
                                                        <p>${bou.templateName}</p>
                                                        <c:choose>
                                                            <c:when test="${bou.avgRating > 0}">
                                                                <p style="color: #f39c12;">🌟 <fmt:formatNumber value="${bou.avgRating}" maxFractionDigits="1"/> / 5</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p style="color: gray;">Chưa có đánh giá</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <form action="${pageContext.request.contextPath}/add" method="get">
                                                            <input type="hidden" name="templateId" value="${bou.templateId}" />
                                                            <button type="submit"
                                                                    class="btn btn-primary" style="border-radius: 4px;">
                                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng   
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div> 

                        <div class="pagination-area text-center"><!--Pagination-area-->
                            <ul class="pagination">
                                <c:set var="baseUrl" value="" />
                                <c:choose>
                                    <c:when test="${page == 'category'}">
                                        <c:set var="baseUrl" value="bouquet?categoryId=${categoryId}&pageNum=" />
                                    </c:when>
                                    <c:when test="${page == 'filter'}">
                                        <c:set var="baseUrl" value="bouquet?categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}&pageNum=" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="baseUrl" value="home?pageNum=" />
                                    </c:otherwise>
                                </c:choose>

                                <!-- Nút trang trước -->
                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="${baseUrl}${currentPage - 1}">&laquo;</a>
                                    </li>
                                </c:if>

                                <!-- Các số trang -->
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="${i == currentPage ? 'active' : ''}">
                                        <a href="${baseUrl}${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Nút trang sau -->
                                <c:if test="${currentPage < totalPages}">
                                    <li>
                                        <a href="${baseUrl}${currentPage + 1}">&raquo;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div> <!--/Pagination-area-->
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
                                    <li><a href="${pageContext.request.contextPath}/flowerRequestForm.jsp">Giỏ hoa theo yêu cầu</a></li>
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



        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <c:if test="${sessionScope.user != null }">
            <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" style="width: 300px; z-index: 500000">
                <div class="toast-header">
                    <!--<img src="assets/img/logo/guitar.png" class="rounded me-2" alt="iconlmao" style= "  max-width: 100%;
                        height: auto;
                        max-height: 20px;">-->
                    <strong class="mr-auto">Thông báo</strong>
                    <small>...</small>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="toast-body">
                    Xin chào! Đăng nhập thành công
                </div>
            </div>
            <script>
                                $(document).ready(function () {
                                    $('.toast').toast({
                                        delay: 3500 // 5 seconds delay before fade-out animation
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
            
            
        <style>
    .notif-dropdown-menu {
        display: none;
        position: absolute;
        top: 38px;
        right: 0;
        min-width: 240px;
        background: #fff;
        border: 1px solid #eee;
        border-radius: 12px;
        box-shadow: 0 4px 16px rgba(44,62,80,0.13);
        z-index: 9999;
        padding: 6px 0;
        list-style: none;
        max-height: 260px;
        overflow-y: auto;
        scrollbar-width: thin;
        scrollbar-color: #ce426c #f3f3f3;
    }
    .notif-dropdown-menu::-webkit-scrollbar {
        width: 8px;
        background: #f3f3f3;
        border-radius: 8px;
    }
    .notif-dropdown-menu::-webkit-scrollbar-thumb {
        background: #ce426c;
        border-radius: 8px;
    }
    .notif-dropdown-menu li { display: block; }
    /* ĐÃ XÓA: .notif-dropdown-menu li:nth-child(n+6) { display: none; } */
    .notification-bell.open .notif-dropdown-menu {
        display: block;
    }
    .notif-dropdown-menu li a {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 14px 8px 12px;
        color: #333;
        font-size: 1rem;
        text-decoration: none;
        border-radius: 8px;
        transition: background 0.15s;
    }
    .notif-dropdown-menu li a:hover {
        background: #f8f9fa;
    }
    .notif-img-mini {
        width: 32px; height: 32px; object-fit: cover; border-radius: 6px; box-shadow: 0 1px 4px rgba(206,66,108,0.08);
        flex-shrink: 0;
    }
    .notif-dot {
        width: 7px;
        height: 7px;
        background: #ce426c;
        border-radius: 50%;
        display: inline-block;
        margin-right: 4px;
    }
    .notif-empty {
        text-align: center;
        color: #888;
        padding: 12px 0;
        font-size: 1rem;
    }
</style>
<script>
function toggleNotifDropdown() {
    var bell = document.querySelector('.notification-bell');
    bell.classList.toggle('open');
}
document.addEventListener('click', function(event) {
    var bell = document.querySelector('.notification-bell');
    if (!bell.contains(event.target)) {
        bell.classList.remove('open');
    }
});
</script>
    </body>
</html>