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
                        <li><a href="storagemanagement?action=view" class="sidebar-link active" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                        <li><a href="orderManagement" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                    </c:if> 

                    <!-- Chỉ hiển thị nếu là Manager -->
                    <c:if test="${sessionScope.user.roleId == 3}"> 
                        <li><a href="statistics" class="sidebar-link" id="menu-management"><i class="fas fa-chart-bar"></i>Quản Lý</a></li>
                        <li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                        <li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
                        <li><a href="storagemanagement?action=view" class="sidebar-link active" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                        <li><a href="orderManagement" class="sidebar-link" id="menu-orderManagement"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                        <li><a href="InvoiceManagement?action=displayAll" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>
                        <li class="sidebar-header">Hệ Thống</li>
                        <li><a href="userManagement.jsp" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Người Dùng</a></li>
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
                            <h2 class="page-title">Inventory Control</h2>
                            <p class="text-muted">Monitor stock levels, manage reorders, and track inventory movements</p>
                        </div>
                        <div class="text-muted">
                            Total Items: <strong>248</strong> | Value: <strong>$45,230</strong>
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
                            <div class="d-flex align-items-center gap-3">
                                <a href="storagemanagement?action=add" class="btn btn-success">
                                    <i class="fas fa-shopping-cart me-2"></i>Build New Product
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" class="form-check-input" onchange="selectAllItems(this)"></th>
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
                                        <c:choose>
                                            <c:when test="${action == 'view' && editMode}">
                                                <c:forEach items="${bouquetList}" var="line1">
                                                    <tr class="table-danger">
                                                        <td><input type="checkbox" class="form-check-input item-checkbox" value="1"></td>
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
                                                                <button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(1)" title="Delete">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            <form action="storagemanagement?action=addProduct" method="get">
                                                <tr class="table-success">
                                                    <td></td>
                                                    <td>
                                                        <input type="text" name="newTemplateName" class="form-control" placeholder="Tên mẫu" />
                                                        <input type="text" name="newTemplateID" class="text-muted small" placeholder="ProductID" />
                                                    </td>
                                                    <td><input type="number" name="newStock" class="form-control" placeholder="Số lượng" min="0" /></td>
                                                    <td></td>
                                                    <td>
                                                        <div id="ingredients-container">
                                                            <div class="ingredient-row d-flex align-items-center mb-2">
                                                                <select name="typeId" class="form-select me-1" style="width:120px;">
                                                                    <option>Type</option>
                                                                    <c:forEach items="${TypeList}" var="t">
                                                                        <option value="${t.typeId}">${t.typeName}</option>
                                                                    </c:forEach>
                                                                </select>

                                                                <select name="colorId" class="form-select me-1" style="width:120px;">
                                                                    <option>Color</option>
                                                                    <c:forEach items="${ColorList}" var="c">
                                                                        <option value="${c.colorId}">${c.colorName}</option>
                                                                    </c:forEach>
                                                                </select>

                                                                <input type="number" name="quantity" class="form-control me-1" 
                                                                       placeholder="Qty" min="1" style="width:80px;"/>

                                                                <button type="button" class="btn btn-sm btn-success save-ingredient me-1">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                                <button type="button" class="btn btn-sm btn-danger remove-ingredient">
                                                                    <i class="fas fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <button type="button" id="add-ingredient-btn" class="btn btn-sm btn-outline-primary">+ Add ingredient</button>
                                                    </td>

                                                    <td><input type="number" name="newBasePrice" class="form-control" placeholder="Giá cơ bản" min="0" /></td>
                                                    <td>
                                                        <div id="ingredients-container">
                                                            <div class="ingredient-row d-flex align-items-center mb-2">
                                                                <select name="newCategory" class="form-select me-1" style="width:120px;">
                                                                    <option>Category</option>
                                                                    <c:forEach items="${categoryList}" var="t">
                                                                        <option value="${t.categoryId}">${t.categoryName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <button type="button" id="add-ingredient-btn" class="btn btn-sm btn-outline-primary">+ Add Category</button>
                                                    </td>
                                                    <td><button type="submit" class="btn btn-primary btn-sm">Save</button></td>
                                                </tr>
                                            </form>
                                        </c:when>
                                        <c:when test="${param.action == 'view'}">
                                            <c:forEach items="${bouquetList}" var="line1">
                                                <tr class="table-danger">
                                                    <td><input type="checkbox" class="form-check-input item-checkbox" value="1"></td>
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
                                                            <div class="text-muted small">${ing.name} : ${ing.requiredQuantity}</div>
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
                                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(1)" title="Delete">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- ===== FILTER SECTION ===== -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-3">
                                    <label class="form-label">Stock Level</label>
                                    <select class="form-select" onchange="filterByStockLevel(this.value)">
                                        <option value="critical">Critical (3)</option>
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
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ===== INVENTORY TABLE ===== -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Inventory RawFlower</h5>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-light">Show:</span>
                            <select class="form-select form-select-sm" style="width: auto;">
                                <option value="25" selected>25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                            <span class="text-light">entries</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" class="form-check-input" onchange="selectAllItems(this)"></th>
                                        <th>Product Info</th>
                                        <th>Current Stock</th>
                                        <th>Status</th>
                                        <th>Supplier Info</th>
                                        <th>Expiration date</th>
                                        <th>Price</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${param.action == 'view' || param.action == 'add'}">
                                            <c:forEach items="${RawFlowerList}" var="line">
                                                <tr class="table-danger">
                                                    <td><input type="checkbox" class="form-check-input item-checkbox" value="1"></td>
                                                    <td>
                                                        <div>
                                                            <strong>Hoa ${line.rawFlowerName}</strong>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="text-center">
                                                            <strong class="text-danger">${line.quantity}</strong>
                                                            <div class="text-muted small">units</div>
                                                            <div class="stock-progress mt-1">
                                                                <div class="progress-bar critical" style="width: 0%"></div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td><span class="stock-level critical">OUT OF STOCK</span></td>
                                                    <td>
                                                        <div class="supplier-info">
                                                            <strong>${line.supplierName}</strong>
                                                            <div class="text-muted small">Date of entry: </div>
                                                            <div class="text-muted small">Cost: ${line.unitPrice}/unit</div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <strong>$0.00</strong>
                                                            <div class="text-muted small">Unit: $45.00</div>
                                                            <div class="text-danger small">Lost sales risk</div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <strong>${line.unitPrice}</strong>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group-vertical" role="group">
                                                            <button class="btn btn-sm btn-danger" onclick="urgentReorder(1)">
                                                                <i class="fas fa-exclamation-triangle"></i> Urgent Order
                                                            </button>
                                                            <a href="stock-adjustment.jsp?id=1" class="btn btn-sm btn-outline-primary">
                                                                <i class="fas fa-edit"></i> Adjust
                                                            </a>
                                                            <a href="inventory-history.jsp?id=1" class="btn btn-sm btn-outline-info">
                                                                <i class="fas fa-history"></i> History
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                        <!-- ===== BULK ACTIONS ===== -->
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div>
                                <button class="btn btn-outline-primary btn-sm" onclick="bulkAdjustment()" disabled id="bulkAdjustBtn">
                                    <i class="fas fa-edit me-2"></i>Bulk Adjustment
                                </button>
                                <button class="btn btn-outline-success btn-sm" onclick="bulkReorder()" disabled id="bulkReorderBtn">
                                    <i class="fas fa-shopping-cart me-2"></i>Bulk Reorder
                                </button>
                                <button class="btn btn-outline-info btn-sm" onclick="bulkTransfer()" disabled id="bulkTransferBtn">
                                    <i class="fas fa-exchange-alt me-2"></i>Transfer Stock
                                </button>
                                <button class="btn btn-outline-warning btn-sm" onclick="bulkPromotion()" disabled id="bulkPromotionBtn">
                                    <i class="fas fa-percent me-2"></i>Create Promotion
                                </button>
                            </div>
                            <div class="text-muted">
                                Showing 1 to 5 of 248 items
                            </div>
                        </div>
                        <!-- ===== PAGINATION ===== -->
                        <nav aria-label="Inventory pagination" class="mt-3">
                            <ul class="pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="inventory.jsp?page=2">2</a></li>
                                <li class="page-item"><a class="page-link" href="inventory.jsp?page=3">3</a></li>
                                <li class="page-item"><a class="page-link" href="inventory.jsp?page=4">4</a></li>
                                <li class="page-item"><a class="page-link" href="inventory.jsp?page=5">5</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="inventory.jsp?page=2"><i class="fas fa-chevron-right"></i></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
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
                                    document.addEventListener('DOMContentLoaded', function() {
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
