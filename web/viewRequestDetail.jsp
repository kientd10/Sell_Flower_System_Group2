<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.FlowerRequest" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    FlowerRequest fr = (FlowerRequest) request.getAttribute("flowerRequest");
    if (fr == null) {
        response.sendRedirect("notificationManagement");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết yêu cầu hoa mẫu | Flower Shop</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-red: #c44d58;
            --primary-red-dark: #a03d4a;
            --sidebar-width: 280px;
            --light-gray: #f8f9fa;
        }
        body { font-family: 'Inter', sans-serif; background: var(--light-gray); margin: 0; padding: 0; }
        .wrapper { display: flex; min-height: 100vh; }
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            position: fixed; height: 100vh; overflow-y: auto; z-index: 1000;
            box-shadow: 2px 0 15px rgba(0,0,0,0.15);
        }
        .sidebar-brand {
            padding: 1.8rem 1.5rem; color: white; text-decoration: none; font-weight: 700; font-size: 1.4rem;
            border-bottom: 1px solid rgba(255,255,255,0.1); display: block; text-align: center;
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%); text-shadow: 0 2px 4px rgba(0,0,0,0.3); letter-spacing: 0.5px;
        }
        .sidebar-profile { padding: 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.1); color: white; text-align: center; }
        .profile-avatar { width: 60px; height: 60px; border-radius: 50%; border: 3px solid rgba(255,255,255,0.2); object-fit: cover; margin-bottom: 0.8rem; }
        .profile-welcome { color: white; font-size: 0.9rem; margin-bottom: 0.5rem; }
        .profile-role { color: #ecf0f1; font-size: 0.8rem; font-weight: 500; margin-bottom: 1rem; padding: 0.3rem 0.8rem; background: rgba(255,255,255,0.1); border-radius: 15px; display: inline-block; }
        .logout-link { color: #c44d58; text-decoration: none; font-size: 0.95rem; font-weight: 500; transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 0.5rem; }
        .logout-link:hover { color: #a03d4a; transform: translateX(3px); }
        .sidebar-nav { list-style: none; padding: 1rem 0; margin: 0; }
        .sidebar-header { padding: 1rem 1.5rem 0.5rem; color: rgba(255,255,255,0.7); font-size: 0.8rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        .sidebar-link {
            display: flex; align-items: center; padding: 0.9rem 1.5rem; color: rgba(255,255,255,0.85); text-decoration: none;
            transition: all 0.3s ease; border-left: 3px solid transparent; margin: 0.2rem 0;
        }
        .sidebar-link:hover, .sidebar-link.active {
            background: linear-gradient(90deg, rgba(231, 76, 60, 0.1) 0%, rgba(231, 76, 60, 0.05) 100%);
            color: white; border-left-color: #e74c3c; transform: translateX(3px);
        }
        .sidebar-link i { margin-right: 0.9rem; width: 18px; font-size: 1rem; }
        .main-content { margin-left: var(--sidebar-width); width: calc(100% - var(--sidebar-width)); min-height: 100vh; }
        .content-area { padding: 2rem; }
        .main-detail-content {
            max-width: 1250px;
            margin: 60px auto 60px auto;
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 4px 32px rgba(206,66,108,0.13);
            padding: 56px 56px 40px 56px;
        }
        .detail-title {
            color: #ce426c;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 18px;
            letter-spacing: 1px;
            text-align: center;
        }
        .detail-row { margin-bottom: 18px; font-size: 1.13rem; }
        .detail-label { color: #324d7a; font-weight: 600; min-width: 120px; display: inline-block; }
        .detail-img {
            width: 370px; height: 370px; object-fit: cover; border-radius: 16px; box-shadow: 0 2px 12px rgba(206,66,108,0.10); margin-bottom: 18px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        .btn-back {
            background: #fff;
            color: #ce426c;
            border: 2px solid #ce426c;
            border-radius: 7px;
            padding: 8px 22px;
            font-size: 1.08rem;
            font-weight: 600;
            transition: background 0.2s;
            height: 42px;
            display: inline-block;
            vertical-align: middle;
            box-sizing: border-box;
        }
        .btn-back:hover {
            background: #fdf6f8;
            color: #a03d4a;
            border-color: #a03d4a;
        }
        .btn-primary {
            background: #ce426c;
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 8px 22px;
            font-size: 1.08rem;
            font-weight: 600;
            height: 42px;
            display: inline-block;
            vertical-align: middle;
            box-sizing: border-box;
        }
        .btn-primary:hover {
            background: #d44071;
            color: #fff;
        }
        .row.align-center {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 48px;
        }
        .detail-flex-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 64px;
        }
        .detail-flex-col { display: flex; flex-direction: column; align-items: center; }
        @media (max-width: 1100px) {
            .main-detail-content { max-width: 99vw; padding: 24px 6vw 18px 6vw; }
            .detail-img { width: 100%; height: 260px; }
            .detail-flex-row { flex-direction: column; gap: 18px; }
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
            <c:if test="${sessionScope.user.roleId == 2}">                                              
                <li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                <li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
                <li><a href="storagemanagement?action=view" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                <li><a href="orderManagement" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
            </c:if> 
            <c:if test="${sessionScope.user.roleId == 3}"> 
                <li><a href="statistics" class="sidebar-link" id="menu-management"><i class="fas fa-chart-bar"></i>Quản Lý</a></li>
                <li><a href="productmanagement?action=view" class="sidebar-link" id="menu-productManagement"><i class="fas fa-list"></i>Quản Lí Sản Phẩm</a></li>
                <li><a href="category?action=management" class="sidebar-link" id="menu-categoryManagement"><i class="fas fa-boxes"></i>Quản Lí Danh Mục Sản Phẩm</a></li>
                <li><a href="storagemanagement?action=view" class="sidebar-link" id="menu-storageManagement"><i class="fas fa-warehouse"></i>Quản Lí Kho Hàng</a></li>
                <li><a href="orderManagement" class="sidebar-link" id="menu-orderManagement"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
                <li><a href="InvoiceManagement?action=displayAll" class="sidebar-link" id="menu-invoiceManagement"><i class="fas fa-file-invoice"></i>Quản Lý Hóa Đơn</a></li>
                <li class="sidebar-header">Hệ Thống</li>
                <li><a href="userManagement.jsp" class="sidebar-link" id="menu-userManagement"><i class="fas fa-user-shield"></i>Quản Lí Người Dùng</a></li>
                <li><a href="feedbackManagement.jsp" class="sidebar-link" id="menu-feedbackManagement"><i class="fas fa-comments"></i>Quản Lý Phản Hồi</a></li>
                <li><a href="notificationManagement" class="sidebar-link active" id="menu-notificationManagement"><i class="fas fa-bell"></i>Thông Báo<span class="badge bg-danger ms-auto">4</span></a></li>
            </c:if> 
            <c:if test="${sessionScope.user.roleId == 4}">
                <li><a href="orderManagement" class="sidebar-link"><i class="fas fa-shopping-cart"></i>Quản Lí Đơn Hàng</a></li>
            </c:if>                   
        </ul>
    </nav>
    <div class="main-content">
        <div class="content-area">
            <div class="main-detail-content">
                <div class="detail-flex-row">
                    <!-- Cột trái: Ảnh -->
                    <div class="detail-flex-col">
                        <span class="detail-label">Ảnh mẫu khách gửi:</span>
                        <c:if test="${not empty flowerRequest.imageUrl}">
                            <img src="${pageContext.request.contextPath}/${flowerRequest.imageUrl}" alt="Ảnh mẫu khách gửi" class="detail-img mb-3" />
                        </c:if>
                    </div>
                    <!-- Cột phải: Thông tin text và form phản hồi -->
                    <div class="detail-flex-col">
                        <div class="detail-title">Chi tiết yêu cầu hoa mẫu</div>
                        <div class="detail-row"><span class="detail-label">Mã yêu cầu:</span> ${flowerRequest.requestId}</div>
                        <div class="detail-row"><span class="detail-label">Khách hàng ID:</span> ${flowerRequest.customerId}</div>
                        <div class="detail-row"><span class="detail-label">Ngày gửi yêu cầu:</span> <fmt:formatDate value="${flowerRequest.createdAt}" pattern="dd/MM/yyyy HH:mm" /></div>
                        <div class="detail-row"><span class="detail-label">Mô tả:</span> ${flowerRequest.description}</div>
                        <div class="detail-row"><span class="detail-label">Màu sắc mong muốn:</span> ${flowerRequest.colorPreference}</div>
                        <div class="detail-row"><span class="detail-label">Dịp:</span> ${flowerRequest.eventType}</div>
                        <div class="detail-row"><span class="detail-label">Ghi chú:</span> ${flowerRequest.note}</div>
                        <div class="detail-row"><span class="detail-label">Trạng thái:</span> <span class="status ${flowerRequest.status}">${flowerRequest.status}</span></div>
                        <form action="send-reply" method="post" enctype="multipart/form-data" class="mt-4">
                            <input type="hidden" name="requestId" value="${flowerRequest.requestId}" />
                            <label for="sampleImage">Ảnh mẫu shop gửi lại:</label>
                            <input type="file" name="sampleImage" id="sampleImage" accept="image/*" class="form-control mb-2" required />
                            <label for="shopReply">Lời nhắn shop:</label>
                            <textarea name="shopReply" id="shopReply" class="form-control mb-2" required></textarea>
                            <div class="d-flex gap-2 mt-3 justify-content-center">
                                <button type="submit" class="btn btn-primary">Gửi phản hồi</button>
                                <a href="notificationManagement" class="btn btn-back"><i class="fa fa-arrow-left"></i> Quay lại danh sách</a>
                            </div>
                            <% if (request.getAttribute("success") != null) { %>
                                <div style="color: green; font-weight: bold; text-align: center; margin-top: 16px;">
                                    <%= request.getAttribute("success") %>
                                </div>
                            <% } %>
                            <% if (request.getAttribute("error") != null) { %>
                                <div style="color: red; font-weight: bold; text-align: center; margin-top: 16px;">
                                    <%= request.getAttribute("error") %>
                                </div>
                            <% } %>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html> 