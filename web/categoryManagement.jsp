<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<!-- ===== SIDEBAR NAVIGATION ===== -->
		<nav class="sidebar">
			<a href="home" class="sidebar-brand" style="font-size:27px ; color: #d4d4d4">
				<i class="fas fa-seedling me-2" style="color: #dc3545;" ></i>Menu quản lý
			</a>

			<div class="sidebar-user">
				<div class="d-flex align-items-center">
					<div>
						<div style="font-weight: 600;">Quản lý</div>
						<small style="opacity: 0.8;">Chào mừng bạn đến trang quản lý!</small>
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
						<input type="text" class="form-control" placeholder="Search products..." id="productSearch">
						<button class="btn btn-outline-secondary" onclick="searchProducts()"><i class="fas fa-search"></i></button>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<a href="category?action=create" class="btn btn-primary">
							<i class="fas fa-plus me-2"></i>Thêm danh mục
						</a>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Quản lí danh mục hoa</h2>
						<p class="text-muted">Danh sách các danh mục hoa, thêm, sửa, xóa.</p>
					</div>
					<div class="text-muted">
						Tổng số danh mục: <strong>${categories != null ? categories.size() : 0}</strong> | Hoạt động: <strong>${categories != null ? categories.size() : 0}</strong>
					</div>
				</div>

				<!-- Hiển thị thông báo lỗi nếu có -->
				<c:if test="${not empty error}">
					<div class="alert alert-danger" role="alert">
						${error}
					</div>
				</c:if>

				<!-- ===== FILTER & CATEGORY SECTION ===== -->
				<div class="category-filter">
					<div class="row align-items-center">
						<div class="col-md-6">
							<div class="d-flex align-items-center gap-3">
								<label class="form-label mb-0">Lọc theo danh mục:</label>
								<select class="form-select" style="width: auto;" onchange="filterByCategory(this.value)">
									<option value="">Tất cả danh mục</option>
									<c:forEach var="category" items="${categories}">
										<option value="${category.categoryId}">${category.categoryName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== PRODUCT TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">Danh sách danh mục</h5>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover" id="productsTable">
								<thead>
									<tr>
										<th>
											<input type="checkbox" class="form-check-input" onchange="selectAllProducts(this)">
										</th>
										<th>Mã danh mục</th>
										<th>Tên danh mục</th>
										<th>Thao tác</th>
									</tr>
								</thead>
								<tbody>
			            <c:forEach var="category" items="${categories}">
                                        <tr>
                                            <td><input type="checkbox" class="form-check-input product-checkbox" value="${category.categoryId}"></td>
                                            <td>
                                                <div>
                                                    <strong>ID: ${category.categoryId}</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div>${category.categoryName}</div>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/category?action=update&id=${category.categoryId}" class="btn btn-sm btn-outline-primary" title="Sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-outline-danger" onclick="deleteCategory(${category.categoryId})" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
									<c:if test="${empty categories}">
										<tr>
											<td colspan="4" class="text-center">Không có danh mục nào!</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="Category pagination" class="mt-3">
							<ul class="pagination">
								<li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
									<a class="page-link" href="${pageContext.request.contextPath}/category?action=management&pageNum=${currentPage - 1}"><i class="fas fa-chevron-left"></i></a>
								</li>
								<c:forEach begin="1" end="${totalPages}" var="i">
									<li class="page-item ${currentPage == i ? 'active' : ''}">
										<a class="page-link" href="${pageContext.request.contextPath}/category?action=management&pageNum=${i}">${i}</a>
									</li>
								</c:forEach>
								<li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
									<a class="page-link" href="${pageContext.request.contextPath}/category?action=management&pageNum=${currentPage + 1}"><i class="fas fa-chevron-right"></i></a>
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
		// ===== CATEGORY MANAGEMENT FUNCTIONALITY =====
		
		// Search categories
		function searchProducts() {
			const searchTerm = document.getElementById('productSearch').value;
			// In real application, this would filter the table or make AJAX request
			console.log('Searching for:', searchTerm);
		}
		
		// Filter by category
		function filterByCategory(categoryId) {
			console.log('Filtering by category:', categoryId);
			// Implementation would filter table rows based on category
		}
		
		// Select all categories
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
				const btn = document.getElementById(btnId);
				if (btn) {
					btn.disabled = selectedProducts.length === 0;
				}
			});
		}
		
		// Delete category
		function deleteCategory(categoryId) {
			if (confirm('Bạn có chắc muốn xóa danh mục này?')) {
				const form = document.createElement('form');
				form.method = 'post';
				form.action = '${pageContext.request.contextPath}/category?action=delete';
				const input = document.createElement('input');
				input.type = 'hidden';
				input.name = 'id';
				input.value = categoryId;
				form.appendChild(input);
				document.body.appendChild(form);
				form.submit();
			}
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

			// Tự động highlight menu item dựa trên URL hiện tại
			var currentPage = window.location.pathname.split('/').pop();
			document.querySelectorAll('.sidebar-link').forEach(function(link) {
				link.classList.remove('active');
			});
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