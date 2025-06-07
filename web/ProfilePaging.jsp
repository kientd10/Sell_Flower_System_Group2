<%-- 
    Document   : ProfilePaging
    Created on : May 22, 2025, 3:14:48 PM
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
                            <div class="btn-group pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                                        VIETNAM
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="#">VIETNAM</a></li>
                                        <li><a href="#">UK</a></li>
                                    </ul>
                                </div>

                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                                        VND
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="#">Dollar</a></li>
                                        <li><a href="#">VND</a></li>
                                    </ul>
                                </div>
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

        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <c:choose>
                            <c:when test="${not empty requestScope.customer.avatarUrl}">
                                <img
                                    class="rounded-circle mt-5"
                                    width="150px"
                                    src="${requestScope.customer.avatarUrl}"
                                    alt="Avatar của ${requestScope.customer.fullName}"
                                    />
                            </c:when>
                            <c:otherwise>
                                <img
                                    class="rounded-circle mt-5"
                                    width="150px"
                                    src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
                                    alt="Ảnh mặc định"
                                    />
                            </c:otherwise>
                        </c:choose>

                        <span class="font-weight-bold mt-3">
                            <c:out value="${requestScope.customer.fullName}"/>
                        </span>
                        <span class="text-black-50">
                            <c:out value="${requestScope.customer.email}"/>
                        </span>
                        <span></span>
                    </div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Profile Settings</h4>
                        </div>
                        <c:choose>
                            <c:when test="${editMode}">
                                <form action="edit" method="post">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">Name</label>
                                            <input
                                                type="text"
                                                name="name"
                                                class="form-control"
                                                value="<c:out value='${user.fullName}'/>"
                                                placeholder="Nhập họ và tên" />
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">Phone</label>
                                            <input
                                                type="tel"
                                                name="phone"
                                                class="form-control"
                                                value="<c:out value='${user.phone}'/>"
                                                placeholder="Nhập số điện thoại" />
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">Status</label>
                                            <c:if test="${user.isActive}">
                                                <input
                                                    type="text"
                                                    class="form-control"
                                                    readonly
                                                    value="Active" />
                                            </c:if>
                                            <c:if test="${!user.isActive}">
                                                <input
                                                    type="text"
                                                    class="form-control"
                                                    readonly
                                                    value="Inactive" />
                                            </c:if>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">Address</label>
                                            <input
                                                type="text"
                                                name="address"
                                                class="form-control"
                                                value="<c:out value='${user.address}'/>"
                                                placeholder="Nhập địa chỉ" />
                                        </div>

                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy" var="formattedDate" />

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">Create Date</label>
                                            <input
                                                type="text"
                                                class="form-control"
                                                readonly
                                                value="${formattedDate}" />
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">Email</label>
                                            <input
                                                type="email"
                                                name="email"
                                                class="form-control"
                                                value="<c:out value='${user.email}'/>"
                                                placeholder="Nhập email" />
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">UserName</label>
                                            <input
                                                type="text"
                                                name="username"
                                                class="form-control"
                                                value="<c:out value='${user.username}'/>"
                                                placeholder="Nhập username" />
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label font-weight-bold">PassWord</label>
                                            <input
                                                type="password"
                                                name="password"
                                                class="form-control"
                                                placeholder="••••••••" />
                                            <small class="form-text text-muted">
                                                Để trống nếu không đổi mật khẩu
                                            </small>
                                        </div>
                                    </div>

                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn btn-success px-4">
                                            Save
                                        </button>
                                        <a href="profile" class="btn btn-outline-secondary ml-2">
                                            Cancel
                                        </a>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">Full Name</label>
                                        <div class="p-2 bg-light rounded">
                                            <c:out value="${user.fullName}"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">Phone</label>
                                        <div class="p-2 bg-light rounded">
                                            <c:out value="${user.phone}"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">Status</label>
                                        <div class="p-2 bg-light rounded">
                                            <c:out value="${user.isActive ? 'Active' : 'Inactive'}"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">Address</label>
                                        <div class="p-2 bg-light rounded">
                                            <c:out value="${user.address}"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">Create Date</label>
                                        <div class="p-2 bg-light rounded">
                                            <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">Email</label>
                                        <div class="p-2 bg-light rounded">
                                            <c:out value="${user.email}"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">UserName</label>
                                        <div class="p-2 bg-light rounded">
                                            <c:out value="${user.username}"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label font-weight-bold">PassWord</label>
                                        <div class="p-2 bg-light rounded">
                                            ••••••••
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-5 text-center">
                                    <a href="edit?mode=edit" class="btn btn-primary profile-button">
                                        Edit Profile
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
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
            <!--                     <img src="assets/img/logo/guitar.png" class="rounded me-2" alt="iconlmao" style= "  max-width: 100%;
                height: auto;
                max-height: 20px;">-->
            <strong class="mr-auto">Notification</strong>
            <small>just now</small>
            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="toast-body">
            Login successfully
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
</c:if>>
</body>
</html>
