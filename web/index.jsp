
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                        <li><a href="orders"><i class="fa fa-truck"></i> Đơn hàng</a></li>
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>
                                        <li><a href="feedback_list.jsp"><i class="fa fa-comments"></i> Đánh giá</a></li>
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

        <section id="slider""><!--slider-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">

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
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <h1><span style="color: #ff6f61">Flower Shop</span></h1>
                                                        <h2>${item.templateName}</h2>
                                                        <p>${item.description}</p>
                                                        <a href="product-detail.jsp?templateId=${item.templateId}" class="btn btn-default get">Mua ngay</a>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <img src="${item.imageUrl}" class="girl img-responsive" alt="${item.templateName}" />
                                                        <img src="images/home/pricing.png" class="pricing" alt="Price Tag" />
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
                                <p style="text-align: center; font-weight: bold; color: red;">Không có sản phẩm nổi bật nào.</p>
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
                                                        <h2>${bou.basePrice} đ</h2>
                                                        <p>${bou.templateName}</p>
                                                        <form action="${pageContext.request.contextPath}/add" method="get">
                                                            <input type="hidden" name="templateId" value="${bou.templateId}" />
                                                            <button type="submit"
                                                                    class="btn btn-primary">
                                                                <i class="fa fa-shopping-cart"></i> Add to cart
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
    </body>
</html>