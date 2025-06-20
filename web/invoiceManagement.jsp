<%-- 
    Document   : invoiceManagement
    Created on : Jun 16, 2025, 9:46:37 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Quản Lý Hóa Đơn | Flower Shop</title>
	
	<!-- External CSS -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap&subset=vietnamese" rel="stylesheet">
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
		
		body { 
			font-family: 'Inter', 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif; 
			background: var(--light-gray); 
			margin: 0; 
			padding: 0; 
		}
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
		
		/* ===== INVOICE SPECIFIC STYLES ===== */
		.invoice-status {
			padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
		}
		.invoice-status.paid { background: #d4edda; color: #155724; }
		.invoice-status.pending { background: #fff3cd; color: #856404; }
		.invoice-status.overdue { background: #f8d7da; color: #721c24; }
		.invoice-status.cancelled { background: #e2e3e5; color: #383d41; }
		.invoice-status.draft { background: #cce5ff; color: #004085; }
		
		.payment-method {
			padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
		}
		.payment-method.cash { background: #e8f5e8; color: #388e3c; }
		.payment-method.card { background: #e3f2fd; color: #1976d2; }
		.payment-method.transfer { background: #f3e5f5; color: #7b1fa2; }
		.payment-method.online { background: #fff3e0; color: #f57c00; }
		
		.invoice-amount {
			font-size: 1.1rem; font-weight: 700;
		}
		.invoice-amount.paid { color: #28a745; }
		.invoice-amount.pending { color: #ffc107; }
		.invoice-amount.overdue { color: #dc3545; }
		
		.invoice-summary {
			background: white; border-radius: 10px; padding: 1.5rem;
			box-shadow: 0 2px 10px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
		}
		
		.summary-item {
			text-align: center; padding: 1rem;
		}
		.summary-number {
			font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem;
		}
		
		.invoice-actions {
			display: flex; gap: 0.5rem; flex-wrap: wrap;
		}
		
		.invoice-preview {
			max-width: 200px; border: 1px solid #dee2e6; border-radius: 8px;
			padding: 1rem; background: white; font-size: 0.8rem;
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
					<div class="input-group" style="width: 300px;">
						<input type="text" class="form-control" placeholder="Tìm kiếm hóa đơn..." id="invoiceSearch">
						<button class="btn btn-outline-secondary" onclick="searchInvoices()"><i class="fas fa-search"></i></button>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<a href="create-invoice.jsp" class="btn btn-primary">
							<i class="fas fa-plus me-2"></i>Tạo Hóa Đơn Mới
						</a>
						<button class="btn btn-success" onclick="exportInvoices()">
							<i class="fas fa-file-export me-2"></i>Xuất Excel
						</button>
						<button class="btn btn-outline-secondary" onclick="printInvoices()">
							<i class="fas fa-print me-2"></i>In Hóa Đơn
						</button>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Quản Lý Hóa Đơn</h2>
						<p class="text-muted">Quản lý và theo dõi tất cả hóa đơn bán hàng</p>
					</div>
					<div class="text-muted">
						Tổng số hóa đơn: <strong>156</strong> | Hôm nay: <strong>12</strong>
					</div>
				</div>

				<!-- ===== INVOICE STATISTICS ===== -->
				<div class="invoice-summary">
					<div class="row">
						<div class="col-md-3">
							<div class="summary-item">
								<div class="summary-number text-success">89</div>
								<div class="text-muted">Đã Thanh Toán</div>
								<div class="text-success small">+12 hôm nay</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="summary-item">
								<div class="summary-number text-warning">34</div>
								<div class="text-muted">Chờ Thanh Toán</div>
								<div class="text-warning small">+3 hôm nay</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="summary-item">
								<div class="summary-number text-danger">18</div>
								<div class="text-muted">Quá Hạn</div>
								<div class="text-danger small">+2 hôm nay</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="summary-item">
								<div class="summary-number text-info">15</div>
								<div class="text-muted">Bản Nháp</div>
								<div class="text-info small">+1 hôm nay</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== FILTER SECTION ===== -->
				<div class="card mb-4">
					<div class="card-body">
						<div class="row align-items-center">
							<div class="col-md-3">
								<label class="form-label">Trạng Thái Hóa Đơn:</label>
								<select class="form-select" onchange="filterByStatus(this.value)">
									<option value="">Tất Cả Trạng Thái</option>
									<option value="paid">Đã Thanh Toán (89)</option>
									<option value="pending">Chờ Thanh Toán (34)</option>
									<option value="overdue">Quá Hạn (18)</option>
									<option value="cancelled">Đã Hủy (12)</option>
									<option value="draft">Bản Nháp (15)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Phương Thức Thanh Toán:</label>
								<select class="form-select" onchange="filterByPaymentMethod(this.value)">
									<option value="">Tất Cả Phương Thức</option>
									<option value="cash">Tiền Mặt (45)</option>
									<option value="card">Thẻ Tín Dụng (38)</option>
									<option value="transfer">Chuyển Khoản (28)</option>
									<option value="online">Thanh Toán Online (12)</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Khoảng Thời Gian:</label>
								<select class="form-select" onchange="filterByDateRange(this.value)">
									<option value="">Tất Cả Thời Gian</option>
									<option value="today">Hôm Nay</option>
									<option value="yesterday">Hôm Qua</option>
									<option value="week">Tuần Này</option>
									<option value="month">Tháng Này</option>
									<option value="quarter">Quý Này</option>
								</select>
							</div>
							<div class="col-md-3">
								<label class="form-label">Khách Hàng:</label>
								<select class="form-select" onchange="filterByCustomer(this.value)">
									<option value="">Tất Cả Khách Hàng</option>
									<option value="vip">Khách VIP (25)</option>
									<option value="regular">Khách Thường (89)</option>
									<option value="new">Khách Mới (42)</option>
								</select>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== INVOICES TABLE ===== -->
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<h5 class="mb-0">Danh Sách Hóa Đơn</h5>
						<div class="d-flex align-items-center gap-3">
							<span class="text-light">Hiển thị:</span>
							<select class="form-select form-select-sm" style="width: auto;">
								<option value="25" selected>25</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							<span class="text-light">mục</span>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" class="form-check-input" onchange="selectAllInvoices(this)"></th>
										<th>Mã Hóa Đơn</th>
										<th>Khách Hàng</th>
										<th>Ngày Tạo</th>
										<th>Hạn Thanh Toán</th>
										<th>Tổng Tiền</th>
										<th>Trạng Thái</th>
										<th>Phương Thức</th>
										<th>Thao Tác</th>
									</tr>
								</thead>
								<tbody>
									<!-- Invoice 1: Paid -->
									<tr>
										<td><input type="checkbox" class="form-check-input invoice-checkbox" value="1"></td>
										<td>
											<div>
												<strong>HD-2024-001</strong>
												<div class="text-muted small">Đơn hàng: #ORD-2024-001</div>
											</div>
										</td>
										<td>
											<div>
												<strong>Nguyễn Thị Mai</strong>
												<div class="text-muted small">mai.nguyen@email.com</div>
												<div class="text-muted small">0901234567</div>
											</div>
										</td>
										<td>
											<div>
												<strong>15/01/2024</strong>
												<div class="text-muted small">09:30 AM</div>
											</div>
										</td>
										<td>
											<div>
												<strong>22/01/2024</strong>
												<div class="text-success small">Còn 7 ngày</div>
											</div>
										</td>
										<td>
											<div class="invoice-amount paid">1.200.000₫</div>
											<div class="text-muted small">Đã thanh toán</div>
										</td>
										<td><span class="invoice-status paid">Đã Thanh Toán</span></td>
										<td><span class="payment-method card">Thẻ Tín Dụng</span></td>
										<td>
											<div class="invoice-actions">
												<a href="invoice-details.jsp?id=1" class="btn btn-sm btn-outline-primary" title="Xem Chi Tiết">
													<i class="fas fa-eye"></i>
												</a>
												<button class="btn btn-sm btn-outline-success" onclick="printInvoice(1)" title="In Hóa Đơn">
													<i class="fas fa-print"></i>
												</button>
												<button class="btn btn-sm btn-outline-info" onclick="sendInvoice(1)" title="Gửi Email">
													<i class="fas fa-envelope"></i>
												</button>
												<a href="edit-invoice.jsp?id=1" class="btn btn-sm btn-outline-warning" title="Chỉnh Sửa">
													<i class="fas fa-edit"></i>
												</a>
											</div>
										</td>
									</tr>

									

						<!-- ===== BULK ACTIONS ===== -->
						<div class="d-flex justify-content-between align-items-center mt-3">
							<div>
								<button class="btn btn-outline-success btn-sm" onclick="bulkMarkAsPaid()" disabled id="bulkPaidBtn">
									<i class="fas fa-check me-2"></i>Đánh Dấu Đã Thanh Toán
								</button>
								<button class="btn btn-outline-info btn-sm" onclick="bulkSendReminder()" disabled id="bulkReminderBtn">
									<i class="fas fa-bell me-2"></i>Gửi Nhắc Nhở
								</button>
								<button class="btn btn-outline-primary btn-sm" onclick="bulkPrint()" disabled id="bulkPrintBtn">
									<i class="fas fa-print me-2"></i>In Hóa Đơn
								</button>
								<button class="btn btn-outline-danger btn-sm" onclick="bulkCancel()" disabled id="bulkCancelBtn">
									<i class="fas fa-times me-2"></i>Hủy Hóa Đơn
								</button>
							</div>
							<div class="text-muted">
								Hiển thị 1 đến 5 trong tổng số 156 hóa đơn
							</div>
						</div>

						<!-- ===== PAGINATION ===== -->
						<nav aria-label="Invoice pagination" class="mt-3">
							<ul class="pagination">
								<li class="page-item disabled">
									<a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
								</li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="invoices.jsp?page=2">2</a></li>
								<li class="page-item"><a class="page-link" href="invoices.jsp?page=3">3</a></li>
								<li class="page-item"><a class="page-link" href="invoices.jsp?page=4">4</a></li>
								<li class="page-item">
									<a class="page-link" href="invoices.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
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
		// ===== INVOICE MANAGEMENT FUNCTIONALITY =====
		
		// Search invoices
		function searchInvoices() {
			const searchTerm = document.getElementById('invoiceSearch').value;
			console.log('Tìm kiếm hóa đơn:', searchTerm);
			// Implementation would filter invoices based on search term
		}
		
		// Filter functions
		function filterByStatus(status) { console.log('Lọc theo trạng thái:', status); }
		function filterByPaymentMethod(method) { console.log('Lọc theo phương thức:', method); }
		function filterByDateRange(range) { console.log('Lọc theo thời gian:', range); }
		function filterByCustomer(customer) { console.log('Lọc theo khách hàng:', customer); }
		
		// Invoice actions
		function printInvoice(invoiceId) {
			console.log('In hóa đơn:', invoiceId);
			window.open(`print-invoice.jsp?id=${invoiceId}`, '_blank');
		}
		
		function sendInvoice(invoiceId) {
			console.log('Gửi hóa đơn qua email:', invoiceId);
			if (confirm('Gửi hóa đơn này qua email cho khách hàng?')) {
				alert('Hóa đơn đã được gửi thành công!');
			}
		}
		
		function markAsPaid(invoiceId) {
			if (confirm('Đánh dấu hóa đơn này là đã thanh toán?')) {
				console.log('Đánh dấu đã thanh toán:', invoiceId);
				alert('Hóa đơn đã được cập nhật trạng thái!');
				location.reload();
			}
		}
		
		function sendReminder(invoiceId) {
			console.log('Gửi nhắc nhở:', invoiceId);
			if (confirm('Gửi email nhắc nhở thanh toán cho khách hàng?')) {
				alert('Email nhắc nhở đã được gửi!');
			}
		}
		
		function sendUrgentReminder(invoiceId) {
			console.log('Gửi nhắc nhở khẩn cấp:', invoiceId);
			if (confirm('Gửi thông báo khẩn cấp về hóa đơn quá hạn?')) {
				alert('Thông báo khẩn cấp đã được gửi!');
			}
		}
		
		function negotiatePayment(invoiceId) {
			console.log('Thương lượng thanh toán:', invoiceId);
			window.location.href = `payment-negotiation.jsp?invoiceId=${invoiceId}`;
		}
		
		function finalizeInvoice(invoiceId) {
			if (confirm('Hoàn tất hóa đơn này và gửi cho khách hàng?')) {
				console.log('Hoàn tất hóa đơn:', invoiceId);
				alert('Hóa đơn đã được hoàn tất và gửi!');
				location.reload();
			}
		}
		
		function deleteInvoice(invoiceId) {
			if (confirm('Xóa hóa đơn này? Hành động này không thể hoàn tác.')) {
				console.log('Xóa hóa đơn:', invoiceId);
				alert('Hóa đơn đã được xóa!');
				location.reload();
			}
		}
		
		function viewCancelReason(invoiceId) {
			console.log('Xem lý do hủy:', invoiceId);
			alert('Lý do hủy: Khách hàng thay đổi ý định, không cần sản phẩm nữa.');
		}
		
		function recreateInvoice(invoiceId) {
			if (confirm('Tạo lại hóa đơn mới dựa trên hóa đơn đã hủy này?')) {
				console.log('Tạo lại hóa đơn:', invoiceId);
				window.location.href = `create-invoice.jsp?baseId=${invoiceId}`;
			}
		}
		
		// Bulk actions
		function selectAllInvoices(checkbox) {
			const invoiceCheckboxes = document.querySelectorAll('.invoice-checkbox');
			invoiceCheckboxes.forEach(cb => cb.checked = checkbox.checked);
			updateBulkActionButtons();
		}
		
		function updateBulkActionButtons() {
			const selectedInvoices = document.querySelectorAll('.invoice-checkbox:checked');
			const bulkButtons = ['bulkPaidBtn', 'bulkReminderBtn', 'bulkPrintBtn', 'bulkCancelBtn'];
			
			bulkButtons.forEach(btnId => {
				document.getElementById(btnId).disabled = selectedInvoices.length === 0;
			});
		}
		
		function bulkMarkAsPaid() {
			const selected = document.querySelectorAll('.invoice-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			if (confirm(`Đánh dấu ${ids.length} hóa đơn đã chọn là đã thanh toán?`)) {
				console.log('Bulk đánh dấu đã thanh toán:', ids);
				alert('Các hóa đơn đã được cập nhật!');
				location.reload();
			}
		}
		
		function bulkSendReminder() {
			const selected = document.querySelectorAll('.invoice-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			if (confirm(`Gửi email nhắc nhở cho ${ids.length} hóa đơn đã chọn?`)) {
				console.log('Bulk gửi nhắc nhở:', ids);
				alert('Email nhắc nhở đã được gửi!');
			}
		}
		
		function bulkPrint() {
			const selected = document.querySelectorAll('.invoice-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			console.log('Bulk in hóa đơn:', ids);
			window.open(`bulk-print-invoices.jsp?ids=${ids.join(',')}`, '_blank');
		}
		
		function bulkCancel() {
			const selected = document.querySelectorAll('.invoice-checkbox:checked');
			const ids = Array.from(selected).map(cb => cb.value);
			if (confirm(`Hủy ${ids.length} hóa đơn đã chọn? Hành động này không thể hoàn tác.`)) {
				console.log('Bulk hủy hóa đơn:', ids);
				alert('Các hóa đơn đã được hủy!');
				location.reload();
			}
		}
		
		// Export and print functions
		function exportInvoices() {
			console.log('Xuất danh sách hóa đơn...');
			window.location.href = 'export-invoices.jsp?format=excel';
		}
		
		function printInvoices() {
			console.log('In danh sách hóa đơn...');
			window.print();
		}
		
		// Initialize page
		document.addEventListener('DOMContentLoaded', function() {
			// Add event listeners to invoice checkboxes
			document.querySelectorAll('.invoice-checkbox').forEach(checkbox => {
				checkbox.addEventListener('change', updateBulkActionButtons);
			});
			
			// Enable real-time search
			document.getElementById('invoiceSearch').addEventListener('keyup', function(e) {
				if (e.key === 'Enter') {
					searchInvoices();
				}
			});
			
			console.log('Trang quản lý hóa đơn đã được khởi tạo');
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
