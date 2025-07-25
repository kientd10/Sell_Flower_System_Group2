<%-- 
    Document   : orderManagement
    Created on : Jun 16, 2025, 9:39:41 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Đơn hàng | Flower Shop</title>
	
	<!-- External CSS -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	
	<style>
		/* ===== SHARED STYLES ===== */
                :root {
		--primary-red: #c44d58;
		--primary-red-dark: #a03d4a;
		--secondary-gray: #6c757d;
		--dark-gray: #343a40;
		--light-gray: #f8f9fa;
		--sidebar-width: 280px;
                }

		body { font-family: 'Inter', sans-serif; background: var(--light-gray); margin: 0; padding: 0; }
		.wrapper { display: flex; min-height: 100vh; }
		
		/* ===== SIDEBAR STYLES ===== */
		.sidebar {
			width: var(--sidebar-width);
			background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
			position: fixed;
			height: 100vh;
			overflow-y: auto;
			z-index: 1000;
			box-shadow: 2px 0 15px rgba(0,0,0,0.15);
		}
		.sidebar-brand {
			padding: 1.8rem 1.5rem;
			color: white;
			text-decoration: none;
			font-weight: 700;
			font-size: 1.4rem;
			border-bottom: 1px solid rgba(255,255,255,0.1);
			display: block;
			text-align: center;
			background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
			text-shadow: 0 2px 4px rgba(0,0,0,0.3);
			letter-spacing: 0.5px;
		}
		.sidebar-profile {
			padding: 1.5rem;
			border-bottom: 1px solid rgba(255,255,255,0.1);
			background: rgba(255,255,255,0.03);
		}
		.profile-avatar {
			width: 60px;
			height: 60px;
			border-radius: 50%;
			border: 3px solid rgba(255,255,255,0.2);
			object-fit: cover;
			margin-bottom: 0.8rem;
		}
		.profile-welcome {
			color: white;
			font-size: 0.9rem;
			margin-bottom: 0.5rem;
		}
		.profile-role {
			color: #ecf0f1;
			font-size: 0.8rem;
			font-weight: 500;
			margin-bottom: 1rem;
			padding: 0.3rem 0.8rem;
			background: rgba(255,255,255,0.1);
			border-radius: 15px;
			display: inline-block;
		}
		.logout-link {
			color: #c44d58;
			text-decoration: none;
			font-size: 0.95rem;
			font-weight: 500;
			transition: all 0.3s ease;
			display: inline-flex;
			align-items: center;
			gap: 0.5rem;
		}
		.logout-link:hover {
			color: #a03d4a;
			transform: translateX(3px);
		}
		.sidebar-nav {
			list-style: none;
			padding: 1rem 0;
			margin: 0;
		}
		.sidebar-header {
			padding: 1rem 1.5rem 0.5rem;
			color: rgba(255,255,255,0.7);
			font-size: 0.8rem;
			font-weight: 600;
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}
		.sidebar-link {
			display: flex;
			align-items: center;
			padding: 0.9rem 1.5rem;
			color: rgba(255,255,255,0.85);
			text-decoration: none;
			transition: all 0.3s ease;
			border-left: 3px solid transparent;
			margin: 0.2rem 0;
		}
		.sidebar-link:hover, .sidebar-link.active {
			background: linear-gradient(90deg, rgba(231, 76, 60, 0.1) 0%, rgba(231, 76, 60, 0.05) 100%);
			color: white;
			border-left-color: #e74c3c;
			transform: translateX(3px);
		}
		.sidebar-link i {
			margin-right: 0.9rem;
			width: 18px;
			font-size: 1rem;
		}
		
		/* ===== MAIN CONTENT STYLES ===== */
		.main-content { margin-left: var(--sidebar-width); width: calc(100% - var(--sidebar-width)); min-height: 100vh; }
		.top-navbar { background: white; padding: 1rem 2rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
		.content-area { padding: 2rem; }
		.page-title { color: var(--dark-gray); font-weight: 700; margin-bottom: 0.5rem; }
		.card { border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.08); border-radius: 10px; margin-bottom: 1.5rem; }
		.card-header { background: var(--primary-red); color: white; border-radius: 10px 10px 0 0 !important; padding: 1.2rem 1.5rem; }
		.btn-primary { background: var(--primary-red); border-color: var(--primary-red); border-radius: 6px; }
		.btn-primary:hover { background: var(--primary-red-dark); transform: translateY(-1px); }
		.table th { background: var(--light-gray); font-weight: 600; border-top: none; }
		
		/* ===== INVENTORY SPECIFIC STYLES ===== */
		.inventory-stats {
			background: white; border-radius: 10px; padding: 1.5rem;
			box-shadow: 0 4px 15px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
		}
		
		.stock-level {
			padding: 0.4rem 0.8rem; border-radius: 15px; font-size: 0.75rem; font-weight: 600;
		}
		.stock-level.critical { background: #ff6b6b; color: white; }
		.stock-level.low { background: #feca57; color: #2f3542; }
		.stock-level.normal { background: #1dd1a1; color: white; }
		.stock-level.high { background: #48dbfb; color: #2f3542; }
		
		.reorder-alert {
			background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 8px;
			padding: 1rem; margin-bottom: 1rem; border-left: 4px solid #f39c12;
		}
		
		.stock-progress {
			height: 8px; border-radius: 4px; overflow: hidden; background: #e9ecef;
		}
		.stock-progress .progress-bar {
			height: 100%; transition: width 0.3s ease;
		}
		.stock-progress .progress-bar.critical { background: #e74c3c; }
		.stock-progress .progress-bar.low { background: #f39c12; }
		.stock-progress .progress-bar.normal { background: #27ae60; }
		.stock-progress .progress-bar.high { background: #3498db; }
		
		.supplier-info {
			background: #f8f9fa; border-radius: 6px; padding: 0.5rem;
			font-size: 0.85rem;
		}
		
		/* ===== PAGINATION STYLES ===== */
		.pagination { justify-content: center; margin-top: 1.5rem; }
		.page-link {
			color: var(--primary-red); border-color: #dee2e6; padding: 0.6rem 0.8rem;
			margin: 0 2px; border-radius: 4px; font-weight: 500; transition: all 0.3s ease;
		}
		.page-link:hover { color: white; background-color: var(--primary-red); border-color: var(--primary-red); transform: translateY(-1px); }
		.page-item.active .page-link { background-color: var(--primary-red); border-color: var(--primary-red); }
		
		/* ===== TABLE STYLES ===== */
		.table {
			font-size: 0.9rem;
			vertical-align: middle;
		}
		.table th {
			background: #f8f9fa;
			border-bottom: 2px solid #dee2e6;
			font-weight: 600;
			white-space: nowrap;
		}
		.table td {
			border-bottom: 1px solid #f1f3f4;
			padding: 0.75rem 0.5rem;
			vertical-align: top;
		}
		.table tbody tr:hover {
			background-color: #f8f9fa;
		}
		.text-truncate {
			max-width: 100%;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		.badge {
			font-size: 0.75rem;
			padding: 0.35em 0.65em;
		}
		.form-select-sm {
			font-size: 0.8rem;
			padding: 0.25rem 0.5rem;
		}
		.btn-sm {
			font-size: 0.8rem;
			padding: 0.25rem 0.5rem;
		}
		
		/* Fix font for all select elements */
		.form-select, .form-select-sm {
			font-family: Arial, sans-serif !important;
			font-size: 14px !important;
		}
		.form-select option {
			font-family: Arial, sans-serif !important;
			font-size: 14px !important;
		}
		
		/* Remove any background images or icons that might overlap */
		.form-select {
			background-image: none !important;
			-webkit-appearance: menulist !important;
			-moz-appearance: menulist !important;
			appearance: menulist !important;
		}
		
		/* Ensure proper z-index and positioning */
		.card-header .form-select {
			position: relative;
			z-index: 1;
			background-color: white !important;
		}
		
		/* ===== RESPONSIVE DESIGN ===== */
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
                <a href="home" class="sidebar-brand">
                    <i style="color: #2c3e50;"></i>Menu Quản Lý
                </a>

                <div class="sidebar-profile text-center">
                    <img src="images/default-avatar.png" class="profile-avatar" alt="User Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=3498db&color=fff&size=60&font-size=0.4'">
                    <div class="profile-welcome">
                        Chào mừng: 
                        <c:choose>
                            <c:when test="${sessionScope.user.roleId == 2}">
                                <span class="profile-role">Nhân viên</span>
                            </c:when>
                            <c:when test="${sessionScope.user.roleId == 3}">
                                <span class="profile-role">Quản lý</span>
                            </c:when>
                            <c:when test="${sessionScope.user.roleId == 4}">
                                <span class="profile-role">Shipper</span>
                            </c:when>
                            <c:otherwise>
                                <span class="profile-role">Người dùng</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <a href="Customer?action=logout" class="logout-link">
                        <i class="fas fa-sign-out-alt"></i>Đăng xuất
                    </a>
                </div>

                <ul class="sidebar-nav">
                    <li class="sidebar-header">Menu Chính</li>
                    <!-- Chỉ hiển thị nếu là Staff -->
                    <c:if test="${sessionScope.user.roleId == 2}">                                             
                        <li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                        <li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
                        <li><a href="storagemanagement?action=view" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                        <li><a href="orderManagement" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                                                <li>
                            <a href="feedbacks?action=view" class="sidebar-link" id="menu-feedback">
                                <i class="fas fa-comments"></i> Quản Lý Phản Hồi
                            </a>
                        </li>  
                        </c:if> 

                    <!-- Chỉ hiển thị nếu là Manager -->
                    <c:if test="${sessionScope.user.roleId == 3}"> 
                        <li><a href="statistics" class="sidebar-link" id="menu-management"><i class="fas fa-chart-bar"></i>Quản Lý</a></li>
                        <li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                        <li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
                        <li><a href="storagemanagement?action=view" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                        <li><a href="orderManagement" class="sidebar-link" id="menu-orderManagement"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                        <li><a href="InvoiceManagement?action=displayAll" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>
                        <li class="sidebar-header">Hệ Thống</li>
                        <li><a href="UserManagementServlet?action=search" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Nhân Sự</a></li>
                        <li>
                            <a href="feedbacks?action=view" class="sidebar-link" id="menu-feedback">
                                <i class="fas fa-comments"></i> Quản Lý Phản Hồi
                            </a>
                        </li>          
                        <li><a href="notificationManagement" class="sidebar-link" id="menu-notificationManagement"><i class="fas fa-bell"></i>Thông Báo<span class="badge bg-danger ms-auto">4</span></a></li>
                        </c:if> 

                    <!-- Chỉ hiển thị nếu là Shipper -->                        
                    <c:if test="${sessionScope.user.roleId == 4}">
                        <li><a href="orderManagement" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                        </c:if>                   
                </ul>
            </nav>
		<!-- ===== MAIN CONTENT AREA ===== -->
		<div class="main-content">
			<!-- Top Navigation Bar -->
			<div class="top-navbar">
				<div class="d-flex justify-content-between align-items-center">
					<div class="input-group" style="width: 300px;">
						<form method="get" action="orderManagement" class="d-flex" style="max-width: 350px;">
							<input type="hidden" name="pageSize" value="${pageSize}"/>
							<input type="hidden" name="status" value="${param.status}"/>
							<input type="hidden" name="category" value="${param.category}"/>
							<input type="hidden" name="priceRange" value="${param.priceRange}"/>
							<input type="hidden" name="province" value="${param.province}"/>
							<input type="hidden" name="dateFilter" value="${param.dateFilter}"/>
							<input type="text" class="form-control me-2" name="search" value="${param.search}" placeholder="Mã đơn, tên, email, sđt..."/>
							<button type="submit" class="btn btn-outline-primary" style="color: #e4cbce; background-color: #c7606e; border: #c7606e;"><i class="fas fa-search"></i></button>
						</form>						
					</div>					
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Quản lí đơn hàng</h2>
						<p class="text-muted">Trang quản lí đơn hàng, trạng thái đơn hàng</p>
					</div>
					<div class="text-muted">
						Số lượng đơn hàng: <strong>${totalOrders}</strong> 
					</div>
				</div>

				<!-- ICON THỐNG KÊ -->
				<!-- QUAN LY -->
				<c:if test="${sessionScope.user.roleId == 3}">
				<div class="row mb-4">
					<div class="col">
						<a href="orderManagement?status=Chờ xác nhận&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-clock fa-2x text-primary mb-2"></i>
								<h4 class="text-primary">${pendingCount}</h4>
								<p class="mb-0">Đơn hàng chờ xác nhận</p>
							</div>
						</a>
					</div>
					<div class="col">
						<a href="orderManagement?status=Đang chuẩn bị&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-cog fa-2x mb-2" style="color: #55e2db;"></i>
								<h4 style="color: #55e2db;">${preparingCount}</h4>
								<p class="mb-0">Đơn hàng đang chuẩn bị</p>
							</div>
						</a>
					</div>
					<div class="col">
						<a href="orderManagement?status=Chờ giao hàng&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-truck fa-2x mb-2" style="color: #2d771e;"></i>
								<h4 class="text-success">${shippingCount}</h4>
								<p class="mb-0">Đơn hàng chờ giao</p>
							</div>
						</a>
					</div>
					<div class="col">
						<a href="orderManagement?status=Đã mua&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-check-circle fa-2x mb-2" style="color: #f0e052;"></i>
								<h4 class="text-warning">${completedCount}</h4>
								<p class="mb-0">Đơn hàng đã giao</p>
							</div>
						</a>
					</div>
					<div class="col">
						<a href="orderManagement?status=Đã hủy&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-times-circle fa-2x mb-2" style="color: #c74e4e;"></i>
								<h4 style="color: #c74e4e;">${canceledCount}</h4>
								<p class="mb-0">Đơn đã hủy</p>
							</div>
						</a>
					</div>
				</div>
				</c:if>
				<!-- NHAN VIEN -->
				<c:if test="${sessionScope.user.roleId == 2}">
				<div class="row mb-4">
					<div class="col-md-6 offset-md-3">
						<a href="orderManagement?status=Đang chuẩn bị&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-cog fa-2x mb-2" style="color: #55e2db;"></i>
								<h4 style="color: #55e2db;">${preparingCount}</h4>
								<p class="mb-0">Đơn hàng đang chuẩn bị</p>
							</div>
						</a>
					</div>
				</div>
				</c:if>				 
				<!-- SHIPPER -->
				<c:if test="${sessionScope.user.roleId == 4}">
				<div class="row mb-4">
					<div class="col-md-6 offset-md-3">
						<a href="orderManagement?status=Chờ giao hàng&pageSize=${pageSize}" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-truck fa-2x mb-2" style="color: #2d771e;"></i>
								<h4 class="text-success">${shippingCount}</h4>
								<p class="mb-0">Đơn hàng chờ giao</p>
							</div>
						</a>
					</div>
				</div>
				</c:if>

				<!-- FILTER FORM (chỉ giữ các select, không có nút Lọc) -->
				<form method="get" action="orderManagement" class="row align-items-center mb-4">
					<input type="hidden" name="pageSize" value="${pageSize}"/>
					<div class="col-md-2">
						<label class="form-label">Trạng thái</label>
						<select class="form-select" name="status">
							<option value="">Tất cả</option>
							<c:forEach var="status" items="${orderStatuses}">
								<option value="${status}" ${param.status == status ? 'selected' : ''}>${status}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
						<label class="form-label">Danh mục</label>
						<select class="form-select" name="category">
							<option value="">Tất cả</option>
							<c:forEach var="cat" items="${categories}">
								<option value="${cat.categoryName}" ${param.category == cat.categoryName ? 'selected' : ''}>${cat.categoryName}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
						<label class="form-label">Khoảng giá</label>
						<select class="form-select" name="priceRange">
							<option value="">Tất cả</option>
							<option value="Dưới 1 triệu" ${param.priceRange == 'Dưới 1 triệu' ? 'selected' : ''}>Dưới 1 triệu</option>
							<option value="Từ 1 triệu đến dưới 5 triệu" ${param.priceRange == 'Từ 1 triệu đến dưới 5 triệu' ? 'selected' : ''}>Từ 1 triệu đến dưới 5 triệu</option>
							<option value="Từ 5 triệu đến dưới 10 triệu" ${param.priceRange == 'Từ 5 triệu đến dưới 10 triệu' ? 'selected' : ''}>Từ 5 triệu đến dưới 10 triệu</option>
							<option value="Trên 10 triệu" ${param.priceRange == 'Trên 10 triệu' ? 'selected' : ''}>Trên 10 triệu</option>
						</select>
					</div>
					<div class="col-md-2">
						<label class="form-label">Sắp xếp giá</label>
						<select class="form-select" name="sortPrice">
							<option value="">Mặc định</option>
							<option value="asc" ${param.sortPrice == 'asc' ? 'selected' : ''}>Từ thấp đến cao</option>
							<option value="desc" ${param.sortPrice == 'desc' ? 'selected' : ''}>Từ cao xuống thấp</option>
						</select>
					</div>
					<div class="col-md-2">
						<label class="form-label">Tỉnh thành</label>
						<select class="form-select" name="province">
							<option value="">Tất cả</option>
							<option value="Hà Nội" ${param.province == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
							<option value="TP Huế" ${param.province == 'Huế' ? 'selected' : ''}>Huế</option>
							<option value="Quảng Ninh" ${param.province == 'Quảng Ninh' ? 'selected' : ''}>Quảng Ninh</option>
							<option value="Cao Bằng" ${param.province == 'Cao Bằng' ? 'selected' : ''}>Cao Bằng</option>
							<option value="Lạng Sơn" ${param.province == 'Lạng Sơn' ? 'selected' : ''}>Lạng Sơn</option>
							<option value="Lai Châu" ${param.province == 'Lai Châu' ? 'selected' : ''}>Lai Châu</option>
							<option value="Điện Biên" ${param.province == 'Điện Biên' ? 'selected' : ''}>Điện Biên</option>
							<option value="Sơn La" ${param.province == 'Sơn La' ? 'selected' : ''}>Sơn La</option>
							<option value="Thanh Hóa" ${param.province == 'Thanh Hóa' ? 'selected' : ''}>Thanh Hóa</option>
							<option value="Nghệ An" ${param.province == 'Nghệ An' ? 'selected' : ''}>Nghệ An</option>
							<option value="Hà Tĩnh" ${param.province == 'Hà Tĩnh' ? 'selected' : ''}>Hà Tĩnh</option>
							<option value="Tuyên Quang" ${param.province == 'Tuyên Quang' ? 'selected' : ''}>Tuyên Quang</option>
							<option value="Lào Cai" ${param.province == 'Lào Cai' ? 'selected' : ''}>Lào Cai</option>
							<option value="Thái Nguyên" ${param.province == 'Thái Nguyên' ? 'selected' : ''}>Thái Nguyên</option>
							<option value="Phú Thọ" ${param.province == 'Phú Thọ' ? 'selected' : ''}>Phú Thọ</option>
							<option value="Bắc Ninh" ${param.province == 'Bắc Ninh' ? 'selected' : ''}>Bắc Ninh</option>
							<option value="Hưng Yên" ${param.province == 'Hưng Yên' ? 'selected' : ''}>Hưng Yên</option>
							<option value="TP Hải Phòng" ${param.province == 'TP Hải Phòng' ? 'selected' : ''}>TP Hải Phòng</option>
							<option value="Ninh Bình" ${param.province == 'Ninh Bình' ? 'selected' : ''}>Ninh Bình</option>
							<option value="Quảng Trị" ${param.province == 'Quảng Trị' ? 'selected' : ''}>Quảng Trị</option>
							<option value="TP Đà Nẵng" ${param.province == 'TP Đà Nẵng' ? 'selected' : ''}>TP Đà Nẵng</option>
							<option value="Quảng Ngãi" ${param.province == 'Quảng Ngãi' ? 'selected' : ''}>Quảng Ngãi</option>
							<option value="Gia Lai" ${param.province == 'Gia Lai' ? 'selected' : ''}>Gia Lai</option>
							<option value="Khánh Hòa" ${param.province == 'Khánh Hòa' ? 'selected' : ''}>Khánh Hòa</option>
							<option value="Lâm Đồng" ${param.province == 'Lâm Đồng' ? 'selected' : ''}>Lâm Đồng</option>
							<option value="Đắk Lắk" ${param.province == 'Đắk Lắk' ? 'selected' : ''}>Đắk Lắk</option>
							<option value="TPHCM" ${param.province == 'TPHCM' ? 'selected' : ''}>TPHCM</option>
							<option value="Đồng Nai" ${param.province == 'Đồng Nai' ? 'selected' : ''}>Đồng Nai</option>
							<option value="Tây Ninh" ${param.province == 'Tây Ninh' ? 'selected' : ''}>Tây Ninh</option>
							<option value="TP Cần Thơ" ${param.province == 'TP Cần Thơ' ? 'selected' : ''}>TP Cần Thơ</option>
							<option value="Vĩnh Long" ${param.province == 'Vĩnh Long' ? 'selected' : ''}>Vĩnh Long</option>
							<option value="Đồng Tháp" ${param.province == 'Đồng Tháp' ? 'selected' : ''}>Đồng Tháp</option>
							<option value="Cà Mau" ${param.province == 'Cà Mau' ? 'selected' : ''}>Cà Mau</option>
							<option value="An Giang" ${param.province == 'An Giang' ? 'selected' : ''}>An Giang</option>
						</select>
					</div>
					<div class="col-md-2">
						<label class="form-label">Ngày đặt</label>
						<select class="form-select" name="dateFilter">
							<option value="">Tất cả</option>
							<option value="today" ${param.dateFilter == 'today' ? 'selected' : ''}>Trong ngày</option>
							<option value="week" ${param.dateFilter == 'week' ? 'selected' : ''}>Trong tuần</option>
							<option value="month" ${param.dateFilter == 'month' ? 'selected' : ''}>Trong tháng này</option>
						</select>
					</div>
					<div class="col-md-12 d-flex justify-content-center mt-3">
						<button type="submit" class="btn btn-primary" style="height:37px; width: 100px;">Lọc</button>
					</div>
				</form>


				<!-- ===== INVENTORY TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">Danh sách đơn hàng</h5>
						<div class="d-flex align-items-center gap-3">
							<span class="text-light">Hiển thị:</span>
							<select class="form-select form-select-sm" style="width: 80px; font-family: Arial, sans-serif; font-size: 14px; background: white; border: 1px solid #ced4da;" onchange="changePageSize(this.value)">
								<option value="20" ${param.pageSize == '20' || empty param.pageSize ? 'selected' : ''}>20</option>
								<option value="40" ${param.pageSize == '40' ? 'selected' : ''}>40</option>
								<option value="60" ${param.pageSize == '60' ? 'selected' : ''}>60</option>
							</select>
							<span class="text-light">Đơn hàng</span>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 50px;"><input type="checkbox" class="form-check-input" onchange="selectAllItems(this)"></th>
										<th style="width: 120px;">Mã đơn hàng</th>
										<th style="width: 200px;">Thông tin đơn hàng</th>
										<th style="width: 120px;">Trạng thái</th>
										<th style="width: 180px;">Thông tin khách hàng</th>
										<th style="width: 150px;">Địa chỉ giao hàng</th>
										<th style="width: 180px;">Phụ trách</th>
										<th style="width: 120px;">Tổng tiền</th>
										<th style="width: 100px;">Ngày tạo</th>
										<th style="width: 150px;">Cập nhật trạng thái</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="order" items="${orders}">
										<tr>
											<td><input type="checkbox" class="form-check-input item-checkbox" value="${order.orderId}"></td>
											<td>
												<div class="text-truncate" title="${order.orderCode}">
													<strong>${order.orderCode}</strong>
												</div>
											</td>
											<td>
												<div style="max-height: 80px; overflow-y: auto;">
													<c:forEach var="item" items="${order.items}" varStatus="status">
														<div class="mb-1 ${status.index > 0 ? 'border-top pt-1' : ''}">
															<div class="text-truncate" title="${item.productName}">
																<strong>${item.productName}</strong>
															</div>
															<div class="small text-muted">
																SL: ${item.quantity} | 
																<fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
															</div>
														</div>
													</c:forEach>
												</div>
											</td>
											<td>
												<c:choose>
													<c:when test="${order.status eq 'Chờ xác nhận'}">
														<span class="badge bg-warning text-dark">${order.status}</span>
													</c:when>
													<c:when test="${order.status eq 'Đang chuẩn bị'}">
														<span class="badge bg-info text-white">${order.status}</span>
													</c:when>
													<c:when test="${order.status eq 'Chờ giao hàng'}">
														<span class="badge bg-primary text-white">${order.status}</span>
													</c:when>
													<c:when test="${order.status eq 'Đã hủy'}">
														<span class="badge" style="background-color: #c74e4e; color: white;">${order.status}</span>
													</c:when>
													<c:otherwise>
														<span class="badge bg-success text-white">${order.status}</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<div>
													<div class="text-truncate" title="${order.deliveryName}">
														<strong>${order.deliveryName}</strong>
													</div>
													<div class="small text-muted text-truncate" title="${order.deliveryPhone}">
														📞 ${order.deliveryPhone}
													</div>
													<div class="small text-muted text-truncate" title="${order.email}">
														📧 ${order.email}
													</div>
												</div>
											</td>
											<td>
												<div title="${order.deliveryAddress}">
													📍 ${order.deliveryAddress}
												</div>
											</td>
											<td>
												<div>
													<c:if test="${not empty order.staffName}">
														<div class="small text-success text-truncate" title="Nhân viên phụ trách: ${order.staffName}">
															👨‍💼 ${order.staffName}
														</div>
													</c:if>
													<c:if test="${not empty order.shipperName}">
														<div class="small text-primary text-truncate" title="Shipper: ${order.shipperName}">
															🚚 ${order.shipperName}
														</div>
													</c:if>
													<c:if test="${empty order.staffName && empty order.shipperName}">
														<div class="small text-muted">Chưa phân công</div>
													</c:if>
												</div>
											</td>
											<td>
												<div>
													<strong class="text-success">
														<fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
													</strong>
												</div>
											</td>
											<td>
												<c:choose>
													<c:when test="${not empty order.createdAt}">
														<fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
														<div class="small">
															<fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
														</div>
														<div class="small text-muted">
															<fmt:formatDate value="${parsedDate}" pattern="HH:mm"/>
														</div>
													</c:when>
													<c:otherwise>
														<div class="small text-muted">-</div>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<div class="d-flex flex-column gap-1">
													<c:if test="${userRole eq 'Manager'}">
														<form method="post" action="orderManagement" class="mb-1">
															<input type="hidden" name="action" value="updateStatus"/>
															<input type="hidden" name="orderId" value="${order.orderId}"/>
															<select name="newStatus" class="form-select form-select-sm mb-1">
																<c:forEach var="status" items="${orderStatuses}">
																	<option value="${status}" ${status eq order.status ? 'selected' : ''}>${status}</option>
																</c:forEach>
															</select>
															<button type="submit" class="btn btn-sm btn-outline-primary w-100">Cập nhật</button>
														</form>
													</c:if>
													<c:if test="${userRole eq 'Staff' && order.status eq 'Đang chuẩn bị'}">
														<form method="post" action="orderManagement">
															<input type="hidden" name="action" value="updateStatus"/>
															<input type="hidden" name="orderId" value="${order.orderId}"/>
															<input type="hidden" name="newStatus" value="Chờ giao hàng"/>
															<button type="submit" class="btn btn-sm btn-outline-primary w-100">Chuyển sang chờ giao hàng</button>
														</form>
													</c:if>
													<c:if test="${userRole eq 'Shipper' && order.status eq 'Chờ giao hàng'}">
														<form method="post" action="orderManagement">
															<input type="hidden" name="action" value="updateStatus"/>
															<input type="hidden" name="orderId" value="${order.orderId}"/>
															<input type="hidden" name="newStatus" value="Đã mua"/>
															<button type="submit" class="btn btn-sm btn-outline-success w-100">Xác nhận giao hàng</button>
														</form>
													</c:if>
													<c:if test="${userRole eq 'Shipper' && order.status eq 'Đã mua'}">
														<span class="btn btn-sm btn-outline-success disabled w-100">Đã giao hàng</span>
													</c:if>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<!-- ===== BULK ACTIONS ===== -->
						<div class="d-flex justify-content-between align-items-center mt-3">
							<div class="text-muted" style="margin-left: 600px;">
								Hiển thị ${(currentPage - 1) * pageSize + 1} đến ${currentPage * pageSize > totalOrders ? totalOrders : currentPage * pageSize} trong tổng số ${totalOrders} đơn hàng
							</div>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="Order pagination" class="mt-3">
							<ul class="pagination">
								<c:if test="${currentPage > 1}">
									<li class="page-item">
										<a class="page-link" href="orderManagement?page=${currentPage - 1}&pageSize=${pageSize}&status=${param.status}&category=${param.category}&priceRange=${param.priceRange}&province=${param.province}&search=${param.search}&dateFilter=${param.dateFilter}"><i class="fas fa-chevron-left"></i></a>
									</li>
								</c:if>
								<c:forEach var="i" begin="1" end="${totalPages}">
									<li class="page-item ${i == currentPage ? 'active' : ''}">
										<a class="page-link" href="orderManagement?page=${i}&pageSize=${pageSize}&status=${param.status}&category=${param.category}&priceRange=${param.priceRange}&province=${param.province}&search=${param.search}&dateFilter=${param.dateFilter}">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${currentPage < totalPages}">
									<li class="page-item">
										<a class="page-link" href="orderManagement?page=${currentPage + 1}&pageSize=${pageSize}&status=${param.status}&category=${param.category}&priceRange=${param.priceRange}&province=${param.province}&search=${param.search}&dateFilter=${param.dateFilter}"><i class="fas fa-chevron-right"></i></a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// ===== INVENTORY MANAGEMENT FUNCTIONALITY =====
		
		// Change page size function
		function changePageSize(pageSize) {
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('pageSize', pageSize);
			urlParams.set('page', '1'); // Reset to first page when changing page size
			window.location.href = 'orderManagement?' + urlParams.toString();
		}
		
		// Search inventory
		function searchInventory() {
			const searchTerm = document.getElementById('inventorySearch').value;
			console.log('Searching inventory:', searchTerm);
			// Implementation would filter inventory based on search term
		}
		
		// Filter functions
		function filterByStockLevel(level) { console.log('Filter by stock level:', level); }
		function filterByCategory(category) { console.log('Filter by category:', category); }
		function filterBySupplier(supplier) { console.log('Filter by supplier:', supplier); }
		function filterByLocation(location) { console.log('Filter by location:', location); }
		
		// Inventory actions
		function urgentReorder(itemId) {
			if (confirm('Create urgent purchase order for this out-of-stock item?')) {
				console.log('Creating urgent reorder for item:', itemId);
				window.location.href = `urgent-purchase-order.jsp?itemId=${itemId}`;
			}
		}
		
		function createReorder(itemId) {
			console.log('Creating reorder for item:', itemId);
			window.location.href = `create-purchase-order.jsp?itemId=${itemId}`;
		}
		
		function createPromotion(itemId) {
			console.log('Creating promotion for overstocked item:', itemId);
			window.location.href = `create-promotion.jsp?itemId=${itemId}`;
		}
		
		function transferStock(itemId) {
			console.log('Transferring stock for item:', itemId);
			window.location.href = `stock-transfer.jsp?itemId=${itemId}`;
		}
		
		function viewDetails(itemId) {
			console.log('Viewing details for item:', itemId);
			window.location.href = `inventory-details.jsp?itemId=${itemId}`;
		}
		
		// Bulk actions
		function selectAllItems(checkbox) {
			const itemCheckboxes = document.querySelectorAll('.item-checkbox');
			itemCheckboxes.forEach(cb => cb.checked = checkbox.checked);
			updateBulkActionButtons();
		}
		
		function updateBulkActionButtons() {
			const selectedItems = document.querySelectorAll('.item-checkbox:checked');
			const bulkButtons = ['bulkAdjustBtn', 'bulkReorderBtn', 'bulkTransferBtn', 'bulkPromotionBtn'];
			
			bulkButtons.forEach(btnId => {
				document.getElementById(btnId).disabled = selectedItems.length === 0;
			});
		}
		
		function bulkAdjustment() {
			const selected = document.querySelectorAll('.item-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = `bulk-stock-adjustment.jsp?itemIds=${ids.join(',')}`;
		}
		
		function bulkReorder() {
			const selected = document.querySelectorAll('.item-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = `bulk-purchase-order.jsp?itemIds=${ids.join(',')}`;
		}
		
		function bulkTransfer() {
			const selected = document.querySelectorAll('.item-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = `bulk-stock-transfer.jsp?itemIds=${ids.join(',')}`;
		}
		
		function bulkPromotion() {
			const selected = document.querySelectorAll('.item-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = `bulk-promotion.jsp?itemIds=${ids.join(',')}`;
		}
		
		function generateInventoryReport() {
			window.location.href = 'inventory-report.jsp?format=excel';
		}
		
		// Initialize page
		document.addEventListener('DOMContentLoaded', function() {
			// Add event listeners to item checkboxes
			document.querySelectorAll('.item-checkbox').forEach(checkbox => {
				checkbox.addEventListener('change', updateBulkActionButtons);
			});
			
			// Enable real-time search
			document.getElementById('inventorySearch').addEventListener('keyup', function(e) {
				if (e.key === 'Enter') {
					searchInventory();
				}
			});
			
			// Auto-refresh inventory status every 10 minutes
			setInterval(function() {
				console.log('Auto-refreshing inventory status...');
				// Implementation would refresh inventory data via AJAX
			}, 600000);
			
			// Check for critical stock alerts every 5 minutes
			setInterval(function() {
				console.log('Checking for critical stock alerts...');
				// Implementation would check for new critical stock situations
			}, 300000);
		});
                
// Tự động highlight menu item dựa trên URL hiện tại
document.addEventListener('DOMContentLoaded', function() {
    // Lấy tên file hiện tại từ URL
    var currentPage = window.location.pathname.split('/').pop();
    
    // Xóa tất cả class active
    document.querySelectorAll('.sidebar-link').forEach(function(link) {
        link.classList.remove('active');
    });
    
    // Thêm class active cho menu item tương ứng
    var menuMap = {
        'management.jsp': 'management.jsp',
        'productManagement.jsp': 'productManagement.jsp',
        'categoryManagement.jsp': 'categoryManagement.jsp',
        'storageManagement.jsp': 'storageManagement.jsp',
        'orderManagement.jsp': 'orderManagement.jsp',
        'orderManagement': 'orderManagement', // Thêm mapping cho servlet
        'invoiceManagement.jsp': 'invoiceManagement.jsp',
        'userManagement.jsp': 'userManagement.jsp',
        'feedbackManagement.jsp': 'feedbackManagement.jsp',
        'notificationManagement.jsp': 'notificationManagement.jsp'
    };
    
    // Tìm và highlight menu item hiện tại
    if (menuMap[currentPage]) {
        var activeLink = document.querySelector('a[href="' + menuMap[currentPage] + '"]');
        if (activeLink) {
            activeLink.classList.add('active');
        }
    }
});
                
	</script>      
</body>
</html>

