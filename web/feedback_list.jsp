<%-- 
    Document   : feedback_list
    Created on : Jun 27, 2025, 8:49:14 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="Model.BouquetTemplate"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<%
    List<BouquetTemplate> purchasedProducts = (List<BouquetTemplate>) request.getAttribute("purchasedProducts");
%>

<html>
<head>
    <title>Danh sách đánh giá</title>
</head>
<body>
    <h2>Sản phẩm bạn đã mua và có thể đánh giá</h2>

    <c:if test="${purchasedProducts == null || purchasedProducts.size() == 0}">
        <p>Bạn chưa có sản phẩm nào để đánh giá.</p>
    </c:if>

    <c:if test="${purchasedProducts != null && purchasedProducts.size() > 0}">
        <table border="1" cellpadding="8">
            <thead>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${purchasedProducts}">
                    <tr>
                        <td>${item.templateName}</td>
                        <td>
                            <a href="feedback-form?product_id=${item.templateId}">Đánh giá / Sửa đánh giá</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
