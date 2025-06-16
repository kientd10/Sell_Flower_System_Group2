<%-- 
    Document   : categoryManagement
    Created on : Jun 16, 2025, 9:06:57 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Sales Reports | Flower Shop</title>
	
	<!-- External CSS -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
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
		
		/* ===== REPORTS SPECIFIC STYLES ===== */
		.metric-card {
			background: white; border-radius: 10px; padding: 1.5rem;
			box-shadow: 0 4px 15px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
			transition: transform 0.3s ease;
		}
		.metric-card:hover { transform: translateY(-3px); }
		
		.metric-value {
			font-size: 2.5rem; font-weight: 700; margin-bottom: 0.5rem;
		}
		
		.metric-change {
			font-size: 0.9rem; font-weight: 600;
		}
		.metric-change.positive { color: #28a745; }
		.metric-change.negative { color: #dc3545; }
		.metric-change.neutral { color: #6c757d; }
		
		.chart-container {
			position: relative; height: 400px; margin: 1rem 0;
		}
		
		.report-filter {
			background: white; border-radius: 10px; padding: 1.5rem;
			box-shadow: 0 4px 15px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
		}
		
		.period-selector {
			display: flex; gap: 0.5rem; margin-bottom: 1rem;
		}
		.period-btn {
			padding: 0.5rem 1rem; border: 1px solid #dee2e6; background: white;
			border-radius: 6px; cursor: pointer; transition: all 0.3s ease;
		}
		.period-btn.active { background: var(--primary-red); color: white; border-color: var(--primary-red); }
		.period-btn:hover { background: var(--light-gray); }
		
		.top-products {
			max-height: 400px; overflow-y: auto;
		}
		
		.product-item {
			display: flex; justify-content: space-between; align-items: center;
			padding: 1rem; border-bottom: 1px solid #e9ecef;
		}
		.product-item:last-child { border-bottom: none; }
		
		.product-rank {
			width: 30px; height: 30px; border-radius: 50%;
			display: flex; align-items: center; justify-content: center;
			font-weight: 700; color: white; margin-right: 1rem;
		}
		.product-rank.rank-1 { background: #ffd700; color: #2f3542; }
		.product-rank.rank-2 { background: #c0c0c0; color: #2f3542; }
		.product-rank.rank-3 { background: #cd7f32; color: white; }
		.product-rank.rank-other { background: var(--secondary-gray); }
		
		/* ===== RESPONSIVE DESIGN ===== */
		@media (max-width: 768px) {
			.sidebar { width: 250px; }
			.main-content { margin-left: 250px; width: calc(100% - 250px); }
			.content-area { padding: 1rem; }
			.chart-container { height: 300px; }
		}
	</style>
              
</head>

<body>
	<div class="wrapper">
		<!-- ===== SIDEBAR NAVIGATION ===== -->
		<nav class="sidebar">
			<a href="index.jsp" class="sidebar-brand">
				<i class="fas fa-seedling me-2"></i>Trang quản lí
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
					<div class="d-flex align-items-center gap-3">
						<h5 class="mb-0">Sales Analytics Dashboard</h5>
						<span class="badge bg-success">Real-time Data</span>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<button class="btn btn-outline-secondary" onclick="refreshData()">
							<i class="fas fa-sync-alt me-2"></i>Refresh
						</button>
						<button class="btn btn-success" onclick="exportReport()">
							<i class="fas fa-file-export me-2"></i>Export Report
						</button>
						<button class="btn btn-primary" onclick="scheduleReport()">
							<i class="fas fa-calendar me-2"></i>Schedule Report
						</button>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Sales Reports & Analytics</h2>
						<p class="text-muted">Comprehensive sales performance analysis and insights</p>
					</div>
					<div class="text-muted">
						Last updated: <strong><%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %></strong>
					</div>
				</div>

				<!-- ===== REPORT FILTERS ===== -->
				<div class="report-filter">
					<div class="row">
						<div class="col-md-12">
							<label class="form-label">Time Period:</label>
							<div class="period-selector">
								<button class="period-btn" onclick="setPeriod('today')">Today</button>
								<button class="period-btn" onclick="setPeriod('yesterday')">Yesterday</button>
								<button class="period-btn active" onclick="setPeriod('week')">This Week</button>
								<button class="period-btn" onclick="setPeriod('month')">This Month</button>
								<button class="period-btn" onclick="setPeriod('quarter')">This Quarter</button>
								<button class="period-btn" onclick="setPeriod('year')">This Year</button>
								<button class="period-btn" onclick="setPeriod('custom')">Custom Range</button>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-md-3">
							<label class="form-label">Date From:</label>
							<input type="date" class="form-control" id="dateFrom" value="2024-01-08">
						</div>
						<div class="col-md-3">
							<label class="form-label">Date To:</label>
							<input type="date" class="form-control" id="dateTo" value="2024-01-15">
						</div>
						<div class="col-md-3">
							<label class="form-label">Product Category:</label>
							<select class="form-select" onchange="filterByCategory(this.value)">
								<option value="">All Categories</option>
								<option value="cut-flowers">Cut Flowers</option>
								<option value="bouquets">Bouquets</option>
								<option value="wedding-flowers">Wedding Flowers</option>
								<option value="potted-plants">Potted Plants</option>
								<option value="seasonal">Seasonal</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Customer Segment:</label>
							<select class="form-select" onchange="filterBySegment(this.value)">
								<option value="">All Customers</option>
								<option value="vip">VIP Customers</option>
								<option value="premium">Premium</option>
								<option value="regular">Regular</option>
								<option value="new">New Customers</option>
							</select>
						</div>
					</div>
				</div>

				<!-- ===== KEY METRICS ===== -->
				<div class="row mb-4">
					<div class="col-xl-3 col-md-6">
						<div class="metric-card text-center">
							<i class="fas fa-dollar-sign fa-2x text-success mb-3"></i>
							<div class="metric-value text-success">$12,450</div>
							<div class="text-muted">Total Revenue</div>
							<div class="metric-change positive">
								<i class="fas fa-arrow-up"></i> +15.3% vs last week
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="metric-card text-center">
							<i class="fas fa-shopping-cart fa-2x text-primary mb-3"></i>
							<div class="metric-value text-primary">187</div>
							<div class="text-muted">Total Orders</div>
							<div class="metric-change positive">
								<i class="fas fa-arrow-up"></i> +8.7% vs last week
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="metric-card text-center">
							<i class="fas fa-chart-line fa-2x text-info mb-3"></i>
							<div class="metric-value text-info">$66.58</div>
							<div class="text-muted">Average Order Value</div>
							<div class="metric-change positive">
								<i class="fas fa-arrow-up"></i> +6.2% vs last week
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="metric-card text-center">
							<i class="fas fa-users fa-2x text-warning mb-3"></i>
							<div class="metric-value text-warning">89</div>
							<div class="text-muted">Unique Customers</div>
							<div class="metric-change positive">
								<i class="fas fa-arrow-up"></i> +12.1% vs last week
							</div>
						</div>
					</div>
				</div>

				<!-- ===== CHARTS SECTION ===== -->
				<div class="row mb-4">
					<!-- Sales Trend Chart -->
					<div class="col-lg-8">
						<div class="card">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h5 class="mb-0">Sales Trend Analysis</h5>
								<div class="btn-group" role="group">
									<button class="btn btn-sm btn-outline-light" onclick="changeChartView('daily')">Daily</button>
									<button class="btn btn-sm btn-outline-light active" onclick="changeChartView('weekly')">Weekly</button>
									<button class="btn btn-sm btn-outline-light" onclick="changeChartView('monthly')">Monthly</button>
								</div>
							</div>
							<div class="card-body">
								<div class="chart-container">
									<canvas id="salesTrendChart"></canvas>
								</div>
							</div>
						</div>
					</div>

					<!-- Top Products -->
					<div class="col-lg-4">
						<div class="card">
							<div class="card-header">
								<h5 class="mb-0">Top Selling Products</h5>
							</div>
							<div class="card-body">
								<div class="top-products">
									<div class="product-item">
										<div class="d-flex align-items-center">
											<div class="product-rank rank-1">1</div>
											<div>
												<strong>Red Roses (12 pcs)</strong>
												<div class="text-muted small">45 units sold</div>
											</div>
										</div>
										<div class="text-end">
											<strong>$1,125</strong>
											<div class="text-success small">+23%</div>
										</div>
									</div>
									<div class="product-item">
										<div class="d-flex align-items-center">
											<div class="product-rank rank-2">2</div>
											<div>
												<strong>Wedding Bouquet</strong>
												<div class="text-muted small">8 units sold</div>
											</div>
										</div>
										<div class="text-end">
											<strong>$1,200</strong>
											<div class="text-success small">+15%</div>
										</div>
									</div>
									<div class="product-item">
										<div class="d-flex align-items-center">
											<div class="product-rank rank-3">3</div>
											<div>
												<strong>Yellow Tulips</strong>
												<div class="text-muted small">32 units sold</div>
											</div>
										</div>
										<div class="text-end">
											<strong>$576</strong>
											<div class="text-success small">+8%</div>
										</div>
									</div>
									<div class="product-item">
										<div class="d-flex align-items-center">
											<div class="product-rank rank-other">4</div>
											<div>
												<strong>Orchid Pot</strong>
												<div class="text-muted small">12 units sold</div>
											</div>
										</div>
										<div class="text-end">
											<strong>$540</strong>
											<div class="text-danger small">-5%</div>
										</div>
									</div>
									<div class="product-item">
										<div class="d-flex align-items-center">
											<div class="product-rank rank-other">5</div>
											<div>
												<strong>Seasonal Arrangement</strong>
												<div class="text-muted small">15 units sold</div>
											</div>
										</div>
										<div class="text-end">
											<strong>$975</strong>
											<div class="text-success small">+18%</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== DETAILED ANALYTICS ===== -->
				<div class="row mb-4">
					<!-- Sales by Category -->
					<div class="col-lg-6">
						<div class="card">
							<div class="card-header">
								<h5 class="mb-0">Sales by Category</h5>
							</div>
							<div class="card-body">
								<div class="chart-container">
									<canvas id="categoryChart"></canvas>
								</div>
							</div>
						</div>
					</div>

					<!-- Customer Segments -->
					<div class="col-lg-6">
						<div class="card">
							<div class="card-header">
								<h5 class="mb-0">Revenue by Customer Segment</h5>
							</div>
							<div class="card-body">
								<div class="chart-container">
									<canvas id="customerSegmentChart"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== SALES PERFORMANCE TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">Detailed Sales Performance</h5>
						<button class="btn btn-sm btn-outline-light" onclick="exportTableData()">
							<i class="fas fa-download me-2"></i>Export Data
						</button>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>Product</th>
										<th>Category</th>
										<th>Units Sold</th>
										<th>Revenue</th>
										<th>Avg Price</th>
										<th>Growth</th>
										<th>Margin</th>
										<th>Performance</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<strong>Red Roses (12 pcs)</strong>
											<div class="text-muted small">SKU: RR-012</div>
										</td>
										<td><span class="badge bg-success">Cut Flowers</span></td>
										<td><strong>45</strong></td>
										<td><strong>$1,125.00</strong></td>
										<td>$25.00</td>
										<td><span class="text-success">+23.5%</span></td>
										<td><span class="text-success">52%</span></td>
										<td><span class="badge bg-success">Excellent</span></td>
									</tr>
									<tr>
										<td>
											<strong>Premium Wedding Bouquet</strong>
											<div class="text-muted small">SKU: WB-001</div>
										</td>
										<td><span class="badge bg-info">Wedding Flowers</span></td>
										<td><strong>8</strong></td>
										<td><strong>$1,200.00</strong></td>
										<td>$150.00</td>
										<td><span class="text-success">+15.2%</span></td>
										<td><span class="text-success">43%</span></td>
										<td><span class="badge bg-success">Excellent</span></td>
									</tr>
									<tr>
										<td>
											<strong>Yellow Tulips (10 pcs)</strong>
											<div class="text-muted small">SKU: YT-010</div>
										</td>
										<td><span class="badge bg-success">Cut Flowers</span></td>
										<td><strong>32</strong></td>
										<td><strong>$576.00</strong></td>
										<td>$18.00</td>
										<td><span class="text-success">+8.1%</span></td>
										<td><span class="text-success">50%</span></td>
										<td><span class="badge bg-primary">Good</span></td>
									</tr>
									<tr>
										<td>
											<strong>Purple Orchid Pot</strong>
											<div class="text-muted small">SKU: OP-001</div>
										</td>
										<td><span class="badge bg-warning">Potted Plants</span></td>
										<td><strong>12</strong></td>
										<td><strong>$540.00</strong></td>
										<td>$45.00</td>
										<td><span class="text-danger">-5.3%</span></td>
										<td><span class="text-success">44%</span></td>
										<td><span class="badge bg-warning">Average</span></td>
									</tr>
									<tr>
										<td>
											<strong>Spring Seasonal Arrangement</strong>
											<div class="text-muted small">SKU: SA-SPR24</div>
										</td>
										<td><span class="badge bg-secondary">Seasonal</span></td>
										<td><strong>15</strong></td>
										<td><strong>$975.00</strong></td>
										<td>$65.00</td>
										<td><span class="text-success">+18.7%</span></td>
										<td><span class="text-success">46%</span></td>
										<td><span class="badge bg-success">Excellent</span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// ===== SALES REPORTS FUNCTIONALITY =====
		
		// Initialize charts when page loads
		document.addEventListener('DOMContentLoaded', function() {
			initializeSalesTrendChart();
			initializeCategoryChart();
			initializeCustomerSegmentChart();
		});
		
		// Sales Trend Chart
		function initializeSalesTrendChart() {
			const ctx = document.getElementById('salesTrendChart').getContext('2d');
			new Chart(ctx, {
				type: 'line',
				data: {
					labels: ['Jan 8', 'Jan 9', 'Jan 10', 'Jan 11', 'Jan 12', 'Jan 13', 'Jan 14', 'Jan 15'],
					datasets: [{
						label: 'Revenue ($)',
						data: [1200, 1450, 1800, 1650, 2100, 1950, 2300, 2150],
						borderColor: '#dc3545',
						backgroundColor: 'rgba(220, 53, 69, 0.1)',
						tension: 0.4,
						fill: true
					}, {
						label: 'Orders',
						data: [18, 22, 28, 25, 32, 29, 35, 33],
						borderColor: '#28a745',
						backgroundColor: 'rgba(40, 167, 69, 0.1)',
						tension: 0.4,
						fill: true,
						yAxisID: 'y1'
					}]
				},
				options: {
					responsive: true,
					maintainAspectRatio: false,
					scales: {
						y: {
							type: 'linear',
							display: true,
							position: 'left',
							title: { display: true, text: 'Revenue ($)' }
						},
						y1: {
							type: 'linear',
							display: true,
							position: 'right',
							title: { display: true, text: 'Orders' },
							grid: { drawOnChartArea: false }
						}
					},
					plugins: {
						legend: { display: true, position: 'top' }
					}
				}
			});
		}
		
		// Category Chart
		function initializeCategoryChart() {
			const ctx = document.getElementById('categoryChart').getContext('2d');
			new Chart(ctx, {
				type: 'doughnut',
				data: {
					labels: ['Cut Flowers', 'Wedding Flowers', 'Potted Plants', 'Seasonal', 'Accessories'],
					datasets: [{
						data: [4200, 3800, 2100, 1500, 850],
						backgroundColor: [
							'#28a745',
							'#dc3545',
							'#ffc107',
							'#17a2b8',
							'#6c757d'
						],
						borderWidth: 2,
						borderColor: '#fff'
					}]
				},
				options: {
					responsive: true,
					maintainAspectRatio: false,
					plugins: {
						legend: { display: true, position: 'bottom' }
					}
				}
			});
		}
		
		// Customer Segment Chart
		function initializeCustomerSegmentChart() {
			const ctx = document.getElementById('customerSegmentChart').getContext('2d');
			new Chart(ctx, {
				type: 'bar',
				data: {
					labels: ['VIP', 'Premium', 'Regular', 'New'],
					datasets: [{
						label: 'Revenue ($)',
						data: [5200, 3800, 2650, 800],
						backgroundColor: [
							'#ffd700',
							'#dc3545',
							'#17a2b8',
							'#28a745'
						],
						borderWidth: 1
					}]
				},
				options: {
					responsive: true,
					maintainAspectRatio: false,
					scales: {
						y: {
							beginAtZero: true,
							title: { display: true, text: 'Revenue ($)' }
						}
					},
					plugins: {
						legend: { display: false }
					}
				}
			});
		}
		
		// Period selection
		function setPeriod(period) {
			// Remove active class from all buttons
			document.querySelectorAll('.period-btn').forEach(btn => btn.classList.remove('active'));
			// Add active class to clicked button
			event.target.classList.add('active');
			
			console.log('Setting period to:', period);
			// Implementation would update charts and data based on selected period
		}
		
		// Filter functions
		function filterByCategory(category) {
			console.log('Filtering by category:', category);
			// Implementation would filter data and update charts
		}
		
		function filterBySegment(segment) {
			console.log('Filtering by segment:', segment);
			// Implementation would filter data and update charts
		}
		
		// Chart view changes
		function changeChartView(view) {
			// Remove active class from all buttons
			document.querySelectorAll('.btn-group .btn').forEach(btn => btn.classList.remove('active'));
			// Add active class to clicked button
			event.target.classList.add('active');
			
			console.log('Changing chart view to:', view);
			// Implementation would update chart data based on view
		}
		
		// Export functions
		function exportReport() {
			console.log('Exporting sales report...');
			window.location.href = 'export-sales-report.jsp?format=pdf&period=week';
		}
		
		function exportTableData() {
			console.log('Exporting table data...');
			window.location.href = 'export-sales-data.jsp?format=excel';
		}
		
		function scheduleReport() {
			console.log('Scheduling report...');
			window.location.href = 'schedule-report.jsp?type=sales';
		}
		
		function refreshData() {
			console.log('Refreshing data...');
			// Implementation would refresh all charts and data via AJAX
			location.reload();
		}
		
		// Auto-refresh data every 5 minutes
		setInterval(function() {
			console.log('Auto-refreshing sales data...');
			// Implementation would refresh data via AJAX without page reload
		}, 300000);
                
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

