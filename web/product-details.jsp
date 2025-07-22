<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Product Details | E-Flower Shop</title>
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
                                        </li>
                                        <li><a href="orders"><i class="fa fa-truck"></i> Đơn hàng</a></li>
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>                                        <li><a href="Customer?action=logout"><b>Đăng xuất</b></a></li> 
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

        <section>
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
                        <div class="product-details"><!--product-details-->
                            <div class="col-sm-5">
                                <div class="view-product">
                                    <img src="${bouquet.imageUrl}" alt="${bouquet.templateName}" />
                                </div>
                            </div>

                            <div class="col-sm-7">
                                <div class="product-information"><!--/product-information-->
                                    <img src="images/product-details/new.jpg" class="newarrival" alt="" />

                                    <h2>${bouquet.templateName}</h2>
                                    <p>Mã hoa : ${bouquet.templateId}</p>
                                    <p><b>Mô tả :</b> ${bouquet.description}</p>
                                    <img src="images/product-details/rating.png" alt="" />
                                    <span>
                                        <span style="margin-top:12px;" >${bouquet.basePrice} đ</span>
                                        <label style="margin-left:18px;" >Số lượng:</label>
                                        <input type="text" value="1" name="quantity" />
                                        <form action="add" method="get" style="display:inline;" >
                                            <input type="hidden" name="templateId" value="${bouquet.templateId}" />
                                            <button type="submit" class="btn btn-fefault cart" style="border-radius: 4px;margin-left: 23px;">
                                                <i class="fa fa-shopping-cart"></i>
                                                Thêm vào giỏ hàng
                                            </button>
                                        </form>
                                    </span>
                                    <p><b>Tình trạng:</b> Còn hàng</p>
                                    <p><b>Thương hiệu:</b> Flower Shop</p>
                                    <ul class="nav navbar-nav">
                                        <li><a href="https://github.com/kientd10/Sell_Flower_System_Group2"><i class="fa fa-brands fa-github"></i></a></li>
                                        <li><a href="https://www.facebook.com/share/16ohs8HR5g/?mibextid=wwXIfr"><i class="fa fa-facebook"></i></a></li>                                   
                                    </ul> 
                                </div><!--/product-information-->
                                <h3>Đánh giá từ người mua</h3>

                                <c:if test="${empty feedbackList}">
                                    <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                                </c:if>

                                <c:forEach var="fb" items="${feedbackList}">
                                    <div style="border:1px solid #ddd; padding:10px; margin-bottom:10px; border-radius:5px;">
                                        <strong>${fb.customerName}</strong>
                                        <em style="float:right;">${fb.createdAt}</em><br/>
                                        <span style="color:orange;">⭐ ${fb.rating}/5</span><br/>
                                        <p>${fb.comment}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </div><!--/product-details-->



                    </div>
                </div><!--/product-details-->


                <div class="recommended_items"> <!--Recommend-->
                    <h2 class="title text-center" style="font-size: 20px; padding: 5px 10px; " >Sản phẩm gợi ý</h2>
                    <div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <c:choose>
                                <c:when test="${empty recommendations}">
                                    <div class="item active">
                                        <div class="no-recommendations">Không tìm thấy sản phẩm gợi ý phù hợp.</div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${recommendations}" var="template" varStatus="status">
                                        <c:if test="${status.index % 4 == 0}">
                                            <div class="item ${status.index == 0 ? 'active' : ''}">
                                            </c:if>

                                            <div class="col-sm-3">
                                                <div class="product-image-wrapper">
                                                    <div class="single-products">
                                                        <div class="productinfo text-center">
                                                            <img src="${template.imageUrl}" alt="${template.templateName}" />
                                                            <h2>${template.basePrice} VND</h2>
                                                            <p>${template.templateName}</p>
                                                            <button type="button" class="btn btn-default add-to-cart" style="border-radius: 4px;">
                                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                                            </button>
                                                            <a href="bouquet-detail?templateId=${template.templateId}" class="btn btn-default">Xem chi tiết</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <c:if test="${status.index % 4 == 3 || status.last}">
                                            </div> <!-- đóng item -->
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${not empty recommendations}">
                            <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </c:if>
                    </div>
                </div> <!--/Recommend-->


              
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
        <script src="js/price-range.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        
    </body>
</html>