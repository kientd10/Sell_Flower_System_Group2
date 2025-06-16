/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author tuanh
 */
public class RoleFilter implements Filter{
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Mã khởi tạo, nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int roleId = user.getRoleId();
        String requestURI = httpRequest.getRequestURI();

        // Xác định quyền truy cập
        boolean isAuthorized = false;

        if (requestURI.endsWith("management.jsp")) {
            // Chỉ Quản lý (role_id: 3) được truy cập manager.jsp
            isAuthorized = (roleId == 3);
        } else if (requestURI.endsWith("management.jsp")) {
            // Chỉ Nhân viên (role_id: 2) được truy cập staff.jsp
            isAuthorized = (roleId == 2);
        } else if (requestURI.endsWith("management.jsp")) {
            // Chỉ Người giao hàng (role_id: 4) được truy cập shipper.jsp
            isAuthorized = (roleId == 4);
        } else {
            // Cho phép truy cập các trang khác (như login.jsp, index.jsp, v.v.)
            isAuthorized = true;
        }

        if (isAuthorized) {
            chain.doFilter(request, response); // Tiếp tục đến trang yêu cầu
        } else {
            httpResponse.sendRedirect("accessDenied.jsp");
        }
    }

    @Override
    public void destroy() {
        // Mã dọn dẹp, nếu cần
    }
}
