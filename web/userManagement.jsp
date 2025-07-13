<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.UserDAO" %>
<%@page import="Model.User" %>
<%@page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>User Management | Flower Shop</title>
        <!-- External CSS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            /* ===== SHARED STYLES (Same as productManagement.jsp) ===== */
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

            .content-area {
                padding: 2rem;
            }

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

            /* ===== USER SPECIFIC STYLES ===== */
            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: var(--primary-red);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                font-size: 0.9rem;
                margin-right: 0.8rem;
            }

            .role-badge {
                padding: 0.4rem 0.8rem;
                border-radius: 15px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .role-customer {
                background: #d4edda;
                color: #155724;
            }

            .role-staff {
                background: #cce5ff;
                color: #004085;
            }

            .role-manager {
                background: #e2e3ff;
                color: #383d41;
            }

            .role-shipper {
                background: #fff3cd;
                color: #856404;
            }

            .status-badge {
                padding: 0.3rem 0.7rem;
                border-radius: 15px;
                font-size: 0.75rem;
                font-weight: 500;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background: #f8f9fa;
                color: #6c757d;
            }

            /* ===== ALERT STYLES ===== */
            .alert {
                border: none;
                border-radius: 8px;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
            }

            /* ===== RESPONSIVE DESIGN ===== */
            @media (max-width: 768px) {
                .sidebar {
                    width: 250px;
                }
                .main-content {
                    margin-left: 250px;
                    width: calc(100% - 250px);
                }
                .content-area {
                    padding: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <%
            UserDAO userDAO = new UserDAO();
            Integer role = (Integer) session.getAttribute("roleId");
            User userToEdit = (User) request.getAttribute("userToEdit");
            String error = request.getParameter("error");
        %>
        <div class="wrapper">
            <!-- ===== SIDEBAR ===== -->
            <nav class="sidebar">
                <a href="home" class="sidebar-brand">
                    Menu Quản Lý
                </a>
                <div class="sidebar-profile text-center">
                    <img src="images/default-avatar.png" class="profile-avatar" alt="User Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=3498db&color=fff&size=60&font-size=0.4'">
                    <div class="profile-welcome">
                        Chào mừng:
                        <%
                            Integer userRole = (Integer) session.getAttribute("roleId");
                            String roleDisplay = "";
                            if (userRole != null) {
                                switch(userRole) {
                                    case 1: roleDisplay = "Khách hàng"; break;
                                    case 2: roleDisplay = "Nhân viên"; break;
                                    case 3: roleDisplay = "Quản lý"; break;
                                    case 4: roleDisplay = "Shipper"; break;
                                    default: roleDisplay = "Người dùng"; break;
                                }
                            }
                        %>
                        <span class="profile-role"><%= roleDisplay %></span>
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
                        <li><a href="UserManagementServlet?action=search" class="sidebar-link active" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Người Dùng</a></li>
                        <li><a href="feedbackManagement.jsp" class="sidebar-link" id="menu-feedbackManagement"><i class="fas fa-comments"></i>Quản Lý Phản Hồi</a></li>
                        <li><a href="notificationManagement.jsp" class="sidebar-link" id="menu-notificationManagement"><i class="fas fa-bell"></i>Thông Báo<span class="badge bg-danger ms-auto">4</span></a></li>
                        </c:if>

                    <!-- Chỉ hiển thị nếu là Shipper -->
                    <c:if test="${sessionScope.user.roleId == 4}">
                        <li><a href="orderManagement" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                        </c:if>
                </ul>
            </nav>

            <!-- ===== MAIN CONTENT AREA ===== -->
            <% if (role != null) { %>
            <% if (role == 2 || role == 3) { %> <!-- Staff or Manager -->
            <div class="main-content">
                <!-- Top Navigation Bar -->
                <div class="top-navbar">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="input-group" style="width: 300px;">
                            <input type="text" class="form-control" placeholder="Tìm kiếm người dùng..." id="searchUser" onkeypress="if (event.key === 'Enter')
                                        searchUser()">
                            <button class="btn btn-outline-secondary" onclick="searchUser()"><i class="fas fa-search"></i></button>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-plus me-2"></i>Thêm người dùng
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="content-area">
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="page-title">User Management</h2>
                            <p class="text-muted">Quản lý thông tin người dùng hệ thống</p>
                        </div>
                        <div class="text-muted">
                            Ngày cập nhật: <%= new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm a").format(new java.util.Date()) %>
                        </div>
                    </div>

                    <!-- Alert Messages -->
                    <% if ("invalidId".equals(error)) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>ID không hợp lệ!
                    </div>
                    <% } else if ("deactivateFailed".equals(error)) { %>
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

                    <!-- Success Messages -->
                    <% String success = request.getParameter("success"); %>
                    <% if ("add".equals(success)) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>Thêm người dùng thành công!
                    </div>
                    <% } else if ("update".equals(success)) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>Cập nhật người dùng thành công!
                    </div>
                    <% } else if ("deactivate".equals(success)) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>Xóa người dùng thành công!
                    </div>
                    <% } %>

                    <!-- User Table -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Danh sách người dùng</h5>
                            <div class="d-flex align-items-center gap-3">
                                <span class="text-light">Hiển thị:</span>
                                <select class="form-select form-select-sm" style="width: auto;" onchange="changePageSize(this)">
                                    <option value="10" <%= "10".equals(request.getParameter("pageSize")) || request.getParameter("pageSize") == null ? "selected" : "" %>>10</option>
                                    <option value="25" <%= "25".equals(request.getParameter("pageSize")) ? "selected" : "" %>>25</option>
                                    <option value="50" <%= "50".equals(request.getParameter("pageSize")) ? "selected" : "" %>>50</option>
                                    <option value="100" <%= "100".equals(request.getParameter("pageSize")) ? "selected" : "" %>>100</option>
                                </select>
                                <span class="text-light">bản ghi</span>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Họ tên</th>
                                            <th>Số điện thoại</th>
                                            <th>Vai trò</th>
                                            <th>Trạng thái</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${users}" var="u">
                                            <tr>
                                                <td><strong>#${u.userId}</strong></td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="user-avatar">
                                                            ${u.username.substring(0, 1).toUpperCase()}
                                                        </div>
                                                        <strong>${u.username}</strong>
                                                    </div>
                                                </td>
                                                <td>${u.email}</td>
                                                <td>${u.fullName}</td>
                                                <td>${u.phone}</td>
                                                <td>
                                                    <span class="role-badge
                                                          ${u.roleId == 1 ? 'role-customer' : 
                                                            u.roleId == 2 ? 'role-staff' : 
                                                            u.roleId == 3 ? 'role-manager' : 
                                                            'role-shipper'}">
                                                              ${u.roleId == 1 ? 'Customer' : 
                                                                u.roleId == 2 ? 'Staff' : 
                                                                u.roleId == 3 ? 'Manager' : 
                                                                'Shipper'}
                                                          </span>
                                                    </td>
                                                    <td>
                                                        <span class="status-badge ${u.isActive ? 'status-active' : 'status-inactive'}">
                                                            ${u.isActive ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="UserManagementServlet?action=edit&id=${u.userId}" class="btn btn-sm btn-outline-primary" title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="UserManagementServlet?action=deactivate&id=${u.userId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')" title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Thêm vào sau thẻ </table> trong .card-body -->
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <div>
                                            Hiển thị ${(currentPage - 1) * pageSize + 1} - ${Math.min(currentPage * pageSize, totalUsers)} trong tổng số ${totalUsers} người dùng
                                        </div>
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination mb-0">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="UserManagementServlet?action=search&searchTerm=${searchTerm}&page=${currentPage - 1}&pageSize=${pageSize}">Trước</a>
                                                </li>
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="UserManagementServlet?action=search&searchTerm=${searchTerm}&page=${i}&pageSize=${pageSize}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="UserManagementServlet?action=search&searchTerm=${searchTerm}&page=${currentPage + 1}&pageSize=${pageSize}">Sau</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                            <label class="form-label">Role</label>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                            <label class="form-label">Role</label>
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

                <% } else if (role == 1) { %> <!-- Customer -->
                <div class="content-area">
                    <!-- Chức năng của khách hàng -->
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

            <% if (userToEdit != null) { %>
            <script>
                                                                document.addEventListener('DOMContentLoaded', function () {
                                                                    var myModal = new bootstrap.Modal(document.getElementById('editUserModal'));
                                                                    myModal.show();
                                                                });
            </script>
            <% } %>

            <script>
                // Search functionality
                function searchUser() {
                    const searchTerm = document.getElementById('searchUser').value;
                    window.location.href = 'UserManagementServlet?action=search&searchTerm=' + encodeURIComponent(searchTerm);
                }
                function changePageSize(select) {
                    const pageSize = select.value;
                    const searchTerm = document.getElementById('searchUser').value;
                    window.location.href = 'UserManagementServlet?action=search&searchTerm=' + encodeURIComponent(searchTerm) + '&page=1&pageSize=' + pageSize;
                }

                // Export users
                function exportUsers() {
                    window.location.href = 'export-users.jsp?format=excel';
                }


                // Auto hide alerts after 5 seconds
                document.addEventListener('DOMContentLoaded', function () {
                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(function (alert) {
                        setTimeout(function () {
                            alert.style.opacity = '0';
                            setTimeout(function () {
                                alert.remove();
                            }, 300);
                        }, 5000);
                    });

                    // Highlight current menu
                    var currentUrl = window.location.href;
                    document.querySelectorAll('.sidebar-link').forEach(function (link) {
                        link.classList.remove('active');
                    });

                    if (currentUrl.includes('userManagement.jsp')) {
                        var userLink = document.getElementById('menu-userManagement');
                        if (userLink) {
                            userLink.classList.add('active');
                        }
                    }
                });
            </script>
        </body>
    </html>
