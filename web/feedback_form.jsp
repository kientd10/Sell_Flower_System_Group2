<%-- 
    Document   : feedback_form
    Created on : Jun 18, 2025, 5:35:15 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đánh giá sản phẩm</title>
</head>
<body>
    <h2>Đánh giá sản phẩm</h2>

    <form method="post" action="feedbackservlet">
        <input type="hidden" name="product_id" value="${product_id}" />

        <label>Chọn số sao:</label>
        <select name="rating" required>
            <c:forEach var="i" begin="1" end="5">
                <option value="${i}" <c:if test="${feedback != null && feedback.rating == i}">selected</c:if>>
                    ${i} ★
                </option>
            </c:forEach>
        </select>
        <br/><br/>

        <label>Viết nhận xét:</label><br/>
        <textarea name="comment" rows="5" cols="40">${feedback != null ? feedback.comment : ''}</textarea><br/><br/>

        <button type="submit">Gửi đánh giá</button>
    </form>
</body>
</html>