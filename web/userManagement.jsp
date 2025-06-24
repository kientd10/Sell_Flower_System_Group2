<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.UserDAO" %>
<%@page import="Model.User" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>User Management | Flower Shop</title>

        <!-- External CSS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
                font-family: 'Inter', sans-serif;
                background: var(--light-gray);
                margin: 0;
                padding: 0;
            }

            .wrapper {
                display: flex;
                min-height: 100vh;
            }

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

            .sidebar-link i {
                margin-right: 0.8rem;
                width: 18px;
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

            .content-area {
                padding: 2rem;
            }

            .page-title {
                color: var(--dark-gray);
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            /* ===== ENHANCED CARD STYLES ===== */
            .card {
                border: none;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                border-radius: 15px;
                margin-bottom: 1.5rem;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            }

            .card-header {
                background: var(--primary-red);
                color: white;
                border-radius: 15px 15px 0 0 !important;
                padding: 1.5rem;
                position: relative;
                overflow: hidden;
            }

            .card-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%);
                transform: translateX(-100%);
                transition: transform 0.6s;
            }

            .card:hover .card-header::before {
                transform: translateX(100%);
            }

            .card-body {
                padding: 2rem;
            }

            /* ===== ENHANCED BUTTON STYLES ===== */
            .btn {
                border-radius: 8px;
                font-weight: 500;
                padding: 0.625rem 1.25rem;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s;
            }

            .btn:hover::before {
                left: 100%;
            }

            .btn-primary {
                background: var(--primary-red);
                border-color: var(--primary-red);
                color: white;
            }

            .btn-primary:hover {
                background: var(--primary-red-dark);
                border-color: var(--primary-red-dark);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(196, 77, 88, 0.4);
                color: white;
            }

            .btn-warning {
                background: #ffc107;
                border-color: #ffc107;
                color: #212529;
            }

            .btn-warning:hover {
                background: #ffb300;
                border-color: #ffb300;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
                color: #212529;
            }

            .btn-danger {
                background: #dc3545;
                border-color: #dc3545;
            }

            .btn-danger:hover {
                background: #c82333;
                border-color: #c82333;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
            }

            /* ===== ENHANCED TABLE STYLES ===== */
            .table-container {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            }

            .table {
                margin: 0;
            }

            .table th {
                background: var(--light-gray);
                font-weight: 600;
                border-top: none;
                border-bottom: 2px solid #dee2e6;
                padding: 1.2rem;
                color: var(--dark-gray);
                position: relative;
            }

            .table th::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 0;
                height: 2px;
                background: var(--primary-red);
                transition: width 0.3s ease;
            }

            .table th:hover::after {
                width: 100%;
            }

            .table td {
                padding: 1.2rem;
                vertical-align: middle;
                border-bottom: 1px solid #f1f3f4;
            }

            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: linear-gradient(90deg, #fff5f5, #ffffff);
                transform: scale(1.01);
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }

            /* ===== ENHANCED MODAL STYLES ===== */
            .modal-content {
                border: none;
                border-radius: 15px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.15);
                overflow: hidden;
            }

            .modal-header {
                background: var(--primary-red);
                color: white;
                border: none;
                padding: 1.5rem 2rem;
                position: relative;
            }

            .modal-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%);
                transform: translateX(-100%);
                animation: shimmer 2s infinite;
            }

            @keyframes shimmer {
                0% {
                    transform: translateX(-100%);
                }
                100% {
                    transform: translateX(100%);
                }
            }

            .modal-body {
                padding: 2rem;
            }

            .modal-footer {
                border: none;
                padding: 1.5rem 2rem;
                background: #f8f9fa;
            }

            /* ===== ENHANCED FORM STYLES ===== */
            .form-label {
                font-weight: 600;
                color: var(--dark-gray);
                margin-bottom: 0.5rem;
            }

            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 0.75rem 1rem;
                transition: all 0.3s ease;
                background: white;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary-red);
                box-shadow: 0 0 0 0.2rem rgba(196, 77, 88, 0.25);
                transform: translateY(-1px);
            }

            /* ===== ENHANCED ALERT STYLES ===== */
            .alert {
                border: none;
                border-radius: 12px;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
                position: relative;
                overflow: hidden;
            }

            .alert::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: currentColor;
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border-left: 4px solid #28a745;
            }

            .alert-danger {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            /* ===== ENHANCED BADGE STYLES ===== */
            .role-badge {
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                position: relative;
                overflow: hidden;
            }

            .role-badge::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
                transition: left 0.5s;
            }

            .role-badge:hover::before {
                left: 100%;
            }

            .role-customer {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
            }
            .role-staff {
                background: linear-gradient(135deg, #cce5ff, #b3d9ff);
                color: #004085;
            }
            .role-manager {
                background: linear-gradient(135deg, #e2e3ff, #d1d3ff);
                color: #383d41;
            }
            .role-shipper {
                background: linear-gradient(135deg, #fff3cd, #ffeaa7);
                color: #856404;
            }

            .status-badge {
                padding: 0.3rem 0.7rem;
                border-radius: 15px;
                font-size: 0.75rem;
                font-weight: 500;
            }

            .status-active {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
            }
            .status-inactive {
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                color: #6c757d;
            }

            /* ===== USER AVATAR STYLES ===== */
            .user-avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--primary-red), #e91e63);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
                font-size: 0.9rem;
                margin-right: 0.75rem;
                box-shadow: 0 3px 10px rgba(196, 77, 88, 0.3);
            }

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
                .table-responsive {
                    font-size: 0.875rem;
                }
            }

            /* ===== ANIMATIONS ===== */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .fade-in-up {
                animation: fadeInUp 0.6s ease-out;
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }

            .pulse-animation {
                animation: pulse 2s infinite;
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
            <% if (role != null) { %>
            <% if (role == 1) { %> <!-- Customer -->
            <div class="content-area">
                <!-- Chức năng của khách hàng -->
            </div>
            <% } else if (role == 2 || role == 3) { %> <!-- Staff or Manager -->
            <div class="main-content">
                <nav class="top-navbar">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">User Management</h5>
                    </div>
                </nav>

                <div class="content-area fade-in-up">
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

                    <div class="page-title">User Management</div>
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">User List</h5>
                            </div>
                        </div>
                        <div class="card-body">
                            <button class="btn btn-primary mb-3 pulse-animation" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-plus me-2"></i>Add User
                            </button>
                            <div class="table-container">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Full Name</th>
                                            <th>Phone</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Actions</th>
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
                                                    <div class="user-avatar">
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
                                                    <%= roleName %>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="status-badge <%= u.isIsActive() ? "status-active" : "status-inactive" %>">
                                                    <%= u.isIsActive() ? "Active" : "Inactive" %>
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="UserManagementServlet?action=edit&id=<%= u.getUserId() %>" class="btn btn-warning btn-sm">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="UserManagementServlet?action=delete&id=<%= u.getUserId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn?')">
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
                                        <i class="fas fa-user-plus me-2"></i>Add New User
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="UserManagementServlet" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Username</label>
                                                <input type="text" name="username" class="form-control" maxlength="50" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="email" name="email" class="form-control" maxlength="100" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Password</label>
                                                <input type="password" name="password" class="form-control" minlength="6" maxlength="255" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Full Name</label>
                                                <input type="text" name="fullName" class="form-control" maxlength="100" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Phone</label>
                                                <input type="text" name="phone" class="form-control" pattern="0[0-9]{9,10}" title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Role ID</label>
                                                <select name="roleId" class="form-select" required>
                                                    <option value="2">Staff</option>
                                                    <option value="1">Customer</option>
                                                    <option value="4">Shipper</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Address</label>
                                            <input type="text" name="address" class="form-control">
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="isActive" value="true" checked id="isActiveAdd">
                                            <label class="form-check-label" for="isActiveAdd">
                                                Active
                                            </label>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Add User</button>
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
                                        <i class="fas fa-user-edit me-2"></i>Edit User
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="UserManagementServlet" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="userId" value="<%= userToEdit != null ? userToEdit.getUserId() : "" %>">
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Username</label>
                                                <input type="text" name="username" class="form-control" value="<%= userToEdit != null ? userToEdit.getUsername() : "" %>" maxlength="50" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="email" name="email" class="form-control" value="<%= userToEdit != null ? userToEdit.getEmail() : "" %>" maxlength="100" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Password</label>
                                                <input type="password" name="password" class="form-control" value="<%= userToEdit != null ? userToEdit.getPassword() : "" %>" minlength="6" maxlength="255" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Full Name</label>
                                                <input type="text" name="fullName" class="form-control" value="<%= userToEdit != null ? userToEdit.getFullName() : "" %>" maxlength="100" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Phone</label>
                                                <input type="text" name="phone" class="form-control" value="<%= userToEdit != null ? userToEdit.getPhone() : "" %>" pattern="0[0-9]{9,10}" title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Role ID</label>
                                                <select name="roleId" class="form-select" required>
                                                    <option value="2" <%= userToEdit != null && userToEdit.getRoleId() == 2 ? "selected" : "" %>>Staff</option>
                                                    <option value="1" <%= userToEdit != null && userToEdit.getRoleId() == 1 ? "selected" : "" %>>Customer</option>
                                                    <option value="4" <%= userToEdit != null && userToEdit.getRoleId() == 4 ? "selected" : "" %>>Shipper</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Address</label>
                                            <input type="text" name="address" class="form-control" value="<%= userToEdit != null ? userToEdit.getAddress() : "" %>">
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="isActive" value="true" <%= userToEdit != null && userToEdit.isIsActive() ? "checked" : "" %> id="isActiveEdit">
                                            <label class="form-check-label" for="isActiveEdit">
                                                Active
                                            </label>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Update User</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } else if (role == 4) { %> <!-- Shipper -->
            <div class="content-area">
                <!-- Chức năng của Shipper -->
            </div>
            <% } else { %>
            <h2>Vai trò không hợp lệ</h2>
            <% } %>
            <% } else { %>
            <h2>Vui lòng đăng nhập để tiếp tục</h2>
            <% } %>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            <% if (userToEdit != null) { %>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        var myModal = new bootstrap.Modal(document.getElementById('editUserModal'));
                                                        myModal.show();
                                                    });
            <% } %>

                                                    // Auto hide alerts after 5 seconds
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        const alerts = document.querySelectorAll('.alert');
                                                        alerts.forEach(function (alert) {
                                                            setTimeout(function () {
                                                                alert.style.opacity = '0';
                                                                alert.style.transform = 'translateY(-20px)';
                                                                setTimeout(function () {
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