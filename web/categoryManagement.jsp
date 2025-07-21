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
                    <a href="login.jsp" class="logout-link">
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
                        <li><a href="UserManagementServlet?action=search" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Người Dùng</a></li>

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
						<form method="get" action="category" class="d-flex" style="max-width: 350px;">
							<input type="hidden" name="action" value="management"/>
							<input type="hidden" name="status" value="${param.status}"/>
							<input type="hidden" name="sortBy" value="${param.sortBy}"/>
							<input type="hidden" name="sortOrder" value="${param.sortOrder}"/>
							<input type="text" class="form-control me-2" name="search" value="${param.search}" placeholder="Tìm kiếm danh mục..."/>
							<button type="submit" class="btn btn-outline-primary" style="color: #e4cbce; background-color: #c7606e; border: #c7606e;"><i class="fas fa-search"></i></button>
						</form>
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
						Tổng số danh mục: <strong>${totalCategories}</strong> | Hoạt động: <strong>${activeWithProduct}</strong>
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
						<div class="col-md-4">
							<div class="d-flex align-items-center">
								<label class="form-label mb-0 me-2">Trạng thái:</label>
								<select class="form-select" onchange="filterByStatus(this.value)">
									<option value="">Tất cả</option>
									<option value="active" ${param.status == 'active' ? 'selected' : ''}>Hoạt động (có sản phẩm)</option>
									<option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động (không có sản phẩm)</option>
								</select>
							</div>
						</div>
						<div class="col-md-4">
							<div class="d-flex align-items-center">
								<label class="form-label mb-0 me-2">Sắp xếp theo:</label>
								<select class="form-select" onchange="sortCategories(this.value)">
									<option value="">Mặc định</option>
									<option value="name_asc" ${param.sortBy == 'name' && param.sortOrder == 'asc' ? 'selected' : ''}>Tên A-Z</option>
									<option value="name_desc" ${param.sortBy == 'name' && param.sortOrder == 'desc' ? 'selected' : ''}>Tên Z-A</option>
									<option value="id_asc" ${param.sortBy == 'id' && param.sortOrder == 'asc' ? 'selected' : ''}>ID tăng dần</option>
									<option value="id_desc" ${param.sortBy == 'id' && param.sortOrder == 'desc' ? 'selected' : ''}>ID giảm dần</option>
									<option value="products_asc" ${param.sortBy == 'products' && param.sortOrder == 'asc' ? 'selected' : ''}>Số sản phẩm tăng dần</option>
									<option value="products_desc" ${param.sortBy == 'products' && param.sortOrder == 'desc' ? 'selected' : ''}>Số sản phẩm giảm dần</option>
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
										<th>Mã danh mục</th>
										<th>Tên danh mục</th>
										<th>Số sản phẩm</th>
										<th>Trạng thái</th>
										<th>Thao tác</th>
									</tr>
								</thead>
								<tbody>
			            <c:forEach var="category" items="${categories}">
                                        <tr>
                                            <td>
                                                <div>
                                                    <strong>ID: ${category.categoryId}</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${editId != null && category.categoryId == editId}">
                                                        <form action="category" method="post" class="d-flex align-items-center">
                                                            <input type="hidden" name="action" value="update" />
                                                            <input type="hidden" name="categoryId" value="${category.categoryId}" />
                                                            <input type="text" name="categoryName" class="form-control me-2" value="${category.categoryName}" required style="max-width: 200px;" maxlength="30" />
                                                            <button type="submit" class="btn btn-sm btn-success me-1">Lưu</button>
                                                            <a href="category?action=management" class="btn btn-sm btn-secondary">Hủy</a>
                                                        </form>
                                                        <c:if test="${not empty error && editId != null && category.categoryId == editId}">
                                                            <div class="text-danger small mb-2">${error}</div>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div>${category.categoryName}</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div>${category.productCount}</div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${category.productCount > 0}">
                                                        <span class="badge bg-success">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Không hoạt động</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <c:choose>
                                                        <c:when test="${editId != null && category.categoryId == editId}">
                                                            <!-- Đang edit, không hiện nút Sửa -->
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="category?action=management&editId=${category.categoryId}" class="btn btn-sm btn-outline-primary" title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button class="btn btn-sm btn-outline-danger" onclick="deleteCategory('${category.categoryId}')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
									<c:if test="${empty categories}">
										<tr>
											<td colspan="6" class="text-center">Không có danh mục nào!</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="Category pagination" class="mt-3">
							<ul class="pagination">
								<li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
									<a class="page-link" href="${pageContext.request.contextPath}/category?action=management&pageNum=${currentPage - 1}&search=${param.search}&status=${param.status}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}"><i class="fas fa-chevron-left"></i></a>
								</li>
								<c:forEach begin="1" end="${totalPages}" var="i">
									<li class="page-item ${currentPage == i ? 'active' : ''}">
										<a class="page-link" href="${pageContext.request.contextPath}/category?action=management&pageNum=${i}&search=${param.search}&status=${param.status}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">${i}</a>
									</li>
								</c:forEach>
								<li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
									<a class="page-link" href="${pageContext.request.contextPath}/category?action=management&pageNum=${currentPage + 1}&search=${param.search}&status=${param.status}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}"><i class="fas fa-chevron-right"></i></a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
				<div class="card mt-4">
    <div class="card-header text-dark" style="background: #bac2d6;">
        <h5 class="mb-0">Danh mục đã xóa</h5>
    </div>
    <div class="card-body">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Mã danh mục</th>
                    <th>Tên danh mục</th>
                    <th>Số sản phẩm</th>
                    <th>Khôi phục</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="cat" items="${deletedCategories}">
                <tr>
                    <td>${cat.categoryId}</td>
                    <td>${cat.categoryName}</td>
                    <td>${cat.productCount}</td>
                    <td>
                        <form action="category" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="restore" />
                            <input type="hidden" name="id" value="${cat.categoryId}" />
                            <button type="submit" class="btn btn-sm btn-success">Khôi phục</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty deletedCategories}">
                <tr><td colspan="4" class="text-center">Không có danh mục đã xóa mềm.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// ===== CATEGORY MANAGEMENT FUNCTIONALITY =====
		
		// Filter by status
		function filterByStatus(status) {
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('status', status);
			urlParams.set('action', 'management');
			urlParams.set('pageNum', '1'); // Reset to first page
			window.location.href = 'category?' + urlParams.toString();
		}
		
		// Sort categories
		function sortCategories(sortValue) {
			if (!sortValue) return;
			
			const [sortBy, sortOrder] = sortValue.split('_');
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('sortBy', sortBy);
			urlParams.set('sortOrder', sortOrder);
			urlParams.set('action', 'management');
			urlParams.set('pageNum', '1'); // Reset to first page
			window.location.href = 'category?' + urlParams.toString();
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
			const bulkDeleteBtn = document.getElementById('bulkDeleteBtn');
			
			if (bulkDeleteBtn) {
				bulkDeleteBtn.disabled = selectedProducts.length === 0;
			}
		}
		
		// Bulk delete categories
		function bulkDelete() {
			const selectedCheckboxes = document.querySelectorAll('.product-checkbox:checked');
			if (selectedCheckboxes.length === 0) {
				alert('Vui lòng chọn ít nhất một danh mục để xóa!');
				return;
			}
			
			if (confirm(`Bạn có chắc muốn xóa ${selectedCheckboxes.length} danh mục đã chọn?`)) {
				const form = document.createElement('form');
				form.method = 'post';
				form.action = 'category?action=bulkDelete';
				
				selectedCheckboxes.forEach(checkbox => {
					const input = document.createElement('input');
					input.type = 'hidden';
					input.name = 'categoryIds';
					input.value = checkbox.value;
					form.appendChild(input);
				});
				
				document.body.appendChild(form);
				form.submit();
			}
		}
		
		// Delete single category
		function deleteCategory(categoryId) {
			if (confirm('Bạn có chắc muốn xóa danh mục này?')) {
				const form = document.createElement('form');
				form.method = 'post';
				form.action = 'category?action=delete';
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

			// Highlight menu item based on URL path
			var path = window.location.pathname.toLowerCase();
			document.querySelectorAll('.sidebar-link').forEach(function(link) {
				link.classList.remove('active');
			});

			if (path.includes('/category')) {
				var categoryLink = document.getElementById('menu-categoryManagement');
				if (categoryLink) categoryLink.classList.add('active');
			} else if (path.includes('/productmanagement')) {
				var productLink = document.getElementById('menu-productManagement');
				if (productLink) productLink.classList.add('active');
			} else if (path.includes('/storagemanagement')) {
				var storageLink = document.getElementById('menu-storageManagement');
				if (storageLink) storageLink.classList.add('active');
			} else if (path.includes('/ordermanagement')) {
				var orderLink = document.getElementById('menu-orderManagement');
				if (orderLink) orderLink.classList.add('active');
			} else if (path.includes('/invoicemanagement')) {
				var invoiceLink = document.getElementById('menu-invoiceManagement');
				if (invoiceLink) invoiceLink.classList.add('active');
			} else if (path.includes('usermanagement.jsp')) {
				var userLink = document.getElementById('menu-userManagement');
				if (userLink) userLink.classList.add('active');
			} else if (path.includes('feedbackmanagement.jsp')) {
				var feedbackLink = document.getElementById('menu-feedbackManagement');
				if (feedbackLink) feedbackLink.classList.add('active');
			} else if (path.includes('notificationmanagement.jsp')) {
				var notificationLink = document.getElementById('menu-notificationManagement');
				if (notificationLink) notificationLink.classList.add('active');
			} else if (path.includes('/statistics')) {
				var managementLink = document.getElementById('menu-management');
				if (managementLink) managementLink.classList.add('active');
			}
		});
	</script>
</body>
</html>