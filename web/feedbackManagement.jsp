<%-- 
    Document   : feedbackManagement
    Created on : Jun 16, 2025, 9:51:13 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Quản Lý Phản Hồi | Flower Shop</title>

<!-- External CSS -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap&subset=vietnamese" rel="stylesheet">
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
	
	/* ===== FEEDBACK SPECIFIC STYLES ===== */
	.feedback-status {
		padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
	}
	.feedback-status.new { background: #cce5ff; color: #004085; }
	.feedback-status.read { background: #e8f5e8; color: #388e3c; }
	.feedback-status.replied { background: #d4edda; color: #155724; }
	.feedback-status.resolved { background: #e2e3e5; color: #383d41; }
	.feedback-status.pending { background: #fff3cd; color: #856404; }
	
	.feedback-type {
		padding: 0.3rem 0.6rem; border-radius: 12px; font-size: 0.7rem; font-weight: 600;
	}
	.feedback-type.complaint { background: #f8d7da; color: #721c24; }
	.feedback-type.suggestion { background: #e3f2fd; color: #1976d2; }
	.feedback-type.compliment { background: #e8f5e8; color: #388e3c; }
	.feedback-type.question { background: #fff3e0; color: #f57c00; }
	.feedback-type.bug-report { background: #f3e5f5; color: #7b1fa2; }
	
	.rating-stars {
		color: #ffc107; font-size: 1.1rem;
	}
	.rating-stars .empty { color: #e9ecef; }
	
	.feedback-summary {
		background: white; border-radius: 10px; padding: 1.5rem;
		box-shadow: 0 2px 10px rgba(0,0,0,0.08); margin-bottom: 1.5rem;
	}
	
	.summary-item {
		text-align: center; padding: 1rem;
	}
	.summary-number {
		font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem;
	}
	
	.feedback-actions {
		display: flex; gap: 0.5rem; flex-wrap: wrap;
	}
	
	.feedback-preview {
		max-width: 300px; max-height: 100px; overflow: hidden;
		text-overflow: ellipsis; font-size: 0.9rem; line-height: 1.4;
	}
	
	.priority-indicator {
		width: 8px; height: 8px; border-radius: 50%; display: inline-block; margin-right: 0.5rem;
	}
	.priority-indicator.high { background: #dc3545; }
	.priority-indicator.medium { background: #ffc107; }
	.priority-indicator.low { background: #28a745; }
	
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
		<a href="management.jsp" class="sidebar-brand">
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
					<input type="text" class="form-control" placeholder="Tìm kiếm phản hồi..." id="feedbackSearch">
					<button class="btn btn-outline-secondary" onclick="searchFeedback()"><i class="fas fa-search"></i></button>
				</div>
				
				<div class="d-flex align-items-center gap-3">
					<button class="btn btn-success" onclick="exportFeedback()">
						<i class="fas fa-file-export me-2"></i>Xuất Excel
					</button>
					<button class="btn btn-outline-secondary" onclick="refreshFeedback()">
						<i class="fas fa-sync-alt me-2"></i>Làm Mới
					</button>
					<button class="btn btn-primary" onclick="generateFeedbackReport()">
						<i class="fas fa-chart-bar me-2"></i>Báo Cáo
					</button>
				</div>
			</div>
		</div>

		<!-- Main Content -->
		<div class="content-area">
			<!-- Page Header -->
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<h2 class="page-title">Quản Lý Phản Hồi Khách Hàng</h2>
					<p class="text-muted">Quản lý và phản hồi tất cả ý kiến từ khách hàng</p>
				</div>
				<div class="text-muted">
					Tổng số phản hồi: <strong>248</strong> | Hôm nay: <strong>18</strong>
				</div>
			</div>

			<!-- ===== FEEDBACK STATISTICS ===== -->
			<div class="feedback-summary">
				<div class="row">
					<div class="col-md-2">
						<div class="summary-item">
							<div class="summary-number text-primary">42</div>
							<div class="text-muted">Mới</div>
							<div class="text-primary small">+8 hôm nay</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="summary-item">
							<div class="summary-number text-info">89</div>
							<div class="text-muted">Đã Đọc</div>
							<div class="text-info small">+12 hôm nay</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="summary-item">
							<div class="summary-number text-success">156</div>
							<div class="text-muted">Đã Phản Hồi</div>
							<div class="text-success small">+15 hôm nay</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="summary-item">
							<div class="summary-number text-secondary">98</div>
							<div class="text-muted">Đã Giải Quyết</div>
							<div class="text-secondary small">+6 hôm nay</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="summary-item">
							<div class="summary-number text-warning">23</div>
							<div class="text-muted">Đang Xử Lý</div>
							<div class="text-warning small">+3 hôm nay</div>
						</div>
					</div>
					<div class="col-md-2">
						<div class="summary-item">
							<div class="summary-number text-warning">4.2</div>
							<div class="text-muted">Đánh Giá TB</div>
							<div class="rating-stars small">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
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
							<label class="form-label">Trạng Thái:</label>
							<select class="form-select" onchange="filterByStatus(this.value)">
								<option value="">Tất Cả Trạng Thái</option>
								<option value="new">Mới (42)</option>
								<option value="read">Đã Đọc (89)</option>
								<option value="replied">Đã Phản Hồi (156)</option>
								<option value="resolved">Đã Giải Quyết (98)</option>
								<option value="pending">Đang Xử Lý (23)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Loại Phản Hồi:</label>
							<select class="form-select" onchange="filterByType(this.value)">
								<option value="">Tất Cả Loại</option>
								<option value="complaint">Khiếu Nại (45)</option>
								<option value="suggestion">Góp Ý (78)</option>
								<option value="compliment">Khen Ngợi (89)</option>
								<option value="question">Câu Hỏi (56)</option>
								<option value="bug-report">Báo Lỗi (12)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Đánh Giá:</label>
							<select class="form-select" onchange="filterByRating(this.value)">
								<option value="">Tất Cả Đánh Giá</option>
								<option value="5">5 Sao (89)</option>
								<option value="4">4 Sao (67)</option>
								<option value="3">3 Sao (45)</option>
								<option value="2">2 Sao (28)</option>
								<option value="1">1 Sao (19)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Thời Gian:</label>
							<select class="form-select" onchange="filterByTime(this.value)">
								<option value="">Tất Cả Thời Gian</option>
								<option value="today">Hôm Nay</option>
								<option value="yesterday">Hôm Qua</option>
								<option value="week">Tuần Này</option>
								<option value="month">Tháng Này</option>
								<option value="quarter">Quý Này</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<!-- ===== FEEDBACK TABLE ===== -->
			<div class="card">
				<div class="card-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0">Danh Sách Phản Hồi</h5>
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
									<th><input type="checkbox" class="form-check-input" onchange="selectAllFeedback(this)"></th>
									<th>Khách Hàng</th>
									<th>Nội Dung</th>
									<th>Loại</th>
									<th>Đánh Giá</th>
									<th>Trạng Thái</th>
									<th>Ngày Tạo</th>
									<th>Ưu Tiên</th>
									<th>Thao Tác</th>
								</tr>
							</thead>
							<tbody>
								<!-- Feedback 1: New Complaint -->
								<tr class="table-warning">
									<td><input type="checkbox" class="form-check-input feedback-checkbox" value="1"></td>
									<td>
										<div>
											<strong>Nguyễn Thị Mai</strong>
											<div class="text-muted small">mai.nguyen@email.com</div>
											<div class="text-muted small">0901234567</div>
										</div>
									</td>
									<td>
										<div class="feedback-preview">
											<strong>Hoa bị héo khi giao đến</strong>
											<div class="text-muted small">Tôi đặt hoa hồng đỏ nhưng khi nhận được hoa đã bị héo và không tươi như trong hình...</div>
										</div>
									</td>
									<td><span class="feedback-type complaint">Khiếu Nại</span></td>
									<td>
										<div class="rating-stars">
											<i class="fas fa-star"></i><i class="fas fa-star empty"></i><i class="fas fa-star empty"></i><i class="fas fa-star empty"></i><i class="fas fa-star empty"></i>
										</div>
										<div class="text-muted small">1/5</div>
									</td>
									<td><span class="feedback-status new">Mới</span></td>
									<td>
										<div>
											<strong>15/01/2024</strong>
											<div class="text-muted small">09:30 AM</div>
										</div>
									</td>
									<td>
										<span class="priority-indicator high"></span>
										<span class="text-danger small">Cao</span>
									</td>
									<td>
										<div class="feedback-actions">
											<button class="btn btn-sm btn-outline-primary" onclick="viewFeedback(1)" title="Xem Chi Tiết">
												<i class="fas fa-eye"></i>
											</button>
											<button class="btn btn-sm btn-success" onclick="replyFeedback(1)" title="Phản Hồi">
												<i class="fas fa-reply"></i>
											</button>
											<button class="btn btn-sm btn-warning" onclick="markAsRead(1)" title="Đánh Dấu Đã Đọc">
												<i class="fas fa-check"></i>
											</button>
											<button class="btn btn-sm btn-outline-danger" onclick="escalateFeedback(1)" title="Báo Cáo Cấp Trên">
												<i class="fas fa-exclamation-triangle"></i>
											</button>
										</div>
									</td>
								</tr>

								<!-- Feedback 2: Suggestion -->
								<tr>
									<td><input type="checkbox" class="form-check-input feedback-checkbox" value="2"></td>
									<td>
										<div>
											<strong>Trần Văn Hùng</strong>
											<div class="text-muted small">hung.tran@email.com</div>
											<div class="text-muted small">0912345678</div>
										</div>
									</td>
									<td>
										<div class="feedback-preview">
											<strong>Đề xuất thêm dịch vụ trang trí</strong>
											<div class="text-muted small">Shop nên có thêm dịch vụ trang trí tiệc cưới và sự kiện để khách hàng tiện lợi hơn...</div>
										</div>
									</td>
									<td><span class="feedback-type suggestion">Góp Ý</span></td>
									<td>
										<div class="rating-stars">
											<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star empty"></i>
										</div>
										<div class="text-muted small">4/5</div>
									</td>
									<td><span class="feedback-status read">Đã Đọc</span></td>
									<td>
										<div>
											<strong>14/01/2024</strong>
											<div class="text-muted small">02:15 PM</div>
										</div>
									</td>
									<td>
										<span class="priority-indicator medium"></span>
										<span class="text-warning small">Trung Bình</span>
									</td>
									<td>
										<div class="feedback-actions">
											<button class="btn btn-sm btn-outline-primary" onclick="viewFeedback(2)" title="Xem Chi Tiết">
												<i class="fas fa-eye"></i>
											</button>
											<button class="btn btn-sm btn-success" onclick="replyFeedback(2)" title="Phản Hồi">
												<i class="fas fa-reply"></i>
											</button>
											<button class="btn btn-sm btn-outline-info" onclick="forwardToTeam(2)" title="Chuyển Tiếp">
												<i class="fas fa-share"></i>
											</button>
											<button class="btn btn-sm btn-outline-secondary" onclick="addToIdeas(2)" title="Thêm Vào Ý Tưởng">
												<i class="fas fa-lightbulb"></i>
											</button>
										</div>
									</td>
								</tr>

								<!-- Feedback 3: Compliment -->
								<tr class="table-success">
									<td><input type="checkbox" class="form-check-input feedback-checkbox" value="3"></td>
									<td>
										<div>
											<strong>Lê Thị Hoa</strong>
											<div class="text-muted small">hoa.le@email.com</div>
											<div class="text-muted small">0923456789</div>
										</div>
									</td>
									<td>
										<div class="feedback-preview">
											<strong>Dịch vụ tuyệt vời!</strong>
											<div class="text-muted small">Hoa rất tươi và đẹp, nhân viên tư vấn nhiệt tình. Tôi sẽ quay lại ủng hộ shop...</div>
										</div>
									</td>
									<td><span class="feedback-type compliment">Khen Ngợi</span></td>
									<td>
										<div class="rating-stars">
											<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
										</div>
										<div class="text-muted small">5/5</div>
									</td>
									<td><span class="feedback-status replied">Đã Phản Hồi</span></td>
									<td>
										<div>
											<strong>13/01/2024</strong>
											<div class="text-muted small">11:45 AM</div>
										</div>
									</td>
									<td>
										<span class="priority-indicator low"></span>
										<span class="text-success small">Thấp</span>
									</td>
									<td>
										<div class="feedback-actions">
											<button class="btn btn-sm btn-outline-primary" onclick="viewFeedback(3)" title="Xem Chi Tiết">
												<i class="fas fa-eye"></i>
											</button>
											<button class="btn btn-sm btn-outline-success" onclick="viewReply(3)" title="Xem Phản Hồi">
												<i class="fas fa-comment-dots"></i>
											</button>
											<button class="btn btn-sm btn-outline-info" onclick="shareTestimonial(3)" title="Chia Sẻ Làm Chứng Thực">
												<i class="fas fa-share-alt"></i>
											</button>
											<button class="btn btn-sm btn-outline-warning" onclick="thankCustomer(3)" title="Gửi Lời Cảm Ơn">
												<i class="fas fa-heart"></i>
											</button>
										</div>
									</td>
								</tr>

								<!-- Feedback 4: Question -->
								<tr>
									<td><input type="checkbox" class="form-check-input feedback-checkbox" value="4"></td>
									<td>
										<div>
											<strong>Phạm Minh Tuấn</strong>
											<div class="text-muted small">tuan.pham@email.com</div>
											<div class="text-muted small">0934567890</div>
										</div>
									</td>
									<td>
										<div class="feedback-preview">
											<strong>Hỏi về chính sách đổi trả</strong>
											<div class="text-muted small">Cho tôi hỏi nếu hoa không đúng ý thì có thể đổi trả trong bao lâu? Quy trình như thế nào?...</div>
										</div>
									</td>
									<td><span class="feedback-type question">Câu Hỏi</span></td>
									<td>
										<div class="text-muted small">Chưa đánh giá</div>
									</td>
									<td><span class="feedback-status pending">Đang Xử Lý</span></td>
									<td>
										<div>
											<strong>15/01/2024</strong>
											<div class="text-muted small">04:20 PM</div>
										</div>
									</td>
									<td>
										<span class="priority-indicator medium"></span>
										<span class="text-warning small">Trung Bình</span>
									</td>
									<td>
										<div class="feedback-actions">
											<button class="btn btn-sm btn-outline-primary" onclick="viewFeedback(4)" title="Xem Chi Tiết">
												<i class="fas fa-eye"></i>
											</button>
											<button class="btn btn-sm btn-success" onclick="replyFeedback(4)" title="Phản Hồi">
												<i class="fas fa-reply"></i>
											</button>
											<button class="btn btn-sm btn-outline-info" onclick="addToFAQ(4)" title="Thêm Vào FAQ">
												<i class="fas fa-question-circle"></i>
											</button>
											<button class="btn btn-sm btn-outline-secondary" onclick="assignToExpert(4)" title="Giao Cho Chuyên Gia">
												<i class="fas fa-user-tie"></i>
											</button>
										</div>
									</td>
								</tr>

								<!-- Feedback 5: Bug Report -->
								<tr class="table-danger">
									<td><input type="checkbox" class="form-check-input feedback-checkbox" value="5"></td>
									<td>
										<div>
											<strong>Võ Thị Lan</strong>
											<div class="text-muted small">lan.vo@email.com</div>
											<div class="text-muted small">0945678901</div>
										</div>
									</td>
									<td>
										<div class="feedback-preview">
											<strong>Lỗi thanh toán online</strong>
											<div class="text-muted small">Tôi không thể thanh toán qua thẻ tín dụng, hệ thống báo lỗi liên tục. Cần khắc phục gấp...</div>
										</div>
									</td>
									<td><span class="feedback-type bug-report">Báo Lỗi</span></td>
									<td>
										<div class="rating-stars">
											<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star empty"></i><i class="fas fa-star empty"></i><i class="fas fa-star empty"></i>
										</div>
										<div class="text-muted small">2/5</div>
									</td>
									<td><span class="feedback-status new">Mới</span></td>
									<td>
										<div>
											<strong>15/01/2024</strong>
											<div class="text-muted small">06:10 PM</div>
										</div>
									</td>
									<td>
										<span class="priority-indicator high"></span>
										<span class="text-danger small">Cao</span>
									</td>
									<td>
										<div class="feedback-actions">
											<button class="btn btn-sm btn-outline-primary" onclick="viewFeedback(5)" title="Xem Chi Tiết">
												<i class="fas fa-eye"></i>
											</button>
											<button class="btn btn-sm btn-danger" onclick="reportToDev(5)" title="Báo Cáo Dev Team">
												<i class="fas fa-bug"></i>
											</button>
											<button class="btn btn-sm btn-warning" onclick="urgentResponse(5)" title="Phản Hồi Khẩn Cấp">
												<i class="fas fa-exclamation"></i>
											</button>
											<button class="btn btn-sm btn-outline-info" onclick="createTicket(5)" title="Tạo Ticket">
												<i class="fas fa-ticket-alt"></i>
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
							<button class="btn btn-outline-success btn-sm" onclick="bulkMarkAsRead()" disabled id="bulkReadBtn">
								<i class="fas fa-check me-2"></i>Đánh Dấu Đã Đọc
							</button>
							<button class="btn btn-outline-primary btn-sm" onclick="bulkReply()" disabled id="bulkReplyBtn">
								<i class="fas fa-reply me-2"></i>Phản Hồi Hàng Loạt
							</button>
							<button class="btn btn-outline-info btn-sm" onclick="bulkExport()" disabled id="bulkExportBtn">
								<i class="fas fa-file-export me-2"></i>Xuất Đã Chọn
							</button>
							<button class="btn btn-outline-danger btn-sm" onclick="bulkDelete()" disabled id="bulkDeleteBtn">
								<i class="fas fa-trash me-2"></i>Xóa Phản Hồi
							</button>
						</div>
						<div class="text-muted">
							Hiển thị 1 đến 5 trong tổng số 248 phản hồi
						</div>
					</div>

					<!-- ===== PAGINATION ===== -->
					<nav aria-label="Feedback pagination" class="mt-3">
						<ul class="pagination">
							<li class="page-item disabled">
								<a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
							</li>
							<li class="page-item active"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="feedbackManagement.jsp?page=2">2</a></li>
							<li class="page-item"><a class="page-link" href="feedbackManagement.jsp?page=3">3</a></li>
							<li class="page-item"><a class="page-link" href="feedbackManagement.jsp?page=4">4</a></li>
							<li class="page-item">
								<a class="page-link" href="feedbackManagement.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
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
	// ===== FEEDBACK MANAGEMENT FUNCTIONALITY =====
	
	// Search feedback
	function searchFeedback() {
		const searchTerm = document.getElementById('feedbackSearch').value;
		console.log('Tìm kiếm phản hồi:', searchTerm);
		// Implementation would filter feedback based on search term
	}
	
	// Filter functions
	function filterByStatus(status) { console.log('Lọc theo trạng thái:', status); }
	function filterByType(type) { console.log('Lọc theo loại:', type); }
	function filterByRating(rating) { console.log('Lọc theo đánh giá:', rating); }
	function filterByTime(time) { console.log('Lọc theo thời gian:', time); }
	
	// Feedback actions
	function viewFeedback(feedbackId) {
		console.log('Xem chi tiết phản hồi:', feedbackId);
		window.location.href = `feedback-details.jsp?id=${feedbackId}`;
	}
	
	function replyFeedback(feedbackId) {
		console.log('Phản hồi:', feedbackId);
		window.location.href = `reply-feedback.jsp?id=${feedbackId}`;
	}
	
	function markAsRead(feedbackId) {
		if (confirm('Đánh dấu phản hồi này là đã đọc?')) {
			console.log('Đánh dấu đã đọc:', feedbackId);
			alert('Phản hồi đã được đánh dấu là đã đọc!');
			location.reload();
		}
	}
	
	function escalateFeedback(feedbackId) {
		if (confirm('Báo cáo phản hồi này lên cấp trên?')) {
			console.log('Báo cáo cấp trên:', feedbackId);
			alert('Phản hồi đã được báo cáo lên cấp trên!');
		}
	}
	
	function forwardToTeam(feedbackId) {
		console.log('Chuyển tiếp cho team:', feedbackId);
		const team = prompt('Chuyển tiếp cho team nào? (sales/support/dev)');
		if (team) {
			alert(`Phản hồi đã được chuyển tiếp cho team ${team}!`);
		}
	}
	
	function addToIdeas(feedbackId) {
		if (confirm('Thêm góp ý này vào danh sách ý tưởng phát triển?')) {
			console.log('Thêm vào ý tưởng:', feedbackId);
			alert('Góp ý đã được thêm vào danh sách ý tưởng!');
		}
	}
	
	function viewReply(feedbackId) {
		console.log('Xem phản hồi đã gửi:', feedbackId);
		window.open(`view-reply.jsp?id=${feedbackId}`, '_blank');
	}
	
	function shareTestimonial(feedbackId) {
		if (confirm('Chia sẻ phản hồi tích cực này làm chứng thực?')) {
			console.log('Chia sẻ chứng thực:', feedbackId);
			alert('Phản hồi đã được chia sẻ làm chứng thực!');
		}
	}
	
	function thankCustomer(feedbackId) {
		if (confirm('Gửi email cảm ơn đặc biệt cho khách hàng?')) {
			console.log('Gửi lời cảm ơn:', feedbackId);
			alert('Email cảm ơn đã được gửi!');
		}
	}
	
	function addToFAQ(feedbackId) {
		if (confirm('Thêm câu hỏi này vào danh sách FAQ?')) {
			console.log('Thêm vào FAQ:', feedbackId);
			alert('Câu hỏi đã được thêm vào FAQ!');
		}
	}
	
	function assignToExpert(feedbackId) {
		console.log('Giao cho chuyên gia:', feedbackId);
		const expert = prompt('Giao cho chuyên gia nào?');
		if (expert) {
			alert(`Phản hồi đã được giao cho ${expert}!`);
		}
	}
	
	function reportToDev(feedbackId) {
		if (confirm('Báo cáo lỗi này cho team phát triển?')) {
			console.log('Báo cáo dev team:', feedbackId);
			alert('Lỗi đã được báo cáo cho team phát triển!');
		}
	}
	
	function urgentResponse(feedbackId) {
		console.log('Phản hồi khẩn cấp:', feedbackId);
		window.location.href = `urgent-reply.jsp?id=${feedbackId}`;
	}
	
	function createTicket(feedbackId) {
		if (confirm('Tạo ticket hỗ trợ cho vấn đề này?')) {
			console.log('Tạo ticket:', feedbackId);
			alert('Ticket hỗ trợ đã được tạo!');
		}
	}
	
	// Bulk actions
	function selectAllFeedback(checkbox) {
		const feedbackCheckboxes = document.querySelectorAll('.feedback-checkbox');
		feedbackCheckboxes.forEach(cb => cb.checked = checkbox.checked);
		updateBulkActionButtons();
	}
	
	function updateBulkActionButtons() {
		const selectedFeedback = document.querySelectorAll('.feedback-checkbox:checked');
		const bulkButtons = ['bulkReadBtn', 'bulkReplyBtn', 'bulkExportBtn', 'bulkDeleteBtn'];
		
		bulkButtons.forEach(btnId => {
			document.getElementById(btnId).disabled = selectedFeedback.length === 0;
		});
	}
	
	function bulkMarkAsRead() {
		const selected = document.querySelectorAll('.feedback-checkbox:checked');
		const ids = Array.from(selected).map(cb => cb.value);
		if (confirm(`Đánh dấu ${ids.length} phản hồi đã chọn là đã đọc?`)) {
			console.log('Bulk đánh dấu đã đọc:', ids);
			alert('Các phản hồi đã được đánh dấu là đã đọc!');
			location.reload();
		}
	}
	
	function bulkReply() {
		const selected = document.querySelectorAll('.feedback-checkbox:checked');
		const ids = Array.from(selected).map(cb => cb.value);
		console.log('Bulk phản hồi:', ids);
		window.location.href = `bulk-reply.jsp?ids=${ids.join(',')}`;
	}
	
	function bulkExport() {
		const selected = document.querySelectorAll('.feedback-checkbox:checked');
		const ids = Array.from(selected).map(cb => cb.value);
		console.log('Bulk xuất:', ids);
		window.location.href = `export-feedback.jsp?ids=${ids.join(',')}&format=excel`;
	}
	
	function bulkDelete() {
		const selected = document.querySelectorAll('.feedback-checkbox:checked');
		const ids = Array.from(selected).map(cb => cb.value);
		if (confirm(`Xóa ${ids.length} phản hồi đã chọn? Hành động này không thể hoàn tác.`)) {
			console.log('Bulk xóa phản hồi:', ids);
			alert('Các phản hồi đã được xóa!');
			location.reload();
		}
	}
	
	// Export and utility functions
	function exportFeedback() {
		console.log('Xuất danh sách phản hồi...');
		window.location.href = 'export-feedback.jsp?format=excel';
	}
	
	function refreshFeedback() {
		console.log('Làm mới danh sách phản hồi...');
		location.reload();
	}
	
	function generateFeedbackReport() {
		console.log('Tạo báo cáo phản hồi...');
		window.open('feedback-report.jsp', '_blank');
	}
	
	// Initialize page
	document.addEventListener('DOMContentLoaded', function() {
		// Add event listeners to feedback checkboxes
		document.querySelectorAll('.feedback-checkbox').forEach(checkbox => {
			checkbox.addEventListener('change', updateBulkActionButtons);
		});
		
		// Enable real-time search
		document.getElementById('feedbackSearch').addEventListener('keyup', function(e) {
			if (e.key === 'Enter') {
				searchFeedback();
			}
		});
		
		// Set active menu
		document.querySelectorAll('.sidebar-link').forEach(l => l.classList.remove('active'));
		document.getElementById('menu-feedbackManagement').classList.add('active');
		
		console.log('Trang quản lý phản hồi đã được khởi tạo');
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
