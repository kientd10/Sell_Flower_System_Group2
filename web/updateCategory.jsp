<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Category | Flower Shop</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-red: #c44d58;
            --primary-red-dark: #a03d4a;
            --secondary-gray: #6c757d;
            --dark-gray: #343a40;
            --light-gray: #f8f9fa;
            --sidebar-width: 280px;
        }
        body {
            font-family: 'Inter', sans-serif;
            background: var(--light-gray);
            margin: 0;
            padding: 0;
        }
        .wrapper { display: flex; min-height: 100vh; }
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(135deg, var(--dark-gray) 0%, #495057 100%);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        .sidebar-brand {
            padding: 1.5rem;
            color: white;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.2rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: block;
            text-align: center;
        }
        .sidebar-user {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            color: white;
        }
        .sidebar-nav {
            list-style: none;
            padding: 1rem 0;
            margin: 0;
        }
        .sidebar-header {
            padding: 1rem 1.5rem 0.5rem;
            color: rgba(255,255,255,0.6);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .sidebar-link:hover, .sidebar-link.active {
            background: var(--primary-red);
            color: white;
            transform: translateX(5px);
        }
        .sidebar-link i { margin-right: 0.8rem; width: 18px; }
        .main-content {
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
            min-height: 100vh;
        }
        .top-navbar {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .content-area { padding: 2rem; }
        .page-title {
            color: var(--dark-gray);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .card {
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-radius: 10px;
            margin-bottom: 1.5rem;
        }
        .card-header {
            background: var(--primary-red);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.2rem 1.5rem;
        }
        .btn-primary {
            background: var(--primary-red);
            border-color: var(--primary-red);
            border-radius: 6px;
        }
        .btn-primary:hover {
            background: var(--primary-red-dark);
            transform: translateY(-1px);
        }
        @media (max-width: 768px) {
            .sidebar { width: 250px; }
            .main-content { margin-left: 250px; width: calc(100% - 250px); }
            .content-area { padding: 1rem; }
        }
    </style>
</head>

<body>
    <div class="wrapper">
		<!-- ===== SIDEBAR NAVIGATION ===== -->
		<nav class="sidebar">
			<a href="home" class="sidebar-brand" style="font-size:27px ; color: #d4d4d4">
				<i class="fas fa-seedling me-2" style="color: #dc3545;" ></i>Menu quản lý
			</a>

			<div class="sidebar-user">
				<div class="d-flex align-items-center">
					<img src="https://via.placeholder.com/45" class="rounded me-2" alt="Admin">
					<div>
						<div style="font-weight: 600;">Admin User</div>
						<small style="opacity: 0.8;">System Manager</small>
					</div>
				</div>
			</div>
                    
			<ul class="sidebar-nav">
				<li class="sidebar-header">Menu Chính</li>
				<!-- Chỉ hiển thị nếu là Staff -->
				<c:if test="${sessionScope.user.roleId == 2}">                                             
					<li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
					<li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
					<li><a href="storagemanagement?action=view" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
					<li><a href="orderManagement.jsp" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
				</c:if> 

				<!-- Chỉ hiển thị nếu là Manager -->
				<c:if test="${sessionScope.user.roleId == 3}"> 
					<li><a href="management.jsp" class="sidebar-link" id="menu-management"><i class="fas fa-chart-bar"></i>Thống Kê</a></li>
					<li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
					<li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
					<li><a href="storagemanagement?action=view" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
					<li><a href="orderManagement.jsp" class="sidebar-link" id="menu-orderManagement"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
					<li><a href="invoiceManagement.jsp" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>
					<li class="sidebar-header">Hệ Thống</li>
					<li><a href="userManagement.jsp" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Người Dùng</a></li>
					<li><a href="feedbackManagement.jsp" class="sidebar-link active" id="menu-feedbackManagement"><i class="fas fa-comments"></i>Quản Lý Phản Hồi</a></li>
					<li><a href="notificationManagement.jsp" class="sidebar-link" id="menu-notificationManagement"><i class="fas fa-bell"></i>Thông Báo<span class="badge bg-danger ms-auto">4</span></a></li>
				</c:if> 
                    
				<!-- Chỉ hiển thị nếu là Shipper -->                        
				<c:if test="${sessionScope.user.roleId == 4}">
					<li><a href="orderManagement.jsp" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
				</c:if>                   
			</ul>
		</nav>

        <div class="main-content">
            <div class="top-navbar">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="input-group" style="width: 300px;">
                        <input type="text" class="form-control" placeholder="Search products..." id="productSearch">
                        <button class="btn btn-outline-secondary" onclick="searchProducts()"><i class="fas fa-search"></i></button>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <a href="${pageContext.request.contextPath}/categories?action=create" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Thêm danh mục
                        </a>
                    </div>
                </div>
            </div>

            <div class="content-area">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="page-title">Cập nhật danh mục</h2>
                        <p class="text-muted">Chỉnh sửa thông tin danh mục hoa.</p>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Form cập nhật danh mục</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/category?action=update" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="categoryId" value="${category.categoryId}">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" id="categoryName" name="categoryName" value="${category.categoryName}" required>
                            </div>
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">Lưu</button>
                                <a href="${pageContext.request.contextPath}/category?action=management" class="btn btn-secondary">Hủy</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function searchProducts() {
            const searchTerm = document.getElementById('productSearch').value;
            console.log('Searching for:', searchTerm);
        }

        function validateForm() {
            const categoryName = document.getElementById('categoryName').value;
            if (categoryName.trim() === '') {
                alert('Tên danh mục không được để trống!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>