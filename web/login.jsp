<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Login | Flower Shop</title>
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

    <section id="form" style="padding: 30px 50px 100px 50px; margin-top: 0 ;margin-bottom: 0">
        <div class="container">
            <div class="row">
                <c:choose>
                    <%-- Nếu action không phải là signup thì hiện login --%>
                    <c:when test="${param.action ne 'signup'}">
                        <%-- FORM LOGIN --%>
                        <div class="col-sm-4 col-sm-offset-4">
                            <div class="login-form">
                                <h2>Đăng nhập vào tài khoản</h2>
                                <form action="LoginServlet" method="post">
                                    <c:if test="${not empty requestScope.error}">
                                        <p style="color: red;">${requestScope.error}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.done}">
                                        <p style="color: red;">${requestScope.done}</p>
                                    </c:if>
                                    <input type="email" name="email"
                                           value="${not empty requestScope.email ? requestScope.email : cookie.email.value}"
                                           placeholder="Email" required />

                                    <input type="password" name="password"
                                           value="${not empty requestScope.password ? requestScope.password : cookie.password.value}"
                                           placeholder="Mật khẩu" required />
                                    <span style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
                                        <label style="display: flex; align-items: center;">

                                            <input type="checkbox" name="remember" value="ON"
                                                   <c:if test="${cookie.remember.value eq 'ON'}">checked</c:if>> Nhớ tài khoản

                                            </label>
                                            <a href="forgot-password.jsp" style="color: black">Quên mật khẩu?</a>
                                        </span>
                                        <button type="submit" class="btn btn-default">Đăng nhập</button>
                                        <p>Chưa có tài khoản ? <a href="login.jsp?action=signup">Đăng ký</a></p>
                                    </form>
                                </div>
                            </div>
                    </c:when>
                    <%-- Nếu action là signup thì hiện signup --%>
                    <c:otherwise>  
                        <div class="col-sm-4 col-sm-offset-4">
                            <div class="signup-form">
                                <h2>Đăng ký tài khoản!</h2>
                                <form action="Customer?action=signup" method="post">
                                    <c:if test="${not empty requestScope.done}">
                                        <p style="color: green;">${requestScope.done}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.emailavailable}">
                                        <p style="color: red;">${requestScope.emailavailable}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.errorname}">
                                        <p style="color: red;">${requestScope.errorname}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.errorpass}">
                                        <p style="color: red;">${requestScope.errorpass}</p>
                                    </c:if>
                                    <input type="text" name="name" value="${username}" placeholder="Tên" required />
                                    <input type="email" name="Email" value="${email}" placeholder="Email" required />
                                    <input type="password" name="Password" value="${pass}" placeholder="Mật khẩu" required />
                                    <input type="password" name="CfPassword" value="${CFpass}" placeholder="Xác nhận mật khẩu" required />
                                    <input type="text" name="phone" value="${phone}" placeholder="Số điện thoại" required />
                                    <input type="text" name="address" value="${address}" placeholder="Địa chỉ" required />
                                    <button type="submit" class="btn btn-default">Đăng ký</button>
                                    <p>Đã có tài khoản ?<a href="login.jsp?action=login">Đăng nhập</a></p>
                                </form>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
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