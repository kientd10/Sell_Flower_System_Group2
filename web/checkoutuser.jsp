<%-- 
    Document   : checkoutuser
    Created on : Jun 3, 2025, 5:31:38 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Thông tin giao hàng | E-Flower Shop</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
</head>
<body>

<h1>Flower Shop Checkout</h1>

<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <ol class="breadcrumb">
                <li><a href="index.jsp">Home</a></li>
                <li class="active">Checkout</li>
            </ol>
        </div>

        <div class="step-one">
            <h2 class="heading">Thông tin nhận hàng</h2>
        </div>

        <div class="row">
            <div class="col-sm-6 col-sm-offset-3">
                <form action="placeOrder" method="post">
                    <div class="form-group">
                        <label for="receiverName">Họ tên người nhận:</label>
                        <input type="text" class="form-control" id="receiverName" name="receiverName" required>
                    </div>
                    <div class="form-group">
                        <label for="receiverPhone">Số điện thoại:</label>
                        <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" required>
                    </div>
                    <div class="form-group">
                        <label for="receiverAddress">Địa chỉ nhận hàng:</label>
                        <textarea class="form-control" id="receiverAddress" name="receiverAddress" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="deliveryTime">Thời gian giao hàng:</label>
                        <input type="datetime-local" class="form-control" id="deliveryTime" name="deliveryTime" required>
                    </div>
                    <button type="submit" class="btn btn-success btn-block">Xác nhận đặt hàng</button>
                </form>
            </div>
        </div>
    </div>
</section>

<footer style="text-align:center; margin-top:30px;">
    <p>© 2025 E-Flower Shop. All rights reserved.</p>
</footer>

<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>
