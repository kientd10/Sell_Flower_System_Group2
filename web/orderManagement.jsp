<%-- 
    Document   : orderManagement
    Created on : Jun 16, 2025, 9:39:41 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Inventory Control | Flower Shop</title>
	
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

		<!-- ===== MAIN CONTENT AREA ===== -->
		<div class="main-content">
			<!-- Top Navigation Bar -->
			<div class="top-navbar">
				<div class="d-flex justify-content-between align-items-center">
					<div class="input-group" style="width: 300px;">
						<input type="text" class="form-control" placeholder="Search inventory..." id="inventorySearch">
						<button class="btn btn-outline-secondary" onclick="searchInventory()"><i class="fas fa-search"></i></button>
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
						<h2 class="page-title">Inventory Control</h2>
						<p class="text-muted">Monitor stock levels, manage reorders, and track inventory movements</p>
					</div>
					<div class="text-muted">
						Total Items: <strong>248</strong> | Value: <strong>$45,230</strong>
					</div>
				</div>

				<!-- ===== INVENTORY OVERVIEW STATISTICS ===== -->
				<div class="row mb-4">
					<div class="col-md-3">
						<div class="inventory-stats text-center">
							<i class="fas fa-boxes fa-2x text-primary mb-2"></i>
							<h4 class="text-primary">248</h4>
							<p class="mb-0">Total Items</p>
							<small class="text-muted">Across all categories</small>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inventory-stats text-center">
							<i class="fas fa-exclamation-triangle fa-2x text-warning mb-2"></i>
							<h4 class="text-warning">12</h4>
							<p class="mb-0">Low Stock Items</p>
							<small class="text-muted">Need reordering</small>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inventory-stats text-center">
							<i class="fas fa-times-circle fa-2x text-danger mb-2"></i>
							<h4 class="text-danger">3</h4>
							<p class="mb-0">Out of Stock</p>
							<small class="text-muted">Urgent attention</small>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inventory-stats text-center">
							<i class="fas fa-dollar-sign fa-2x text-success mb-2"></i>
							<h4 class="text-success">$45.2K</h4>
							<p class="mb-0">Total Value</p>
							<small class="text-muted">Current inventory</small>
						</div>
					</div>
				</div>

				<!-- ===== CRITICAL ALERTS ===== -->
				<div class="row mb-4">
					<div class="col-12">
						<div class="reorder-alert">
							<div class="d-flex align-items-center justify-content-between">
								<div>
									<h6 class="mb-1"><i class="fas fa-exclamation-triangle me-2"></i>Urgent Reorder Required</h6>
									<p class="mb-0">3 items are out of stock and 12 items are below minimum stock levels. Immediate action required to prevent stockouts.</p>
								</div>
								<div>
									<a href="urgent-reorder.jsp" class="btn btn-warning">
										<i class="fas fa-shopping-cart me-2"></i>Create Purchase Orders
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== FILTER SECTION ===== -->
				<div class="card mb-4">
					<div class="card-body">
						<div class="row align-items-center">
							<div class="col-md-3">
								<label class="form-label">Stock Level:</label>
								<select class="form-select" onchange="filterByStockLevel(this.value)">
									<option value="">All Stock Levels</option>
									<option value="critical">Critical (3)</option>
									<option value="low">Low Stock (12)</option>
									<option value="normal">Normal (198)</option>
									<option value="high">Overstocked (35)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Category:</label>
								<select class="form-select" onchange="filterByCategory(this.value)">
									<option value="">All Categories</option>
									<option value="cut-flowers">Cut Flowers (89)</option>
									<option value="bouquets">Bouquets (45)</option>
									<option value="potted-plants">Potted Plants (67)</option>
									<option value="wedding-flowers">Wedding Flowers (23)</option>
									<option value="supplies">Supplies & Materials (24)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Supplier:</label>
								<select class="form-select" onchange="filterBySupplier(this.value)">
									<option value="">All Suppliers</option>
									<option value="flower-paradise">Flower Paradise (78)</option>
									<option value="rose-garden">Rose Garden Co. (65)</option>
									<option value="dutch-flowers">Dutch Flowers Ltd. (45)</option>
									<option value="exotic-plants">Exotic Plants Inc. (35)</option>
									<option value="seasonal-blooms">Seasonal Blooms (25)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Location:</label>
								<select class="form-select" onchange="filterByLocation(this.value)">
									<option value="">All Locations</option>
									<option value="main-warehouse">Main Warehouse (180)</option>
									<option value="cold-storage">Cold Storage (45)</option>
									<option value="display-area">Display Area (23)</option>
								</select>
							</div>
						</div>
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
										<th>Product Info</th>
										<th>Current Stock</th>
										<th>Stock Level</th>
										<th>Reorder Point</th>
										<th>Supplier Info</th>
										<th>Last Movement</th>
										<th>Value</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<!-- Item 1: Critical Stock - Out of Stock -->
									<tr class="table-danger">
										<td><input type="checkbox" class="form-check-input item-checkbox" value="1"></td>
										<td>
											<div>
												<strong>Purple Orchid Pot</strong>
												<div class="text-muted small">SKU: OP-001</div>
												<div class="text-muted small">Location: Cold Storage</div>
												<div class="text-muted small">Category: Potted Plants</div>
											</div>
										</td>
										<td>
											<div class="text-center">
												<strong class="text-danger">0</strong>
												<div class="text-muted small">units</div>
												<div class="stock-progress mt-1">
													<div class="progress-bar critical" style="width: 0%"></div>
												</div>
											</div>
										</td>
										<td><span class="stock-level critical">OUT OF STOCK</span></td>
										<td>
											<div>
												<strong>Min: 5</strong>
												<div class="text-muted small">Max: 20</div>
												<div class="text-danger small">Reorder: 15 units</div>
											</div>
										</td>
										<td>
											<div class="supplier-info">
												<strong>Exotic Plants Inc.</strong>
												<div class="text-muted small">Lead time: 5-7 days</div>
												<div class="text-muted small">Last order: Dec 20, 2023</div>
												<div class="text-muted small">Cost: $25.00/unit</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Sale</strong>
												<div class="text-muted small">Jan 12, 2024</div>
												<div class="text-muted small">-1 unit</div>
												<div class="text-danger small">5 days ago</div>
											</div>
										</td>
										<td>
											<div>
												<strong>$0.00</strong>
												<div class="text-muted small">Unit: $45.00</div>
												<div class="text-danger small">Lost sales risk</div>
											</div>
										</td>
										<td>
											<div class="btn-group-vertical" role="group">
												<button class="btn btn-sm btn-danger" onclick="urgentReorder(1)">
													<i class="fas fa-exclamation-triangle"></i> Urgent Order
												</button>
												<a href="stock-adjustment.jsp?id=1" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i> Adjust
												</a>
												<a href="inventory-history.jsp?id=1" class="btn btn-sm btn-outline-info">
													<i class="fas fa-history"></i> History
												</a>
											</div>
										</td>
									</tr>

									<!-- Item 2: Low Stock - Wedding Bouquet -->
									<tr class="table-warning">
										<td><input type="checkbox" class="form-check-input item-checkbox" value="2"></td>
										<td>
											<div>
												<strong>Premium Wedding Bouquet</strong>
												<div class="text-muted small">SKU: WB-001</div>
												<div class="text-muted small">Location: Main Warehouse</div>
												<div class="text-muted small">Category: Wedding Flowers</div>
											</div>
										</td>
										<td>
											<div class="text-center">
												<strong class="text-warning">5</strong>
												<div class="text-muted small">units</div>
												<div class="stock-progress mt-1">
													<div class="progress-bar low" style="width: 25%"></div>
												</div>
											</div>
										</td>
										<td><span class="stock-level low">LOW STOCK</span></td>
										<td>
											<div>
												<strong>Min: 10</strong>
												<div class="text-muted small">Max: 30</div>
												<div class="text-warning small">Reorder: 25 units</div>
											</div>
										</td>
										<td>
											<div class="supplier-info">
												<strong>Flower Paradise</strong>
												<div class="text-muted small">Lead time: 2-3 days</div>
												<div class="text-muted small">Last order: Jan 5, 2024</div>
												<div class="text-muted small">Cost: $85.00/unit</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Sale</strong>
												<div class="text-muted small">Jan 15, 2024</div>
												<div class="text-muted small">-1 unit</div>
												<div class="text-success small">Today</div>
											</div>
										</td>
										<td>
											<div>
												<strong>$750.00</strong>
												<div class="text-muted small">Unit: $150.00</div>
												<div class="text-warning small">High demand item</div>
											</div>
										</td>
										<td>
											<div class="btn-group-vertical" role="group">
												<button class="btn btn-sm btn-warning" onclick="createReorder(2)">
													<i class="fas fa-shopping-cart"></i> Reorder
												</button>
												<a href="stock-adjustment.jsp?id=2" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i> Adjust
												</a>
												<a href="inventory-history.jsp?id=2" class="btn btn-sm btn-outline-info">
													<i class="fas fa-history"></i> History
												</a>
											</div>
										</td>
									</tr>

									<!-- Item 3: Normal Stock - Red Roses -->
									<tr>
										<td><input type="checkbox" class="form-check-input item-checkbox" value="3"></td>
										<td>
											<div>
												<strong>Red Roses (12 pieces)</strong>
												<div class="text-muted small">SKU: RR-012</div>
												<div class="text-muted small">Location: Cold Storage</div>
												<div class="text-muted small">Category: Cut Flowers</div>
											</div>
										</td>
										<td>
											<div class="text-center">
												<strong class="text-success">45</strong>
												<div class="text-muted small">units</div>
												<div class="stock-progress mt-1">
													<div class="progress-bar normal" style="width: 75%"></div>
												</div>
											</div>
										</td>
										<td><span class="stock-level normal">NORMAL</span></td>
										<td>
											<div>
												<strong>Min: 20</strong>
												<div class="text-muted small">Max: 60</div>
												<div class="text-success small">Stock OK</div>
											</div>
										</td>
										<td>
											<div class="supplier-info">
												<strong>Rose Garden Co.</strong>
												<div class="text-muted small">Lead time: 1-2 days</div>
												<div class="text-muted small">Last order: Jan 12, 2024</div>
												<div class="text-muted small">Cost: $12.00/unit</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Received</strong>
												<div class="text-muted small">Jan 14, 2024</div>
												<div class="text-muted small">+20 units</div>
												<div class="text-success small">1 day ago</div>
											</div>
										</td>
										<td>
											<div>
												<strong>$1,125.00</strong>
												<div class="text-muted small">Unit: $25.00</div>
												<div class="text-success small">Best seller</div>
											</div>
										</td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="stock-adjustment.jsp?id=3" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i> Adjust
												</a>
												<a href="inventory-history.jsp?id=3" class="btn btn-sm btn-outline-info">
													<i class="fas fa-history"></i> History
												</a>
												<button class="btn btn-sm btn-outline-success" onclick="viewDetails(3)">
													<i class="fas fa-eye"></i> Details
												</button>
											</div>
										</td>
									</tr>

									<!-- Item 4: High Stock - Yellow Tulips -->
									<tr>
										<td><input type="checkbox" class="form-check-input item-checkbox" value="4"></td>
										<td>
											<div>
												<strong>Yellow Tulips (10 pieces)</strong>
												<div class="text-muted small">SKU: YT-010</div>
												<div class="text-muted small">Location: Cold Storage</div>
												<div class="text-muted small">Category: Cut Flowers</div>
											</div>
										</td>
										<td>
											<div class="text-center">
												<strong class="text-info">85</strong>
												<div class="text-muted small">units</div>
												<div class="stock-progress mt-1">
													<div class="progress-bar high" style="width: 95%"></div>
												</div>
											</div>
										</td>
										<td><span class="stock-level high">OVERSTOCKED</span></td>
										<td>
											<div>
												<strong>Min: 15</strong>
												<div class="text-muted small">Max: 50</div>
												<div class="text-info small">Excess: 35 units</div>
											</div>
										</td>
										<td>
											<div class="supplier-info">
												<strong>Dutch Flowers Ltd.</strong>
												<div class="text-muted small">Lead time: 3-5 days</div>
												<div class="text-muted small">Last order: Jan 10, 2024</div>
												<div class="text-muted small">Cost: $9.00/unit</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Received</strong>
												<div class="text-muted small">Jan 10, 2024</div>
												<div class="text-muted small">+50 units</div>
												<div class="text-muted small">5 days ago</div>
											</div>
										</td>
										<td>
											<div>
												<strong>$1,530.00</strong>
												<div class="text-muted small">Unit: $18.00</div>
												<div class="text-info small">Promotion candidate</div>
											</div>
										</td>
										<td>
											<div class="btn-group-vertical" role="group">
												<button class="btn btn-sm btn-info" onclick="createPromotion(4)">
													<i class="fas fa-percent"></i> Promote
												</button>
												<a href="stock-adjustment.jsp?id=4" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i> Adjust
												</a>
												<button class="btn btn-sm btn-outline-warning" onclick="transferStock(4)">
													<i class="fas fa-exchange-alt"></i> Transfer
												</button>
											</div>
										</td>
									</tr>

									<!-- Item 5: Normal Stock - Seasonal Arrangement -->
									<tr>
										<td><input type="checkbox" class="form-check-input item-checkbox" value="5"></td>
										<td>
											<div>
												<strong>Spring Seasonal Arrangement</strong>
												<div class="text-muted small">SKU: SA-SPR24</div>
												<div class="text-muted small">Location: Display Area</div>
												<div class="text-muted small">Category: Seasonal</div>
											</div>
										</td>
										<td>
											<div class="text-center">
												<strong class="text-success">15</strong>
												<div class="text-muted small">units</div>
												<div class="stock-progress mt-1">
													<div class="progress-bar normal" style="width: 60%"></div>
												</div>
											</div>
										</td>
										<td><span class="stock-level normal">NORMAL</span></td>
										<td>
											<div>
												<strong>Min: 8</strong>
												<div class="text-muted small">Max: 25</div>
												<div class="text-success small">Stock OK</div>
											</div>
										</td>
										<td>
											<div class="supplier-info">
												<strong>Seasonal Blooms</strong>
												<div class="text-muted small">Lead time: 2-4 days</div>
												<div class="text-muted small">Last order: Jan 14, 2024</div>
												<div class="text-muted small">Cost: $35.00/unit</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Received</strong>
												<div class="text-muted small">Jan 15, 2024</div>
												<div class="text-muted small">+10 units</div>
												<div class="text-success small">Today</div>
											</div>
										</td>
										<td>
											<div>
												<strong>$975.00</strong>
												<div class="text-muted small">Unit: $65.00</div>
												<div class="text-success small">Seasonal item</div>
											</div>
										</td>
										<td>
											<div class="btn-group-vertical" role="group">
												<a href="stock-adjustment.jsp?id=5" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i> Adjust
												</a>
												<a href="inventory-history.jsp?id=5" class="btn btn-sm btn-outline-info">
													<i class="fas fa-history"></i> History
												</a>
												<button class="btn btn-sm btn-outline-success" onclick="viewDetails(5)">
													<i class="fas fa-eye"></i> Details
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
								<button class="btn btn-outline-primary btn-sm" onclick="bulkAdjustment()" disabled id="bulkAdjustBtn">
									<i class="fas fa-edit me-2"></i>Bulk Adjustment
								</button>
								<button class="btn btn-outline-success btn-sm" onclick="bulkReorder()" disabled id="bulkReorderBtn">
									<i class="fas fa-shopping-cart me-2"></i>Bulk Reorder
								</button>
								<button class="btn btn-outline-info btn-sm" onclick="bulkTransfer()" disabled id="bulkTransferBtn">
									<i class="fas fa-exchange-alt me-2"></i>Transfer Stock
								</button>
								<button class="btn btn-outline-warning btn-sm" onclick="bulkPromotion()" disabled id="bulkPromotionBtn">
									<i class="fas fa-percent me-2"></i>Create Promotion
								</button>
							</div>
							<div class="text-muted">
								Showing 1 to 5 of 248 items
							</div>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="Inventory pagination" class="mt-3">
							<ul class="pagination">
								<li class="page-item disabled">
									<a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
								</li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="inventory.jsp?page=2">2</a></li>
								<li class="page-item"><a class="page-link" href="inventory.jsp?page=3">3</a></li>
								<li class="page-item"><a class="page-link" href="inventory.jsp?page=4">4</a></li>
								<li class="page-item"><a class="page-link" href="inventory.jsp?page=5">5</a></li>
								<li class="page-item">
									<a class="page-link" href="inventory.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
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
