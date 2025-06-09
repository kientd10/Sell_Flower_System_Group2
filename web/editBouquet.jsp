<%-- 
    Document   : editBouquet
    Created on : Jun 9, 2025, 10:14:17 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.BouquetTemplate" %>

<%
    // Lấy biến từ request (có thể null)
    BouquetTemplate bouquet = (BouquetTemplate) request.getAttribute("bouquet");
    boolean isEdit = bouquet != null;
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Sửa" : "Thêm" %> sản phẩm</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2><%= isEdit ? "Sửa" : "Thêm" %> sản phẩm</h2>

    <form action="staffbouquetservlet" method="post">
        <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= bouquet.getTemplateId() %>">
        <% } %>

        <div class="mb-3">
            <label for="name" class="form-label">Tên sản phẩm</label>
            <input type="text" class="form-control" name="name" required
                   value="<%= isEdit ? bouquet.getTemplateName() : "" %>">
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" required><%= isEdit ? bouquet.getDescription() : "" %></textarea>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Giá</label>
            <input type="number" step="1000" class="form-control" name="price" required
                   value="<%= isEdit ? bouquet.getBasePrice() : "" %>">
        </div>

        <div class="mb-3">
            <label for="imageUrl" class="form-label">Link hình ảnh</label>
            <input type="text" class="form-control" name="imageUrl"
                   value="<%= isEdit ? bouquet.getImageUrl() : "" %>">
        </div>

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="staffbouquetservlet" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>
