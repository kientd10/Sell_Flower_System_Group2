<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.BouquetTemplate" %>
<%
    // Kiểm tra session user
    Model.User user = (Model.User) session.getAttribute("user");
    if (user == null || user.getRoleId() != 2) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Dashboard | Flower Shop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                font-size: 16px;
                margin: 0;
                padding: 0;
            }
            html, body {
                height: 100%;
            }
            .wrapper {
                display: flex;
                min-height: 100%;
            }
            .sidebar {
                width: 220px;
                background: #f8f9fa;
                min-height: 100vh;
                padding-top: 20px;
                position: fixed;
                top: 0;
                left: 0;
                border-right: 1px solid #dee2e6;
            }
            .sidebar h5 {
                margin: 0 0 1rem 20px;
                color: #343a40;
                font-size: 1.25rem; /* lớn hơn */
                text-transform: uppercase;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .sidebar ul li {
                margin: 0.75rem 0;
            }
            .sidebar ul li a {
                display: flex;
                align-items: center;
                color: #495057;
                text-decoration: none;
                padding: 10px 20px;
                font-size: 1.5rem; /* lớn hơn */
                transition: background 0.2s, color 0.2s;
            }
            .sidebar ul li a i {
                margin-right: 10px;
                padding: 20px 20px;
                font-size: 1.2rem;
            }
            .sidebar ul li a:hover, .sidebar ul li a.active {
                background: #e9ecef;
                color: #007bff;
            }
            .sidebar ul li.logout {
                margin-top: 2rem;
                text-align: center;
            }
            .sidebar ul li.logout a {
                border: 1px solid #dc3545;
                color: #dc3545;
                border-radius: 4px;
                padding: 6px 12px;
                font-size: 1.5rem;
            }
            .sidebar ul li.logout a:hover {
                background: #dc3545;
                color: #fff;
            }
            .main-content {
                margin-left: 220px;
                padding: 50px 40px;
            }
            .main-content h2 {
                color: #28a745;
                font-size: 2rem; /* lớn hơn */
                margin-bottom: 0.75rem;
            }
            .main-content .subtitle {
                font-size: 1.1rem; /* lớn hơn */
                color: #6c757d;
                margin-bottom: 2.5rem;
            }
            .sidebar {
                position: relative;
                width: 220px;
                background: #f8f9fa;
                min-height: 100vh;
                padding-top: 20px;
                border-right: 1px solid #dee2e6;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .sidebar ul {
                flex-grow: 1;
            }

            .sidebar .greeting {
                text-align: center;
                padding: 15px;
            }

            .sidebar .greeting img {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #dee2e6;
                margin-bottom: 8px;
            }

            .sidebar .greeting p {
                margin: 0;
                font-size: 1rem;
                color: #343a40;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="sidebar">
                <h5>Chức năng</h5>
                <ul>
                    <li><a href="staffbouquetservlet?action=view"><i class="fa fa-leaf"></i> Quản lý sản phẩm</a></li>
                    <li><a href="order?action=pending"><i class="fa fa-list-alt"></i> Đơn chờ xác nhận</a></li>
                    <li><a href="order?action=confirmed"><i class="fa fa-check-square"></i> Đơn đã xử lý</a></li>
                    <li><a href="order?action=confirmed"><i class="fa fa-check-square"></i> Xem lịch trình</a></li>
                    <li><a href="delivery?action=assign"><i class="fa fa-truck"></i> Giao cho shipper</a></li>
                    <li class="logout"><a href="Customer?action=logout"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
                </ul>
                <div class="greeting">
                    <img src="images/default-avatar.png" alt="Avatar" />
                    <p>Xin chào, Staff!</p>
                </div>
            </div>

            <div class="main-content">
                <c:choose>
                    <c:when test="${param.action == 'view' && editMode}">
                        <h2>Danh sách sản phẩm</h2>
                        <div class="table-responsive">
                            <form action="staffbouquetservlet" method="post">
                                <table class="table table-bordered table-fixed">
                                    <thead>
                                        <tr class="cart_menu">
                                            <th class="text">ID</th>
                                            <th class="text">Tên</th>
                                            <th class="quantity">Số lượng</th>
                                            <th class="description">Mô tả</th>
                                            <th class="image" style="width: 200px;">Ảnh</th>
                                            <th class="price">Giá:</th>
                                            <th>Hành Động</th>
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
                                            <td><%= b.getStock() %></td>
                                            <td><%= b.getDescription() %></td>
                                            <td>
                                                <img
                                                    class="image-wrapper"
                                                    src="${pageContext.request.contextPath}/images/cart/${b.imageUrl}"
                                                    alt="${b.templateName}" />
                                            </td>
                                            <td><%= b.getBasePrice() %> VNĐ</td>
                                            <td>
                                                <a href="staffbouquetservlet?action=edit&id=<%= b.getTemplateId() %>" class="btn btn-primary btn-sm">Sửa</a>
                                                <a href="staffbouquetservlet?action=delete&id=<%= b.getTemplateId() %>" class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa mềm sản phẩm này không?');">Xóa</a>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                        <tr><td colspan="7">Không có sản phẩm nào.</td></tr>
                                        <% } %>
                                        <tr>
                                            <%
                                             int nextId = 1;
                                             if (list != null && !list.isEmpty()) {
                                                nextId = list.get(list.size() - 1).getTemplateId() + 1;
                                              }
                                            %>
                                            <td><%= nextId %></td>
                                            <td><input type="text" name="name" class="form-control" required></td>
                                            <td><input type="number" name="stock" class="form-control" required></td>
                                            <td><input type="text" name="description" class="form-control" required></td>
                                            <td><input type="text" name="imageUrl" class="form-control" required></td>
                                            <td><input type="number" name="price" class="form-control" required></td>
                                            <td>
                                                <input type="hidden" name="action" value="saveAdd"/>
                                                <button type="submit" class="btn btn-success btn-sm">💾 Lưu</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </c:when>
                    <c:when test="${param.action == 'view'}">
                        <h2>Danh sách sản phẩm</h2>
                        <a href="staffbouquetservlet?action=view&mode=edit" class="btn btn-success">➕ Thêm sản phẩm mới</a>
                        <div class="table-responsive">
                            <table class="table table-bordered table-fixed">
                                <thead>
                                    <tr class="cart_menu">
                                        <th class="text">ID</th>
                                        <th class="text">Tên</th>
                                        <th class="quantity">Số lượng</th>
                                        <th class="description">Mô tả</th>
                                        <th class="image" style="width: 200px;">Ảnh</th>
                                        <th class="price">Giá:</th>
                                        <th>Hành Động</th>
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
                                        <td><%= b.getStock() %></td>
                                        <td><%= b.getDescription() %></td>
                                        <td>
                                            <img
                                                class="image-wrapper"
                                                src="${pageContext.request.contextPath}/images/cart/${b.imageUrl}"
                                                alt="${b.templateName}" />
                                        </td>
                                        <td><%= b.getBasePrice() %> VNĐ</td>
                                        <td>
                                            <a href="staffbouquetservlet?action=edit&id=<%= b.getTemplateId() %>" class="btn btn-primary btn-sm">Sửa</a>
                                            <a href="staffbouquetservlet?action=delete&id=<%= b.getTemplateId() %>" class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc muốn xóa mềm sản phẩm này không?');">Xóa</a>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                    <tr><td colspan="7">Không có sản phẩm nào.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:when test="${param.action == 'pending'}">
                        <jsp:include page="orderPending.jsp"/>
                    </c:when>
                    <c:when test="${param.action == 'confirmed'}">
                        <jsp:include page="orderConfirmed.jsp"/>
                    </c:when>
                    <c:when test="${param.action == 'assign'}">
                        <jsp:include page="assignDelivery.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <p style="font-size:1.1rem;">Chọn chức năng bên trái để bắt đầu.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Script JS -->
            <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        </div>
    </body>
</html>