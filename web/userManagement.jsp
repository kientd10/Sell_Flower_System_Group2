<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.UserDAO" %>
<%@page import="Model.User" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>User Management | Flower Shop</title>
        <!-- External CSS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
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

            /* ===== USER MANAGEMENT SPECIFIC STYLES ===== */
            .form-container {
                margin-top: 1rem;
            }
            .modal-content {
                padding: 1rem;
            }
            .btn-danger {
                margin-left: 0.5rem;
            }
            .alert {
                margin-top: 1rem;
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

                    <!-- Chỉ hiển thị nếu là Staff -->
                    <% if (role == 2) { %>
                    <li><a href="productManagement.jsp" class="sidebar-link"><i class="fas fa-list"></i>Quản Lý Sản Phẩm</a></li>
                        <% } %>

                    <!-- Chỉ hiển thị nếu là Manager -->
                    <% if (role == 3) { %>
                    <li><a href="management.jsp" class="sidebar-link" id="menu-management"><i class="fas fa-chart-bar"></i>Thống Kê</a></li>
                    <li><a href="productManagement.jsp" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lý Sản Phẩm</a></li>
                    <li><a href="categoryManagement.jsp" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lý Danh Mục Sản Phẩm</a></li>
                    <li><a href="storageManagement.jsp" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lý Kho Hàng</a></li>
                    <li><a href="orderManagement.jsp" class="sidebar-link" id="menu-orderManagement"><i class="fas fa-shopping-cart"></i>Quản Lý Đơn Hàng</a></li>
                    <li><a href="invoiceManagement.jsp" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>

                    <li class="sidebar-header">Hệ Thống</li>
                    <li><a href="userManagement.jsp" class="sidebar-link active" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lý Người Dùng</a></li>
                    <li><a href="feedbackManagement.jsp" class="sidebar-link" id="menu-feedbackManagement"><i class="fas fa-comments"></i>Quản Lý Phản Hồi</a></li>
                    <li><a href="notificationManagement.jsp" class="sidebar-link" id="menu-notificationManagement"><i class="fas fa-bell"></i>Thông Báo<span class="badge bg-danger ms-auto">4</span></a></li>
                        <% } %>

                    <!-- Chỉ hiển thị nếu là Shipper -->
                    <% if (role == 4) { %>
                    <li><a href="orderManagement.jsp" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lý Đơn Hàng</a></li>
                        <% } %>
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
                </nav>
                <div class="content-area">
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <% if ("invalidId".equals(error)) { %>
                    <div class="alert alert-danger">ID không hợp lệ!</div>
                    <% } else if ("deleteFailed".equals(error)) { %>
                    <div class="alert alert-danger">Xóa người dùng thất bại!</div>
                    <% } else if ("operationFailed".equals(error)) { %>
                    <div class="alert alert-danger">Thao tác thất bại!</div>
                    <% } else if ("invalidUsername".equals(error)) { %>
                    <div class="alert alert-danger">Tên người dùng không hợp lệ (tối đa 50 ký tự, không rỗng)!</div>
                    <% } else if ("invalidEmail".equals(error)) { %>
                    <div class="alert alert-danger">Email không hợp lệ (tối đa 100 ký tự, định dạng đúng)!</div>
                    <% } else if ("invalidPassword".equals(error)) { %>
                    <div class="alert alert-danger">Mật khẩu không hợp lệ (tối thiểu 6 ký tự, tối đa 255 ký tự)!</div>
                    <% } else if ("invalidFullName".equals(error)) { %>
                    <div class="alert alert-danger">Tên đầy đủ không hợp lệ (tối đa 100 ký tự, không rỗng)!</div>
                    <% } else if ("invalidPhone".equals(error)) { %>
                    <div class="alert alert-danger">Số điện thoại không hợp lệ (10-11 số, bắt đầu bằng 0)!</div>
                    <% } else if ("invalidRole".equals(error)) { %>
                    <div class="alert alert-danger">Vai trò không hợp lệ!</div>
                    <% } else if ("invalidStatus".equals(error)) { %>
                    <div class="alert alert-danger">Trạng thái không hợp lệ!</div>
                    <% } else if ("missingFields".equals(error)) { %>
                    <div class="alert alert-danger">Vui lòng điền đầy đủ các trường bắt buộc!</div>
                    <% } else if ("emailExists".equals(error)) { %>
                    <div class="alert alert-danger">Email đã tồn tại!</div>
                    <% } else if ("usernameExists".equals(error)) { %>
                    <div class="alert alert-danger">Tên người dùng đã tồn tại!</div>
                    <% } %>
                    <!-- Hiển thị thông báo thành công nếu có -->
                    <% String success = request.getParameter("success"); %>
                    <% if ("add".equals(success)) { %>
                    <div class="alert alert-success">Thêm người dùng thành công!</div>
                    <% } else if ("update".equals(success)) { %>
                    <div class="alert alert-success">Cập nhật người dùng thành công!</div>
                    <% } else if ("delete".equals(success)) { %>
                    <div class="alert alert-success">Xóa người dùng thành công!</div>
                    <% } %>

                    <div class="page-title">User Management</div>
                    <div class="card">
                        <div class="card-header">User List</div>
                        <div class="card-body">
                            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addUserModal">Add User</button>
                            <table class="table table-striped">
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
                                        List<User> users = userDAO.getAllUsers(); // Giả sử có phương thức getAllUsers
                                        for (User u : users) {
                                    %>
                                    <tr>
                                        <td><%= u.getUserId() %></td>
                                        <td><%= u.getUsername() %></td>
                                        <td><%= u.getEmail() %></td>
                                        <td><%= u.getFullName() %></td>
                                        <td><%= u.getPhone() %></td>
                                        <td><%= u.getRoleId() == 1 ? "Customer" : u.getRoleId() == 2 ? "Staff" : u.getRoleId() == 3 ? "Manager" : "Shipper" %></td>
                                        <td><%= u.isIsActive() ? "Active" : "Inactive" %></td>
                                        <td>
                                            <a href="UserManagementServlet?action=edit&id=<%= u.getUserId() %>" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="UserManagementServlet?action=delete&id=<%= u.getUserId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn?')">Delete</a>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Add User Modal -->
                    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="UserManagementServlet" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" class="form-control" maxlength="50" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" maxlength="100" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control" minlength="6" maxlength="255" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" name="fullName" class="form-control" maxlength="100" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Phone</label>
                                        <input type="text" name="phone" class="form-control" pattern="0[0-9]{9,10}" title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Address</label>
                                        <input type="text" name="address" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Role ID</label>
                                        <select name="roleId" class="form-control" required>
                                            <option value="2">Staff</option>
                                            <option value="1">Customer</option>
                                            <option value="4">Shipper</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Active</label>
                                        <input type="checkbox" name="isActive" value="true" checked>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Add User</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Edit User Modal -->
                    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="UserManagementServlet" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="userId" value="<%= userToEdit != null ? userToEdit.getUserId() : "" %>">
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" class="form-control" value="<%= userToEdit != null ? userToEdit.getUsername() : "" %>" maxlength="50" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" value="<%= userToEdit != null ? userToEdit.getEmail() : "" %>" maxlength="100" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control" value="<%= userToEdit != null ? userToEdit.getPassword() : "" %>" minlength="6" maxlength="255" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" name="fullName" class="form-control" value="<%= userToEdit != null ? userToEdit.getFullName() : "" %>" maxlength="100" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Phone</label>
                                        <input type="text" name="phone" class="form-control" value="<%= userToEdit != null ? userToEdit.getPhone() : "" %>" pattern="0[0-9]{9,10}" title="Số điện thoại phải bắt đầu bằng 0 và có 10-11 số">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Address</label>
                                        <input type="text" name="address" class="form-control" value="<%= userToEdit != null ? userToEdit.getAddress() : "" %>">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Role ID</label>
                                        <select name="roleId" class="form-control" required>
                                            <option value="2" <%= userToEdit != null && userToEdit.getRoleId() == 2 ? "selected" : "" %>>Staff</option>
                                            <option value="1" <%= userToEdit != null && userToEdit.getRoleId() == 1 ? "selected" : "" %>>Customer</option>
                                            <option value="4" <%= userToEdit != null && userToEdit.getRoleId() == 4 ? "selected" : "" %>>Shipper</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Active</label>
                                        <input type="checkbox" name="isActive" value="true" <%= userToEdit != null && userToEdit.isIsActive() ? "checked" : "" %>>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Update User</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                <% if (userToEdit != null) { %>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    var myModal = new bootstrap.Modal(document.getElementById('editUserModal'));
                                                    myModal.show();
                                                });
                <% } %>
            </script>
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
    </body>
</html>