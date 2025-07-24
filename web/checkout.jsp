<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <div class="container" style="margin-bottom: 40px" >
                <div class="checkout-information">
                    <h2 class="heading">Thông tin người nhận hàng</h2>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3">
<form action="placeOrder" method="post" onsubmit="return validateForm();">
                                <div class="form-group">
                                    <label for="receiverName">Họ tên người nhận:</label>
                                    <input type="text" class="form-control" id="receiverName" name="receiverName" required>
                                </div>
                                <div class="form-group">
                                    <label for="receiverPhone">Số điện thoại:</label>
                                    <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" required>
                                </div>
                                <div class="form-group">
                                    <label for="province">Tỉnh / Thành phố:</label>
                                    <select id="province" name="province" class="form-control" required></select>
                                </div>
                                <div class="form-group">
                                    <label for="district">Quận / Huyện:</label>
                                    <select id="district" name="district" class="form-control" required></select>
                                </div>
                                <div class="form-group">
                                    <label for="ward">Phường / Xã:</label>
                                    <select id="ward" name="ward" class="form-control" required></select>
                                </div>
                                <div class="form-group">
                                    <label for="receiverAddress">Địa chỉ cụ thể (Số nhà, tên đường...):</label>
                                    <input type="text" class="form-control" id="receiverAddress" name="receiverAddress" required placeholder="VD: 123 Lê Lợi, P.7">
                                </div>
                                <div class="form-group">
                                    <label for="deliveryTime">Thời gian giao hàng:</label>
                                    <input type="datetime-local" class="form-control" id="deliveryTime" name="deliveryTime" required>
                                </div>
                                <!-- Hiển thị giỏ hàng -->
                                <c:choose>
                                    <c:when test="${not empty sessionScope.cart}">
                                        <h4>Chi tiết đơn hàng</h4>
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Tên sản phẩm</th>
                                                        <th>Giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="total" value="0" />
                                                    <c:forEach var="line" items="${sessionScope.cart}">
                                                        <c:set var="itemTotal" value="${line.bouquetTemplate.basePrice * line.quantity}" />
                                                        <tr>
                                                            <td>${line.bouquetTemplate.templateName}</td>
                                                            <td>${line.bouquetTemplate.basePrice} VNĐ</td>
                                                            <td>${line.quantity}</td>
                                                            <td>${itemTotal} VNĐ</td>
                                                        </tr>
                                                        <c:set var="total" value="${total + itemTotal}" />
                                                    </c:forEach>
                                                    <tr>
                                                        <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
                                                        <td><strong>${total} VNĐ</strong></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:when test="${not empty sessionScope.customFlowerRequestId}">
                                        <h4>Chi tiết đơn hàng</h4>
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Tên sản phẩm</th>
                                                        <th>Giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Hoa yêu cầu</td>
                                                        <td><fmt:formatNumber value="${sessionScope.customFlowerPrice}" type="currency" currencySymbol="₫"/></td>
                                                        <td>${sessionScope.customFlowerQuantity}</td>
                                                        <td><fmt:formatNumber value="${sessionScope.customFlowerPrice * sessionScope.customFlowerQuantity}" type="currency" currencySymbol="₫"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
                                                        <td><strong><fmt:formatNumber value="${sessionScope.customFlowerPrice * sessionScope.customFlowerQuantity}" type="currency" currencySymbol="₫"/></strong></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Không có sản phẩm nào trong giỏ hàng.</p>
                                    </c:otherwise>
                                </c:choose>
                                <button type="submit" class="btn btn-success btn-block">Xác nhận đặt hàng</button>
                            </form>
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

        <c:if test="${sessionScope.user != null}">
            <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" style="width: 300px; z-index: 500000">
                <div class="toast-header">
                    <strong class="mr-auto">Thông báo</strong>
                    <small>...</small>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="toast-body">
                    Chào mừng bạn đến với trang giỏ hàng
                </div>
            </div>
            <script>
                                $(document).ready(function () {
                                    $('.toast').toast({
                                        delay: 3500
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

        <script>
    let treeData = {};
    fetch('json/tree.json')
        .then(res => res.json())
        .then(data => {
            treeData = data;
            const provinceSelect = document.getElementById('province');
            provinceSelect.innerHTML = '<option value="">-- Chọn Tỉnh/Thành --</option>';
            for (const [code, province] of Object.entries(data)) {
                const option = document.createElement('option');
                option.value = province.name;       // Gửi tên tỉnh về server
                option.text = province.name;
                option.dataset.code = code;         // Lưu code để truy dữ liệu
                provinceSelect.appendChild(option);
            }
        });

    document.getElementById('province').addEventListener('change', function () {
        const selectedProvince = this.options[this.selectedIndex];
        const provinceCode = selectedProvince.dataset.code; // Lấy lại code gốc

        const districtSelect = document.getElementById('district');
        const wardSelect = document.getElementById('ward');
        districtSelect.innerHTML = '<option value="">-- Chọn Quận/Huyện --</option>';
        wardSelect.innerHTML = '<option value="">-- Chọn Phường/Xã --</option>';

        if (provinceCode && treeData[provinceCode]) {
            const districts = treeData[provinceCode]['quan-huyen'];
            for (const [code, district] of Object.entries(districts)) {
                const option = document.createElement('option');
                option.value = district.name;       // Gửi tên quận/huyện
                option.text = district.name;
                option.dataset.code = code;         // Lưu lại code để tra phường
                districtSelect.appendChild(option);
            }
        }
    });

    document.getElementById('district').addEventListener('change', function () {
        const provinceSelect = document.getElementById('province');
        const selectedProvince = provinceSelect.options[provinceSelect.selectedIndex];
        const provinceCode = selectedProvince.dataset.code;

        const selectedDistrict = this.options[this.selectedIndex];
        const districtCode = selectedDistrict.dataset.code;

        const wardSelect = document.getElementById('ward');
        wardSelect.innerHTML = '<option value="">-- Chọn Phường/Xã --</option>';

        if (provinceCode && districtCode && treeData[provinceCode]['quan-huyen'][districtCode]) {
            const wards = treeData[provinceCode]['quan-huyen'][districtCode]['xa-phuong'];
            for (const [code, ward] of Object.entries(wards)) {
                const option = document.createElement('option');
                option.value = ward.name;           // Gửi tên phường/xã
                option.text = ward.name;
                wardSelect.appendChild(option);
            }
        }
    });
</script>
<script>
    function validateForm() {
        // Kiểm tra số điện thoại
        const phone = document.getElementById("receiverPhone").value.trim();
        const phoneRegex = /^0\d{9}$/;
        if (!phoneRegex.test(phone)) {
            alert("Số điện thoại không hợp lệ.");
            return false;
        }

        // Kiểm tra thời gian giao hàng là tương lai
        const deliveryInput = document.getElementById("deliveryTime");
        const deliveryTime = new Date(deliveryInput.value);
        const now = new Date();

        if (deliveryTime <= now) {
            alert("Thời gian giao hàng phải nằm trong tương lai.");
            return false;
        }

        return true; // Hợp lệ thì mới cho submit
    }
</script>

    </body>
</html>