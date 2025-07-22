
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Model.ProductFeedback" %>
<%@ page import="Model.User" %>
<%@ page import="dal.ProductFeedbackDAO" %>
<%
    int productId = Integer.parseInt(request.getParameter("product_id"));
    ProductFeedback feedback = (ProductFeedback) request.getAttribute("feedback");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Đánh giá sản phẩm</title>
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
        .feedback-form-container {
            max-width: 520px;
            margin: 60px auto 60px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 32px rgba(206,66,108,0.10);
            padding: 36px 32px 32px 32px;
        }
        .feedback-form-container h2 {
            color: #ce426c;
            font-weight: 700;
            margin-bottom: 24px;
            text-align: center;
        }
        .star-rating {
            direction: rtl;
            font-size: 32px;
            unicode-bidi: bidi-override;
            display: inline-flex;
            margin-bottom: 12px;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ce426c;
        }
        .feedback-form-container textarea {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #eee;
            padding: 10px;
            font-size: 1.1rem;
            margin-bottom: 18px;
            resize: vertical;
        }
        .feedback-form-container button[type="submit"] {
            background: #ce426c;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background 0.2s;
            box-shadow: 0 2px 8px rgba(206,66,108,0.08);
        }
        .feedback-form-container button[type="submit"]:hover {
            background: #a81e4a;
        }
        .feedback-form-container label {
            font-weight: 500;
            color: #333;
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
                                        <li><a href="orders"><i class="fa fa-truck"></i> Đơn hàng</a></li>
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>                                        <li><a href="Customer?action=logout"><b>Đăng xuất</b></a></li> 
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
    
    <div class="feedback-form-container">
        <h2>Đánh giá sản phẩm mã: <%= productId %></h2>
        <form action="submit-feedback" method="post">
            <input type="hidden" name="productId" value="<%= productId %>">
            <p>
                <label>Chọn số sao:</label><br>
                <div class="star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                        <input type="radio" id="star<%= i %>" name="rating" value="<%= i %>"
                            <%= (feedback != null && feedback.getRating() == i) ? "checked" : "" %> >
                        <label for="star<%= i %>">&#9733;</label>
                    <% } %>
                </div>
            </p>
            <p>
                <label>Viết nhận xét:</label><br>
                <textarea name="comment" rows="4" required><%= (feedback != null ? feedback.getComment() : "") %></textarea>
            </p>
            <div style="text-align:center;">
                <button type="submit">Gửi đánh giá</button>
            </div>
        </form>
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