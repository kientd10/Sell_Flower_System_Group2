<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Yêu cầu hoa theo mẫu</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <style>
        .flower-request-form {
            max-width: 1100px;
            margin: 48px auto 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 24px rgba(206,66,108,0.10);
            padding: 40px 36px 32px 36px;
            display: flex;
            gap: 32px;
            flex-wrap: wrap;
        }
        .flower-request-form h2 {
            color: #ce426c;
            font-weight: bold;
            margin-bottom: 32px;
            text-align: center;
            width: 100%;
            font-size: 2.3rem;
            letter-spacing: 1px;
        }
        .flower-request-form .left-col {
            flex: 1 1 260px;
            min-width: 260px;
            max-width: 340px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
        }
        .flower-request-form .right-col {
            flex: 2 1 340px;
            min-width: 320px;
        }
        .dropzone {
            width: 100%;
            min-height: 220px;
            border: 2px dashed #ce426c;
            border-radius: 10px;
            background: #fdf6f8;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ce426c;
            font-size: 1.15rem;
            margin-bottom: 18px;
            cursor: pointer;
            transition: border 0.2s;
            text-align: center;
        }
        .dropzone.dragover {
            border: 2.5px solid #d44071;
            background: #fff0f6;
        }
        .preview-img {
            max-width: 100%;
            max-height: 180px;
            margin-bottom: 10px;
            border-radius: 8px;
            box-shadow: 0 1px 6px rgba(206,66,108,0.08);
        }
        .flower-request-form label {
            font-weight: 600;
            color: #324d7a;
            font-size: 1.22rem;
            margin-bottom: 4px;
        }
        .flower-request-form input[type="text"],
        .flower-request-form input[type="number"],
        .flower-request-form textarea {
            width: 100%;
            padding: 14px 16px;
            margin-bottom: 18px;
            border: 1.5px solid #aeafb0;
            border-radius: 6px;
            font-size: 1.18rem;
            background: #fafbfc;
            color: #222;
        }
        .flower-request-form input[type="file"] {
            display: none;
        }
        .flower-request-form button {
            background: #ce426c;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 7px;
            padding: 17px 0;
            width: 100%;
            font-size: 1.22rem;
            transition: background 0.2s;
            margin-top: 10px;
        }
        .flower-request-form button:hover {
            background: #d44071;
        }
        .flower-request-form .note {
            font-size: 1.05rem;
            color: #888;
            margin-bottom: 12px;
        }
        @media (max-width: 900px) {
            .flower-request-form {
                flex-direction: column;
                padding: 28px 10px 20px 10px;
                gap: 18px;
            }
            .flower-request-form .left-col, .flower-request-form .right-col {
                max-width: 100%;
                min-width: 0;
            }
        }
    </style>
    <script>
        // Xá»­ lÃ½ kÃ©o tháº£ áº£nh vÃ  preview
        function setupDropzone() {
            const dropzone = document.getElementById('dropzone');
            const fileInput = document.getElementById('flowerImage');
            const preview = document.getElementById('previewImg');
            dropzone.addEventListener('click', () => fileInput.click());
            dropzone.addEventListener('dragover', (e) => {
                e.preventDefault();
                dropzone.classList.add('dragover');
            });
            dropzone.addEventListener('dragleave', (e) => {
                e.preventDefault();
                dropzone.classList.remove('dragover');
            });
            dropzone.addEventListener('drop', (e) => {
                e.preventDefault();
                dropzone.classList.remove('dragover');
                if (e.dataTransfer.files && e.dataTransfer.files[0]) {
                    fileInput.files = e.dataTransfer.files;
                    showPreview(fileInput.files[0]);
                }
            });
            fileInput.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    showPreview(this.files[0]);
                }
            });
            function showPreview(file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        }
        window.onload = setupDropzone;
    </script>
</head>
<body>
<!-- HEADER Báº®T Äáº¦U -->
<header id="header"><!--header-->
    <div class="header_top"><!--header_top-->
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <div class="contactinfo">
                        <ul class="nav nav-pills">
                            <li><a href="#"><i class="fa fa-phone"></i> 0123456789</a></li>
                            <li><a href="#"><i class="fa fa-envelope"></i> Group2@fpt.edu.vn</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="social-icons pull-right">
                        <ul class="nav navbar-nav">
                            <li><a href="https://github.com/kientd10/Sell_Flower_System_Group2"><i class="fa fa-brands fa-github"></i></a></li>
                            <li><a href="https://www.facebook.com/share/16ohs8HR5g/?mibextid=wwXIfr"><i class="fa fa-facebook"></i></a></li>                                   
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/header_top-->
    <div class="header-middle"><!--header-middle-->
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="logo pull-left">
                        <a href="${pageContext.request.contextPath}/home?pageNum=1" ><img src="https://i.ibb.co/CsMwqtJx/logo-2.png" alt="" width="120px" height="70px" /></a>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="shop-menu pull-right">
                        <ul class="nav navbar-nav">
                            <c:if test="${sessionScope.user != null}">
                                <li><a href="profile"><i class="fa fa-user"></i> Hồ sơ</a></li>
                                <li><a href="orders"><i class="fa fa-truck"></i> Đơn hàng</a></li>
                                <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>
                                <li><a href="Customer?action=logout"><b>Đăng xuất</b></a></li> 
                            </c:if> 
                            <c:if test="${sessionScope.user == null}">
                                <li><a href="cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a></li>
                                <li><a href="login.jsp"><b>Đăng nhập</b></a></li> 
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/header-middle-->
    <div class="header-bottom"><!--header-bottom-->
        <div class="container">
            <div class="row">
                <div class="col-sm-9">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="mainmenu pull-left">
                        <ul class="nav navbar-nav collapse navbar-collapse">
                            <li><a href="${pageContext.request.contextPath}/home?pageNum=1" class="active">Trang chủ</a></li>                            
                            <li><a href="contact-us.jsp">Liên hệ</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="search_box pull-right">
                        <form action="SearchServlet" method="GET">
                            <input type="text" name="searchQuery" placeholder="Tìm kiếm mẫu hoa..." required/>
                            <button type="submit">
                                <i class="fa fa-search" style="border: none; height: 29px; line-height: 29px;"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/header-bottom-->        
</header><!--/header-->
<!-- HEADER Káº¾T THÃC -->
    <form action="${pageContext.request.contextPath}/flower-request" method="post" enctype="multipart/form-data" class="flower-request-form">
        <h2>Yêu cầu hoa theo mẫu</h2>
        <div class="left-col">
            <label for="flowerImage">Ảnh mẫu hoa <span style="color:red">*</span></label>
            <div id="dropzone" class="dropzone">
                <span>Kéo thả ảnh vào đây hoặc bấm để chọn ảnh</span>
            </div>
            <input type="file" id="flowerImage" name="flowerImage" accept="image/*" required>
            <img id="previewImg" class="preview-img" style="display:none;" alt="Preview" />
        </div>
        <div class="right-col">
            <label for="description">Mô tả yêu cầu <span style="color:red">*</span></label>
            <textarea id="description" name="description" rows="3" placeholder="Ví dụ: Hoa cắm dạng tròn, phối màu pastel..." required></textarea>

            <label for="price">Mức giá mong muốn (VNĐ)</label>
            <input type="number" id="price" name="price" min="100000" step="10000" placeholder="Ví dụ: 300000">

            <label for="color">Màu sắc chủ đạo</label>
            <input type="text" id="color" name="color" placeholder="Ví dụ: Hồng, trắng, vàng...">

            <label for="event">Dịp tặng</label>
            <input type="text" id="event" name="event" placeholder="Ví dụ: Sinh nhật, 8/3, 20/10...">

            <label for="note">Ghi chú thêm</label>
            <textarea id="note" name="note" rows="2" placeholder="Yêu cầu đặc biệt, lời chúc... (nếu có)"></textarea>

            <div class="note">* Bắt buộc</div>
            <button type="submit"><i class="fa fa-paper-plane"></i> Gửi yêu cầu</button>
            <% if (request.getAttribute("success") != null) { %>
                <div style="color: green; font-weight: bold; text-align: center; margin-top: 14px;">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div style="color: red; font-weight: bold; text-align: center; margin-top: 14px;">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
        </div>
    </form>
<!-- FOOTER Báº®T Äáº¦U -->
<footer id="footer"><!--Footer-->
    <div class="footer-widget">
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <div class="single-widget">
                        <h2>Dịch vụ</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="orders">Xem Đơn mua</a></li>
                            <li><a href="profile">Thay đổi hồ sơ</a></li>
                            <li><a href="#">Giỏ hoa theo yêu cầu</a></li>
                            <li><a href="${pageContext.request.contextPath}/home?pageNum=1">Tiếp tục mua sắm</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="single-widget">
                        <h2>Liên hệ </h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="https://www.facebook.com/tran.uc.kien.588942">Facebook</a></li>
                            <li><a href="https://github.com/kientd10/Sell_Flower_System_Group2">Github</a></li>
                            <li><a href="https://accounts.google.com/v3/signin/identifier?ifkv=AdBytiMmsOAuql232UmLNKelOUNWSkE5R7zTjDiG1c2Eh9s_g4WpAUxqvRqKj9gMYsdypUFg84Mr&service=mail&flowName=GlifWebSignIn&flowEntry=ServiceLogin&dsh=S1730468177%3A1750350775108616">kientdhe186194@fpt.edu.vn</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-3 col-sm-offset-1">
                    <div class="single-widget">
                        <h2>Về chúng tôi</h2>
                        <form action="#" class="searchform">
                            <input type="text" placeholder="Nhập email" />
                            <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                            <p>Đăng kí để nhận được các thông báo <br />ưu đãi và sản phẩm mới nhất...</p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <p class="pull-left">Copyright © 2025  Flower Shop. All rights reserved</p>
                <p class="pull-right">Designed by <span style="color: #080101;"  ><a target="_blank" href="https://github.com/kientd10/Sell_Flower_System_Group2">Group 2</a></span></p>
            </div>
        </div>
    </div>
</footer><!--/Footer-->
</body>
</html> 