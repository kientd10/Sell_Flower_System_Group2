<%-- 
    Document   : feedbackManagement
    Created on : Jun 16, 2025, 9:51:13 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

            /* ===== FEEDBACK SPECIFIC STYLES ===== */
            .feedback-status {
                padding: 0.3rem 0.6rem;
                border-radius: 12px;
                font-size: 0.7rem;
                font-weight: 600;
            }
            .feedback-status.new {
                background: #cce5ff;
                color: #004085;
            }
            .feedback-status.read {
                background: #e8f5e8;
                color: #388e3c;
            }
            .feedback-status.replied {
                background: #d4edda;
                color: #155724;
            }
            .feedback-status.resolved {
                background: #e2e3e5;
                color: #383d41;
            }
            .feedback-status.pending {
                background: #fff3cd;
                color: #856404;
            }

            .feedback-type {
                padding: 0.3rem 0.6rem;
                border-radius: 12px;
                font-size: 0.7rem;
                font-weight: 600;
            }
            .feedback-type.complaint {
                background: #f8d7da;
                color: #721c24;
            }
            .feedback-type.suggestion {
                background: #e3f2fd;
                color: #1976d2;
            }
            .feedback-type.compliment {
                background: #e8f5e8;
                color: #388e3c;
            }
            .feedback-type.question {
                background: #fff3e0;
                color: #f57c00;
            }
            .feedback-type.bug-report {
                background: #f3e5f5;
                color: #7b1fa2;
            }

            .rating-stars {
                color: #ffc107;
                font-size: 1.1rem;
            }
            .rating-stars .empty {
                color: #e9ecef;
            }

            .feedback-summary {
                background: white;
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 1.5rem;
            }

            .summary-item {
                text-align: center;
                padding: 1rem;
            }
            .summary-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .feedback-actions {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
            }

            .feedback-preview {
                max-width: 300px;
                max-height: 100px;
                overflow: hidden;
                text-overflow: ellipsis;
                font-size: 0.9rem;
                line-height: 1.4;
            }

            .priority-indicator {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                display: inline-block;
                margin-right: 0.5rem;
            }
            .priority-indicator.high {
                background: var(--primary-red);
            }
            .priority-indicator.medium {
                background: #ffc107;
            }
            .priority-indicator.low {
                background: #28a745;
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
                                    <!-- =====phan duc lam===== -->


                                    <c:if test="${empty feedbacks}">
                                        <tr><td colspan="8" style="color:red;">Không có phản hồi nào!</td></tr>
                                    </c:if>
                                    <p>Tổng phản hồi: ${fn:length(feedbacks)}</p>
                                    <tbody>
                                        <c:forEach var="f" items="${feedbacks}">
                                            <tr>
                                                <td><input type="checkbox" class="form-check-input feedback-checkbox" value="${f.feedbackId}"></td>
                                                <td>
                                                    <div>
                                                        <strong>${f.customerName}</strong>
                                                        <!-- Nếu có thêm email và phone từ bảng user thì bạn có thể truyền và hiện ở đây -->
                                                        <div class="text-muted small">${f.email}</div>
                                                        <div class="text-muted small">${f.phone}</div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="feedback-preview">
                                                        <strong>Phản hồi</strong>
                                                        <div class="text-muted small">${f.comment}</div>
                                                    </div>
                                                </td>
                                                <td><span class="feedback-type">Từ Đơn Hàng</span></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${f.rating > 0}">
                                                            <div class="rating-stars">
                                                                <c:forEach var="i" begin="1" end="5">
                                                                    <i class="fas fa-star ${i <= f.rating ? '' : 'empty'}"></i>
                                                                </c:forEach>
                                                            </div>
                                                            <div class="text-muted small">${f.rating}/5</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="text-muted small">Chưa đánh giá</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><span class="feedback-status new">Mới</span></td>
                                                <td>
                                                    <div>
                                                        <strong><fmt:formatDate value="${f.createdAt}" pattern="dd/MM/yyyy"/></strong>
                                                        <div class="text-muted small"><fmt:formatDate value="${f.createdAt}" pattern="HH:mm"/></div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="priority-indicator medium"></span>
                                                    <span class="text-warning small">Trung Bình</span>
                                                </td>
                                                <td>
                                                    <div class="feedback-actions">
                                                        <button class="btn btn-sm btn-outline-primary" onclick="viewFeedback(${f.feedbackId})" title="Xem Chi Tiết">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                        <!-- Các nút khác bạn muốn thêm -->
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <!-- =====phan duc lam===== -->

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
                                        function filterByStatus(status) {
                                            console.log('Lọc theo trạng thái:', status);
                                        }
                                        function filterByType(type) {
                                            console.log('Lọc theo loại:', type);
                                        }
                                        function filterByRating(rating) {
                                            console.log('Lọc theo đánh giá:', rating);
                                        }
                                        function filterByTime(time) {
                                            console.log('Lọc theo thời gian:', time);
                                        }

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
                                        document.addEventListener('DOMContentLoaded', function () {
                                            // Add event listeners to feedback checkboxes
                                            document.querySelectorAll('.feedback-checkbox').forEach(checkbox => {
                                                checkbox.addEventListener('change', updateBulkActionButtons);
                                            });

                                            // Enable real-time search
                                            document.getElementById('feedbackSearch').addEventListener('keyup', function (e) {
                                                if (e.key === 'Enter') {
                                                    searchFeedback();
                                                }
                                            });

                                            // Set active menu
                                            document.querySelectorAll('.sidebar-link').forEach(l => l.classList.remove('active'));
                                            document.getElementById('menu-feedbackManagement').classList.add('active');

                                            console.log('Trang quản lý phản hồi đã được khởi tạo');
                                        });

                                        // Highlight current menu
                                        document.addEventListener('DOMContentLoaded', function () {
                                            var currentUrl = window.location.href;
                                            document.querySelectorAll('.sidebar-link').forEach(function (link) {
                                                link.classList.remove('active');
                                            });

                                            if (currentUrl.includes('feedbackManagement.jsp')) {
                                                var feedbackLink = document.getElementById('menu-feedbackManagement');
                                                if (feedbackLink) {
                                                    feedbackLink.classList.add('active');
                                                }
                                            }
                                        });
        </script>
    </body>
</html>
