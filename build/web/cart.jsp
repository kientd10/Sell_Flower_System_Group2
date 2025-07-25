
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        
        <!-- GIỮ style cho header/footer, xóa style cũ cart -->
    <style>
        /* GIỮ style cho header/footer, xóa style cũ cart */
        /* --- CART SECTION NEW STYLE --- */
        #cart_items {
            margin-top: 40px;
        }
        .cart-section-container {
            max-width: 1100px;
            margin: 48px auto 60px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 32px rgba(206,66,108,0.10);
            padding: 48px 48px 40px 48px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .cart-section-container h2 {
            color: #ce4242;
            font-weight: 700;
            margin-bottom: 24px;
            text-align: center;
        }
        .cart-table {
            width: 100%;
            min-width: 800px;
            margin: 0 auto 24px auto;
            border-collapse: separate;
            border-spacing: 0 10px;
        }
        .cart-table th {
            background: #ce4242;
            color: #fff;
            font-weight: 600;
            padding: 12px 8px;
            border: none;
            border-radius: 8px 8px 0 0;
            font-size: 1.08rem;
        }
        .cart-table td {
            background: #fff;
            border: none;
            box-shadow: 0 2px 12px rgba(206,66,108,0.07);
            border-radius: 8px;
            padding: 14px 8px;
            vertical-align: middle;
        }
        .cart-table tr {
            background: transparent;
        }
        .cart_product img {
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(206,66,108,0.10);
            max-width: 130px;
            max-height: 130px;
            min-width: 90px;
            object-fit: cover;
            display: block;
            margin: 0 auto;
        }
        .cart_product h4 {
            color: #ce4242;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .cart_product p {
            color: #888;
            font-size: 0.95rem;
            margin-bottom: 2px;
        }
        .cart_quantity button {
            background: #fff;
            color: #ce4242;
            border: 1.5px solid #ce4242;
            border-radius: 6px;
            width: 32px;
            height: 32px;
            font-size: 1.2rem;
            font-weight: bold;
            transition: background 0.2s, color 0.2s;
        }
        .cart_quantity button:hover {
            background: #ce4242;
            color: #fff;
        }
        .cart_quantity input[type="number"] {
            border: 1.5px solid #ce4242;
            border-radius: 6px;
            width: 48px;
            text-align: center;
            margin: 0 4px;
        }
        .cart_quantity input[type="number"]:focus {
            outline: 1.5px solid #ce4242;
        }
        .btn-success, .btn-default {
            background: #ce4242 !important;
            border: none;
            color: #fff !important;
            border-radius: 8px;
            font-weight: 600;
            padding: 8px 24px;
            transition: background 0.2s;
        }
        .btn-success:hover, .btn-default:hover {
            background: #a81e4a !important;
            color: #fff !important;
        }
        .alert-danger {
            background: #ffe3ef;
            color: #ce4242;
            border: 1px solid #ce4242;
            border-radius: 8px;
            margin-bottom: 18px;
        }
        .cart-actions {
            text-align: right;
            margin-top: 18px;
        }
        /* Responsive tweaks */
        @media (max-width: 1200px) {
            .cart-section-container {
                max-width: 99vw;
                padding: 18px 2vw 18px 2vw;
            }
            .cart-table {
                min-width: 600px;
            }
        }
        @media (max-width: 900px) {
            .cart-section-container {
                padding: 8px 1vw;
            }
            .cart-table {
                min-width: 400px;
            }
        }
        @media (max-width: 600px) {
            .cart-section-container {
                box-shadow: none;
                padding: 0;
            }
            .cart-table {
                min-width: unset;
                width: 100%;
            }
            .cart-table th, .cart-table td {
                font-size: 0.85rem;
            }
        }
        .cart-table th, .cart-table td {
            padding: 16px 10px;
            text-align: center;
            vertical-align: middle;
        }
        .cart-table th {
            min-width: 70px;
        }
        .cart-table td.cart_product {
            min-width: 130px;
            width: 130px;
            max-width: 150px;
            background: none !important;
            box-shadow: none !important;
            padding: 0 8px;
            text-align: center !important;
            vertical-align: middle !important;
            display: table-cell !important;
            position: relative;
        }
        .cart_product img {
            display: block;
            margin: 0 auto;
            border-radius: 10px;
            max-width: 100px;
            max-height: 100px;
            min-width: 80px;
            min-height: 80px;
            object-fit: cover;
            box-shadow: none;
            background: #fff;
            vertical-align: middle;
        }
        .cart-table td:nth-child(2) {
            min-width: 90px;
            font-size: 0.95rem;
            text-align: left;
            padding-left: 8px;
            padding-right: 8px;
        }
        .cart-table th, .cart-table td {
            padding: 8px 6px;
        }
        .cart-table td:nth-child(3),
        .cart-table td:nth-child(4),
        .cart-table td:nth-child(5),
        .cart-table td:nth-child(6),
        .cart-table td:nth-child(7) {
            min-width: 55px;
        }
        @media (max-width: 900px) {
            .cart-table th, .cart-table td {
                padding: 8px 3px;
            }
        }
        @media (max-width: 600px) {
            .cart-table th, .cart-table td {
                padding: 4px 1px;
            }
        }
    </style>
        
        <section id="cart_items">
            <div class="cart-section-container">
                <div class="text-center" style="margin-bottom: 32px;">
                    <h2><i class="fa fa-shopping-bag"></i> Giỏ hàng </h2>
                    <p class="text-muted">Theo dõi và quản lý giỏ hàng của bạn</p>
                </div>
                <c:if test="${cart.isEmpty()}">
                    <div class="alert alert-danger">Chưa chọn sản phẩm nào vào giỏ hàng </div>
                </c:if>
                <c:if test="${!cart.isEmpty()}">
                    <form action="cart" method="post">
                        <div class="table-responsive">
                            <table class="cart-table">
                                <thead>
                                    <tr class="cart_menu">
                                        <th>Ảnh</th>
                                        <th>Tên Sản Phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Tổng tiền</th>
                                        <th>Chọn</th>
                                        <th>Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cart}" var="line">
                                        <tr>
                                            <td class="cart_product">
                                                <img src="${pageContext.request.contextPath}/${line.bouquetTemplate.imageUrl}" alt="${line.bouquetTemplate.templateName}" />
                                            </td>
                                            <td>
                                                <h4>${line.bouquetTemplate.templateName}</h4>
                                                <p>Web ID: ${line.bouquetTemplate.templateId}</p>
                                                <input type="number" id="stk_${line.bouquetTemplate.templateId}" value="${line.bouquetTemplate.stock}" min="0" readonly style="display:none;">
                                                <div id="notice_${line.bouquetTemplate.templateId}" style="margin-top: 5px; color: #ce426c; font-size: 0.95rem;"></div>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${line.bouquetTemplate.basePrice}" type="currency" currencySymbol="₫"/>
                                            </td>
                                            <td class="cart_quantity">
                                                <button type="button" onclick="decreaseQty('${line.bouquetTemplate.templateId}')" id="btnMinus_${line.bouquetTemplate.templateId}" class="btn btn-xs btn-default">-</button>
                                                <input type="number" id="qty_${line.bouquetTemplate.templateId}" name="quantity[]" value="${line.quantity}" min="1" data-base-price="${line.bouquetTemplate.basePrice}" readonly />
                                                <button type="button" id="btnPlus_${line.bouquetTemplate.templateId}" onclick="increaseQty('${line.bouquetTemplate.templateId}')" class="btn btn-xs btn-default">+</button>
                                                <input type="hidden" name="templateId[]" value="${line.bouquetTemplate.templateId}"/>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${line.bouquetTemplate.basePrice * line.quantity}" type="currency" currencySymbol="₫"/>
                                            </td>
                                            <td>
                                                <input type="hidden" name="cartId[]" value="${line.cartId}" />
                                                <input type="checkbox" name="isChecked[]" value="${line.cartId}" <c:if test="${fn:contains(selectedCartIds, line.cartId.toString())}">checked</c:if> />
                                            </td>
                                            <td>
                                                <a href="remove?templateId=${line.bouquetTemplate.templateId}"><i class="fa fa-times"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="cart-actions">
                            <c:if test="${not empty sessionScope.error}">
                                <div class="alert alert-danger">${sessionScope.error}</div>
                            </c:if>
                            <c:if test="${!sessionScope.isEmpty}">
                                <c:if test="${sessionScope.user == null}">
                                    <a href="login.jsp" class="btn btn-success">Thanh Toán</a>
                                </c:if>
                                <c:if test="${sessionScope.user != null}">
                                    <button type="submit" class="btn btn-success">Thanh Toán</button>
                                </c:if>
                            </c:if>
                        </div>
                    </form>
                </c:if>
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
                <!--                     <img src="assets/img/logo/guitar.png" class="rounded me-2" alt="iconlmao" style= "  max-width: 100%;
                    height: auto;
                    max-height: 20px;">-->
                <strong class="mr-auto">Thông báo</strong>
                <small>...</small>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                Chào mừng bạn đến với trang giỏ hàng
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

