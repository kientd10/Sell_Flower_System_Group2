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

        <div class="header-middle">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="logo pull-left">
                            <a href="index.jsp"><img src="https://i.ibb.co/CsMwqtJx/logo-2.png" alt="" width="120px" height="70px" /></a>
                        </div>                       
                    </div>
                </div>
            </div>
        </div>

        <div class="header-bottom">
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
                                <li style="padding-left: 0">/</li>
                                <li style="padding-left: 0">Login</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section id="form" style="padding: 30px 50px 100px 50px; margin-top: 0 ;margin-bottom: 0">
        <div class="container">
            <div class="row">
                <c:choose>
                    <%-- Nếu action không phải là signup thì hiện login --%>
                    <c:when test="${param.action ne 'signup'}">
                        <%-- FORM LOGIN --%>
                        <div class="col-sm-4 col-sm-offset-4">
                            <div class="login-form">
                                <h2>Login to your account</h2>
                                <form action="LoginServlet" method="post">
                                    <c:if test="${not empty requestScope.error}">
                                        <p style="color: red;">${requestScope.error}</p>
                                    </c:if>
                                    <input type="email" name="email" value="${cookie.email.value}" placeholder="Email Address" required />
                                    <input type="password" name="password" value="${cookie.password.value}" placeholder="Password" required />
                                    <span style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
                                        <label style="display: flex; align-items: center;">
                                            <input type="checkbox" name="remember" value="ON" class="checkbox" 
                                                   <c:if test="${cookie.remember.value eq 'ON'}">checked</c:if>> 
                                                   Remember me
                                            </label>
                                            <a href="forgot-password.jsp" style="color: black">Forgot password?</a>
                                        </span>
                                        <button type="submit" class="btn btn-default">Login</button>
                                        <p>You do not have account ? <a href="login.jsp?action=signup">Register</a></p>
                                    </form>
                                </div>
                            </div>
                    </c:when>
                    <%-- Nếu action là signup thì hiện signup --%>
                    <c:otherwise>  
                        <div class="col-sm-4 col-sm-offset-4">
                            <div class="signup-form">
                                <h2>New User Signup!</h2>
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
                                    <input type="text" name="name" value="${username}" placeholder="Name" required />
                                    <input type="email" name="Email" value="${email}" placeholder="Email Address" required />
                                    <input type="password" name="Password" value="${pass}" placeholder="Password" required />
                                    <input type="password" name="CfPassword" value="${CFpass}" placeholder="Confirm Password" required />
                                    <input type="text" name="phone" value="${phone}" placeholder="Phone" required />
                                    <input type="text" name="address" value="${address}" placeholder="Address" required />
                                    <button type="submit" class="btn btn-default">Signup</button>
                                    <p>Had account ?<a href="login.jsp?action=login">Login</a></p>
                                </form>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <footer id="footer">
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="companyinfo">
                            <h2><span>Flower</span> Shop</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,sed do eiusmod tempor</p>
                        </div>
                    </div>
                    <div class="col-sm-7">
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#">
                                    <div class="iframe-img">
                                        <img src="images/home/iframe1.png" alt="" />
                                    </div>
                                    <div class="overlay-icon">
                                        <i class="fa fa-play-circle-o"></i>
                                    </div>
                                </a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#">
                                    <div class="iframe-img">
                                        <img src="images/home/iframe2.png" alt="" />
                                    </div>
                                    <div class="overlay-icon">
                                        <i class="fa fa-play-circle-o"></i>
                                    </div>
                                </a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#">
                                    <div class="iframe-img">
                                        <img src="images/home/iframe3.png" alt="" />
                                    </div>
                                    <div class="overlay-icon">
                                        <i class="fa fa-play-circle-o"></i>
                                    </div>
                                </a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#">
                                    <div class="iframe-img">
                                        <img src="images/home/iframe4.png" alt="" />
                                    </div>
                                    <div class="overlay-icon">
                                        <i class="fa fa-play-circle-o"></i>
                                    </div>
                                </a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="address">
                            <img src="images/home/map.png" alt="" />
                            <p>505 S Atlantic Ave Virginia Beach, VA(Virginia)</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-widget">
            <div class="container">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>Service</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Online Help</a></li>
                                <li><a href="#">Contact Us</a></li>
                                <li><a href="#">Order Status</a></li>
                                <li><a href="#">Change Location</a></li>
                                <li><a href="#">FAQ’s</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>Quick Shop</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Flowers</a></li>
                                <li><a href="#">Bouquets</a></li>
                                <li><a href="#">Gift Cards</a></li>
                                <li><a href="#">Special Offers</a></li>
                                <li><a href="#">Seasonal</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>Policies</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Terms of Use</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Refund Policy</a></li>
                                <li><a href="#">Billing System</a></li>
                                <li><a href="#">Ticket System</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>About Flower Shop</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Company Information</a></li>
                                <li><a href="#">Careers</a></li>
                                <li><a href="#">Store Location</a></li>
                                <li><a href="#">Affiliate Program</a></li>
                                <li><a href="#">Copyright</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-3 col-sm-offset-1">
                        <div class="single-widget">
                            <h2>Stay Updated</h2>
                            <div class="searchform">
                                <input type="text" placeholder="Your email address" />
                                <button type="button" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                                <p>Get the most recent updates from <br />our site and be updated yourself...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="container">
                <div class="row">
                    <p class="pull-left">Copyright © 2025 Flower Shop Inc. All rights reserved.</p>
                    <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
                </div>
            </div>
        </div>
    </footer>

    <script src="js/jquery.js"></script>
    <script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>