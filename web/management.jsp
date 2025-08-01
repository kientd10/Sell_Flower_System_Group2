<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý | Flower Shop</title>

        <!-- External CSS -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap&subset=vietnamese" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Chart.js for bar chart -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

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

            /* ===== STATISTICS STYLES ===== */
            .summary-card {
                background: white;
                border-radius: 10px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 1.5rem;
            }
            .summary-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }
            .summary-label {
                color: var(--secondary-gray);
                font-size: 1rem;
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

                <!-- Main Content -->
                <div class="main-content">
                    <!-- Page Header -->
                <div class="top-navbar">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="input-group">
                            <form method="get" action="statistics" class="d-flex gap-2">
                                <select class="form-select" name="viewType" id="viewType" onchange="changeView()">
                                    <option value="daily" ${viewType == 'daily' ? 'selected' : ''}>Theo ngày</option>
                                    <option value="monthly" ${viewType == 'monthly' ? 'selected' : ''}>Theo tháng</option>
                                    <option value="yearly" ${viewType == 'yearly' ? 'selected' : ''}>Theo năm</option>
                                </select>
                                <input type="number" class="form-control" name="day" id="dayInput" placeholder="Ngày" value="${day}" style="display: ${viewType == 'daily' ? 'block' : 'none'};" min="1" max="31">
                                <input type="number" class="form-control" name="month" id="monthInput" placeholder="Tháng" value="${month}" min="1" max="12">
                                <input type="number" class="form-control" name="year" id="yearInput" placeholder="Năm" value="${year}" min="2000" max="2100">
                                <button type="submit" class="btn btn-primary">Cập nhật</button>
                            </form>
                        </div>
                    </div>
                </div>

                    <!-- ===== STATISTICS SUMMARY ===== -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                Tổng Quan Thống Kê - 
                                <c:choose>
                                    <c:when test="${viewType == 'daily'}">Ngày ${day}/${month}/${year}</c:when>
                                    <c:when test="${viewType == 'yearly'}">Năm ${year}</c:when>
                                    <c:otherwise>Tháng ${month}/${year}</c:otherwise>
                                </c:choose>
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="summary-card">
                                        <div class="summary-number"><fmt:formatNumber value="${stats.monthlyRevenue}" type="currency" currencySymbol="₫"/></div>
                                        <div class="summary-label">Doanh Thu</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="summary-card">
                                        <div class="summary-number">${stats.monthlyOrderCount}</div>
                                        <div class="summary-label">Số Đơn Hàng</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ===== REVENUE CHART ===== -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Biểu Đồ Doanh Thu Theo Tháng - Năm ${year}</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="revenueChart" height="100"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                                    // Search functionality
                                    function searchManagement() {
                                        const searchTerm = document.getElementById('searchManagement').value;
                                        console.log('Tìm kiếm quản lý:', searchTerm);
                                    }

                                    // Update statistics based on user input
                                    function updateStatistics() {
                                        const viewType = document.getElementById('viewType').value;
                                        const day = document.getElementById('dayInput').value;
                                        const month = document.getElementById('monthInput').value;
                                        const year = document.getElementById('yearInput').value;

                                        // Thêm log kiểm tra
                                        console.log("Updating with:", {viewType, day, month, year});

                                        window.location.href = `statistics?viewType=${viewType}&day=${day}&month=${month}&year=${year}`;
                                    }


                                    // Show/hide day input based on view type
                                    function changeView() {
                                        const viewType = document.getElementById('viewType').value;
                                        document.getElementById('dayInput').style.display = viewType === 'daily' ? 'block' : 'none';
                                    }

                                    // Auto-highlight active menu item
                                    document.addEventListener('DOMContentLoaded', function () {
                                        var currentPage = window.location.pathname.split('/').pop();
                                        document.querySelectorAll('.sidebar-link').forEach(function (link) {
                                            link.classList.remove('active');
                                        });
                                        var activeLink = document.querySelector('a[href="' + currentPage + '"]');
                                        if (activeLink) {
                                            activeLink.classList.add('active');
                                        }

                                        // Initialize Chart.js
                                        const ctx = document.getElementById('revenueChart').getContext('2d');
                                        const monthlyRevenues = [
                <c:forEach items="${monthlyRevenues}" var="revenue" varStatus="loop">
                    ${revenue}${!loop.last ? ',' : ''}
                </c:forEach>
                                        ];
                                        new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
                                                    'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                                                datasets: [{
                                                        label: 'Doanh Thu (VND)',
                                                        data: monthlyRevenues,
                                                        backgroundColor: 'rgba(196, 77, 88, 0.6)',
                                                        borderColor: 'rgba(196, 77, 88, 1)',
                                                        borderWidth: 1
                                                    }]
                                            },
                                            options: {
                                                scales: {
                                                    y: {
                                                        beginAtZero: true,
                                                        title: {
                                                            display: true,
                                                            text: 'Doanh Thu (VND)'
                                                        }
                                                    },
                                                    x: {
                                                        title: {
                                                            display: true,
                                                            text: 'Tháng'
                                                        }
                                                    }
                                                },
                                                plugins: {
                                                    legend: {
                                                        display: true,
                                                        position: 'top'
                                                    }
                                                }
                                            }
                                        });
                                    });
            </script>
        </div>
    </body>
</html>