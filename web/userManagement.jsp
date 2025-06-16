<%-- 
    Document   : staffManagement
    Created on : Jun 16, 2025, 9:50:24 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>User Management | Flower Shop</title>
	
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
		.table th { background: var(--light-gray); font-weight: 600; border-top: none; }
		
		/* ===== USER MANAGEMENT SPECIFIC STYLES ===== */
		.user-avatar {
			width: 60px; height: 60px; border-radius: 50%; object-fit: cover;
			border: 3px solid #e9ecef; transition: transform 0.3s ease;
		}
		.user-avatar:hover { transform: scale(1.1); border-color: var(--primary-red); }
		
		.user-role {
			padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
		}
		.user-role.admin { background: #dc3545; color: white; }
		.user-role.manager { background: #ffc107; color: #212529; }
		.user-role.staff { background: #17a2b8; color: white; }
		.user-role.viewer { background: #28a745; color: white; }
		
		.user-status {
			padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
		}
		.user-status.active { background: #d4edda; color: #155724; }
		.user-status.inactive { background: #f8d7da; color: #721c24; }
		.user-status.suspended { background: #e2e3e5; color: #383d41; }
		.user-status.pending { background: #fff3cd; color: #856404; }
		
		.permission-badge {
			padding: 0.2rem 0.5rem; border-radius: 8px; font-size: 0.65rem; font-weight: 600;
			margin: 0.1rem; display: inline-block;
		}
		.permission-badge.read { background: #e3f2fd; color: #1976d2; }
		.permission-badge.write { background: #f3e5f5; color: #7b1fa2; }
		.permission-badge.admin { background: #ffebee; color: #d32f2f; }
		
		.last-activity {
			font-size: 0.85rem;
		}
		.activity-online { color: #28a745; }
		.activity-recent { color: #ffc107; }
		.activity-offline { color: #6c757d; }
		
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
			<a href="index.jsp" class="sidebar-brand">
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
		</ul>
		</nav>

		<!-- ===== MAIN CONTENT AREA ===== -->
		<div class="main-content">
			<!-- Top Navigation Bar -->
			<div class="top-navbar">
				<div class="d-flex justify-content-between align-items-center">
					<div class="input-group" style="width: 300px;">
						<input type="text" class="form-control" placeholder="Search users..." id="userSearch">
						<button class="btn btn-outline-secondary" onclick="searchUsers()"><i class="fas fa-search"></i></button>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<a href="add-user.jsp" class="btn btn-primary">
							<i class="fas fa-user-plus me-2"></i>Add User
						</a>
						<a href="user-roles.jsp" class="btn btn-success">
							<i class="fas fa-user-cog me-2"></i>Manage Roles
						</a>
						<button class="btn btn-outline-secondary" onclick="exportUsers()">
							<i class="fas fa-file-export me-2"></i>Export
						</button>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">User Management</h2>
						<p class="text-muted">Manage system users, roles, and permissions</p>
					</div>
					<div class="text-muted">
						Total Users: <strong>12</strong> | Active: <strong>9</strong>
					</div>
				</div>

				<!-- ===== USER STATISTICS ===== -->
				<div class="row mb-4">
					<div class="col-md-3">
						<div class="card bg-danger text-white">
							<div class="card-body text-center">
								<i class="fas fa-user-shield fa-2x mb-2"></i>
								<h4>2</h4>
								<p class="mb-0">Administrators</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="card bg-warning text-dark">
							<div class="card-body text-center">
								<i class="fas fa-user-tie fa-2x mb-2"></i>
								<h4>3</h4>
								<p class="mb-0">Managers</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="card bg-info text-white">
							<div class="card-body text-center">
								<i class="fas fa-users fa-2x mb-2"></i>
								<h4>6</h4>
								<p class="mb-0">Staff Members</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="card bg-success text-white">
							<div class="card-body text-center">
								<i class="fas fa-eye fa-2x mb-2"></i>
								<h4>1</h4>
								<p class="mb-0">Viewers</p>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== FILTER SECTION ===== -->
				<div class="card mb-4">
					<div class="card-body">
						<div class="row align-items-center">
							<div class="col-md-3">
								<label class="form-label">User Role:</label>
								<select class="form-select" onchange="filterByRole(this.value)">
									<option value="">All Roles</option>
									<option value="admin">Administrator (2)</option>
									<option value="manager">Manager (3)</option>
									<option value="staff">Staff (6)</option>
									<option value="viewer">Viewer (1)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">User Status:</label>
								<select class="form-select" onchange="filterByStatus(this.value)">
									<option value="">All Status</option>
									<option value="active">Active (9)</option>
									<option value="inactive">Inactive (2)</option>
									<option value="suspended">Suspended (1)</option>
									<option value="pending">Pending (0)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Last Activity:</label>
								<select class="form-select" onchange="filterByActivity(this.value)">
									<option value="">All Users</option>
									<option value="online">Currently Online (3)</option>
									<option value="today">Active Today (6)</option>
									<option value="week">Active This Week (9)</option>
									<option value="month">Active This Month (12)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Department:</label>
								<select class="form-select" onchange="filterByDepartment(this.value)">
									<option value="">All Departments</option>
									<option value="management">Management (3)</option>
									<option value="sales">Sales (4)</option>
									<option value="inventory">Inventory (3)</option>
									<option value="customer-service">Customer Service (2)</option>
								</select>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== USERS TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">System Users</h5>
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
										<th><input type="checkbox" class="form-check-input" onchange="selectAllUsers(this)"></th>
										<th>User Information</th>
										<th>Role & Permissions</th>
										<th>Department</th>
										<th>Last Activity</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<!-- User 1: System Administrator -->
									<tr>
										<td><input type="checkbox" class="form-check-input user-checkbox" value="1"></td>
										<td>
											<div class="d-flex align-items-center">
												<img src="https://via.placeholder.com/60/4a90e2/ffffff?text=JD" 
													 class="user-avatar me-3" alt="John Doe">
												<div>
													<strong>John Doe</strong>
													<div class="text-muted small">john.doe@flowerparadise.com</div>
													<div class="text-muted small">User ID: #USR-001</div>
													<div class="text-muted small">Joined: Jan 2020</div>
												</div>
											</div>
										</td>
										<td>
											<div>
												<span class="user-role admin">Administrator</span>
												<div class="mt-2">
													<span class="permission-badge admin">Full Access</span>
													<span class="permission-badge write">User Management</span>
													<span class="permission-badge write">System Settings</span>
													<span class="permission-badge read">All Reports</span>
												</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Management</strong>
												<div class="text-muted small">System Administrator</div>
												<div class="text-muted small">IT Department</div>
											</div>
										</td>
										<td>
											<div class="last-activity">
												<div class="activity-online">
													<i class="fas fa-circle me-1"></i><strong>Online Now</strong>
												</div>
												<div class="text-muted small">Last login: Today 09:15 AM</div>
												<div class="text-muted small">IP: 192.168.1.100</div>
											</div>
										</td>
										<td><span class="user-status active">Active</span></td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="user-details.jsp?id=1" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-eye"></i> View
												</a>
												<a href="edit-user.jsp?id=1" class="btn btn-sm btn-outline-success">
													<i class="fas fa-edit"></i> Edit
												</a>
												<button class="btn btn-sm btn-outline-info" onclick="viewUserActivity(1)">
													<i class="fas fa-history"></i> Activity
												</button>
												<button class="btn btn-sm btn-outline-warning" onclick="resetPassword(1)">
													<i class="fas fa-key"></i> Reset Password
												</button>
											</div>
										</td>
									</tr>

									<!-- User 2: Manager -->
									<tr>
										<td><input type="checkbox" class="form-check-input user-checkbox" value="2"></td>
										<td>
											<div class="d-flex align-items-center">
												<img src="https://via.placeholder.com/60/e74c3c/ffffff?text=SJ" 
													 class="user-avatar me-3" alt="Sarah Johnson">
												<div>
													<strong>Sarah Johnson</strong>
													<div class="text-muted small">sarah.johnson@flowerparadise.com</div>
													<div class="text-muted small">User ID: #USR-002</div>
													<div class="text-muted small">Joined: Mar 2020</div>
												</div>
											</div>
										</td>
										<td>
											<div>
												<span class="user-role manager">Manager</span>
												<div class="mt-2">
													<span class="permission-badge write">Order Management</span>
													<span class="permission-badge write">Customer Management</span>
													<span class="permission-badge read">Sales Reports</span>
													<span class="permission-badge read">Inventory View</span>
												</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Sales</strong>
												<div class="text-muted small">Sales Manager</div>
												<div class="text-muted small">Customer Relations</div>
											</div>
										</td>
										<td>
											<div class="last-activity">
												<div class="activity-recent">
													<i class="fas fa-circle me-1"></i><strong>2 hours ago</strong>
												</div>
												<div class="text-muted small">Last login: Today 07:30 AM</div>
												<div class="text-muted small">IP: 192.168.1.105</div>
											</div>
										</td>
										<td><span class="user-status active">Active</span></td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="user-details.jsp?id=2" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-eye"></i> View
												</a>
												<a href="edit-user.jsp?id=2" class="btn btn-sm btn-outline-success">
													<i class="fas fa-edit"></i> Edit
												</a>
												<button class="btn btn-sm btn-outline-info" onclick="viewUserActivity(2)">
													<i class="fas fa-history"></i> Activity
												</button>
												<button class="btn btn-sm btn-outline-warning" onclick="changeRole(2)">
													<i class="fas fa-user-cog"></i> Change Role
												</button>
											</div>
										</td>
									</tr>

									<!-- User 3: Staff Member -->
									<tr>
										<td><input type="checkbox" class="form-check-input user-checkbox" value="3"></td>
										<td>
											<div class="d-flex align-items-center">
												<img src="https://via.placeholder.com/60/2ecc71/ffffff?text=MW" 
													 class="user-avatar me-3" alt="Mike Wilson">
												<div>
													<strong>Mike Wilson</strong>
													<div class="text-muted small">mike.wilson@flowerparadise.com</div>
													<div class="text-muted small">User ID: #USR-003</div>
													<div class="text-muted small">Joined: Aug 2021</div>
												</div>
											</div>
										</td>
										<td>
											<div>
												<span class="user-role staff">Staff</span>
												<div class="mt-2">
													<span class="permission-badge write">Inventory Management</span>
													<span class="permission-badge read">Product Catalog</span>
													<span class="permission-badge read">Order View</span>
												</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Inventory</strong>
												<div class="text-muted small">Inventory Specialist</div>
												<div class="text-muted small">Warehouse Operations</div>
											</div>
										</td>
										<td>
											<div class="last-activity">
												<div class="activity-online">
													<i class="fas fa-circle me-1"></i><strong>Online Now</strong>
												</div>
												<div class="text-muted small">Last login: Today 08:00 AM</div>
												<div class="text-muted small">IP: 192.168.1.110</div>
											</div>
										</td>
										<td><span class="user-status active">Active</span></td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="user-details.jsp?id=3" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-eye"></i> View
												</a>
												<a href="edit-user.jsp?id=3" class="btn btn-sm btn-outline-success">
													<i class="fas fa-edit"></i> Edit
												</a>
												<button class="btn btn-sm btn-outline-info" onclick="viewUserActivity(3)">
													<i class="fas fa-history"></i> Activity
												</button>
												<button class="btn btn-sm btn-outline-warning" onclick="changeRole(3)">
													<i class="fas fa-user-cog"></i> Change Role
												</button>
											</div>
										</td>
									</tr>

									<!-- User 4: Staff Member -->
									<tr>
										<td><input type="checkbox" class="form-check-input user-checkbox" value="4"></td>
										<td>
											<div class="d-flex align-items-center">
												<img src="https://via.placeholder.com/60/9b59b6/ffffff?text=ED" 
													 class="user-avatar me-3" alt="Emily Davis">
												<div>
													<strong>Emily Davis</strong>
													<div class="text-muted small">emily.davis@flowerparadise.com</div>
													<div class="text-muted small">User ID: #USR-004</div>
													<div class="text-muted small">Joined: Nov 2022</div>
												</div>
											</div>
										</td>
										<td>
											<div>
												<span class="user-role staff">Staff</span>
												<div class="mt-2">
													<span class="permission-badge write">Customer Service</span>
													<span class="permission-badge read">Customer Records</span>
													<span class="permission-badge read">Order Processing</span>
												</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Customer Service</strong>
												<div class="text-muted small">Customer Support Rep</div>
												<div class="text-muted small">Front Desk Operations</div>
											</div>
										</td>
										<td>
											<div class="last-activity">
												<div class="activity-recent">
													<i class="fas fa-circle me-1"></i><strong>30 minutes ago</strong>
												</div>
												<div class="text-muted small">Last login: Today 08:45 AM</div>
												<div class="text-muted small">IP: 192.168.1.115</div>
											</div>
										</td>
										<td><span class="user-status active">Active</span></td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="user-details.jsp?id=4" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-eye"></i> View
												</a>
												<a href="edit-user.jsp?id=4" class="btn btn-sm btn-outline-success">
													<i class="fas fa-edit"></i> Edit
												</a>
												<button class="btn btn-sm btn-outline-info" onclick="viewUserActivity(4)">
													<i class="fas fa-history"></i> Activity
												</button>
												<button class="btn btn-sm btn-outline-warning" onclick="changeRole(4)">
													<i class="fas fa-user-cog"></i> Change Role
												</button>
											</div>
										</td>
									</tr>

									<!-- User 5: Inactive User -->
									<tr class="table-secondary">
										<td><input type="checkbox" class="form-check-input user-checkbox" value="5"></td>
										<td>
											<div class="d-flex align-items-center">
												<img src="https://via.placeholder.com/60/95a5a6/ffffff?text=RB" 
													 class="user-avatar me-3" alt="Robert Brown">
												<div>
													<strong>Robert Brown</strong>
													<div class="text-muted small">robert.brown@flowerparadise.com</div>
													<div class="text-muted small">User ID: #USR-005</div>
													<div class="text-muted small">Joined: Feb 2021</div>
												</div>
											</div>
										</td>
										<td>
											<div>
												<span class="user-role viewer">Viewer</span>
												<div class="mt-2">
													<span class="permission-badge read">Reports View</span>
													<span class="permission-badge read">Dashboard Access</span>
												</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Management</strong>
												<div class="text-muted small">External Consultant</div>
												<div class="text-muted small">Business Analysis</div>
											</div>
										</td>
										<td>
											<div class="last-activity">
												<div class="activity-offline">
													<i class="fas fa-circle me-1"></i><strong>2 weeks ago</strong>
												</div>
												<div class="text-muted small">Last login: Dec 28, 2023</div>
												<div class="text-muted small">IP: 203.0.113.45</div>
											</div>
										</td>
										<td><span class="user-status inactive">Inactive</span></td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="user-details.jsp?id=5" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-eye"></i> View
												</a>
												<button class="btn btn-sm btn-success" onclick="activateUser(5)">
													<i class="fas fa-user-check"></i> Activate
												</button>
												<button class="btn btn-sm btn-outline-warning" onclick="resetPassword(5)">
													<i class="fas fa-key"></i> Reset Password
												</button>
												<button class="btn btn-sm btn-danger" onclick="deleteUser(5)">
													<i class="fas fa-trash"></i> Delete
												</button>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- ===== BULK ACTIONS ===== -->
						<div class="d-flex justify-content-between align-items-center mt-3">
							<div>
								<button class="btn btn-outline-primary btn-sm" onclick="bulkActivate()" disabled id="bulkActivateBtn">
									<i class="fas fa-user-check me-2"></i>Activate Selected
								</button>
								<button class="btn btn-outline-warning btn-sm" onclick="bulkDeactivate()" disabled id="bulkDeactivateBtn">
									<i class="fas fa-user-times me-2"></i>Deactivate Selected
								</button>
								<button class="btn btn-outline-info btn-sm" onclick="bulkChangeRole()" disabled id="bulkRoleBtn">
									<i class="fas fa-user-cog me-2"></i>Change Role
								</button>
								<button class="btn btn-outline-danger btn-sm" onclick="bulkDelete()" disabled id="bulkDeleteBtn">
									<i class="fas fa-trash me-2"></i>Delete Selected
								</button>
							</div>
							<div class="text-muted">
								Showing 1 to 5 of 12 users
							</div>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="User pagination" class="mt-3">
							<ul class="pagination">
								<li class="page-item disabled">
									<a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
								</li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="user-management.jsp?page=2">2</a></li>
								<li class="page-item"><a class="page-link" href="user-management.jsp?page=3">3</a></li>
								<li class="page-item">
									<a class="page-link" href="user-management.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
								</li>
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
		// ===== USER MANAGEMENT FUNCTIONALITY =====
		
		// Search users
		function searchUsers() {
			const searchTerm = document.getElementById('userSearch').value;
			console.log('Searching users:', searchTerm);
			// Implementation would filter users based on search term
		}
		
		// Filter functions
		function filterByRole(role) { console.log('Filter by role:', role); }
		function filterByStatus(status) { console.log('Filter by status:', status); }
		function filterByActivity(activity) { console.log('Filter by activity:', activity); }
		function filterByDepartment(department) { console.log('Filter by department:', department); }
		
		// User actions
		function viewUserActivity(userId) {
			console.log('Viewing activity for user:', userId);
			window.location.href = `user-activity.jsp?userId=${userId}`;
		}
		
		function resetPassword(userId) {
			if (confirm('Reset password for this user? They will receive an email with a new temporary password.')) {
				console.log('Resetting password for user:', userId);
				alert('Password reset email sent successfully!');
			}
		}
		
		function changeRole(userId) {
			console.log('Changing role for user:', userId);
			window.location.href = `change-user-role.jsp?userId=${userId}`;
		}
		
		function activateUser(userId) {
			if (confirm('Activate this user account?')) {
				console.log('Activating user:', userId);
				alert('User account activated successfully!');
			}
		}
		
		function deleteUser(userId) {
			if (confirm('Delete this user account? This action cannot be undone.')) {
				console.log('Deleting user:', userId);
				alert('User account deleted successfully!');
			}
		}
		
		// Bulk actions
		function selectAllUsers(checkbox) {
			const userCheckboxes = document.querySelectorAll('.user-checkbox');
			userCheckboxes.forEach(cb => cb.checked = checkbox.checked);
			updateBulkActionButtons();
		}
		
		function updateBulkActionButtons() {
			const selectedUsers = document.querySelectorAll('.user-checkbox:checked');
			const bulkButtons = ['bulkActivateBtn', 'bulkDeactivateBtn', 'bulkRoleBtn', 'bulkDeleteBtn'];
			
			bulkButtons.forEach(btnId => {
				document.getElementById(btnId).disabled = selectedUsers.length === 0;
			});
		}
		
		function bulkActivate() {
			const selected = document.querySelectorAll('.user-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			if (confirm(`Activate ${ids.length} selected users?`)) {
				console.log('Bulk activating users:', ids);
				alert('Selected users activated successfully!');
			}
		}
		
		function bulkDeactivate() {
			const selected = document.querySelectorAll('.user-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			if (confirm(`Deactivate ${ids.length} selected users?`)) {
				console.log('Bulk deactivating users:', ids);
				alert('Selected users deactivated successfully!');
			}
		}
		
		function bulkChangeRole() {
			const selected = document.querySelectorAll('.user-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = `bulk-change-role.jsp?userIds=${ids.join(',')}`;
		}
		
		function bulkDelete() {
			const selected = document.querySelectorAll('.user-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			if (confirm(`Delete ${ids.length} selected users? This action cannot be undone.`)) {
				console.log('Bulk deleting users:', ids);
				alert('Selected users deleted successfully!');
			}
		}
		
		function exportUsers() {
			window.location.href = 'export-users.jsp?format=excel';
		}
		
		// Initialize page
		document.addEventListener('DOMContentLoaded', function() {
			// Add event listeners to user checkboxes
			document.querySelectorAll('.user-checkbox').forEach(checkbox => {
				checkbox.addEventListener('change', updateBulkActionButtons);
			});
			
			// Enable real-time search
			document.getElementById('userSearch').addEventListener('keyup', function(e) {
				if (e.key === 'Enter') {
					searchUsers();
				}
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
