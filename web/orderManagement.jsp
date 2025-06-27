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
			background: linear-gradient(135deg, var(--dark-gray) 0%, #495057 100%);
			position: fixed; height: 100vh; overflow-y: auto; z-index: 1000;
			box-shadow: 2px 0 10px rgba(0,0,0,0.1);
		}
		.sidebar-brand { padding: 1.5rem; color: white; text-decoration: none; font-weight: 700; font-size: 1.2rem; border-bottom: 1px solid rgba(255,255,255,0.1); display: block; text-align: center; }
		.sidebar-user { padding: 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.1); color: white; }
		.sidebar-nav { list-style: none; padding: 1rem 0; margin: 0; }
		.sidebar-header { padding: 1rem 1.5rem 0.5rem; color: rgba(255,255,255,0.6); font-size: 0.85rem; font-weight: 600; text-transform: uppercase; }
		.sidebar-link { display: flex; align-items: center; padding: 0.8rem 1.5rem; color: rgba(255,255,255,0.8); text-decoration: none; transition: all 0.3s ease; }
		.sidebar-link:hover, .sidebar-link.active { background: var(--primary-red); color: white; transform: translateX(5px); }
		.sidebar-link i { margin-right: 0.8rem; width: 18px; }
		
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
					<li><a href="InvoiceManagement?action=displayAll" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>
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

		<!-- ===== MAIN CONTENT AREA ===== -->
		<div class="main-content">
			<!-- Top Navigation Bar -->
			<div class="top-navbar">
				<div class="d-flex justify-content-between align-items-center">
					<div class="input-group" style="width: 300px;">
						<form method="get" action="orderManagement" class="d-flex" style="max-width: 350px;">
							<input type="hidden" name="status" value="${param.status}"/>
							<input type="hidden" name="category" value="${param.category}"/>
							<input type="hidden" name="priceRange" value="${param.priceRange}"/>
							<input type="hidden" name="province" value="${param.province}"/>
							<input type="hidden" name="dateFilter" value="${param.dateFilter}"/>
							<input type="text" class="form-control me-2" name="search" value="${param.search}" placeholder="Tìm kiếm mã đơn, tên, SĐT..."/>
							<button type="submit" class="btn btn-outline-primary" style="color: #e4cbce; background-color: #c7606e; border: #c7606e;"><i class="fas fa-search"></i></button>
						</form>						
					</div>					
					<div class="d-flex align-items-center gap-3">
						<a href="stock-adjustment.jsp" class="btn btn-primary">
							<i class="fas fa-edit me-2"></i>Stock Adjustment
						</a>
						<a href="purchase-order.jsp" class="btn btn-success">
							<i class="fas fa-shopping-cart me-2"></i>Purchase Order
						</a>
						<button class="btn btn-outline-secondary" onclick="generateInventoryReport()">
							<i class="fas fa-file-export me-2"></i>Export Report
						</button>
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
						Total Items: <strong>100</strong> | Value: <strong>100</strong>
					</div>
				</div>

				<!-- FILTER FORM (chỉ giữ các select, không có nút Lọc) -->
				<form method="get" action="orderManagement" class="row align-items-center mb-4">
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
						<label class="form-label">Tỉnh thành</label>
						<select class="form-select" name="province">
							<option value="">Tất cả</option>
							<option value="Hà Nội" ${param.province == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
							<option value="TP. Hồ Chí Minh" ${param.province == 'TP. Hồ Chí Minh' ? 'selected' : ''}>TP. Hồ Chí Minh</option>
							<option value="Đà Nẵng" ${param.province == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
							<option value="Cần Thơ" ${param.province == 'Cần Thơ' ? 'selected' : ''}>Cần Thơ</option>
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
					<div class="col-md-2 d-flex align-items-end justify-content-center">
						<button type="submit" class="btn btn-primary w-100" style="height:37px; width: 50px; margin-top: 28px;">Lọc</button>
					</div>
				</form>


				<!-- ICON THỐNG KÊ -->
				<div class="row mb-4">
					<div class="col-md-3">
						<a href="orderManagement?status=Chờ xác nhận" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-clock fa-2x text-primary mb-2"></i>
								<h4 class="text-primary">${pendingCount}</h4>
								<p class="mb-0">Đơn hàng chờ xác nhận</p>
							</div>
						</a>
					</div>
					<div class="col-md-3">
						<a href="orderManagement?status=Đang chuẩn bị" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-cog fa-2x mb-2" style="color: #d84c4c;"></i>
								<h4 class="text-danger">${preparingCount}</h4>
								<p class="mb-0">Đơn hàng đang chuẩn bị</p>
							</div>
						</a>
					</div>
					<div class="col-md-3">
						<a href="orderManagement?status=Chờ giao hàng" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-truck fa-2x mb-2" style="color: #2d771e;"></i>
								<h4 class="text-success">${shippingCount}</h4>
								<p class="mb-0">Đơn hàng chờ giao</p>
							</div>
						</a>
					</div>
					<div class="col-md-3">
						<a href="orderManagement?status=Đã mua" style="text-decoration:none">
							<div class="inventory-stats text-center">
								<i class="fa-solid fa-check-circle fa-2x mb-2" style="color: #f0e052;"></i>
								<h4 class="text-warning">${completedCount}</h4>
								<p class="mb-0">Đơn hàng đã giao</p>
							</div>
						</a>
					</div>
				</div>

				<!-- ===== INVENTORY TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">Inventory Status</h5>
						<div class="d-flex align-items-center gap-3">
							<span class="text-light">Show:</span>
							<select class="form-select form-select-sm" style="width: auto;">
								<option value="25" selected>25</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="text-light">entries</span>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" class="form-check-input" onchange="selectAllItems(this)"></th>
										<th>Mã đơn hàng</th>
										<th>Thông tin đơn hàng</th>
										<th>Trạng thái</th>
										<th>Thông tin khách hàng</th>
										<th>Địa chỉ giao hàng</th>
										<th>Tổng tiền</th>
										<th>Ngày tạo</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="order" items="${orders}">
										<tr>
											<td><input type="checkbox" class="form-check-input item-checkbox" value="${order.orderId}"></td>
											<td>
												<div>
													<strong>ID : ${order.orderCode}</strong>
												</div>
											</td>
											<td>
												<c:forEach var="item" items="${order.items}">
													<div>
														<strong>${item.productName}</strong>
														<span class="text-muted small">SL: ${item.quantity}</span>
														<span class="text-muted small">Giá: <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/></span>
													</div>
												</c:forEach>
											</td>
											<td>
												<c:choose>
													<c:when test="${order.status eq 'Chờ xác nhận'}">
														<span class="stock-level" style="background: #ff6b6b; color: white;">${order.status}</span>
													</c:when>
													<c:when test="${order.status eq 'Đang chuẩn bị'}">
														<span class="stock-level" style="background: #feca57; color: white;">${order.status}</span>
													</c:when>
													<c:when test="${order.status eq 'Chờ giao hàng'}">
														<span class="stock-level" style="background: #1dd1a1; color: white;">${order.status}</span>
													</c:when>
													<c:otherwise>
														<span class="stock-level" style="background: #48dbfb; color: white;">${order.status}</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<div>
													<strong>${order.customerName}</strong>
													<div class="text-muted small">Số điện thoại: ${order.phone}</div>
													<div class="text-muted small">Email: ${order.email}</div>
												</div>
											</td>
											<td>
												<div>
													<strong>${order.deliveryAddress}</strong>
												</div>
											</td>
											<td>
												<div>
													<strong><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></strong>
												</div>
											</td>
											<td>
												<div>
													<strong>Ngày tạo :</strong>
													<c:choose>
														<c:when test="${not empty order.createdAt}">
															<fmt:parseDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
															<div class="text-muted small">
																<fmt:formatDate value="${parsedDate}" pattern="dd-MM-yyyy"/>
															</div>
														</c:when>
														<c:otherwise>
															<div class="text-muted small">-</div>
														</c:otherwise>
													</c:choose>
												</div>
											</td>
											<td>
												<div class="btn-group-vertical" role="group">
													<c:if test="${userRole eq 'Manager'}">
														<form method="post" action="orderManagement">
															<input type="hidden" name="action" value="updateStatus"/>
															<input type="hidden" name="orderId" value="${order.orderId}"/>
															<select name="newStatus" class="form-select form-select-sm mb-1">
																<c:forEach var="status" items="${orderStatuses}">
																	<option value="${status}" ${status eq order.status ? 'selected' : ''}>${status}</option>
																</c:forEach>
															</select>
															<button type="submit" class="btn btn-sm btn-outline-primary">Cập nhật</button>
														</form>
													</c:if>
													<c:if test="${userRole eq 'Staff' && order.status eq 'Đang chuẩn bị'}">
														<form method="post" action="orderManagement">
															<input type="hidden" name="action" value="updateStatus"/>
															<input type="hidden" name="orderId" value="${order.orderId}"/>
															<input type="hidden" name="newStatus" value="Chờ giao hàng"/>
															<button type="submit" class="btn btn-sm btn-outline-primary">Chuyển sang chờ giao hàng</button>
														</form>
													</c:if>
													<c:if test="${userRole eq 'Shipper' && order.status eq 'Chờ giao hàng'}">
														<span class="btn btn-sm btn-outline-success disabled">Đang giao hàng</span>
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
							<div>
								<button class="btn btn-outline-primary btn-sm" onclick="bulkAdjustment()" disabled id="bulkAdjustBtn">
									<i class="fas fa-edit me-2"></i>Xác nhận
								</button>
							</div>
							<div class="text-muted">
								Showing 1 to 20 of 100
							</div>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="Order pagination" class="mt-3">
							<ul class="pagination">
								<c:if test="${currentPage > 1}">
									<li class="page-item">
										<a class="page-link" href="orderManagement?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i></a>
									</li>
								</c:if>
								<c:forEach var="i" begin="1" end="${totalPages}">
									<li class="page-item ${i == currentPage ? 'active' : ''}">
										<a class="page-link" href="orderManagement?page=${i}">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${currentPage < totalPages}">
									<li class="page-item">
										<a class="page-link" href="orderManagement?page=${currentPage + 1}"><i class="fas fa-chevron-right"></i></a>
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

