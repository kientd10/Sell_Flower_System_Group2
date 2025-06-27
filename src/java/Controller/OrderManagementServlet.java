package Controller;

import Model.Category;
import dal.OrderDAO;
import Model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/orderManagement")
public class OrderManagementServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Integer roleId = (Integer) session.getAttribute("roleId");
        if (userId == null || roleId == null || (roleId != 2 && roleId != 3 && roleId != 4)) {
            response.sendRedirect("accessDenied.jsp");
            return;
        }
        String role = "";
        if (roleId == 2) role = "Staff";
        else if (roleId == 3) role = "Manager";
        else if (roleId == 4) role = "Shipper";

        // Lấy filter từ request
        String status = request.getParameter("status");
        String category = request.getParameter("category");
        String priceRange = request.getParameter("priceRange");
        String province = request.getParameter("province");
        String search = request.getParameter("search");
        String dateFilter = request.getParameter("dateFilter");
        int page = 1;
        int pageSize = 20;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy danh sách đơn hàng theo role và filter
        List<Order> orders = orderDAO.getOrdersForManagement(roleId, status, category, priceRange, province, search, dateFilter, page, pageSize);
        int totalOrders = orderDAO.countOrdersForManagement(roleId, status, category, priceRange, province, search, dateFilter);
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

        // Đếm số lượng đơn hàng theo từng trạng thái cho icon thống kê
        int pendingCount = orderDAO.countOrdersForManagement(roleId, "Chờ xác nhận", category, priceRange, province, search, dateFilter);
        int preparingCount = orderDAO.countOrdersForManagement(roleId, "Đang chuẩn bị", category, priceRange, province, search, dateFilter);
        int shippingCount = orderDAO.countOrdersForManagement(roleId, "Chờ giao hàng", category, priceRange, province, search, dateFilter);
        int completedCount = orderDAO.countOrdersForManagement(roleId, "Đã mua", category, priceRange, province, search, dateFilter);

        // Lấy danh sách danh mục
        List<Category> categories = orderDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("status", status);
        request.setAttribute("category", category);
        request.setAttribute("priceRange", priceRange);
        request.setAttribute("province", province);
        request.setAttribute("search", search);
        request.setAttribute("userRole", role);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("preparingCount", preparingCount);
        request.setAttribute("shippingCount", shippingCount);
        request.setAttribute("completedCount", completedCount);

        // Lấy danh sách trạng thái cho dropdown
        try {
            List<String> orderStatuses = orderDAO.getAllOrderStatuses();
            request.setAttribute("orderStatuses", orderStatuses);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("orderManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer roleId = (Integer) session.getAttribute("roleId");
        if (roleId == null || (roleId != 2 && roleId != 3)) {
            response.sendRedirect("accessDenied.jsp");
            return;
        }
        String role = roleId == 3 ? "Manager" : (roleId == 2 ? "Staff" : "");
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String newStatus = request.getParameter("newStatus");
                boolean canUpdate = false;
                if (roleId == 3) {
                    canUpdate = true;
                } else if (roleId == 2) {
                    String currentStatus = orderDAO.getOrderStatusById(orderId);
                    if ("Đang chuẩn bị".equals(currentStatus) && "Chờ giao hàng".equals(newStatus)) {
                        canUpdate = true;
                    }
                }
                if (canUpdate) {
                    orderDAO.updateOrderStatus(orderId, newStatus);
                    request.setAttribute("message", "Cập nhật trạng thái đơn hàng thành công!");
                } else {
                    request.setAttribute("error", "Bạn không có quyền thực hiện thao tác này!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi cập nhật trạng thái đơn hàng!");
            }
        }
        response.sendRedirect("orderManagement");
    }
} 