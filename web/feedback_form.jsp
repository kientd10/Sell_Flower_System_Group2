<%-- 
    Document   : feedback_form.jsp
    Created on : Jul 4, 2025, 4:42:38 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Model.ProductFeedback" %>
<%@ page import="Model.User" %>
<%@ page import="dal.ProductFeedbackDAO" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    User user = (User) session.getAttribute("user");

    ProductFeedbackDAO dao = new ProductFeedbackDAO();
    ProductFeedback existingFeedback = dao.getFeedback(productId, user.getUserId());
%>

<html>
<head>
    <title>Đánh giá sản phẩm</title>
    <style>
        .star-rating {
            direction: rtl;
            font-size: 30px;
            unicode-bidi: bidi-override;
            display: inline-flex;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            color: #ccc;
            cursor: pointer;
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: gold;
        }
    </style>
</head>
<body>
    <h2>Đánh giá sản phẩm mã: <%= productId %></h2>

    <form action="submit-feedback" method="post">
        <input type="hidden" name="productId" value="<%= productId %>">

        <p>
            <label>Chọn số sao:</label><br>
            <div class="star-rating">
                <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="star<%= i %>" name="rating" value="<%= i %>"
                        <%= (existingFeedback != null && existingFeedback.getRating() == i) ? "checked" : "" %> >
                    <label for="star<%= i %>">&#9733;</label>
                <% } %>
            </div>
        </p>

        <p>
            <label>Viết nhận xét:</label><br>
            <textarea name="comment" rows="4" cols="50" required><%= (existingFeedback != null ? existingFeedback.getComment() : "") %></textarea>
        </p>

        <button type="submit">Gửi đánh giá</button>
    </form>
</body>
</html>
