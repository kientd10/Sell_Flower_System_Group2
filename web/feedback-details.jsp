
<%-- 
    Document   : feedback-details
    Created on : Jul 22, 2025, 5:08:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Phản Hồi</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-primary">Chi tiết phản hồi</h2>

    <c:if test="${not empty feedback}">
        <table class="table table-bordered">
            <tr>
                <th>Bình luận</th>
                <td>${feedback.comment}</td>
            </tr>
            <tr>
                <th>Đánh giá</th>
                <td>${feedback.rating} ★</td>
            </tr>
            <tr>
                <th>Sản phẩm</th>
                <td>${feedback.productName}</td>
            </tr>
            <tr>
                <th>Khách hàng</th>
                <td>${feedback.customerName}</td>
            </tr>
            <tr>
                <th>Thời gian gửi</th>
                <td>
                    <fmt:formatDate value="${feedback.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                </td>
            </tr>
        </table>
        <a href="feedbacks" class="btn btn-secondary">Quay lại</a>
    </c:if>

    <c:if test="${empty feedback}">
        <div class="alert alert-danger">Không tìm thấy phản hồi nào!</div>
        <a href="feedbacks" class="btn btn-secondary">Quay lại</a>
    </c:if>
</div>
</body>
</html>
