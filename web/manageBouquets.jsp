<%-- 
    Document   : manageBouquets
    Created on : Jun 9, 2025, 10:13:35 PM
    Author     : Admin
--%>
<%@ page import="java.util.List" %>
<%@ page import="Model.BouquetTemplate" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Danh sách sản phẩm</h2>
    <a href="staffbouquetservlet?action=add" class="btn btn-success mb-3">➕ Thêm sản phẩm mới</a>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Mô tả</th>
            <th>Giá</th>
            <th>Ảnh</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<BouquetTemplate> list = (List<BouquetTemplate>) request.getAttribute("bouquetList");
            if (list != null) {
                for (BouquetTemplate b : list) {
        %>
        <tr>
            <td><%= b.getTemplateId() %></td>
            <td><%= b.getTemplateName() %></td>
            <td><%= b.getDescription() %></td>
            <td><%= b.getBasePrice() %> đ</td>
            <td><img src="<%= b.getImageUrl() %>" width="80"></td>
            <td>
                <a href="staffbouquetservlet?action=edit&id=<%= b.getTemplateId() %>" class="btn btn-primary btn-sm">Sửa</a>
                <a href="staffbouquetservlet?action=delete&id=<%= b.getTemplateId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Bạn có chắc muốn xóa mềm sản phẩm này không?');">Xóa</a>
            </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="6">Không có sản phẩm nào.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
