<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Thống kê | Flower Shop Management</title>
	
	<!-- External CSS -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	
	<style>
		/* ===== CSS VARIABLES ===== */
        :root {
		--primary-red: #c44d58;
		--primary-red-dark: #a03d4a;
		--secondary-gray: #6c757d;
		--dark-gray: #343a40;
		--light-gray: #f8f9fa;
		--sidebar-width: 280px;
                }
		
		/* ===== GLOBAL STYLES ===== */
		body {
			font-family: 'Inter', sans-serif;
			background: var(--light-gray);
			margin: 0;
			padding: 0;
		}
		
		/* ===== LAYOUT STRUCTURE ===== */
		.wrapper { display: flex; min-height: 100vh; }
		
		/* ===== SIDEBAR STYLES ===== */
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
		
		/* ===== MAIN CONTENT STYLES ===== */
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
		
		/* ===== COMPONENT STYLES ===== */
		.page-title {
			color: var(--dark-gray);
			font-weight: 700;
			margin-bottom: 0.5rem;
		}
		
		.stats-card {
			background: white;
			border-radius: 10px;
			padding: 1.5rem;
			box-shadow: 0 4px 15px rgba(0,0,0,0.08);
			border-left: 4px solid var(--primary-red);
			transition: transform 0.3s ease;
		}
		
		.stats-card:hover { transform: translateY(-3px); }
		
		.stats-number {
			font-size: 2rem;
			font-weight: 700;
			color: var(--primary-red);
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
		
		/* ===== BUTTON STYLES ===== */
		.btn-primary {
			background: var(--primary-red);
			border-color: var(--primary-red);
			border-radius: 6px;
		}
		
		.btn-primary:hover {
			background: var(--primary-red-dark);
			transform: translateY(-1px);
		}
		
		/* ===== TABLE STYLES ===== */
		.table th {
			background: var(--light-gray);
			font-weight: 600;
			border-top: none;
		}
		
		/* ===== STATUS BADGES ===== */
		.order-status {
			padding: 0.4rem 0.8rem;
			border-radius: 15px;
			font-size: 0.75rem;
			font-weight: 600;
		}
		.order-status.pending { background: #fff3cd; color: #856404; }
		.order-status.processing { background: #d1ecf1; color: #0c5460; }
		.order-status.completed { background: #d4edda; color: #155724; }
		.order-status.cancelled { background: #f8d7da; color: #721c24; }
		
		/* ===== NOTIFICATION STYLES ===== */
		.notification-item {
			background: white;
			border-radius: 8px;
			padding: 1rem;
			margin-bottom: 1rem;
			border-left: 4px solid var(--primary-red);
			box-shadow: 0 2px 10px rgba(0,0,0,0.08);
		}
		
		.notification-icon {
			width: 40px;
			height: 40px;
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
			color: white;
			margin-right: 1rem;
		}
		.notification-icon.warning { background: #ffc107; color: #212529; }
		.notification-icon.danger { background: var(--primary-red); }
		
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
			<!-- ===== SIDEBAR USER ===== -->
			<c:if test="${sessionScope.user.roleId == 2}">
				<div class="sidebar-user">
					<div class="d-flex align-items-center">
						<div>
							<div style="font-weight: 600;">Staff</div>
							<small style="opacity: 0.8;">Chào mừng nhân viên !</small>
						</div>
					</div>
				</div>
			</c:if>

			<c:if test="${sessionScope.user.roleId == 3}">
				<div class="sidebar-user">
					<div class="d-flex align-items-center">
						<div>
							<div style="font-weight: 600;">Manager</div>
							<small style="opacity: 0.8;">Chào mừng người quản lí!</small>
						</div>
					</div>
				</div>
			</c:if> 
			
			<c:if test="${sessionScope.user.roleId == 4}">
				<div class="sidebar-user">
					<div class="d-flex align-items-center">
						<div>
							<div style="font-weight: 600;">Shipper</div>
							<small style="opacity: 0.8;">Chào mừng người giao hàng!</small>
						</div>
					</div>
				</div>
			</c:if> 
                    
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
					<!-- Search Box -->
					<div class="input-group" style="width: 300px;">
						<input type="text" class="form-control" placeholder="Search products, orders, customers...">
						<button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
					</div>
					
					<!-- Action Buttons -->
					<div class="d-flex align-items-center gap-3">
						<a href="add-product.jsp" class="btn btn-primary">
							<i class="fas fa-plus me-2"></i>Add Product
						</a>
						<a href="create-order.jsp" class="btn btn-success">
							<i class="fas fa-shopping-cart me-2"></i>New Order
						</a>
						
						<!-- User Dropdown -->
						<div class="dropdown">
							<button class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
								<i class="fas fa-user-circle me-2"></i>Admin
							</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Profile</a></li>
								<li><a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog me-2"></i>Settings</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Dashboard Overview</h2>
						<p class="text-muted">Welcome to your flower shop management system</p>
					</div>
					<div class="text-muted">
						<i class="fas fa-calendar me-2"></i>Today: <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %>
					</div>
				</div>
				
				<!-- ===== KEY PERFORMANCE INDICATORS ===== -->
				<div class="row mb-4">
					<!-- Total Revenue -->
					<div class="col-xl-3 col-md-6 mb-3">
						<div class="stats-card">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<div class="text-muted small">Today's Revenue</div>
									<div class="stats-number">$1,250</div>
									<div class="text-success small">
										<i class="fas fa-arrow-up"></i> +12.5% from yesterday
									</div>
								</div>
								<i class="fas fa-dollar-sign fa-2x text-muted opacity-50"></i>
							</div>
						</div>
					</div>
					
					<!-- Total Orders -->
					<div class="col-xl-3 col-md-6 mb-3">
						<div class="stats-card">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<div class="text-muted small">Today's Orders</div>
									<div class="stats-number">32</div>
									<div class="text-info small">
										<i class="fas fa-clock"></i> 5 pending processing
									</div>
								</div>
								<i class="fas fa-shopping-cart fa-2x text-muted opacity-50"></i>
							</div>
						</div>
					</div>
					
					<!-- Total Products -->
					<div class="col-xl-3 col-md-6 mb-3">
						<div class="stats-card">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<div class="text-muted small">Total Products</div>
									<div class="stats-number">248</div>
									<div class="text-warning small">
										<i class="fas fa-exclamation-triangle"></i> 12 low stock
									</div>
								</div>
								<i class="fas fa-boxes fa-2x text-muted opacity-50"></i>
							</div>
						</div>
					</div>
					
					<!-- Active Customers -->
					<div class="col-xl-3 col-md-6 mb-3">
						<div class="stats-card">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<div class="text-muted small">Active Customers</div>
									<div class="stats-number">1,234</div>
									<div class="text-success small">
										<i class="fas fa-user-plus"></i> 8 new this week
									</div>
								</div>
								<i class="fas fa-users fa-2x text-muted opacity-50"></i>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== MAIN DASHBOARD CONTENT ===== -->
				<div class="row">
					<!-- Recent Orders Table -->
					<div class="col-lg-8">
						<div class="card">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h5 class="mb-0">Recent Orders</h5>
								<a href="orders.jsp" class="btn btn-sm btn-outline-light">View All Orders</a>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>Order ID</th>
												<th>Customer</th>
												<th>Products</th>
												<th>Total</th>
												<th>Status</th>
												<th>Date</th>
												<th>Actions</th>
											</tr>
										</thead>
										<tbody>
											<!-- Order 1: Wedding Order -->
											<tr>
												<td><strong>#ORD001</strong></td>
												<td>
													<div>John Smith</div>
													<small class="text-muted">john@email.com</small>
												</td>
												<td>
													<div>Wedding Bouquet</div>
													<small class="text-muted">Qty: 1</small>
												</td>
												<td><strong>$150.00</strong></td>
												<td><span class="order-status processing">Processing</span></td>
												<td>
													<div>Jan 15, 2024</div>
													<small class="text-muted">10:30 AM</small>
												</td>
												<td>
													<a href="order-details.jsp?id=1" class="btn btn-sm btn-outline-primary">
														<i class="fas fa-eye"></i>
													</a>
												</td>
											</tr>
											
											<!-- Order 2: Regular Order -->
											<tr>
												<td><strong>#ORD002</strong></td>
												<td>
													<div>Sarah Johnson</div>
													<small class="text-muted">sarah@email.com</small>
												</td>
												<td>
													<div>Red Roses (12 pcs)</div>
													<small class="text-muted">Qty: 1</small>
												</td>
												<td><strong>$25.00</strong></td>
												<td><span class="order-status completed">Completed</span></td>
												<td>
													<div>Jan 15, 2024</div>
													<small class="text-muted">09:15 AM</small>
												</td>
												<td>
													<a href="order-details.jsp?id=2" class="btn btn-sm btn-outline-primary">
														<i class="fas fa-eye"></i>
													</a>
												</td>
											</tr>
											
											<!-- Order 3: Corporate Order -->
											<tr>
												<td><strong>#ORD003</strong></td>
												<td>
													<div>Mike Wilson</div>
													<small class="text-muted">mike@company.com</small>
												</td>
												<td>
													<div>Office Arrangement</div>
													<small class="text-muted">Qty: 3</small>
												</td>
												<td><strong>$85.00</strong></td>
												<td><span class="order-status pending">Pending</span></td>
												<td>
													<div>Jan 14, 2024</div>
													<small class="text-muted">04:45 PM</small>
												</td>
												<td>
													<a href="order-details.jsp?id=3" class="btn btn-sm btn-outline-primary">
														<i class="fas fa-eye"></i>
													</a>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<!-- Right Sidebar: Alerts & Quick Actions -->
					<div class="col-lg-4">
						<!-- Stock Alerts -->
						<div class="card mb-3">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h6 class="mb-0">Stock Alerts</h6>
								<a href="inventory.jsp" class="btn btn-sm btn-outline-light">View Inventory</a>
							</div>
							<div class="card-body">
								<!-- Low Stock Alert -->
								<div class="notification-item">
									<div class="d-flex align-items-center">
										<div class="notification-icon warning">
											<i class="fas fa-exclamation-triangle"></i>
										</div>
										<div class="flex-grow-1">
											<div style="font-weight: 600;">Wedding Bouquet</div>
											<div style="font-size: 0.85rem; color: #6c757d;">Only 5 units left</div>
										</div>
										<a href="restock.jsp?product=wedding-bouquet" class="btn btn-sm btn-warning">Restock</a>
									</div>
								</div>
								
								<!-- Out of Stock Alert -->
								<div class="notification-item">
									<div class="d-flex align-items-center">
										<div class="notification-icon danger">
											<i class="fas fa-times-circle"></i>
										</div>
										<div class="flex-grow-1">
											<div style="font-weight: 600;">Orchid Pot</div>
											<div style="font-size: 0.85rem; color: #6c757d;">Out of stock</div>
										</div>
										<a href="restock.jsp?product=orchid-pot" class="btn btn-sm btn-danger">Urgent</a>
									</div>
								</div>
							</div>
						</div>

						<!-- Quick Actions -->
						<div class="card">
							<div class="card-header">
								<h6 class="mb-0">Quick Actions</h6>
							</div>
							<div class="card-body">
								<div class="d-grid gap-2">
									<a href="add-product.jsp" class="btn btn-primary">
										<i class="fas fa-plus me-2"></i>Add New Product
									</a>
									<a href="create-order.jsp" class="btn btn-success">
										<i class="fas fa-shopping-cart me-2"></i>Create Order
									</a>
									<a href="add-customer.jsp" class="btn btn-info">
										<i class="fas fa-user-plus me-2"></i>Add Customer
									</a>
									<a href="sales-reports.jsp" class="btn btn-secondary">
										<i class="fas fa-chart-bar me-2"></i>View Reports
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== BUSINESS INSIGHTS SECTION ===== -->
				<div class="row mt-4">
					<!-- Top Selling Products -->
					<div class="col-md-6">
						<div class="card">
							<div class="card-header">
								<h6 class="mb-0">Top Selling Products (This Week)</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-sm">
										<thead>
											<tr>
												<th>Product</th>
												<th>Sold</th>
												<th>Revenue</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>Red Roses (12 pcs)</td>
												<td>45</td>
												<td>$1,125</td>
											</tr>
											<tr>
												<td>Wedding Bouquet</td>
												<td>8</td>
												<td>$1,200</td>
											</tr>
											<tr>
												<td>Yellow Tulips</td>
												<td>32</td>
												<td>$576</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<!-- Recent Customer Activity -->
					<div class="col-md-6">
						<div class="card">
							<div class="card-header">
								<h6 class="mb-0">Recent Customer Activity</h6>
							</div>
							<div class="card-body">
								<div class="list-group list-group-flush">
									<div class="list-group-item d-flex justify-content-between align-items-center px-0">
										<div>
											<div style="font-weight: 600;">John Smith</div>
											<small class="text-muted">Placed order #ORD001</small>
										</div>
										<small class="text-muted">2 hours ago</small>
									</div>
									<div class="list-group-item d-flex justify-content-between align-items-center px-0">
										<div>
											<div style="font-weight: 600;">Sarah Johnson</div>
											<small class="text-muted">Completed payment</small>
										</div>
										<small class="text-muted">4 hours ago</small>
									</div>
									<div class="list-group-item d-flex justify-content-between align-items-center px-0">
										<div>
											<div style="font-weight: 600;">Mike Wilson</div>
											<small class="text-muted">Registered new account</small>
										</div>
										<small class="text-muted">1 day ago</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// ===== DASHBOARD FUNCTIONALITY =====
		
		// Auto-refresh dashboard data every 5 minutes
		setInterval(function() {
			// In real application, this would fetch updated data via AJAX
			console.log('Dashboard data refreshed at: ' + new Date().toLocaleTimeString());
		}, 300000);
		
		// Real-time clock update
		function updateClock() {
			const now = new Date();
			const timeString = now.toLocaleTimeString();
			// Update any clock elements if present
		}
		setInterval(updateClock, 1000);
		
		// Initialize tooltips for better UX
		document.addEventListener('DOMContentLoaded', function() {
			// Enable Bootstrap tooltips
			var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
			var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
				return new bootstrap.Tooltip(tooltipTriggerEl);
			});
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