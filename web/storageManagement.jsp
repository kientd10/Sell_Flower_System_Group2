<%-- 
    Document   : storageManagement
    Created on : Jun 16, 2025, 9:32:11 AM
    Author     : ADMIN
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inventory Control | Flower Shop</title>

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

            /* ===== INVENTORY SPECIFIC STYLES ===== */
            .inventory-stats {
                background: white;
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                margin-bottom: 1.5rem;
            }

            .stock-level {
                padding: 0.4rem 0.8rem;
                border-radius: 15px;
                font-size: 0.75rem;
                font-weight: 600;
            }
            .stock-level.critical {
                background: #ff6b6b;
                color: white;
            }
            .stock-level.low {
                background: #feca57;
                color: #2f3542;
            }
            .stock-level.normal {
                background: #1dd1a1;
                color: white;
            }
            .stock-level.high {
                background: #48dbfb;
                color: #2f3542;
            }

            .reorder-alert {
                background: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 8px;
                padding: 1rem;
                margin-bottom: 1rem;
                border-left: 4px solid #f39c12;
            }

            .stock-progress {
                height: 8px;
                border-radius: 4px;
                overflow: hidden;
                background: #e9ecef;
            }
            .stock-progress .progress-bar {
                height: 100%;
                transition: width 0.3s ease;
            }
            .stock-progress .progress-bar.critical {
                background: #e74c3c;
            }
            .stock-progress .progress-bar.low {
                background: #f39c12;
            }
            .stock-progress .progress-bar.normal {
                background: #27ae60;
            }
            .stock-progress .progress-bar.high {
                background: #3498db;
            }

            .supplier-info {
                background: #f8f9fa;
                border-radius: 6px;
                padding: 0.5rem;
                font-size: 0.85rem;
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
                            <input type="text" class="form-control" placeholder="Search inventory..." id="inventorySearch">
                            <button class="btn btn-outline-secondary" onclick="searchInventory()"><i class="fas fa-search"></i></button>
                        </div>

                        <!--                        <div class="d-flex align-items-center gap-3">
                                                    <a href="stock-adjustment.jsp" class="btn btn-primary">
                                                        <i class="fas fa-edit me-2"></i>Stock Adjustment
                                                    </a>
                                                    <a href="purchase-order.jsp" class="btn btn-success">
                                                        <i class="fas fa-shopping-cart me-2"></i>Purchase Order
                                                    </a>
                                                    <button class="btn btn-outline-secondary" onclick="generateInventoryReport()">
                                                        <i class="fas fa-file-export me-2"></i>Export Report
                                                    </button>
                                                </div>-->
                    </div>
                </div>

                <!-- Main Content -->
                <div class="content-area">
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="page-title">Quản lí kho</h2>
                            <!--                            <p class="text-muted">Monitor stock levels, manage reorders, and track inventory movements</p>-->
                            <div class="page-title">
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm
                                    </button>
                           </div>
                        </div>

                    </div>

                    <!-- ===== INVENTORY OVERVIEW STATISTICS ===== -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="inventory-stats text-center">
                                <i class="fas fa-boxes fa-2x text-primary mb-2"></i>
                                <h4 class="text-primary">248</h4>
                                <p class="mb-0">Total Items</p>
                                <small class="text-muted">Across all categories</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="inventory-stats text-center">
                                <i class="fas fa-exclamation-triangle fa-2x text-warning mb-2"></i>
                                <h4 class="text-warning">12</h4>
                                <p class="mb-0">Low Stock Items</p>
                                <small class="text-muted">Need reordering</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="inventory-stats text-center">
                                <i class="fas fa-times-circle fa-2x text-danger mb-2"></i>
                                <h4 class="text-danger">3</h4>
                                <p class="mb-0">Out of Stock</p>
                                <small class="text-muted">Urgent attention</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="inventory-stats text-center">
                                <i class="fas fa-dollar-sign fa-2x text-success mb-2"></i>
                                <h4 class="text-success">$45.2K</h4>
                                <p class="mb-0">Total Value</p>
                                <small class="text-muted">Current inventory</small>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Inventory Product</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Quantity</th>
                                            <th>Status</th>
                                            <th>Ingredients</th>
                                            <th>Price</th>
                                            <th>Category</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach items="${bouquetList}" var="line1">
                                            <tr >
                                                <td>
                                                    <div>
                                                        <div class="text-muted">${line1.templateName}</div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="text-center">
                                                        <strong class="text-danger">${line1.stock}</strong>
                                                        <div class="text-muted small">units</div>
                                                        <div class="stock-progress mt-1">
                                                            <div class="progress-bar critical" style="width: 0%"></div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>

                                                </td>
                                                <td>
                                                    <c:forEach items="${line1.ingredients}" var="ing">
                                                        <strong class="text-muted small">${ing.name} : ${ing.requiredQuantity}</strong>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <strong class="text-muted">${line1.basePrice}</strong>
                                                </td>
                                                <td>
                                                    <strong class="text-muted">${line1.categoryName}</strong>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                                <a href="productmanagement?action=edit&mode=edit&editId=${line.templateId}" class="btn btn-sm btn-outline-primary" title="Edit">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button class="btn btn-sm btn-outline-danger"  onclick="return confirm('Bạn có chắc chắn muốn xóa lô hàng này?')" title="Xóa">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <nav aria-label="Inventory pagination" class="mt-3">
                                <c:set var="page" value="${page1}"/>
                                <div class="shop_toolbar t_bottom" style="border: none;">
                                    <div class="pagination">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach begin="1" end="${num1}" var="i1">
                                                <li class="page-item ${i1 == page1 ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="storagemanagement?action=view&page1=${i1}">
                                                        ${i1}
                                                    </a>

                                                </li>
                                            </c:forEach>

                                        </ul>

                                    </div>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>

                <div class="content-area">
                    <!-- ===== FILTER SECTION ===== -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-3">
                                    <label class="form-label">Lọc theo hạn sử dụng</label>
                                    <select class="form-select" onchange="filterByStockLevel(this.value)">
                                        <option value="critical"></option>
                                        <option value="low">Low Stock (12)</option>
                                        <option value="normal">Normal (198)</option>
                                        <option value="high">Overstocked (35)</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Expiration Date</label>
                                    <select class="form-select" onchange="filterByCategory(this.value)">
                                        <c:forEach items="${categoryList}" var="line">
                                            <option value="${line.categoryId}">${line.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Price</label>
                                    <select class="form-select" onchange="filterBySupplier(this.value)">
                                        <option value="">All Suppliers</option>
                                        <c:forEach items="${RawFlowerList}" var="line">
                                            <option value="${line.rawFlowerId}">${line.supplierName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRawFlowerModal">
                                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- ===== INVENTORY TABLE ===== -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Quản lí hoa thô</h5>

                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <!--                                        <th><input type="checkbox" class="form-check-input" onchange="selectAllItems(this)"></th>-->
                                            <th >Loại hoa</th>
                                            <th >Màu sắc</th>
                                            <th >Số lượng</th>
                                            <th >Trạng thái</th>
                                            <th >Nhà cung cấp</th>
                                            <th >Ngày nhập</th>
                                            <th >Ngày hết hạn</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach items="${RawFlowerList}" var="line">
                                            <tr >
                                                <!--                                                    <td><input type="checkbox" class="form-check-input item-checkbox" value="1"></td>-->
                                                <td>
                                                    <div>
                                                        <strong>Hoa ${line.rawFlowerName}</strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <strong>${line.colorName}</strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="text-center">
                                                        <strong class="text-danger">${line.quantity}</strong>
                                                        <div class="text-muted small">bông</div>
                                                        <div class="stock-progress mt-1">
                                                            <div class="progress-bar critical" style="width: 0%"></div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <strong>${line.status}</strong>
                                                    </div>
                                                </td>
                                                <td>

                                                    <strong>${line.supplierName}</strong>
                                                    <div class="text-muted small">Giá: ${line.unitPrice}/bông</div>

                                                </td>
                                                <td>
                                                    <div>
                                                        <strong>${line.importDate}</strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <strong>${line.expiryDate}</strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <a href="javascript:void(0)" 
                                                           class="btn btn-sm btn-outline-primary" title="Edit"
                                                           onclick="openEditModal(
                                                           ${line.rawFlowerId},
                                                                           '${line.typeId}',
                                                                           '${line.unitPrice}',
                                                                           '${fn:escapeXml(line.supplierName)}',
                                                                           '${line.colorId}',
                                                                           '${line.quantity}',
                                                                           '${line.importDate}',
                                                                           '${line.expiryDate}',
                                                                           '${fn:escapeXml(line.notes)}')">
                                                            <i class="fas fa-edit"></i>
                                                        </a>


                                                        <a href="storagemanagement?action=deleteRawflower&id=${line.rawFlowerId}" 
                                                           class="btn btn-sm btn-outline-danger" title="Delete"
                                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?')">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                            <!-- ===== BULK ACTIONS ===== -->
                            <div class="d-flex justify-content-between align-items-center mt-3">

                                <div class="text-muted">
                                    Showing 1 to 5 of ${fn:length(RawFlowerList)} items
                                </div>
                            </div>
                            <!-- ===== PAGINATION ===== -->
                            <!--                            <nav aria-label="Inventory pagination" class="mt-3">
                            <c:set var="page" value="${page}"/>
                            <div class="shop_toolbar t_bottom" style="border: none;">
                                <div class="pagination">
                                    <ul class="pagination justify-content-center">
                            <c:forEach begin="1" end="${num}" var="i">
                                <li class="page-item ${i == page ? 'active' : ''}">
                                    <a class="page-link"
                                       href="storagemanagement?action=view&page=${i}&page1=${param.page1}">
                                ${i}
                            </a>
                        </li>
                            </c:forEach>

                        </ul>

                    </div>
                </div>
            </nav>-->
                        </div>
                    </div>
                </div>
            </div>
                            <!<!-- add product -->
                            <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModal" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModal">
                                Thêm sản phẩm theo mẫu
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="storagemanagement" method="get">
                            <input type="hidden" name="action" value="addProduct">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Mẫu sản phẩm</label>
                                        <select class="form-select" name="templateId" id="modal-templateId" required>
                                            <c:forEach var="name" items="${productList}">
                                                <option value="${name.templateId}">${name.templateName}</option>
                                            </c:forEach>
                                        </select>
                                    </div >
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Số lượng</label>
                                        <input type="number" class="form-control" name="quantity" id="modal-quantity" required>
                                    </div>
                                    

                            </div>
                                 
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Thoát</button>
                                <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Add Modal -->
            <div class="modal fade" id="addRawFlowerModal" tabindex="-1" aria-labelledby="addRawFlowerModal" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addRawFlowerModal">
                                Thêm sản phẩm
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="storagemanagement" method="get">
                            <input type="hidden" name="action" value="addRawflower">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên hoa</label>
                                        <select class="form-select" name="typeId" id="modal-typeid" required>
                                            <c:forEach var="name" items="${flowerNameList}">
                                                <option value="${name.typeId}">${name.typeName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <!-- Danh mục (Color) -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Màu sắc</label>
                                        <select class="form-select" name="colorId" id="modal-colorId" required>
                                            <c:forEach var="cat" items="${colorList}">
                                                <option value="${cat.colorId}">${cat.colorName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Số lượng (bông)</label>
                                        <input type="number" class="form-control" name="quantity" id="modal-quantity" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ghi chú</label>
                                        <input type="text" class="form-control" name="notes" id="modal-notes">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Nhà cung cấp</label>
                                        <input type="text" class="form-control" name="supplierName" id="modal-supplierName">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Giá từng bông</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" name="unitPrice" id="modal-unitPrice" required>
                                            <span class="input-group-text">đ/bông</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ngày nhập</label>
                                        <input type="date" class="form-control" name="importDate" id="modal-importDate" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ngày hết hạn</label>
                                        <input type="date" class="form-control" name="expiryDate" id="modal-expiryDate" required>
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Thoát</button>
                                <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!<!-- Edit modal -->
            <div class="modal fade" id="rawflowerModal" tabindex="-1" aria-labelledby="rawflowerModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <form action="storagemanagement" method="get">
                        <input type="hidden" name="action" value="updateRawflower" />
                        <input type="hidden" name="rawflowerId" id="modal-rawFlowerId" />
                        <input type="hidden" name="typeId" id="modal-typeid"/>
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="rawflowerModalLabel">Thông tin hoa thô</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row g-3">

                                    <!-- Tên hoa -->
                                    <div class="col-md-6">
                                        <label class="form-label">Tên hoa</label>
                                        <select class="form-select" name="typeId" id="modal-typeid" required>
                                            <c:forEach var="name" items="${flowerNameList}">
                                                <option value="${name.typeId}">${name.typeName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Danh mục (Color) -->
                                    <div class="col-md-6">
                                        <label class="form-label">Màu sắc</label>
                                        <select class="form-select" name="colorId" id="modal-colorId" required>
                                            <c:forEach var="cat" items="${colorList}">
                                                <option value="${cat.colorId}">${cat.colorName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Số lượng -->
                                    <div class="col-md-6">
                                        <label class="form-label">Số lượng (bông)</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" name="quantity" id="modal-quantity" required>
                                            <span class="input-group-text">bông</span>
                                        </div>
                                    </div>
                                    <!-- Nhà cung cấp -->
                                    <div class="col-md-6">
                                        <label class="form-label">Nhà cung cấp</label>
                                        <input type="text" class="form-control" name="supplierName" id="modal-supplierName">
                                    </div>

                                    <!-- Giá từng bông -->
                                    <div class="col-md-6">
                                        <label class="form-label">Giá từng bông</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" name="unitPrice" id="modal-unitPrice" required>
                                            <span class="input-group-text">đ/bông</span>
                                        </div>
                                    </div>

                                    <!-- Ngày nhập -->
                                    <div class="col-md-6">
                                        <label class="form-label">Ngày nhập</label>
                                        <input type="date" class="form-control" name="importDate" id="modal-importDate" required>
                                    </div>

                                    <!-- Ngày hết hạn -->
                                    <div class="col-md-6">
                                        <label class="form-label">Ngày hết hạn</label>
                                        <input type="date" class="form-control" name="expiryDate" id="modal-expiryDate" required>
                                    </div>

                                    <!<!-- Notes -->
                                    <div class="col-md-6">
                                        <label class="form-label">Ghi chú</label>
                                        <input type="text" class="form-control" name="notes" id="modal-notes">
                                    </div>

                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Lưu</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                                                               // ===== INVENTORY MANAGEMENT FUNCTIONALITY =====

                                                               // Search inventory
                                                               function searchInventory() {
                                                                   const searchTerm = document.getElementById('inventorySearch').value;
                                                                   console.log('Searching inventory:', searchTerm);
                                                                   // Implementation would filter inventory based on search term
                                                               }
                                                               function openEditModal(id, typeid, unitPrice, supplierName, colorId, quantity, importDate, expiryDate, notes) {
                                                                   document.getElementById("rawflowerModalLabel").innerText = "Chỉnh sửa sản phẩm";
                                                                   document.getElementById("modal-rawFlowerId").value = id;
                                                                   document.getElementById("modal-typeid").value = typeid;
                                                                   document.getElementById("modal-unitPrice").value = unitPrice;
                                                                   document.getElementById("modal-supplierName").value = supplierName;
                                                                   document.getElementById("modal-colorId").value = colorId;
                                                                   document.getElementById("modal-quantity").value = quantity;
                                                                   document.getElementById("modal-importDate").value = importDate;
                                                                   document.getElementById("modal-expiryDate").value = expiryDate;
                                                                   document.getElementById("modal-notes").value = notes;
                                                                   let modal = new bootstrap.Modal(document.getElementById('rawflowerModal'));
                                                                   modal.show();

                                                               }
                                                               function openAddModal() {
                                                                   document.getElementById("productModalLabel").innerText = "Thêm sản phẩm mới";
                                                                   document.getElementById("modal-typeId").value = "";
                                                                   document.getElementById("modal-templateName").value = "";
                                                                   document.getElementById("modal-unitPrice").value = "";
                                                                   document.getElementById("modal-description").value = "";
                                                                   document.getElementById("modal-imageUrl").value = "";
                                                                   document.getElementById("modal-categoryId").selectedIndex = 0;

                                                                   let modal = new bootstrap.Modal(document.getElementById('productModal'));
                                                                   modal.show();
                                                               }
                                                               
                                                               function addProductModal() {
                                                                   document.getElementById("productModalLabe2").innerText = "Thêm mẫu mới";
                                                                   document.getElementById("modal-templateId").value = "";
                                                                   document.getElementById("modal-templateName").value = "";
                                                                   document.getElementById("modal-quantity").value = "";
                                                                  //document.getElementById("modal-Ingredients").value = "";
//                                                                   document.getElementById("modal-imageUrl").value = "";
//                                                                   document.getElementById("modal-categoryId").selectedIndex = 0;

                                                                   let modal = new bootstrap.Modal(document.getElementById('productModal'));
                                                                   modal.show();
                                                               }

                                                               // Filter functions
                                                               function filterByStockLevel(level) {
                                                                   console.log('Filter by stock level:', level);
                                                               }
                                                               function filterByCategory(category) {
                                                                   console.log('Filter by category:', category);
                                                               }
                                                               function filterBySupplier(supplier) {
                                                                   console.log('Filter by supplier:', supplier);
                                                               }
                                                               function filterByLocation(location) {
                                                                   console.log('Filter by location:', location);
                                                               }

                                                               // Inventory actions
                                                               function urgentReorder(itemId) {
                                                                   if (confirm('Create urgent purchase order for this out-of-stock item?')) {
                                                                       console.log('Creating urgent reorder for item:', itemId);
                                                                       window.location.href = `urgent-purchase-order.jsp?itemId=${itemId}`;
                                                                   }
                                                               }

                                                               function createReorder(itemId) {
                                                                   console.log('Creating reorder for item:', itemId);
                                                                   window.location.href = `create-purchase-order.jsp?itemId=${itemId}`;
                                                               }

                                                               function createPromotion(itemId) {
                                                                   console.log('Creating promotion for overstocked item:', itemId);
                                                                   window.location.href = `create-promotion.jsp?itemId=${itemId}`;
                                                               }

                                                               function transferStock(itemId) {
                                                                   console.log('Transferring stock for item:', itemId);
                                                                   window.location.href = `stock-transfer.jsp?itemId=${itemId}`;
                                                               }

                                                               function viewDetails(itemId) {
                                                                   console.log('Viewing details for item:', itemId);
                                                                   window.location.href = `inventory-details.jsp?itemId=${itemId}`;
                                                               }

                                                               // Bulk actions
                                                               function selectAllItems(checkbox) {
                                                                   const itemCheckboxes = document.querySelectorAll('.item-checkbox');
                                                                   itemCheckboxes.forEach(cb => cb.checked = checkbox.checked);
                                                                   updateBulkActionButtons();
                                                               }

                                                               function updateBulkActionButtons() {
                                                                   const selectedItems = document.querySelectorAll('.item-checkbox:checked');
                                                                   const bulkButtons = ['bulkAdjustBtn', 'bulkReorderBtn', 'bulkTransferBtn', 'bulkPromotionBtn'];

                                                                   bulkButtons.forEach(btnId => {
                                                                       document.getElementById(btnId).disabled = selectedItems.length === 0;
                                                                   });
                                                               }

                                                               function bulkAdjustment() {
                                                                   const selected = document.querySelectorAll('.item-checkbox:checked');
                                                                   const ids = Array.from(selected).map(cb => cb.value);
                                                                   window.location.href = `bulk-stock-adjustment.jsp?itemIds=${ids.join(',')}`;
                                                               }

                                                               function bulkReorder() {
                                                                   const selected = document.querySelectorAll('.item-checkbox:checked');
                                                                   const ids = Array.from(selected).map(cb => cb.value);
                                                                   window.location.href = `bulk-purchase-order.jsp?itemIds=${ids.join(',')}`;
                                                               }

                                                               function bulkTransfer() {
                                                                   const selected = document.querySelectorAll('.item-checkbox:checked');
                                                                   const ids = Array.from(selected).map(cb => cb.value);
                                                                   window.location.href = `bulk-stock-transfer.jsp?itemIds=${ids.join(',')}`;
                                                               }

                                                               function bulkPromotion() {
                                                                   const selected = document.querySelectorAll('.item-checkbox:checked');
                                                                   const ids = Array.from(selected).map(cb => cb.value);
                                                                   window.location.href = `bulk-promotion.jsp?itemIds=${ids.join(',')}`;
                                                               }

                                                               function generateInventoryReport() {
                                                                   window.location.href = 'inventory-report.jsp?format=excel';
                                                               }


                                                               // Initialize page
                                                               document.addEventListener('DOMContentLoaded', function () {
                                                                   // Add event listeners to item checkboxes
                                                                   document.querySelectorAll('.item-checkbox').forEach(checkbox => {
                                                                       checkbox.addEventListener('change', updateBulkActionButtons);
                                                                   });

                                                                   // Enable real-time search
                                                                   document.getElementById('inventorySearch').addEventListener('keyup', function (e) {
                                                                       if (e.key === 'Enter') {
                                                                           searchInventory();
                                                                       }
                                                                   });

                                                                   // Auto-refresh inventory status every 10 minutes
                                                                   setInterval(function () {
                                                                       console.log('Auto-refreshing inventory status...');
                                                                       // Implementation would refresh inventory data via AJAX
                                                                   }, 600000);

                                                                   // Check for critical stock alerts every 5 minutes
                                                                   setInterval(function () {
                                                                       console.log('Checking for critical stock alerts...');
                                                                       // Implementation would check for new critical stock situations
                                                                   }, 300000);
                                                               });

                                                               // Tự động highlight menu item dựa trên URL hiện tại
                                                               document.addEventListener('DOMContentLoaded', function () {
                                                                   // Highlight menu item based on URL path
                                                                   var path = window.location.pathname.toLowerCase();
                                                                   document.querySelectorAll('.sidebar-link').forEach(function (link) {
                                                                       link.classList.remove('active');
                                                                   });

                                                                   if (path.includes('/category')) {
                                                                       var categoryLink = document.getElementById('menu-categoryManagement');
                                                                       if (categoryLink)
                                                                           categoryLink.classList.add('active');
                                                                   } else if (path.includes('/productmanagement')) {
                                                                       var productLink = document.getElementById('menu-productManagement');
                                                                       if (productLink)
                                                                           productLink.classList.add('active');
                                                                   } else if (path.includes('/storagemanagement')) {
                                                                       var storageLink = document.getElementById('menu-storageManagement');
                                                                       if (storageLink)
                                                                           storageLink.classList.add('active');
                                                                   } else if (path.includes('/ordermanagement')) {
                                                                       var orderLink = document.getElementById('menu-orderManagement');
                                                                       if (orderLink)
                                                                           orderLink.classList.add('active');
                                                                   } else if (path.includes('/invoicemanagement')) {
                                                                       var invoiceLink = document.getElementById('menu-invoiceManagement');
                                                                       if (invoiceLink)
                                                                           invoiceLink.classList.add('active');
                                                                   } else if (path.includes('usermanagement.jsp')) {
                                                                       var userLink = document.getElementById('menu-userManagement');
                                                                       if (userLink)
                                                                           userLink.classList.add('active');
                                                                   } else if (path.includes('feedbackmanagement.jsp')) {
                                                                       var feedbackLink = document.getElementById('menu-feedbackManagement');
                                                                       if (feedbackLink)
                                                                           feedbackLink.classList.add('active');
                                                                   } else if (path.includes('notificationmanagement.jsp')) {
                                                                       var notificationLink = document.getElementById('menu-notificationManagement');
                                                                       if (notificationLink)
                                                                           notificationLink.classList.add('active');
                                                                   } else if (path.includes('/statistics')) {
                                                                       var managementLink = document.getElementById('menu-management');
                                                                       if (managementLink)
                                                                           managementLink.classList.add('active');
                                                                   }
                                                               });

            </script>
    </body>
</html>
