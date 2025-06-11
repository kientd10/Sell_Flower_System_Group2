
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Shopping Cart</a></li>
                                        <li><a href="Customer?action=logout"><b>Logout</b></a></li> 
                                        </c:if> 
                                        <c:if test="${sessionScope.user == null}">
                                        <li><a href="login.jsp"><i class="fa fa-credit-card"></i> Payment</a></li>
                                        <li><a href="cart"><i class="fa fa-shopping-cart"></i> Shopping Cart</a></li>
                                        <li><a href="login.jsp"><b>Login</b></a></li> 
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
        <style>
            .table-fixed {
                table-layout: fixed;
                width: 100%;
            }
            .table-fixed th.image,
            .table-fixed td.cart_product {
                padding: 0;
                width: 150px;
                overflow: hidden;
            }
            .image-wrapper {
                width: 150px;
                height: 150px;
                overflow: hidden;
                position: relative;
            }
            .image-wrapper img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }
        </style>
        <section id="cart_items">
            <div class="container">
                <h2>Giỏ hàng</h2>
                <c:if test="${cart.isEmpty()}">
                    <div class="alert alert-danger">Chưa chọn sản phẩm nào vào giỏ hàng </div>
                </c:if>
                <c:if test="${!cart.isEmpty()}">
                    <form action="cart" method="post">
                        <div class="table-responsive">
                            <table class="table table-bordered table-fixed">
                                <thead>
                                    <tr class="cart_menu">
                                        <th class="image" style="width: 200px;">Tên Sản Phẩm</th>
                                        <th class="description">Mô tả</th>
                                        <th class="price">Giá</th>
                                        <th class="quantity">Số lượng</th>
                                        <th class="total">Tổng tiền</th>
                                        <th class="pay">Đặt Hàng</th>
                                        <th class="delete"></th>  
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cart}" var="line">
                                        <tr>
                                            <td class="cart_product">
                                                <img
                                                    class="image-wrapper"
                                                    src="${pageContext.request.contextPath}/images/cart/${line.bouquetTemplate.imageUrl}"
                                                    alt="${line.bouquetTemplate.templateName}" />
                                            </td>
                                            <td>
                                                <h4>${line.bouquetTemplate.templateName}</h4>
                                                <p>Web ID: ${line.bouquetTemplate.templateId}</p>
                                                <p>
                                                    Quantity: 
                                                    <input type="number" id="stk_${line.bouquetTemplate.templateId}" 
                                                           value="${line.bouquetTemplate.stock}" 
                                                           min="0" readonly style="border: none; background: transparent; width: 50px;">
                                                </p>
                                                <div id="notice_${line.bouquetTemplate.templateId}" style="margin-top: 5px;"></div>
                                            </td>
                                            <td>
                                                ${line.bouquetTemplate.basePrice} VNĐ
                                            </td>
                                            <td class="cart_quantity">
                                                <button type="button"
                                                        onclick="decreaseQty('${line.bouquetTemplate.templateId}')"
                                                        class="btn btn-xs btn-default">
                                                    -
                                                </button>
                                                <input type="number"
                                                       id="qty_${line.bouquetTemplate.templateId}"
                                                       name="quantity[]"
                                                       value="${line.quantity}"
                                                       min="1"
                                                       data-base-price="${line.bouquetTemplate.basePrice}"
                                                       readonly
                                                       style="width:60px; text-align:center;"/>

                                                <!-- Nút tăng -->
                                                <button
                                                    type="button"
                                                    id="btnPlus_${line.bouquetTemplate.templateId}"
                                                    onclick="increaseQty('${line.bouquetTemplate.templateId}')"

                                                    class="btn btn-xs btn-default">
                                                    +
                                                </button>


                                                <!-- Hidden input để gửi templateId lên server -->
                                                <input type="hidden"
                                                       name="templateId[]"
                                                       value="${line.bouquetTemplate.templateId}"/>
                                            </td>
                                            <td>
                                                <span id="lineTotal_${line.bouquetTemplate.templateId}">
                                                    ${line.bouquetTemplate.basePrice * line.quantity}
                                                </span> VNĐ
                                            </td>
                                            <td >
                                                <input type="hidden" name="cartId[]" value="${line.cartId}" />
                                                <input
                                                    type="checkbox"
                                                    name="isChecked[]"
                                                    value="${line.cartId}"
                                                    <c:if test="${fn:contains(selectedCartIds, line.cartId.toString())}">
                                                        checked
                                                    </c:if>
                                                    />
                                            </td>
                                            <td>
                                                <a href="remove?templateId=${line.bouquetTemplate.templateId}">
                                                    <i class="fa fa-times"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-right" style="margin-top:20px;">
                            <c:if test="${not empty sessionScope.error}">
                                <div class="alert alert-danger">${sessionScope.error}</div>
                            </c:if>
                        </div>
                        <c:if test="${!sessionScope.isEmpty}">
                            <c:if test="${sessionScope.user == null}">
                                <div class="text-right" style="margin-top:20px;">
                                    <a href="login.jsp" class="btn btn-success">Thanh Toán</a>
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <div class="text-right" style="margin-top:20px;">
                                    <button type="submit" class="btn btn-success">Thanh Toán</button>
                                </div>
                            </c:if>
                        </c:if>
                    </form>
                </c:if>
            </div>
        </section>
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
    <script>
        function increaseQty(id) {
            const qtyInput = document.getElementById('qty_' + id);
            let current = parseInt(qtyInput.value, 10);

            // stockQty sẽ disable nút + và trả false nếu sẽ âm
            if (!stockQty(id, 1)) {
                return;
            }

            // Còn hàng mới tăng qty và cập nhật tổng tiền
            qtyInput.value = current + 1;
            updateLineTotal(id);
        }

        function decreaseQty(id) {
            const qtyInput = document.getElementById('qty_' + id);
            let current = parseInt(qtyInput.value, 10);

            if (current > 1) {
                // Giảm qty trước
                qtyInput.value = current - 1;
                updateLineTotal(id);

                // Trả hàng về kho, stockQty sẽ enable lại nút +
                stockQty(id, -1);
            }
        }

        function stockQty(id, delta) {
            const stockInput = document.getElementById('stk_' + id);
            const notice = document.getElementById('notice_' + id);
            const btnPlus = document.getElementById('btnPlus_' + id);

            let current = parseInt(stockInput.value, 10);
            let next = current - delta;

            // Nếu next < 0 thì hết hàng
            if (next < 0) {
                if (notice) {
                    notice.textContent = "Sản phẩm đã hết hàng!";
                    notice.style.color = 'red';
                }
                if (btnPlus) {
                    btnPlus.disabled = true;
                }
                return false;
            }

            // Còn hàng → cập nhật stock và bật lại nút +
            stockInput.value = next;
            if (notice)
                notice.textContent = "";
            if (btnPlus)
                btnPlus.disabled = false;

            return true;
        }

        function updateLineTotal(id) {
            const qtyInput = document.getElementById('qty_' + id);
            const qty = parseInt(qtyInput.value, 10);
            const basePrice = parseFloat(qtyInput.getAttribute('data-base-price'));
            const lineTotal = document.getElementById('lineTotal_' + id);

            lineTotal.textContent = (basePrice * qty).toLocaleString('vi-VN') + ' ₫';
        }

        // Khởi tạo: đảm bảo nút + đang đúng trạng thái lúc load
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('input[id^="stk_"]').forEach(stkInput => {
                const id = stkInput.id.replace('stk_', '');
                stockQty(id, 0);
            });
        });
    </script>
</body>
</html>

