<%-- 
    Document   : notificationManagement
    Created on : Jun 16, 2025, 9:51:04 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
			position: fixed; height: 100vh; overflow-y: auto; z-index: 1000;
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
		.sidebar-user { padding: 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.1); color: white; }
		.sidebar-nav { list-style: none; padding: 1rem 0; margin: 0; }
		.sidebar-header { padding: 1rem 1.5rem 0.5rem; color: rgba(255,255,255,0.7); font-size: 0.8rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
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
        /* Chỉ bổ sung/tinh chỉnh cho phần request hoa mẫu */
        .request-title { font-size: 1.18rem; font-weight: 600; margin-bottom: 8px; }
        .request-desc { color: #444; font-size: 1.08rem; margin-bottom: 12px; }
        .status {
            padding: 2px 12px; border-radius: 7px; font-size: 1.05rem; font-weight: 700;
            margin-left: 8px;
        }
        .status.pending { background: #fff3cd; color: #b8860b; }
        .status.sample_sent { background: #e3fcec; color: #218838; }
        .status.accepted { background: #d1ecf1; color: #0c5460; }
        .status.rejected { background: #f8d7da; color: #721c24; }
        .status.completed { background: #e2e3e5; color: #383d41; }
        .request-actions .btn {
            margin-right: 10px; padding: 8px 20px; border-radius: 7px; font-size: 1.08rem; font-weight: 600;
        }
        .btn-view { background: #ce426c; color: #fff; border: none; }
        .btn-reply { background: #fff; color: #ce426c; border: 2px solid #ce426c; }
        .btn-reply:hover, .btn-view:hover { opacity: 0.88; }
        /* Modal chỉnh nhẹ cho rõ ràng */
        .modal-content label { font-weight: 600; color: #324d7a; margin-top: 8px; }
        .modal-content textarea { font-size: 1.08rem; border-radius: 6px; border: 1.5px solid #aeafb0; padding: 10px; }
        .modal-content .btn-send-reply { font-size: 1.13rem; font-weight: 600; }
        .notification-list {
            width: 100%;
            max-width: none;
            margin: 0 0 40px 0;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        .notification-item {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(206,66,108,0.07);
            padding: 22px 28px 18px 28px;
            position: relative;
            margin-bottom: 0;
        }
        .notification-title {
            font-size: 1.18rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: #ce426c;
        }
        .notification-desc {
            color: #444;
            font-size: 1.08rem;
            margin-bottom: 12px;
        }
        .notification-actions {
            margin-top: 10px;
        }
        .notification-actions .btn {
            margin-right: 10px;
            padding: 8px 20px;
            border-radius: 7px;
            font-size: 1.08rem;
            font-weight: 600;
        }
        .btn-detail { background: #ce426c; color: #fff; border: none; }
        .btn-detail:hover { opacity: 0.88; }
        .reply-form-inline {
            margin-top: 18px;
            background: #fdf6f8;
            border-radius: 8px;
            padding: 18px 18px 10px 18px;
            box-shadow: 0 1px 6px rgba(206,66,108,0.06);
        }
        .reply-form-inline label { font-weight: 600; color: #324d7a; margin-top: 8px; }
        .reply-form-inline textarea { font-size: 1.08rem; border-radius: 6px; border: 1.5px solid #aeafb0; padding: 10px; width: 100%; margin-bottom: 10px; }
        .reply-form-inline .dropzone { width: 100%; min-height: 100px; border: 2px dashed #ce426c; border-radius: 10px; background: #fff; display: flex; align-items: center; justify-content: center; color: #ce426c; font-size: 1.08rem; margin-bottom: 12px; cursor: pointer; transition: border 0.2s; text-align: center; }
        .reply-form-inline .dropzone.dragover { border: 2.5px solid #d44071; background: #fff0f6; }
        .reply-form-inline .preview-img { max-width: 100%; max-height: 90px; margin-bottom: 8px; border-radius: 8px; box-shadow: 0 1px 6px rgba(206,66,108,0.08); }
        .flower-request-list {
            display: flex;
            flex-direction: column;
            gap: 24px;
            margin: 0 0 40px 0;
        }
        .flower-request-item {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(206,66,108,0.07);
            padding: 24px 32px 18px 32px;
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 10px;
            border-left: 5px solid #ce426c;
        }
        .flower-request-row {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 32px;
            margin-bottom: 6px;
        }
        .flower-request-title {
            font-size: 1.18rem;
            font-weight: 700;
            color: #ce426c;
            margin-right: 24px;
        }
        .flower-request-info {
            color: #324d7a;
            font-size: 1.08rem;
            margin-right: 18px;
            font-weight: 500;
        }
        .flower-request-status {
            display: inline-block;
            padding: 2px 14px;
            border-radius: 7px;
            font-size: 1.05rem;
            font-weight: 700;
            margin-left: 8px;
        }
        .status-pending { background: #fff3cd; color: #b8860b; }
        .status-sample_sent { background: #e3fcec; color: #218838; }
        .status-accepted { background: #d1ecf1; color: #0c5460; }
        .status-rejected { background: #f8d7da; color: #721c24; }
        .status-completed { background: #e2e3e5; color: #383d41; }
        .btn-detail {
            background: #ce426c;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 8px 22px;
            font-size: 1.08rem;
            font-weight: 600;
            transition: background 0.2s;
            margin-top: 8px;
            width: fit-content;
        }
        .btn-detail:hover {
            background: #d44071;
            color: #fff;
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
					<div class="d-flex align-items-center gap-3">
						<h5 class="mb-0">Thông báo</h5>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<button class="btn btn-primary" onclick="configureNotifications()">
							<i class="fas fa-cog me-2"></i>Cài đặt
						</button>
					</div>
				</div>
			</div>

			<!-- Main Content -->
			<div class="content-area">
				<!-- Page Header -->
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div>
						<h2 class="page-title">Thông báo & Yêu cầu</h2>
						<p class="text-muted">Trang quản lí thông báo, có thể theo dõi và phản hồi các thông báo, yêu cầu</p>
					</div>
					<div class="text-muted">
						Cập nhật gần đây: <strong><%= new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date()) %></strong>
					</div>
				</div>

				<!-- ===== NOTIFICATION STATISTICS ===== -->
				<div class="notification-stats">
					<div class="row">
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-danger">10</div>
								<div class="text-muted">Chưa đọc</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-warning">10</div>
								<div class="text-muted">Hôm nay</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-info">10</div>
								<div class="text-muted">Tuần này</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="stat-item">
								<div class="stat-number text-success">10</div>
								<div class="text-muted">Tháng này</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== NOTIFICATION FILTERS ===== -->
				<div class="notification-filter">
					<div class="row align-items-center">
						<div class="col-md-3">
							<label class="form-label">Trạng thái:</label>
							<select class="form-select" onchange="filterByStatus(this.value)">
								<option value="">Tất cả</option>
								<option value="unread">Unread (4)</option>
								<option value="read">Read (85)</option>
								<option value="archived">Archived (156)</option>
							</select>
						</div>
						<div class="col-md-3">
							<label class="form-label">Ngày gửi:</label>
							<select class="form-select" onchange="filterByCategory(this.value)">
								<option value="">Tất cả</option>
								<option value="inventory">Inventory (12)</option>
								<option value="orders">Orders (8)</option>
								<option value="customers">Customers (5)</option>
								<option value="system">System (3)</option>
								<option value="security">Security (1)</option>
							</select>
						</div>
					</div>
				</div>                               

				<!-- ===== NOTIFICATIONS LIST ===== -->
				<div class="flower-request-list">
    <c:forEach var="req" items="${requests}">
        <div class="flower-request-item">
            <div class="flower-request-row">
                <span class="flower-request-title">Yêu cầu hoa từ khách hàng: ${req.customerName}</span>
                <span class="flower-request-info">ID: ${req.requestId}</span>
                <span class="flower-request-info">Trạng thái:
                    <span class="flower-request-status status-${req.status}">${req.status}</span>
                </span>
            </div>
            <a href="viewRequestDetail?requestId=${req.requestId}" class="btn btn-detail">Xem chi tiết</a>
        </div>
    </c:forEach>
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
