
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Product Management | Flower Shop</title>
        <!-- External CSS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            /* ===== SHARED STYLES (Same as index.jsp) ===== */
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

            /* ===== PRODUCT SPECIFIC STYLES ===== */
            .product-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e9ecef;
                cursor: pointer;
                transition: transform 0.3s ease;
            }

            .product-image:hover {
                transform: scale(1.1);
                border-color: var(--primary-red);
            }

            .stock-badge {
                padding: 0.4rem 0.8rem;
                border-radius: 15px;
                font-size: 0.75rem;
                font-weight: 600;
            }
            .stock-badge.in-stock {
                background: #d4edda;
                color: #155724;
            }
            .stock-badge.low-stock {
                background: #fff3cd;
                color: #856404;
            }
            .stock-badge.out-of-stock {
                background: #f8d7da;
                color: #721c24;
            }

            .category-filter {
                background: white;
                border-radius: 8px;
                padding: 1rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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
                        <form class="input-group" style="width: 300px;" method="get" action="productmanagement">
                            <input type="hidden" name="action" value="view" />
                            <input type="text" class="form-control" name="search" placeholder="Tìm kiếm sản phẩm..."
                                   value="${search != null ? search : ''}" />
                            <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                        </form>


                        <div class="d-flex align-items-center gap-3">
                            <button class="btn btn-primary" onclick="openAddModal()">Thêm sản phẩm</button>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="content-area">
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="page-title">Quản lí sản phẩm</h2>

                        </div>
                        <div class="text-muted">
                            Tổng sản phẩm: <strong>248</strong> | Active: <strong>235</strong>
                        </div>
                    </div>

                    <!-- ===== FILTER & CATEGORY SECTION ===== -->
                    <div class="category-filter">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center gap-3">
                                    <form method="get" action="productmanagement">
                                        <label>Lọc theo loại:</label>
                                        <select name="categoryId" onchange="this.form.submit()">
                                            <option value="">All Categories</option>
                                            <c:forEach var="c" items="${categoryList}">
                                                <option value="${c.categoryId}" ${c.categoryId == categoryId ? 'selected' : ''}>${c.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </form>



                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- ===== PRODUCT TABLE ===== -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Danh sách sản phẩm</h5>
                            <div class="d-flex align-items-center gap-3">
                                <span class="text-light">Show:</span>
                                <select class="form-select form-select-sm" style="width: auto;" onchange="changeEntriesPerPage(this.value)">
                                    <option value="10" selected>10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select>
                                <span class="text-light">entries</span>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover" id="productsTable">
                                    <thead>
                                        <tr>
                                            <th>
                                                <input type="checkbox" class="form-check-input" onchange="selectAllProducts(this)">
                                            </th>
                                            <th>Image</th>
                                            <th>Product Info</th>
                                            <th>Category</th>
                                            <th>Price</th>
                                            <th>Stock</th>

                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${action == 'view' && editMode}">
                                                <c:forEach items="${bouquetList}" var="line">
                                                    <tr>
                                                        <td><input type="checkbox" class="form-check-input product-checkbox" value="1" /></td>
                                                        <td>
                                                            <img class="image-wrapper"
                                                                 src="${pageContext.request.contextPath}/images/cart/${line.imageUrl}"
                                                                 alt="${line.templateName}" />
                                                        </td>
                                                        <td>

                                                            <form action="productmanagement" method="get">
                                                                <input type="hidden" name="templateId" value="${line.templateId}" />
                                                                <input type="hidden" name="action" value="update" />
                                                                <div class="text-muted small">Web ID: ${line.templateId}</div>
                                                                <textarea name="templateName"
                                                                          class="form-control"
                                                                          placeholder="Nhập tên"
                                                                          rows="3"
                                                                          style="resize: none; overflow: hidden;"
                                                                          oninput="autoResize(this)">${line.templateName}</textarea>
                                                                <textarea name="description"
                                                                          class="form-control"
                                                                          placeholder="Nhập mô tả"
                                                                          rows="3"
                                                                          style="resize: none; overflow: hidden;"
                                                                          oninput="autoResize(this)">${line.description}</textarea>
                                                        </td>
                                                        <td><span class="badge bg-info">${line.categoryName}</span></td>
                                                        <td>
                                                            <strong>$150.00</strong>
                                                            <input type="number" name="basePrice" class="form-control" min="0" step="0.01"
                                                                   value="${line.basePrice}" />

                                                        </td>
                                                        <td>
                                                            <input type="number" name="stock" class="form-control" min="0"
                                                                   value="${line.stock}" />
                                                        </td>

                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <button type="submit" class="btn btn-success px-4">
                                                                    Save
                                                                </button>
                                                            </div>
                                                            </form>
                                                            <a href="javascript:void(0)" 
                                                               class="btn btn-sm btn-outline-primary"
                                                               onclick="openEditModal(${line.templateId}, '${fn:escapeXml(line.templateName)}', '${line.basePrice}', '${fn:escapeXml(line.description)}', '${line.imageUrl}', ${line.categoryId})">
                                                                <i class="fas fa-edit"></i>
                                                            </a>

                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:when test="${param.action == 'view'}">
                                                <c:forEach items="${bouquetList}" var="line">
                                                    <tr>
                                                        <td><input type="checkbox" class="form-check-input product-checkbox" value="1"></td>
                                                        <td>
                                                            <img
                                                                class="image-wrapper"
                                                                src="${pageContext.request.contextPath}/images/cart/${line.imageUrl}"
                                                                alt="${line.templateName}" />
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <strong>${line.templateName}</strong>
                                                                <div class="text-muted small">Web: ${line.templateId}</div>
                                                                <div class="text-muted small">Added: </div>
                                                                <div class="text-muted">Description: ${line.description} </div>
                                                            </div>
                                                        </td>
                                                        <td><span class="badge bg-info">${line.categoryName}</span></td>
                                                        <td>
                                                            <strong>$150.00</strong>
                                                            <div class="text-muted small">Cost: ${line.basePrice}</div>
                                                        </td>
                                                        <td>
                                                            <strong>${line.stock}</strong>
                                                            <div class="text-muted small">Min: ${line.stock}</div>
                                                        </td>

                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <a href="javascript:void(0)" 
                                                                   class="btn btn-sm btn-outline-primary" title="Edit"
                                                                   onclick="openEditModal(
                                                                   ${line.templateId},
                                                                                   '${fn:escapeXml(line.templateName)}',
                                                                                   '${line.basePrice}',
                                                                                   '${fn:escapeXml(line.description)}',
                                                                                   '${line.imageUrl}',
                                                                   ${line.categoryId}
                                                                           )">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>


                                                                <a href="productmanagement?action=delete&id=${line.templateId}" 
                                                                   class="btn btn-sm btn-outline-danger" title="Delete"
                                                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?')">
                                                                    <i class="fas fa-trash"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr> 
                                                </c:forEach>
                                            </c:when> 
                                        </c:choose>
                                    </tbody>
                                </table>
                                <div class="pagination justify-content-center">
                                    <ul class="pagination">
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="productmanagement?action=view&page=${i}${not empty search ? '&search=' += search : ''}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>


                            </div>
                            <!-- Modal Form Add/Edit Product -->
                            <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <form action="productmanagement" method="post">
                                        <input type="hidden" name="action" value="save" />
                                        <input type="hidden" name="templateId" id="modal-templateId" />
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="productModalLabel">Thông tin sản phẩm</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body row g-3">
                                                <div class="col-md-6">
                                                    <label>Tên sản phẩm</label>
                                                    <input type="text" class="form-control" name="templateName" id="modal-templateName" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Giá gốc</label>
                                                    <input type="number" class="form-control" name="basePrice" id="modal-basePrice" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Danh mục</label>
                                                    <select class="form-select" name="categoryId" id="modal-categoryId" required>
                                                        <c:forEach var="cat" items="${categoryList}">
                                                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>URL Hình ảnh</label>
                                                    <input type="text" class="form-control" name="imageUrl" id="modal-imageUrl">
                                                </div>
                                                <div class="col-12">
                                                    <label>Mô tả</label>
                                                    <textarea class="form-control" name="description" id="modal-description" rows="3"></textarea>
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

                            <!-- ===== BULK ACTIONS ===== -->
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="text-muted">
                                    Showing 1 to 5 of 248 products
                                </div>
                            </div>
                            <!-- Bootstrap JS -->
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                            <script>
                                                                       // ===== PRODUCT MANAGEMENT FUNCTIONALITY =====

                                                                       // Search products
                                                                       function searchProducts() {
                                                                           const searchTerm = document.getElementById('productSearch').value;
                                                                           // In real application, this would filter the table or make AJAX request
                                                                           console.log('Searching for:', searchTerm);
                                                                       }

                                                                       // Filter by category
                                                                       function filterByCategory(category) {
                                                                           console.log('Filtering by category:', category);
                                                                           // Implementation would filter table rows based on category
                                                                       }

                                                                       // Filter by stock status
                                                                       function filterByStock(status) {
                                                                           console.log('Filtering by stock status:', status);
                                                                           // Implementation would filter table rows based on stock status
                                                                       }

                                                                       // Change entries per page
                                                                       function changeEntriesPerPage(count) {
                                                                           console.log('Showing', count, 'entries per page');
                                                                           // Implementation would update pagination and reload data
                                                                       }

                                                                       // Select all products
                                                                       function selectAllProducts(checkbox) {
                                                                           const productCheckboxes = document.querySelectorAll('.product-checkbox');
                                                                           productCheckboxes.forEach(cb => cb.checked = checkbox.checked);
                                                                           updateBulkActionButtons();
                                                                       }

                                                                       // Update bulk action buttons based on selection
                                                                       function updateBulkActionButtons() {
                                                                           const selectedProducts = document.querySelectorAll('.product-checkbox:checked');
                                                                           const bulkButtons = ['bulkEditBtn', 'bulkDeleteBtn', 'bulkRestockBtn'];

                                                                           bulkButtons.forEach(btnId => {
                                                                               document.getElementById(btnId).disabled = selectedProducts.length === 0;
                                                                           });
                                                                       }

                                                                       // Product actions
                                                                       function restockProduct(productId) {
                                                                           if (confirm('Redirect to restock page for product ID: ' + productId + '?')) {
                                                                               window.location.href = 'restock-product.jsp?id=' + productId;
                                                                           }
                                                                       }

                                                                       function deleteProduct(productId) {
                                                                           if (confirm('Are you sure you want to delete this product?')) {
                                                                               // In real application, this would make AJAX request to delete
                                                                               console.log('Deleting product:', productId);
                                                                               alert('Product deleted successfully!');
                                                                           }
                                                                       }

                                                                       function duplicateProduct(productId) {
                                                                           if (confirm('Create a copy of this product?')) {
                                                                               window.location.href = 'add-product.jsp?duplicate=' + productId;
                                                                           }
                                                                       }

                                                                       function viewProductImage(imageSrc) {
                                                                           // Create modal to view larger image
                                                                           alert('View larger image: ' + imageSrc);
                                                                       }
                                                                       function openAddModal() {
                                                                           document.getElementById("productModalLabel").innerText = "Thêm sản phẩm mới";
                                                                           document.getElementById("modal-templateId").value = "";
                                                                           document.getElementById("modal-templateName").value = "";
                                                                           document.getElementById("modal-basePrice").value = "";
                                                                           document.getElementById("modal-description").value = "";
                                                                           document.getElementById("modal-imageUrl").value = "";
                                                                           document.getElementById("modal-categoryId").selectedIndex = 0;

                                                                           let modal = new bootstrap.Modal(document.getElementById('productModal'));
                                                                           modal.show();
                                                                       }

                                                                       function openEditModal(id, name, price, desc, imageUrl, categoryId) {
                                                                           document.getElementById("productModalLabel").innerText = "Chỉnh sửa sản phẩm";
                                                                           document.getElementById("modal-templateId").value = id;
                                                                           document.getElementById("modal-templateName").value = name;
                                                                           document.getElementById("modal-basePrice").value = price;
                                                                           document.getElementById("modal-description").value = desc;
                                                                           document.getElementById("modal-imageUrl").value = imageUrl;
                                                                           document.getElementById("modal-categoryId").value = categoryId;

                                                                           let modal = new bootstrap.Modal(document.getElementById('productModal'));
                                                                           modal.show();
                                                                       }

                                                                       // Bulk actions
                                                                       function bulkEdit() {
                                                                           const selected = document.querySelectorAll('.product-checkbox:checked');
                                                                           const ids = Array.from(selected).map(cb => cb.value);
                                                                           window.location.href = 'bulk-edit-products.jsp?ids=' + ids.join(',');
                                                                       }

                                                                       function bulkDelete() {
                                                                           const selected = document.querySelectorAll('.product-checkbox:checked');
                                                                           if (confirm(`Delete ${selected.length} selected products?`)) {
                                                                               console.log('Bulk deleting products');
                                                                           }
                                                                       }

                                                                       function bulkRestock() {
                                                                           const selected = document.querySelectorAll('.product-checkbox:checked');
                                                                           const ids = Array.from(selected).map(cb => cb.value);
                                                                           window.location.href = 'bulk-restock.jsp?ids=' + ids.join(',');
                                                                       }

                                                                       function exportProducts() {
                                                                           // Export products to CSV/Excel
                                                                           window.location.href = 'export-products.jsp?format=excel';
                                                                       }

                                                                       // Initialize page
                                                                       document.addEventListener('DOMContentLoaded', function () {
                                                                           // Add event listeners to product checkboxes
                                                                           document.querySelectorAll('.product-checkbox').forEach(checkbox => {
                                                                               checkbox.addEventListener('change', updateBulkActionButtons);
                                                                           });

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

