<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Hóa Đơn | Flower Shop</title>

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

            /* ===== INVOICE SPECIFIC STYLES ===== */
            .invoice-status {
                padding: 0.3rem 0.6rem;
                border-radius: 12px;
                font-size: 0.7rem;
                font-weight: 600;
            }
            .invoice-status.paid {
                background: #d4edda;
                color: #155724;
            }
            .invoice-status.pending {
                background: #fff3cd;
                color: #856404;
            }
            .invoice-status.overdue {
                background: #f8d7da;
                color: #721c24;
            }
            .invoice-status.cancelled {
                background: #e2e3e5;
                color: #383d41;
            }
            .invoice-status.draft {
                background: #cce5ff;
                color: #004085;
            }

            .payment-method {
                padding: 0.3rem 0.6rem;
                border-radius: 12px;
                font-size: 0.7rem;
                font-weight: 600;
            }
            .payment-method.cash {
                background: #e8f5e8;
                color: #388e3c;
            }
            .payment-method.card {
                background: #e3f2fd;
                color: #1976d2;
            }
            .payment-method.transfer {
                background: #f3e5f5;
                color: #7b1fa2;
            }
            .payment-method.online {
                background: #fff3e0;
                color: #f57c00;
            }

            .invoice-amount {
                font-size: 1.1rem;
                font-weight: 700;
            }
            .invoice-amount.paid {
                color: #28a745;
            }
            .invoice-amount.pending {
                color: #ffc107;
            }
            .invoice-amount.overdue {
                color: #dc3545;
            }

            .invoice-summary {
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

            .invoice-actions {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
            }

            .invoice-preview {
                max-width: 200px;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                padding: 1rem;
                background: white;
                font-size: 0.8rem;
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
                    <a href="Customer?action=logout" class="logout-link">
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
                                                <li>
                            <a href="feedbacks?action=view" class="sidebar-link" id="menu-feedback">
                                <i class="fas fa-comments"></i> Quản Lý Phản Hồi
                            </a>
                        </li>  
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
                        <li><a href="UserManagementServlet?action=search" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Nhân Sự</a></li>
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
                            <input type="text"  class="form-control" placeholder="Tìm kiếm hóa đơn..." id="invoiceSearch">
                            <button class="btn btn-outline-secondary" onclick="searchInvoices()"><i class="fas fa-search"></i></button>
                        </div>

                        <div class="d-flex align-items-center gap-3">
                            <button class="btn btn-outline-secondary" onclick="myApp.printTable()">
                                <i class="fas fa-print me-2"></i>In Hóa Đơn
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="content-area">
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="page-title">Quản Lý Hóa Đơn</h2>
                            <p class="text-muted">Quản lý và theo dõi tất cả hóa đơn bán hàng</p>
                        </div>

                        <div class="text-muted">
                            Tổng số hóa đơn: <strong>${fn:length(listInvoices)}</strong> | Hôm nay: <strong>${countToday}</strong>
                        </div>
                    </div>



                    <!-- ===== FILTER SECTION ===== -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form id="filterForm" method="get" action="InvoiceManagement">
                                <input type="hidden" name="action" value="filterAll">

                                <div class="row">
                                    <div class="col-md-3">
                                        <label class="form-label">Khoảng Thời Gian:</label>
                                        <select class="form-select" name="date" onchange="filterAll()">
                                            <option value="all" <%= "all".equals(request.getAttribute("selectedRange")) ? "selected" : "" %>>Tất cả thời gian</option>
                                            <option value="today" <%= "today".equals(request.getAttribute("selectedRange")) ? "selected" : "" %>>Hôm nay</option>
                                            <option value="yesterday" <%= "yesterday".equals(request.getAttribute("selectedRange")) ? "selected" : "" %>>Hôm qua</option>
                                            <option value="week" <%= "week".equals(request.getAttribute("selectedRange")) ? "selected" : "" %>>Tuần này</option>
                                            <option value="month" <%= "month".equals(request.getAttribute("selectedRange")) ? "selected" : "" %>>Tháng này</option>
                                            <option value="quarter" <%= "quarter".equals(request.getAttribute("selectedRange")) ? "selected" : "" %>>Quý này</option>
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <label class="form-label">Lọc hóa đơn</label>
                                        <select class="form-select" name="priceRange" onchange="filterAll()">
                                            <option value="all" <%= "all".equals(request.getAttribute("selectedPrice")) ? "selected" : "" %>>Tất Cả</option>
                                            <option value="price1" <%= "price1".equals(request.getAttribute("selectedPrice")) ? "selected" : "" %>>Đơn từ 0 đến 99.000 vnđ</option>
                                            <option value="price2" <%= "price2".equals(request.getAttribute("selectedPrice")) ? "selected" : "" %>>Đơn từ 100.000 vnđ đến 499.000 vnđ</option>
                                            <option value="price3" <%= "price3".equals(request.getAttribute("selectedPrice")) ? "selected" : "" %>>Đơn từ 500.000 vnđ</option>
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <label class="form-label">Sắp xếp theo giá</label>
                                        <select class="form-select" name="sortPrice" onchange="filterAll()">
                                            <option value="all" <%= "all".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Tất cả</option>
                                            <option value="asc" <%= "asc".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Từ thấp đến cao</option>
                                            <option value="desc" <%= "desc".equals(request.getAttribute("selectedSort")) ? "selected" : "" %>>Từ cao đến thấp</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- ===== INVOICES TABLE ===== -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Danh Sách Hóa Đơn</h5>
                            <div class="d-flex align-items-center gap-3">
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th>Mã Hóa Đơn</th>
                                            <th>Khách Hàng</th>
                                            <th>Ngày Tạo</th>
                                            <th>Tổng Tiền</th>
                                            <th>Phương Thức</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="listI" items="${listInvoice}">
                                            <!-- Invoice 1: Paid -->
                                            <tr>
                                                <td>
                                                    <div>
                                                        <strong>${listI.order_code}</strong>
                                                        <div class="text-muted small">Đơn hàng: ${listI.order_code}</div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <strong>${listI.customer_name}</strong>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <strong>${listI.date}</strong>
                                                    </div>
                                                </td>

                                                <td>
                                                    <div class="invoice-amount paid">${listI.totalPayment}</div>
                                                </td>
                                                <td><span class="payment-method card">${listI.payment}</span></td>
                                                <td><button class="btn btn-outline-primary btn-sm" onclick="myApp.printRow(this)"><i class="fas fa-print me-2"></i>In hóa đơn</button></td>

                                            </tr>
                                        </c:forEach>

                                    </tbody>


                                </table>
                            </div>

                            <!-- ===== BULK ACTIONS ===== -->
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="text-muted">
                                    Hiển thị 1 đến 5 trong tổng số ${fn:length(listInvoice)} hóa đơn
                                </div>
                            </div>

                            <!-- ===== PAGINATION ===== -->
                            <nav aria-label="Invoice pagination" class="mt-3">
                                <c:set var="page" value="${page}"/>
                                <div class="shop_toolbar t_bottom" style="border: none;">
                                    <div class="pagination">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach begin="1" end="${num}" var="i">
                                                <li class="page-item ${i == page ? 'active' : ''}">
                                                    <a class="page-link" 
                                                       href="InvoiceManagement?action=${param.action}&page=${i}
                                                       <c:if test='${not empty param.date}'>&date=${param.date}</c:if>
                                                       <c:if test='${not empty param.priceRange}'>&priceRange=${param.priceRange}</c:if>
                                                       <c:if test='${not empty param.value}'>&value=${param.value}</c:if>">
                                                        ${i}
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
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                                    // ===== INVOICE MANAGEMENT FUNCTIONALITY =====

                                                    // Search invoices
                                                    function searchInvoices() {
                                                        var search = document.getElementById('invoiceSearch').value.trim();

                                                        window.location.href = 'InvoiceManagement?action=Search&value=' + encodeURIComponent(search);

                                                        // Implementation would filter invoices based on search term
                                                    }

                                                    // Filter functions
                                                    function filterByStatus(status) {
                                                        console.log('Lọc theo trạng thái:', status);
                                                    }
                                                    function filterByPaymentMethod(method) {
                                                        console.log('Lọc theo phương thức:', method);
                                                    }
                                                    function filterAll() {
                                                        const date = document.querySelector('select[name="date"]').value;
                                                        const priceRange = document.querySelector('select[name="priceRange"]').value;
                                                        const sortPrice = document.querySelector('select[name="sortPrice"]').value;

                                                        const url = new URL(window.location.href);
                                                        url.searchParams.set('action', 'filterAll');

                                                        if (date && date !== "all") {
                                                            url.searchParams.set('date', date);
                                                        } else {
                                                            url.searchParams.delete('date');
                                                        }

                                                        if (priceRange && priceRange !== "all") {
                                                            url.searchParams.set('priceRange', priceRange);
                                                        } else {
                                                            url.searchParams.delete('priceRange');
                                                        }

                                                        if (sortPrice && sortPrice !== "all") {
                                                            url.searchParams.set('sortPrice', sortPrice);
                                                        } else {
                                                            url.searchParams.delete('sortPrice');
                                                        }

                                                        url.searchParams.set('page', '1'); // ✅ reset lại về trang 1 khi lọc
                                                        window.location.href = url.toString();
                                                    }


                                                    //In dữ liệu
                                                    var myApp = new function () {
                                                        this.printTable = function () {
                                                            var tab = document.getElementById('sampleTable');
                                                            var win = window.open('', '', 'height=700,width=700');
                                                            win.document.write(tab.outerHTML);
                                                            win.document.close();
                                                            win.print();
                                                        };

                                                        this.printRow = function (btn) {
                                                            var row = btn.parentNode.parentNode.cloneNode(true); // clone dòng
                                                            row.removeChild(row.lastChild); // xoá cột nút In nếu muốn

                                                            var table = document.createElement('table');
                                                            table.border = 1;
                                                            table.appendChild(row);

                                                            var win = window.open('', '', 'height=400,width=600');
                                                            win.document.write('<html><head><title>In 1 dòng</title></head><body>');
                                                            win.document.write(table.outerHTML);
                                                            win.document.write('</body></html>');
                                                            win.document.close();
                                                            win.print();
                                                        };
                                                    };

                                                    // Invoice actions
                                                    function printInvoice(invoiceId) {
                                                        console.log('In hóa đơn:', invoiceId);
                                                        window.open(`print-invoice.jsp?id=${invoiceId}`, '_blank');
                                                    }

                                                    function sendInvoice(invoiceId) {
                                                        console.log('Gửi hóa đơn qua email:', invoiceId);
                                                        if (confirm('Gửi hóa đơn này qua email cho khách hàng?')) {
                                                            alert('Hóa đơn đã được gửi thành công!');
                                                        }
                                                    }

                                                    function markAsPaid(invoiceId) {
                                                        if (confirm('Đánh dấu hóa đơn này là đã thanh toán?')) {
                                                            console.log('Đánh dấu đã thanh toán:', invoiceId);
                                                            alert('Hóa đơn đã được cập nhật trạng thái!');
                                                            location.reload();
                                                        }
                                                    }

                                                    function sendReminder(invoiceId) {
                                                        console.log('Gửi nhắc nhở:', invoiceId);
                                                        if (confirm('Gửi email nhắc nhở thanh toán cho khách hàng?')) {
                                                            alert('Email nhắc nhở đã được gửi!');
                                                        }
                                                    }

                                                    function sendUrgentReminder(invoiceId) {
                                                        console.log('Gửi nhắc nhở khẩn cấp:', invoiceId);
                                                        if (confirm('Gửi thông báo khẩn cấp về hóa đơn quá hạn?')) {
                                                            alert('Thông báo khẩn cấp đã được gửi!');
                                                        }
                                                    }

                                                    function negotiatePayment(invoiceId) {
                                                        console.log('Thương lượng thanh toán:', invoiceId);
                                                        window.location.href = `payment-negotiation.jsp?invoiceId=${invoiceId}`;
                                                    }

                                                    function finalizeInvoice(invoiceId) {
                                                        if (confirm('Hoàn tất hóa đơn này và gửi cho khách hàng?')) {
                                                            console.log('Hoàn tất hóa đơn:', invoiceId);
                                                            alert('Hóa đơn đã được hoàn tất và gửi!');
                                                            location.reload();
                                                        }
                                                    }

                                                    function deleteInvoice(invoiceId) {
                                                        if (confirm('Xóa hóa đơn này? Hành động này không thể hoàn tác.')) {
                                                            console.log('Xóa hóa đơn:', invoiceId);
                                                            alert('Hóa đơn đã được xóa!');
                                                            location.reload();
                                                        }
                                                    }

                                                    function viewCancelReason(invoiceId) {
                                                        console.log('Xem lý do hủy:', invoiceId);
                                                        alert('Lý do hủy: Khách hàng thay đổi ý định, không cần sản phẩm nữa.');
                                                    }

                                                    function recreateInvoice(invoiceId) {
                                                        if (confirm('Tạo lại hóa đơn mới dựa trên hóa đơn đã hủy này?')) {
                                                            console.log('Tạo lại hóa đơn:', invoiceId);
                                                            window.location.href = `create-invoice.jsp?baseId=${invoiceId}`;
                                                        }
                                                    }

                                                    // Bulk actions
                                                    function selectAllInvoices(checkbox) {
                                                        const invoiceCheckboxes = document.querySelectorAll('.invoice-checkbox');
                                                        invoiceCheckboxes.forEach(cb => cb.checked = checkbox.checked);
                                                        updateBulkActionButtons();
                                                    }

                                                    function updateBulkActionButtons() {
                                                        const selectedInvoices = document.querySelectorAll('.invoice-checkbox:checked');
                                                        const bulkButtons = ['bulkPaidBtn', 'bulkReminderBtn', 'bulkPrintBtn', 'bulkCancelBtn'];

                                                        bulkButtons.forEach(btnId => {
                                                            document.getElementById(btnId).disabled = selectedInvoices.length === 0;
                                                        });
                                                    }

                                                    function bulkMarkAsPaid() {
                                                        const selected = document.querySelectorAll('.invoice-checkbox:checked');
                                                        const ids = Array.from(selected).map(cb => cb.value);
                                                        if (confirm(`Đánh dấu ${ids.length} hóa đơn đã chọn là đã thanh toán?`)) {
                                                            console.log('Bulk đánh dấu đã thanh toán:', ids);
                                                            alert('Các hóa đơn đã được cập nhật!');
                                                            location.reload();
                                                        }
                                                    }

                                                    function bulkSendReminder() {
                                                        const selected = document.querySelectorAll('.invoice-checkbox:checked');
                                                        const ids = Array.from(selected).map(cb => cb.value);
                                                        if (confirm(`Gửi email nhắc nhở cho ${ids.length} hóa đơn đã chọn?`)) {
                                                            console.log('Bulk gửi nhắc nhở:', ids);
                                                            alert('Email nhắc nhở đã được gửi!');
                                                        }
                                                    }

                                                    function bulkPrint() {
                                                        const selected = document.querySelectorAll('.invoice-checkbox:checked');
                                                        const ids = Array.from(selected).map(cb => cb.value);
                                                        console.log('Bulk in hóa đơn:', ids);
                                                        window.open(`bulk-print-invoices.jsp?ids=${ids.join(',')}`, '_blank');
                                                    }

                                                    function bulkCancel() {
                                                        const selected = document.querySelectorAll('.invoice-checkbox:checked');
                                                        const ids = Array.from(selected).map(cb => cb.value);
                                                        if (confirm(`Hủy ${ids.length} hóa đơn đã chọn? Hành động này không thể hoàn tác.`)) {
                                                            console.log('Bulk hủy hóa đơn:', ids);
                                                            alert('Các hóa đơn đã được hủy!');
                                                            location.reload();
                                                        }
                                                    }

                                                    // Export and print functions
                                                    function exportInvoices() {
                                                        console.log('Xuất danh sách hóa đơn...');
                                                        window.location.href = 'export-invoices.jsp?format=excel';
                                                    }

                                                    function printInvoices() {
                                                        console.log('In danh sách hóa đơn...');
                                                        window.print();
                                                    }

                                                    // Initialize page
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        // Add event listeners to invoice checkboxes
                                                        document.querySelectorAll('.invoice-checkbox').forEach(checkbox => {
                                                            checkbox.addEventListener('change', updateBulkActionButtons);
                                                        });

                                                        // Enable real-time search
                                                        document.getElementById('invoiceSearch').addEventListener('keyup', function (e) {
                                                            if (e.key === 'Enter') {
                                                                searchInvoices();
                                                            }
                                                        });

                                                        console.log('Trang quản lý hóa đơn đã được khởi tạo');
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


    </script>       

</body>
</html>

