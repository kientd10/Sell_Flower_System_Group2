<%-- 
    Document   : notificationManagement
    Created on : Jun 16, 2025, 9:51:04 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Notifications | Flower Shop</title>
	
	<!-- External CSS -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	
	<style>
		/* ===== SHARED STYLES ===== */
		:root {
			--primary-red: #dc3545;
			--primary-red-dark: #b02a37;
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
		
		/* ===== NOTIFICATION SPECIFIC STYLES ===== */
		.notification-item {
			background: white; border-radius: 10px; padding: 1.5rem; margin-bottom: 1rem;
			box-shadow: 0 2px 10px rgba(0,0,0,0.08); transition: all 0.3s ease;
			border-left: 4px solid transparent;
		}
		.notification-item:hover { transform: translateY(-2px); box-shadow: 0 4px 20px rgba(0,0,0,0.12); }
		.notification-item.unread { border-left-color: var(--primary-red); background: #fff8f8; }
		.notification-item.read { border-left-color: #28a745; }
		
		.notification-icon {
			width: 50px; height: 50px; border-radius: 50%; display: flex;
			align-items: center; justify-content: center; color: white; margin-right: 1rem;
		}
		.notification-icon.critical { background: #dc3545; }
		.notification-icon.warning { background: #ffc107; color: #212529; }
		.notification-icon.info { background: #17a2b8; }
		.notification-icon.success { background: #28a745; }
		.notification-icon.system { background: #6c757d; }
		
		.notification-priority {
			padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
		}
		.notification-priority.high { background: #dc3545; color: white; }
		.notification-priority.medium { background: #ffc107; color: #212529; }
		.notification-priority.low { background: #28a745; color: white; }
		
		.notification-category {
			padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
		}
		.notification-category.inventory { background: #e3f2fd; color: #1976d2; }
		.notification-category.orders { background: #f3e5f5; color: #7b1fa2; }
		.notification-category.customers { background: #e8f5e8; color: #388e3c; }
		.notification-category.system { background: #fff3e0; color: #f57c00; }
		.notification-category.security { background: #ffebee; color: #d32f2f; }
		
		.notification-actions {
			display: flex; gap: 0.5rem; margin-top: 1rem;
		}
		
		.notification-filter {
			background: white; border-radius: 10px; padding: 1.5rem;
			box-shadow: 0 2px 10px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
		}
		
		.notification-stats {
			background: white; border-radius: 10px; padding: 1.5rem;
			box-shadow: 0 2px 10px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
		}
		
		.stat-item {
			text-align: center; padding: 1rem;
		}
		.stat-number {
			font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem;
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
            <% 
            // Lấy thông tin vai trò từ session
            Integer role = (Integer) request.getSession().getAttribute("role"); 
            %>
            <!-- Kiểm tra vai trò người dùng và hiển thị các chức năng tương ứng -->
            <% if (role != null) { %>
            <% if (role == 1) { %>  <!-- Khách hàng (Customer) -->
            <div class="content-area">
                <!-- Các chức năng của khách hàng -->
            </div>
            <% } else if (role == 2) { %>  <!-- Nhân viên (Staff) -->
            <div class="content-area">

                <!-- Các chức năng của nhân viên -->
            </div>
            <% } else if (role == 3) { %>  <!-- Quản lý (Manager) -->
            <div class="content-area">

                <!-- Các chức năng của quản lý -->
            </div>
            <% } else if (role == 4) { %>  <!-- Người giao hàng (Shipper) -->
            <div class="content-area">

                <!-- Các chức năng của người giao hàng -->
            </div>
            <% } else { %>
            <h2>Vai trò không hợp lệ</h2>
            <% } %>
            <% } else { %>
            <h2>Vui lòng đăng nhập để tiếp tục</h2>
            <% } %>
		<!-- ===== SIDEBAR NAVIGATION ===== -->
		<nav class="sidebar">
			<a href="home" class="sidebar-brand">
				<i class="fas fa-seedling me-2"></i>Flower Management
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

                    <!-- Chỉ hiển thị nếu là Manager hoặc Staff -->
                    <% if (role == 2) { %>
                    <li><a href="productManagement.jsp" class="sidebar-link"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                        <% } %>

                    <!-- Chỉ hiển thị nếu là Manager -->
                    <% if (role == 3) { %>
                    <li><a href="management.jsp" class="sidebar-link" id="menu-management"><i class="fas fa-chart-bar"></i>Thống Kê</a></li>
                    <li><a href="productManagement.jsp" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                    <li><a href="categoryManagement.jsp" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
                    <li><a href="storageManagement.jsp" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                    <li><a href="orderManagement.jsp" class="sidebar-link" id="menu-orderManagement"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                    <li><a href="invoiceManagement.jsp" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>

                    <li class="sidebar-header">Hệ Thống</li>
                    <li><a href="userManagement.jsp" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Người Dùng</a></li>
                    <li><a href="feedbackManagement.jsp" class="sidebar-link active" id="menu-feedbackManagement"><i class="fas fa-comments"></i>Quản Lý Phản Hồi</a></li>
                    <li><a href="notificationManagement.jsp" class="sidebar-link" id="menu-notificationManagement"><i class="fas fa-bell"></i>Thông Báo<span class="badge bg-danger ms-auto">4</span></a></li>
                        <% } %>

                    <!-- Chỉ hiển thị nếu là Shipper -->
                    <% if (role == 4) { %>
                    <li><a href="orderManagement.jsp" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                        <% } %>
                </ul>
		</nav>

		<!-- ===== MAIN CONTENT AREA ===== -->
		<div class="main-content">
			<!-- Top Navigation Bar -->
			<div class="top-navbar">
				<div class="d-flex justify-content-between align-items-center">
					<div class="d-flex align-items-center gap-3">
						<h5 class="mb-0">Notification Center</h5>
						<span class="badge bg-danger">4 Unread</span>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<button class="btn btn-outline-secondary" onclick="markAllAsRead()">
							<i class="fas fa-check-double me-2"></i>Mark All Read
						</button>
						<button class="btn btn-outline-secondary" onclick="clearAllNotifications()">
							<i class="fas fa-trash me-2"></i>Clear All
						</button>
						<button class="btn btn-primary" onclick="configureNotifications()">
							<i class="fas fa-cog me-2"></i>Settings
						</button>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Notifications & Alerts</h2>
						<p class="text-muted">Stay updated with important system alerts and business notifications</p>
					</div>
					<div class="text-muted">
						Last updated: <strong><%= new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date()) %></strong>
					</div>
				</div>

				<!-- ===== NOTIFICATION STATISTICS ===== -->
				<div class="notification-stats">
					<div class="row">
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-danger">4</div>
								<div class="text-muted">Unread</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-warning">2</div>
								<div class="text-muted">Critical</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-info">15</div>
								<div class="text-muted">Today</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-success">89</div>
								<div class="text-muted">This Week</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== NOTIFICATION FILTERS ===== -->
				<div class="notification-filter">
					<div class="row align-items-center">
						<div class="col-md-3">
							<label class="form-label">Filter by Status:</label>
							<select class="form-select" onchange="filterByStatus(this.value)">
								<option value="">All Notifications</option>
								<option value="unread">Unread (4)</option>
								<option value="read">Read (85)</option>
								<option value="archived">Archived (156)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Filter by Category:</label>
							<select class="form-select" onchange="filterByCategory(this.value)">
								<option value="">All Categories</option>
								<option value="inventory">Inventory (12)</option>
								<option value="orders">Orders (8)</option>
								<option value="customers">Customers (5)</option>
								<option value="system">System (3)</option>
								<option value="security">Security (1)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Filter by Priority:</label>
							<select class="form-select" onchange="filterByPriority(this.value)">
								<option value="">All Priorities</option>
								<option value="high">High Priority (2)</option>
								<option value="medium">Medium Priority (6)</option>
								<option value="low">Low Priority (21)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Time Period:</label>
							<select class="form-select" onchange="filterByTime(this.value)">
								<option value="">All Time</option>
								<option value="today">Today</option>
								<option value="yesterday">Yesterday</option>
								<option value="week">This Week</option>
								<option value="month">This Month</option>
							</select>
						</div>
					</div>
				</div>

				<!-- ===== NOTIFICATIONS LIST ===== -->
				<div class="notifications-container">
					<!-- Critical Inventory Alert -->
					<div class="notification-item unread">
						<div class="d-flex align-items-start">
							<div class="notification-icon critical">
								<i class="fas fa-exclamation-triangle"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">Critical Stock Alert: Purple Orchid Pot</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority high">High Priority</span>
											<span class="notification-category inventory">Inventory</span>
										</div>
									</div>
									<small class="text-muted">2 minutes ago</small>
								</div>
								<p class="mb-2">Purple Orchid Pot (SKU: OP-001) is completely out of stock. This item has pending orders and requires immediate restocking to prevent customer dissatisfaction.</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-danger" onclick="urgentRestock('OP-001')">
										<i class="fas fa-shopping-cart me-1"></i>Urgent Restock
									</button>
									<button class="btn btn-sm btn-outline-primary" onclick="viewInventory('OP-001')">
										<i class="fas fa-eye me-1"></i>View Details
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(1)">
										<i class="fas fa-check me-1"></i>Mark Read
									</button>
								</div>
							</div>
						</div>
					</div>

					<!-- Order Processing Alert -->
					<div class="notification-item unread">
						<div class="d-flex align-items-start">
							<div class="notification-icon warning">
								<i class="fas fa-clock"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">Urgent Order Requires Attention</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority high">High Priority</span>
											<span class="notification-category orders">Orders</span>
										</div>
									</div>
									<small class="text-muted">15 minutes ago</small>
								</div>
								<p class="mb-2">Order #ORD-2024-004 (Funeral Wreath) requires same-day delivery by 6:00 PM. Customer Emily Davis has requested urgent processing for funeral service.</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-warning" onclick="prioritizeOrder('ORD-2024-004')">
										<i class="fas fa-bolt me-1"></i>Prioritize
									</button>
									<button class="btn btn-sm btn-outline-primary" onclick="viewOrder('ORD-2024-004')">
										<i class="fas fa-eye me-1"></i>View Order
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(2)">
										<i class="fas fa-check me-1"></i>Mark Read
									</button>
								</div>
							</div>
						</div>
					</div>

					<!-- New Customer Registration -->
					<div class="notification-item unread">
						<div class="d-flex align-items-start">
							<div class="notification-icon success">
								<i class="fas fa-user-plus"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">New VIP Customer Registration</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority medium">Medium Priority</span>
											<span class="notification-category customers">Customers</span>
										</div>
									</div>
									<small class="text-muted">1 hour ago</small>
								</div>
								<p class="mb-2">Emily Davis has registered as a new customer and placed a high-value order ($120). Consider offering VIP welcome package and personalized service.</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-success" onclick="sendWelcomePackage('CUST-004')">
										<i class="fas fa-gift me-1"></i>Welcome Package
									</button>
									<button class="btn btn-sm btn-outline-primary" onclick="viewCustomer('CUST-004')">
										<i class="fas fa-user me-1"></i>View Profile
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(3)">
										<i class="fas fa-check me-1"></i>Mark Read
									</button>
								</div>
							</div>
						</div>
					</div>

					<!-- System Maintenance -->
					<div class="notification-item unread">
						<div class="d-flex align-items-start">
							<div class="notification-icon system">
								<i class="fas fa-tools"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">Scheduled System Maintenance</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority low">Low Priority</span>
											<span class="notification-category system">System</span>
										</div>
									</div>
									<small class="text-muted">2 hours ago</small>
								</div>
								<p class="mb-2">System maintenance is scheduled for tonight at 2:00 AM - 4:00 AM EST. The system will be temporarily unavailable during this period. Please plan accordingly.</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-info" onclick="viewMaintenanceDetails()">
										<i class="fas fa-info-circle me-1"></i>Details
									</button>
									<button class="btn btn-sm btn-outline-warning" onclick="notifyStaff()">
										<i class="fas fa-users me-1"></i>Notify Staff
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="markAsRead(4)">
										<i class="fas fa-check me-1"></i>Mark Read
									</button>
								</div>
							</div>
						</div>
					</div>

					<!-- Read Notifications -->
					<div class="notification-item read">
						<div class="d-flex align-items-start">
							<div class="notification-icon info">
								<i class="fas fa-chart-line"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">Weekly Sales Report Available</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority low">Low Priority</span>
											<span class="notification-category system">System</span>
										</div>
									</div>
									<small class="text-muted">3 hours ago</small>
								</div>
								<p class="mb-2">Your weekly sales report for January 8-15, 2024 is now available. Total revenue: $12,450 (+15.3% vs last week).</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-info" onclick="viewReport('weekly-sales')">
										<i class="fas fa-chart-bar me-1"></i>View Report
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="archiveNotification(5)">
										<i class="fas fa-archive me-1"></i>Archive
									</button>
								</div>
							</div>
						</div>
					</div>

					<div class="notification-item read">
						<div class="d-flex align-items-start">
							<div class="notification-icon success">
								<i class="fas fa-truck"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">Supplier Delivery Completed</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority low">Low Priority</span>
											<span class="notification-category inventory">Inventory</span>
										</div>
									</div>
									<small class="text-muted">5 hours ago</small>
								</div>
								<p class="mb-2">Delivery from Rose Garden Co. has been completed successfully. 20 units of Red Roses (SKU: RR-012) have been added to inventory.</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-success" onclick="viewDelivery('DEL-001')">
										<i class="fas fa-clipboard-check me-1"></i>View Delivery
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="archiveNotification(6)">
										<i class="fas fa-archive me-1"></i>Archive
									</button>
								</div>
							</div>
						</div>
					</div>

					<div class="notification-item read">
						<div class="d-flex align-items-start">
							<div class="notification-icon info">
								<i class="fas fa-star"></i>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between align-items-start mb-2">
									<div>
										<h6 class="mb-1">Customer Review Received</h6>
										<div class="d-flex gap-2 mb-2">
											<span class="notification-priority low">Low Priority</span>
											<span class="notification-category customers">Customers</span>
										</div>
									</div>
									<small class="text-muted">1 day ago</small>
								</div>
								<p class="mb-2">Sarah Johnson left a 5-star review for Red Roses (12 pieces): "Beautiful flowers, excellent quality and fast delivery. Highly recommended!"</p>
								<div class="notification-actions">
									<button class="btn btn-sm btn-info" onclick="viewReview('REV-001')">
										<i class="fas fa-star me-1"></i>View Review
									</button>
									<button class="btn btn-sm btn-outline-success" onclick="thankCustomer('CUST-002')">
										<i class="fas fa-heart me-1"></i>Thank Customer
									</button>
									<button class="btn btn-sm btn-outline-secondary" onclick="archiveNotification(7)">
										<i class="fas fa-archive me-1"></i>Archive
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== PAGINATION ===== -->
				<div class="d-flex justify-content-center mt-4">
					<nav aria-label="Notifications pagination">
						<ul class="pagination">
							<li class="page-item disabled">
								<a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
							</li>
							<li class="page-item active"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="notifications.jsp?page=2">2</a></li>
							<li class="page-item"><a class="page-link" href="notifications.jsp?page=3">3</a></li>
							<li class="page-item">
								<a class="page-link" href="notifications.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// ===== NOTIFICATION MANAGEMENT FUNCTIONALITY =====
		
		// Filter functions
		function filterByStatus(status) { console.log('Filter by status:', status); }
		function filterByCategory(category) { console.log('Filter by category:', category); }
		function filterByPriority(priority) { console.log('Filter by priority:', priority); }
		function filterByTime(time) { console.log('Filter by time:', time); }
		
		// Notification actions
		function markAsRead(notificationId) {
			console.log('Marking notification as read:', notificationId);
			// Implementation would mark notification as read via AJAX
			const notification = document.querySelector(`[data-notification-id="${notificationId}"]`);
			if (notification) {
				notification.classList.remove('unread');
				notification.classList.add('read');
			}
		}
		
		function markAllAsRead() {
			if (confirm('Mark all notifications as read?')) {
				console.log('Marking all notifications as read');
				document.querySelectorAll('.notification-item.unread').forEach(item => {
					item.classList.remove('unread');
					item.classList.add('read');
				});
				// Update badge count
				document.querySelector('.badge').textContent = '0 Unread';
			}
		}
		
		function archiveNotification(notificationId) {
			console.log('Archiving notification:', notificationId);
			// Implementation would archive notification via AJAX
		}
		
		function clearAllNotifications() {
			if (confirm('Clear all notifications? This action cannot be undone.')) {
				console.log('Clearing all notifications');
				// Implementation would clear all notifications
			}
		}
		
		function configureNotifications() {
			console.log('Opening notification settings');
			window.location.href = 'notification-settings.jsp';
		}
		
		// Specific action handlers
		function urgentRestock(sku) {
			console.log('Creating urgent restock for:', sku);
			window.location.href = `urgent-restock.jsp?sku=${sku}`;
		}
		
		function viewInventory(sku) {
			console.log('Viewing inventory for:', sku);
			window.location.href = `inventory-details.jsp?sku=${sku}`;
		}
		
		function prioritizeOrder(orderId) {
			console.log('Prioritizing order:', orderId);
			window.location.href = `prioritize-order.jsp?orderId=${orderId}`;
		}
		
		function viewOrder(orderId) {
			console.log('Viewing order:', orderId);
			window.location.href = `order-details.jsp?orderId=${orderId}`;
		}
		
		function sendWelcomePackage(customerId) {
			console.log('Sending welcome package to:', customerId);
			window.location.href = `send-welcome-package.jsp?customerId=${customerId}`;
		}
		
		function viewCustomer(customerId) {
			console.log('Viewing customer:', customerId);
			window.location.href = `customer-details.jsp?customerId=${customerId}`;
		}
		
		function viewMaintenanceDetails() {
			console.log('Viewing maintenance details');
			window.location.href = 'maintenance-schedule.jsp';
		}
		
		function notifyStaff() {
			console.log('Notifying staff about maintenance');
			// Implementation would send notifications to staff
			alert('Staff notification sent successfully!');
		}
		
		function viewReport(reportType) {
			console.log('Viewing report:', reportType);
			window.location.href = `${reportType}-report.jsp`;
		}
		
		function viewDelivery(deliveryId) {
			console.log('Viewing delivery:', deliveryId);
			window.location.href = `delivery-details.jsp?deliveryId=${deliveryId}`;
		}
		
		function viewReview(reviewId) {
			console.log('Viewing review:', reviewId);
			window.location.href = `customer-review.jsp?reviewId=${reviewId}`;
		}
		
		function thankCustomer(customerId) {
			console.log('Thanking customer:', customerId);
			window.location.href = `thank-customer.jsp?customerId=${customerId}`;
		}
		
		// Auto-refresh notifications every 30 seconds
		setInterval(function() {
			console.log('Auto-refreshing notifications...');
			// Implementation would check for new notifications via AJAX
		}, 30000);
		
		// Initialize page
		document.addEventListener('DOMContentLoaded', function() {
			console.log('Notification center initialized');
			
			// Check for new notifications on page load
			checkForNewNotifications();
		});
		
		function checkForNewNotifications() {
			// Implementation would check for new notifications via AJAX
			console.log('Checking for new notifications...');
		}
                
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
