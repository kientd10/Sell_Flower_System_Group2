<%-- 
    Document   : purchase-history
    Created on : Jun 19, 2025, 9:00:25 AM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Sản phẩm đã mua</title>
    </head>
    <body>
        <h2>Sản phẩm bạn đã mua (đã giao):</h2>

        <c:forEach var="item" items="${purchasedList}">
            <div style="margin-bottom: 15px;">
                <strong>${item.templateName}</strong>
                <a href="feedback_form.jsp?templateId=${item.templateId}">Đánh giá</a>
            </div>
        </c:forEach>

        <a href="home">← Quay lại trang chủ</a>
    </body>
</html>
