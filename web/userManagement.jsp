<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.UserDAO" %>
<%@page import="Model.User" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lý Người Dùng | Flower Shop</title>
    
    <!-- External CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        /* ===== CSS VARIABLES ===== */
        :root {
            --primary-rose: #e11d48;
            --primary-rose-dark: #be185d;
            --primary-rose-light: #fecdd3;
            --secondary-pink: #f472b6;
            --accent-purple: #8b5cf6;
            --dark-gray: #1f2937;
            --medium-gray: #6b7280;
            --light-gray: #f9fafb;
            --white: #ffffff;
            --sidebar-width: 280px;
            --border-radius: 12px;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        }

        /* ===== GLOBAL STYLES ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #fdf2f8 0%, #fce7f3 50%, #fbcfe8 100%);
            min-height: 100vh;
            color: var(--dark-gray);
            line-height: 1.6;
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* ===== SIDEBAR STYLES ===== */
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--dark-gray) 0%, #374151 100%);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: var(--shadow-xl);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 3px;
        }

        .sidebar-brand {
            padding: 2rem 1.5rem;
            color: var(--white);
            text-decoration: none;
            font-weight: 700;
            font-size: 1.25rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
        }

        .sidebar-brand:hover {
            color: var(--primary-rose-light);
            transform: translateX(2px);
        }

        .sidebar-user {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--white);
        }

        .sidebar-user img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 2px solid var(--primary-rose);
        }

        .sidebar-nav {
            list-style: none;
            padding: 1rem 0;
            margin: 0;
        }

        .sidebar-header {
            padding: 1.5rem 1.5rem 0.5rem;
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            margin: 0.125rem 0.75rem;
            border-radius: 8px;
        }

        .sidebar-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--white);
            transform: translateX(4px);
        }

        .sidebar-link.active {
            background: var(--primary-rose);
            color: var(--white);
            box-shadow: var(--shadow-md);
        }

        .sidebar-link.active::before {
            content: '';
            position: absolute;
            left: -0.75rem;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 20px;
            background: var(--white);
            border-radius: 2px;
        }

        .sidebar-link i {
            margin-right: 0.875rem;
            width: 18px;
            text-align: center;
        }

        .badge {
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
        }

        /* ===== MAIN CONTENT STYLES ===== */
        .main-content {
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
            min-height: 100vh;
        }

        .top-navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 1.5rem 2rem;
            box-shadow: var(--shadow-sm);
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .content-area {
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            color: var(--dark-gray);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-subtitle {
            color: var(--medium-gray);
            font-size: 1rem;
            font-weight: 400;
        }

        /* ===== CARD STYLES ===== */
        .card {
            border: none;
            box-shadow: var(--shadow-md);
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            background: var(--white);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-2px);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-rose) 0%, var(--secondary-pink) 100%);
            color: var(--white);
            border-radius: var(--border-radius) var(--border-radius) 0 0 !important;
            padding: 1.5rem;
            border: none;
        }

        .card-header h5 {
            margin: 0;
            font-weight: 600;
            font-size: 1.25rem;
        }

        .card-body {
            padding: 2rem;
        }

        /* ===== BUTTON STYLES ===== */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.625rem 1.25rem;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-rose) 0%, var(--primary-rose-dark) 100%);
            color: var(--white);
            box-shadow: var(--shadow-sm);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-rose-dark) 0%, #9d174d 100%);
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
            color: var(--white);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: var(--white);
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #d97706 0%, #b45309 100%);
            transform: translateY(-1px);
            color: var(--white);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: var(--white);
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            transform: translateY(-1px);
            color: var(--white);
        }

        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
        }

        /* ===== TABLE STYLES ===== */
        .table-container {
            background: var(--white);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }

        .table {
            margin: 0;
        }

        .table th {
            background: var(--light-gray);
            font-weight: 600;
            border-top: none;
            border-bottom: 2px solid #e5e7eb;
            padding: 1rem;
            color: var(--dark-gray);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background: #fef7ff;
            transform: scale(1.01);
        }

        /* ===== MODAL STYLES ===== */
        .modal-content {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-xl);
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary-rose) 0%, var(--secondary-pink) 100%);
            color: var(--white);
            border: none;
            padding: 1.5rem;
        }

        .modal-title {
            font-weight: 600;
            margin: 0;
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-footer {
            border: none;
            padding: 1.5rem 2rem;
            background: var(--light-gray);
        }

        /* ===== FORM STYLES ===== */
        .form-label {
            font-weight: 500;
            color: var(--dark-gray);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 0.75rem;
            transition: all 0.3s ease;
            font-size: 0.875rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-rose);
            box-shadow: 0 0 0 3px rgba(225, 29, 72, 0.1);
            outline: none;
        }

        /* ===== ALERT STYLES ===== */
        .alert {
            border: none;
            border-radius: var(--border-radius);
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .alert-success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            border-left: 4px solid #10b981;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            border-left: 4px solid #ef4444;
        }

        /* ===== BADGE STYLES ===== */
        .role-badge {
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .role-customer { background: #dcfce7; color: #166534; }
        .role-staff { background: #dbeafe; color: #1e40af; }
        .role-manager { background: #e0e7ff; color: #5b21b6; }
        .role-shipper { background: #fed7aa; color: #c2410c; }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .status-active { background: #d1fae5; color: #065f46; }
        .status-inactive { background: #f3f4f6; color: #6b7280; }

        /* ===== RESPONSIVE DESIGN ===== */
        @media (max-width: 1024px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
                width: calc(100% - 250px);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            .sidebar.show {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            .content-area {
                padding: 1rem;
            }
            .page-title {
                font-size: 1.5rem;
            }
            .table-responsive {
                font-size: 0.875rem;
            }
        }

        /* ===== ANIMATIONS ===== */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }

        /* ===== UTILITY CLASSES ===== */
        .text-gradient {
            background: linear-gradient(135deg, var(--primary-rose) 0%, var(--secondary-pink) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <% 
            Integer role = (Integer) request.getSession().getAttribute("role"); 
            UserDAO userDAO = new UserDAO();
            User userToEdit = (User) request.getAttribute("user");
            String error = request.getParameter("error");
        %>
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
        <% if (role != null && (role == 2 || role == 3)) { %>
        <div class="main-content">
            <nav class="top-navbar glass-effect">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-gradient">Quản Lý Người Dùng</h5>
                    <div class="d-flex align-items-center gap-3">
                        <span class="text-muted"><i class="fas fa-calendar-alt me-2"></i><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></span>
                    </div>
                </div>
            </nav>
            
            <div class="content-area fade-in">
                <!-- Hiển thị thông báo lỗi nếu có -->
                <% if ("invalidId".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>ID không hợp lệ!
                </div>
                <% } else if ("deleteFailed".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Xóa người dùng thất bại!
                </div>
                <% } else if ("operationFailed".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Thao tác thất bại!
                </div>
                <% } else if ("invalidUsername".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Tên người dùng không hợp lệ (tối đa 50 ký tự, không rỗng)!
                </div>
                <% } else if ("invalidEmail".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Email không hợp lệ (tối đa 100 ký tự, định dạng đúng)!
                </div>
                <% } else if ("invalidPassword".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Mật khẩu không hợp lệ (tối thiểu 6 ký tự, tối đa 255 ký tự)!
                </div>
                <% } else if ("invalidFullName".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Tên đầy đủ không hợp lệ (tối đa 100 ký tự, không rỗng)!
                </div>
                <% } else if ("invalidPhone".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Số điện thoại không hợp lệ (10-11 số, bắt đầu bằng 0)!
                </div>
                <% } else if ("invalidRole".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Vai trò không hợp lệ!
                </div>
                <% } else if ("invalidStatus".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Trạng thái không hợp lệ!
                </div>
                <% } else if ("missingFields".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Vui lòng điền đầy đủ các trường bắt buộc!
                </div>
                <% } else if ("emailExists".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Email đã tồn tại!
                </div>
                <% } else if ("usernameExists".equals(error)) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>Tên người dùng đã tồn tại!
                </div>
                <% } %>

                <!-- Hiển thị thông báo thành công nếu có -->
                <% String success = request.getParameter("success"); %>
                <% if ("add".equals(success)) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>Thêm người dùng thành công!
                </div>
                <% } else if ("update".equals(success)) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>Cập nhật người dùng thành công!
                </div>
                <% } else if ("delete".equals(success)) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>Xóa người dùng thành công!
                </div>
                <% } %>

                <div class="page-header">
                    <h1 class="page-title">
                        <i class="fas fa-users text-gradient"></i>
                        Quản Lý Người Dùng
                    </h1>
                    <p class="page-subtitle">Quản lý thông tin người dùng và phân quyền trong hệ thống</p>
                </div>

                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="fas fa-list me-2"></i>Danh Sách Người Dùng
                            </h5>
                            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-plus me-2"></i>Thêm Người Dùng
                            </button>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                        <th><i class="fas fa-user me-2"></i>Tên Đăng Nhập</th>
                                        <th><i class="fas fa-envelope me-2"></i>Email</th>
                                        <th><i class="fas fa-id-card me-2"></i>Họ Tên</th>
                                        <th><i class="fas fa-phone me-2"></i>Điện Thoại</th>
                                        <th><i class="fas fa-user-tag me-2"></i>Vai Trò</th>
                                        <th><i class="fas fa-toggle-on me-2"></i>Trạng Thái</th>
                                        <th><i class="fas fa-cogs me-2"></i>Thao Tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<User> users = userDAO.getAllUsers();
                                        for (User u : users) {
                                            String roleClass = "";
                                            String roleName = "";
                                            switch(u.getRoleId()) {
                                                case 1: roleClass = "role-customer"; roleName = "Customer"; break;
                                                case 2: roleClass = "role-staff"; roleName = "Staff"; break;
                                                case 3: roleClass = "role-manager"; roleName = "Manager"; break;
                                                case 4: roleClass = "role-shipper"; roleName = "Shipper"; break;
                                            }
                                    %>
                                    <tr>
                                        <td><strong>#<%= u.getUserId() %></strong></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-gradient-primary rounded-circle d-flex align-items-center justify-content-center me-2" 
                                                     style="width: 32px; height: 32px; background: linear-gradient(135deg, var(--primary-rose), var(--secondary-pink)); color: white; font-weight: 600; font-size: 0.8rem;">
                                                    <%= u.getUsername().substring(0, 1).toUpperCase() %>
                                                </div>
                                                <strong><%= u.getUsername() %></strong>
                                            </div>
                                        </td>
                                        <td><%= u.getEmail() %></td>
                                        <td><%= u.getFullName() %></td>
                                        <td><%= u.getPhone() %></td>
                                        <td>
                                            <span class="role-badge <%= roleClass %>">
                                                <i class="fas fa-user-tag me-1"></i><%= roleName %>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge <%= u.isIsActive() ? "status-active" : "status-inactive" %>">
                                                <i class="fas fa-<%= u.isIsActive() ? "check-circle" : "times-circle" %> me-1"></i>
                                                <%= u.isIsActive() ? "Hoạt động" : "Không hoạt động" %>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="UserManagementServlet?action=edit&id=<%= u.getUserId() %>" 
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="UserManagementServlet?action=delete&id=<%= u.getUserId() %>" 
                                                   class="btn btn-danger btn-sm" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Add User Modal -->
                <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addUserModalLabel">
                                    <i class="fas fa-user-plus me-2"></i>Thêm Người Dùng Mới
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="UserManagementServlet" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-user me-2"></i>Tên Đăng Nhập
                                            </label>
                                            <input type="text" name="username" class="form-control" maxlength="50" required 
                                                   placeholder="Nhập tên đăng nhập">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-envelope me-2"></i>Email
                                            </label>
                                            <input type="email" name="email" class="form-control" maxlength="100" required 
                                                   placeholder="Nhập địa chỉ email">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-lock me-2"></i>Mật Khẩu
                                            </label>
                                            <input type="password" name="password" class="form-control" minlength="6" maxlength="255" required 
                                                   placeholder="Nhập mật khẩu">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-id-card me-2"></i>Họ Tên
                                            </label>
                                            <input type="text" name="fullName" class="form-control" maxlength="100" required 
                                                   placeholder="Nhập họ và tên">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-phone me-2"></i>Số Điện Thoại
                                            </label>
                                            <input type="text" name="phone" class="form-control" pattern="0[0-9]{9,10}" 
                                                   title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số" 
                                                   placeholder="0123456789">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-user-tag me-2"></i>Vai Trò
                                            </label>
                                            <select name="roleId" class="form-select" required>
                                                <option value="">Chọn vai trò</option>
                                                <option value="1">Customer</option>
                                                <option value="2">Staff</option>
                                                <option value="4">Shipper</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-map-marker-alt me-2"></i>Địa Chỉ
                                        </label>
                                        <input type="text" name="address" class="form-control" placeholder="Nhập địa chỉ">
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="isActive" value="true" checked id="isActiveAdd">
                                        <label class="form-check-label" for="isActiveAdd">
                                            <i class="fas fa-toggle-on me-2"></i>Kích hoạt tài khoản
                                        </label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Hủy
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Thêm Người Dùng
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Edit User Modal -->
                <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editUserModalLabel">
                                    <i class="fas fa-user-edit me-2"></i>Chỉnh Sửa Người Dùng
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="UserManagementServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="userId" value="<%= userToEdit != null ? userToEdit.getUserId() : "" %>">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-user me-2"></i>Tên Đăng Nhập
                                            </label>
                                            <input type="text" name="username" class="form-control" 
                                                   value="<%= userToEdit != null ? userToEdit.getUsername() : "" %>" 
                                                   maxlength="50" required placeholder="Nhập tên đăng nhập">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-envelope me-2"></i>Email
                                            </label>
                                            <input type="email" name="email" class="form-control" 
                                                   value="<%= userToEdit != null ? userToEdit.getEmail() : "" %>" 
                                                   maxlength="100" required placeholder="Nhập địa chỉ email">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-lock me-2"></i>Mật Khẩu
                                            </label>
                                            <input type="password" name="password" class="form-control" 
                                                   value="<%= userToEdit != null ? userToEdit.getPassword() : "" %>" 
                                                   minlength="6" maxlength="255" required placeholder="Nhập mật khẩu">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-id-card me-2"></i>Họ Tên
                                            </label>
                                            <input type="text" name="fullName" class="form-control" 
                                                   value="<%= userToEdit != null ? userToEdit.getFullName() : "" %>" 
                                                   maxlength="100" required placeholder="Nhập họ và tên">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-phone me-2"></i>Số Điện Thoại
                                            </label>
                                            <input type="text" name="phone" class="form-control" 
                                                   value="<%= userToEdit != null ? userToEdit.getPhone() : "" %>" 
                                                   pattern="0[0-9]{9,10}" title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số" 
                                                   placeholder="0123456789">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">
                                                <i class="fas fa-user-tag me-2"></i>Vai Trò
                                            </label>
                                            <select name="roleId" class="form-select" required>
                                                <option value="1" <%= userToEdit != null && userToEdit.getRoleId() == 1 ? "selected" : "" %>>Customer</option>
                                                <option value="2" <%= userToEdit != null && userToEdit.getRoleId() == 2 ? "selected" : "" %>>Staff</option>
                                                <option value="4" <%= userToEdit != null && userToEdit.getRoleId() == 4 ? "selected" : "" %>>Shipper</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-map-marker-alt me-2"></i>Địa Chỉ
                                        </label>
                                        <input type="text" name="address" class="form-control" 
                                               value="<%= userToEdit != null ? userToEdit.getAddress() : "" %>" 
                                               placeholder="Nhập địa chỉ">
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="isActive" value="true" 
                                               <%= userToEdit != null && userToEdit.isIsActive() ? "checked" : "" %> id="isActiveEdit">
                                        <label class="form-check-label" for="isActiveEdit">
                                            <i class="fas fa-toggle-on me-2"></i>Kích hoạt tài khoản
                                        </label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Hủy
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Cập Nhật
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } else { %>
        <div class="main-content d-flex align-items-center justify-content-center">
            <div class="text-center">
                <i class="fas fa-lock text-muted" style="font-size: 4rem;"></i>
                <h2 class="mt-3">Không có quyền truy cập</h2>
                <p class="text-muted">Vui lòng đăng nhập với tài khoản có quyền phù hợp</p>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto show edit modal if user is being edited
        <% if (userToEdit != null) { %>
        document.addEventListener('DOMContentLoaded', function () {
            var editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
            editModal.show();
        });
        <% } %>

        // Auto hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
        });

        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('show');
        }

        // Add mobile menu button for small screens
        if (window.innerWidth <= 768) {
            const navbar = document.querySelector('.top-navbar .d-flex');
            const menuButton = document.createElement('button');
            menuButton.className = 'btn btn-outline-primary d-md-none';
            menuButton.innerHTML = '<i class="fas fa-bars"></i>';
            menuButton.onclick = toggleSidebar;
            navbar.insertBefore(menuButton, navbar.firstChild);
        }
    </script>
</body>
</html>