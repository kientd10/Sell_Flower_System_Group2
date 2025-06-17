<%-- 
    Document   : success
    Created on : Jun 13, 2025, 9:45:27 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success-box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: center;
        }

        .success-box svg {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            color: #28a745;
        }

        .btn-home {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="success-box">
    <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-check-circle"
         viewBox="0 0 16 16">
        <path d="M15.854 4.146a.5.5 0 0 0-.708-.708L7 11.293 4.354 8.646a.5.5 0 1 0-.708.708l3 
        3a.5.5 0 0 0 .708 0l8-8z"/>
        <path d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
    </svg>
    <h1>Thanh toán thành công!</h1>
    <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn sẽ được xử lý sớm nhất.</p>
    <a href="home" class="btn btn-success btn-home">Về trang chủ</a>
</div>
</body>
</html>