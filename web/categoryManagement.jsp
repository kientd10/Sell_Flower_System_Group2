
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Product Management | Flower Shop</title>
	
	<!-- External CSS -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	
	<style>
		/* ===== SHARED STYLES (Same as index.jsp) ===== */
		:root {
			--primary-red: #dc3545;
			--primary-red-dark: #b02a37;
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
		
		.table th {
			background: var(--light-gray);
			font-weight: 600;
			border-top: none;
		}
		
		/* ===== PRODUCT SPECIFIC STYLES ===== */
		.product-image {
			width: 60px;
			height: 60px;
			object-fit: cover;
			border-radius: 8px;
			border: 2px solid #e9ecef;
			cursor: pointer;
			transition: transform 0.3s ease;
		}
		
		.product-image:hover {
			transform: scale(1.1);
			border-color: var(--primary-red);
		}
		
		.stock-badge {
			padding: 0.4rem 0.8rem;
			border-radius: 15px;
			font-size: 0.75rem;
			font-weight: 600;
		}
		.stock-badge.in-stock { background: #d4edda; color: #155724; }
		.stock-badge.low-stock { background: #fff3cd; color: #856404; }
		.stock-badge.out-of-stock { background: #f8d7da; color: #721c24; }
		
		.category-filter {
			background: white;
			border-radius: 8px;
			padding: 1rem;
			margin-bottom: 1.5rem;
			box-shadow: 0 2px 10px rgba(0,0,0,0.05);
		}
		
		/* ===== PAGINATION STYLES ===== */
		.pagination {
			justify-content: center;
			margin-top: 1.5rem;
		}
		
		.page-link {
			color: var(--primary-red);
			border-color: #dee2e6;
			padding: 0.6rem 0.8rem;
			margin: 0 2px;
			border-radius: 4px;
			font-weight: 500;
			transition: all 0.3s ease;
		}
		
		.page-link:hover {
			color: white;
			background-color: var(--primary-red);
			border-color: var(--primary-red);
			transform: translateY(-1px);
		}
		
		.page-item.active .page-link {
			background-color: var(--primary-red);
			border-color: var(--primary-red);
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
		<!-- ===== SIDEBAR NAVIGATION (Same as index.jsp) ===== -->
		<nav class="sidebar">
			<a href="index.jsp" class="sidebar-brand">
				<i class="fas fa-seedling me-2"></i>Quản lí
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
				<li class="sidebar-header">Menu</li>
                                <li><a href="management.jsp" class="sidebar-link "><i class="fas fa-chart-bar"></i>Thống kê</a></li>
				<li><a href="productManagement.jsp" class="sidebar-link"><i class="fas fa-boxes"></i>Quản lí sản phẩm</a></li>
                                <li><a href="categoryManagement.jsp" class="sidebar-link"><i class="fas fa-boxes"></i>Quản lí danh mục sản phẩm</a></li>
                                <li><a href="storageManagement.jsp" class="sidebar-link"><i class="fas fa-warehouse"></i>Quản lí kho hàng</a></li>
				<li><a href="orderManagement.jsp" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản lí đơn hàng</a></li>
				<li><a href="invoiceManagement.jsp" class="sidebar-link "><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>
                                
				<li class="sidebar-header">Hệ thống</li>
				<li><a href="userManagement.jsp" class="sidebar-link"><i class="fas fa-user-shield"></i>Quản lí tài khoản</a></li>
                                <li><a href="notificationManagement.jsp" class="sidebar-link"><i class="fas fa-bell"></i>Thông báo<span class="badge bg-danger ms-auto">4</span></a></li>
			</ul>
		</nav>

		<!-- ===== MAIN CONTENT AREA ===== -->
		<div class="main-content">
			<!-- Top Navigation Bar -->
			<div class="top-navbar">
				<div class="d-flex justify-content-between align-items-center">
					<div class="input-group" style="width: 300px;">
						<input type="text" class="form-control" placeholder="Search products..." id="productSearch">
						<button class="btn btn-outline-secondary" onclick="searchProducts()"><i class="fas fa-search"></i></button>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<a href="add-product.jsp" class="btn btn-primary">
							<i class="fas fa-plus me-2"></i>Add Product
						</a>
						<a href="import-products.jsp" class="btn btn-success">
							<i class="fas fa-file-import me-2"></i>Import Products
						</a>
						<button class="btn btn-outline-secondary" onclick="exportProducts()">
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
						<h2 class="page-title">Product Management</h2>
						<p class="text-muted">Manage your flower inventory and product catalog</p>
					</div>
					<div class="text-muted">
						Total Products: <strong>248</strong> | Active: <strong>235</strong>
					</div>
				</div>

				<!-- ===== FILTER & CATEGORY SECTION ===== -->
				<div class="category-filter">
					<div class="row align-items-center">
						<div class="col-md-6">
							<div class="d-flex align-items-center gap-3">
								<label class="form-label mb-0">Filter by Category:</label>
								<select class="form-select" style="width: auto;" onchange="filterByCategory(this.value)">
									<option value="">All Categories</option>
									<option value="cut-flowers">Cut Flowers (89)</option>
									<option value="bouquets">Bouquets (45)</option>
									<option value="potted-plants">Potted Plants (67)</option>
									<option value="wedding-flowers">Wedding Flowers (23)</option>
									<option value="funeral-flowers">Funeral Flowers (18)</option>
									<option value="seasonal">Seasonal Flowers (6)</option>
								</select>
							</div>
						</div>
						<div class="col-md-6">
							<div class="d-flex align-items-center gap-3 justify-content-end">
								<label class="form-label mb-0">Stock Status:</label>
								<select class="form-select" style="width: auto;" onchange="filterByStock(this.value)">
									<option value="">All Stock</option>
									<option value="in-stock">In Stock (223)</option>
									<option value="low-stock">Low Stock (12)</option>
									<option value="out-of-stock">Out of Stock (13)</option>
								</select>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== PRODUCT TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">Product Inventory</h5>
						<div class="d-flex align-items-center gap-3">
							<span class="text-light">Show:</span>
							<select class="form-select form-select-sm" style="width: auto;" onchange="changeEntriesPerPage(this.value)">
								<option value="10">10</option>
								<option value="25" selected>25</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="text-light">entries</span>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover" id="productsTable">
								<thead>
									<tr>
										<th>
											<input type="checkbox" class="form-check-input" onchange="selectAllProducts(this)">
										</th>
										<th>Image</th>
										<th>Product Info</th>
										<th>Category</th>
										<th>Price</th>
										<th>Stock</th>
										<th>Status</th>
										<th>Supplier</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<!-- Product 1: Premium Wedding Bouquet -->
									<tr>
										<td><input type="checkbox" class="form-check-input product-checkbox" value="1"></td>
										<td>
											<img src="https://via.placeholder.com/60x60/ff69b4/ffffff?text=WB" 
												 class="product-image" alt="Wedding Bouquet" 
												 onclick="viewProductImage(this.src)">
										</td>
										<td>
											<div>
												<strong>Premium Wedding Bouquet</strong>
												<div class="text-muted small">SKU: WB-001</div>
												<div class="text-muted small">Added: Jan 10, 2024</div>
											</div>
										</td>
										<td><span class="badge bg-info">Wedding Flowers</span></td>
										<td>
											<strong>$150.00</strong>
											<div class="text-muted small">Cost: $85.00</div>
										</td>
										<td>
											<strong>5</strong>
											<div class="text-muted small">Min: 10</div>
										</td>
										<td><span class="stock-badge low-stock">Low Stock</span></td>
										<td>
											<div>Flower Paradise</div>
											<div class="text-muted small">Last order: Jan 5</div>
										</td>
										<td>
											<div class="btn-group" role="group">
												<a href="edit-product.jsp?id=1" class="btn btn-sm btn-outline-primary" title="Edit">
													<i class="fas fa-edit"></i>
												</a>
												<a href="product-details.jsp?id=1" class="btn btn-sm btn-outline-info" title="View Details">
													<i class="fas fa-eye"></i>
												</a>
												<button class="btn btn-sm btn-outline-warning" onclick="restockProduct(1)" title="Restock">
													<i class="fas fa-plus"></i>
												</button>
												<button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(1)" title="Delete">
													<i class="fas fa-trash"></i>
												</button>
											</div>
										</td>
									</tr>

									<!-- Product 2: Red Roses -->
									<tr>
										<td><input type="checkbox" class="form-check-input product-checkbox" value="2"></td>
										<td>
											<img src="https://via.placeholder.com/60x60/ff6b6b/ffffff?text=RR" 
												 class="product-image" alt="Red Roses">
										</td>
										<td>
											<div>
												<strong>Red Roses (12 pieces)</strong>
												<div class="text-muted small">SKU: RR-012</div>
												<div class="text-muted small">Added: Jan 8, 2024</div>
											</div>
										</td>
										<td><span class="badge bg-success">Cut Flowers</span></td>
										<td>
											<strong>$25.00</strong>
											<div class="text-muted small">Cost: $12.00</div>
										</td>
										<td>
											<strong>45</strong>
											<div class="text-muted small">Min: 20</div>
										</td>
										<td><span class="stock-badge in-stock">In Stock</span></td>
										<td>
											<div>Rose Garden Co.</div>
											<div class="text-muted small">Last order: Jan 12</div>
										</td>
										<td>
											<div class="btn-group" role="group">
												<a href="edit-product.jsp?id=2" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i>
												</a>
												<a href="product-details.jsp?id=2" class="btn btn-sm btn-outline-info">
													<i class="fas fa-eye"></i>
												</a>
												<button class="btn btn-sm btn-outline-success" onclick="duplicateProduct(2)">
													<i class="fas fa-copy"></i>
												</button>
												<button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(2)">
													<i class="fas fa-trash"></i>
												</button>
											</div>
										</td>
									</tr>

									<!-- Product 3: Yellow Tulips -->
									<tr>
										<td><input type="checkbox" class="form-check-input product-checkbox" value="3"></td>
										<td>
											<img src="https://via.placeholder.com/60x60/ffd700/000000?text=YT" 
												 class="product-image" alt="Yellow Tulips">
										</td>
										<td>
											<div>
												<strong>Yellow Tulips (10 pieces)</strong>
												<div class="text-muted small">SKU: YT-010</div>
												<div class="text-muted small">Added: Jan 6, 2024</div>
											</div>
										</td>
										<td><span class="badge bg-success">Cut Flowers</span></td>
										<td>
											<strong>$18.00</strong>
											<div class="text-muted small">Cost: $9.00</div>
										</td>
										<td>
											<strong>32</strong>
											<div class="text-muted small">Min: 15</div>
										</td>
										<td><span class="stock-badge in-stock">In Stock</span></td>
										<td>
											<div>Dutch Flowers Ltd.</div>
											<div class="text-muted small">Last order: Jan 10</div>
										</td>
										<td>
											<div class="btn-group" role="group">
												<a href="edit-product.jsp?id=3" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i>
												</a>
												<a href="product-details.jsp?id=3" class="btn btn-sm btn-outline-info">
													<i class="fas fa-eye"></i>
												</a>
												<button class="btn btn-sm btn-outline-success" onclick="duplicateProduct(3)">
													<i class="fas fa-copy"></i>
												</button>
												<button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(3)">
													<i class="fas fa-trash"></i>
												</button>
											</div>
										</td>
									</tr>

									<!-- Product 4: Orchid Pot (Out of Stock) -->
									<tr>
										<td><input type="checkbox" class="form-check-input product-checkbox" value="4"></td>
										<td>
											<img src="https://via.placeholder.com/60x60/9370db/ffffff?text=OP" 
												 class="product-image" alt="Orchid Pot">
										</td>
										<td>
											<div>
												<strong>Purple Orchid Pot</strong>
												<div class="text-muted small">SKU: OP-001</div>
												<div class="text-muted small">Added: Dec 28, 2023</div>
											</div>
										</td>
										<td><span class="badge bg-warning">Potted Plants</span></td>
										<td>
											<strong>$45.00</strong>
											<div class="text-muted small">Cost: $25.00</div>
										</td>
										<td>
											<strong>0</strong>
											<div class="text-muted small">Min: 5</div>
										</td>
										<td><span class="stock-badge out-of-stock">Out of Stock</span></td>
										<td>
											<div>Exotic Plants Inc.</div>
											<div class="text-muted small">Last order: Dec 20</div>
										</td>
										<td>
											<div class="btn-group" role="group">
												<a href="edit-product.jsp?id=4" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i>
												</a>
												<a href="product-details.jsp?id=4" class="btn btn-sm btn-outline-info">
													<i class="fas fa-eye"></i>
												</a>
												<button class="btn btn-sm btn-danger" onclick="restockProduct(4)">
													<i class="fas fa-exclamation-triangle"></i> Urgent Restock
												</button>
											</div>
										</td>
									</tr>

									<!-- Product 5: Seasonal Arrangement -->
									<tr>
										<td><input type="checkbox" class="form-check-input product-checkbox" value="5"></td>
										<td>
											<img src="https://via.placeholder.com/60x60/ff4500/ffffff?text=SA" 
												 class="product-image" alt="Seasonal Arrangement">
										</td>
										<td>
											<div>
												<strong>Spring Seasonal Arrangement</strong>
												<div class="text-muted small">SKU: SA-SPR24</div>
												<div class="text-muted small">Added: Jan 15, 2024</div>
											</div>
										</td>
										<td><span class="badge bg-secondary">Seasonal</span></td>
										<td>
											<strong>$65.00</strong>
											<div class="text-muted small">Cost: $35.00</div>
										</td>
										<td>
											<strong>15</strong>
											<div class="text-muted small">Min: 8</div>
										</td>
										<td><span class="stock-badge in-stock">In Stock</span></td>
										<td>
											<div>Seasonal Blooms</div>
											<div class="text-muted small">Last order: Jan 14</div>
										</td>
										<td>
											<div class="btn-group" role="group">
												<a href="edit-product.jsp?id=5" class="btn btn-sm btn-outline-primary">
													<i class="fas fa-edit"></i>
												</a>
												<a href="product-details.jsp?id=5" class="btn btn-sm btn-outline-info">
													<i class="fas fa-eye"></i>
												</a>
												<button class="btn btn-sm btn-outline-success" onclick="duplicateProduct(5)">
													<i class="fas fa-copy"></i>
												</button>
												<button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(5)">
													<i class="fas fa-trash"></i>
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
								<button class="btn btn-outline-primary btn-sm" onclick="bulkEdit()" disabled id="bulkEditBtn">
									<i class="fas fa-edit me-2"></i>Bulk Edit
								</button>
								<button class="btn btn-outline-danger btn-sm" onclick="bulkDelete()" disabled id="bulkDeleteBtn">
									<i class="fas fa-trash me-2"></i>Bulk Delete
								</button>
								<button class="btn btn-outline-success btn-sm" onclick="bulkRestock()" disabled id="bulkRestockBtn">
									<i class="fas fa-plus me-2"></i>Bulk Restock
								</button>
							</div>
							<div class="text-muted">
								Showing 1 to 5 of 248 products
							</div>
						</div>

						<!-- ===== PAGINATION ===== */
						<nav aria-label="Product pagination" class="mt-3">
							<ul class="pagination">
								<li class="page-item disabled">
									<a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
								</li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="products.jsp?page=2">2</a></li>
								<li class="page-item"><a class="page-link" href="products.jsp?page=3">3</a></li>
								<li class="page-item"><a class="page-link" href="products.jsp?page=4">4</a></li>
								<li class="page-item"><a class="page-link" href="products.jsp?page=5">5</a></li>
								<li class="page-item">
									<a class="page-link" href="products.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
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
		// ===== PRODUCT MANAGEMENT FUNCTIONALITY =====
		
		// Search products
		function searchProducts() {
			const searchTerm = document.getElementById('productSearch').value;
			// In real application, this would filter the table or make AJAX request
			console.log('Searching for:', searchTerm);
		}
		
		// Filter by category
		function filterByCategory(category) {
			console.log('Filtering by category:', category);
			// Implementation would filter table rows based on category
		}
		
		// Filter by stock status
		function filterByStock(status) {
			console.log('Filtering by stock status:', status);
			// Implementation would filter table rows based on stock status
		}
		
		// Change entries per page
		function changeEntriesPerPage(count) {
			console.log('Showing', count, 'entries per page');
			// Implementation would update pagination and reload data
		}
		
		// Select all products
		function selectAllProducts(checkbox) {
			const productCheckboxes = document.querySelectorAll('.product-checkbox');
			productCheckboxes.forEach(cb => cb.checked = checkbox.checked);
			updateBulkActionButtons();
		}
		
		// Update bulk action buttons based on selection
		function updateBulkActionButtons() {
			const selectedProducts = document.querySelectorAll('.product-checkbox:checked');
			const bulkButtons = ['bulkEditBtn', 'bulkDeleteBtn', 'bulkRestockBtn'];
			
			bulkButtons.forEach(btnId => {
				document.getElementById(btnId).disabled = selectedProducts.length === 0;
			});
		}
		
		// Product actions
		function restockProduct(productId) {
			if (confirm('Redirect to restock page for product ID: ' + productId + '?')) {
				window.location.href = 'restock-product.jsp?id=' + productId;
			}
		}
		
		function deleteProduct(productId) {
			if (confirm('Are you sure you want to delete this product?')) {
				// In real application, this would make AJAX request to delete
				console.log('Deleting product:', productId);
				alert('Product deleted successfully!');
			}
		}
		
		function duplicateProduct(productId) {
			if (confirm('Create a copy of this product?')) {
				window.location.href = 'add-product.jsp?duplicate=' + productId;
			}
		}
		
		function viewProductImage(imageSrc) {
			// Create modal to view larger image
			alert('View larger image: ' + imageSrc);
		}
		
		// Bulk actions
		function bulkEdit() {
			const selected = document.querySelectorAll('.product-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = 'bulk-edit-products.jsp?ids=' + ids.join(',');
		}
		
		function bulkDelete() {
			const selected = document.querySelectorAll('.product-checkbox:checked');
			if (confirm(`Delete ${selected.length} selected products?`)) {
				console.log('Bulk deleting products');
			}
		}
		
		function bulkRestock() {
			const selected = document.querySelectorAll('.product-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			window.location.href = 'bulk-restock.jsp?ids=' + ids.join(',');
		}
		
		function exportProducts() {
			// Export products to CSV/Excel
			window.location.href = 'export-products.jsp?format=excel';
		}
		
		// Initialize page
		document.addEventListener('DOMContentLoaded', function() {
			// Add event listeners to product checkboxes
			document.querySelectorAll('.product-checkbox').forEach(checkbox => {
				checkbox.addEventListener('change', updateBulkActionButtons);
			});
			
			// Enable real-time search
			document.getElementById('productSearch').addEventListener('keyup', function(e) {
				if (e.key === 'Enter') {
					searchProducts();
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


