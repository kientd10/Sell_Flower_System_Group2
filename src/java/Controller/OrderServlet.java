/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Order;
import java.sql.Connection;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class OrderServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private OrderDAO orderDAO;
    @Override
        public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Integer roleId = (Integer) session.getAttribute("roleId"); // Lấy role từ session dưới dạng Integer
        
        if (userId == null || roleId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Order> allOrders = new ArrayList<>();
            
            // Lấy đơn hàng theo role
            if (roleId == 1) { // Customer
                // Customer chỉ thấy đơn hàng của mình
                allOrders = orderDAO.getOrdersByUserId(userId);
            } else if (roleId == 3) { // Manager
                // Manager thấy tất cả đơn hàng
                allOrders = orderDAO.getAllOrders();
            } else if (roleId == 2) { // Staff
                // Staff chỉ thấy đơn hàng đang chuẩn bị
                allOrders = orderDAO.getOrdersByStatus("Đang chuẩn bị");
            } else if (roleId == 4) { // Shipper
                // Shipper chỉ thấy đơn hàng đang giao hàng
                allOrders = orderDAO.getOrdersByStatus("Chờ giao hàng");
            } else {
                // Role không hợp lệ
                response.sendRedirect("accessDenied.jsp");
                return;
            }

            // Phân loại đơn hàng theo trạng thái
            List<Order> pendingOrders = new ArrayList<>();
            List<Order> preparingOrders = new ArrayList<>();
            List<Order> shippingOrders = new ArrayList<>();
            List<Order> completedOrders = new ArrayList<>();
            List<Order> cancelledOrders = new ArrayList<>();

            // Bổ sung: Xử lý đơn hoa theo yêu cầu (requestId != null)
            dal.FlowerRequestDAO flowerRequestDAO = null;
            try { flowerRequestDAO = new dal.FlowerRequestDAO(); } catch (Exception ignore) {}
            for (Order order : allOrders) {
                Integer reqId = order.getRequestId();
                if (reqId != null && flowerRequestDAO != null) {
                    try {
                        Model.FlowerRequest fr = flowerRequestDAO.getRequestById(reqId);
                        if (fr != null) {
                            Model.OrderItem customItem = new Model.OrderItem();
                            customItem.setProductName("Hoa yêu cầu");
                            int qty = (fr.getQuantity() > 0) ? fr.getQuantity() : 1;
                            double price = (fr.getSuggestedPrice() != null && fr.getSuggestedPrice().doubleValue() > 0) ? fr.getSuggestedPrice().doubleValue() : 1;
                            customItem.setQuantity(qty);
                            customItem.setUnitPrice(price);
                            // Ưu tiên sampleImageUrl nếu có, không thì lấy imageUrl
                            String img = (fr.getSampleImageUrl() != null && !fr.getSampleImageUrl().isEmpty()) ? fr.getSampleImageUrl() : fr.getImageUrl();
                            customItem.setImageUrl(img != null ? img : "");
                            customItem.setTemplateId(-1); // Để link không bị lỗi
                            List<Model.OrderItem> customList = new ArrayList<>();
                            customList.add(customItem);
                            order.setItems(customList);
                        }
                    } catch (Exception ignore) { /* log nếu cần */ }
                }
            }

            for (Order order : allOrders) {
                switch (order.getStatus()) {
                    case "Chờ xác nhận" -> pendingOrders.add(order);
                    case "Đang chuẩn bị" -> preparingOrders.add(order);
                    case "Chờ giao hàng" -> shippingOrders.add(order);
                    case "Đã mua" -> completedOrders.add(order);
                    case "Đã hủy" -> cancelledOrders.add(order);
                }
            }

            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("preparingOrders", preparingOrders);
            request.setAttribute("shippingOrders", shippingOrders);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("cancelledOrders", cancelledOrders);
            request.setAttribute("userRole", roleId);

            // Lấy danh sách trạng thái để hiển thị trong dropdown
            List<String> orderStatuses = orderDAO.getAllOrderStatuses();
            request.setAttribute("orderStatuses", orderStatuses);

            request.getRequestDispatcher("order.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi khi lấy đơn hàng", e);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Integer roleId = (Integer) session.getAttribute("roleId");
        
        // Chỉ Customer mới được hủy đơn hàng
        if (userId == null || roleId == null || roleId != 1) {
            response.sendRedirect("accessDenied.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("cancelOrder".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                
                // Kiểm tra xem đơn hàng có thể hủy không
                if (orderDAO.canCancelOrder(orderId, userId)) {
                    boolean cancelled = orderDAO.cancelOrder(orderId, userId);
                    if (cancelled) {
                        session.setAttribute("message", "Hủy đơn hàng thành công!");
                    } else {
                        session.setAttribute("error", "Không thể hủy đơn hàng!");
                    }
                } else {
                    session.setAttribute("error", "Đơn hàng không thể hủy hoặc không thuộc về bạn!");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Lỗi khi hủy đơn hàng!");
            }
        } else if ("updateStatus".equals(action)) {
            // Chỉ Manager, Staff và Shipper mới được update trạng thái
            if (roleId != 3 && roleId != 2 && roleId != 4) { // 3 = Manager, 2 = Staff, 4 = Shipper
                response.sendRedirect("accessDenied.jsp");
                return;
            }
            
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String newStatus = request.getParameter("newStatus");
                
                // Kiểm tra quyền update theo role
                boolean canUpdate = false;
                if (roleId == 3) { // Manager
                    // Manager có thể update tất cả trạng thái
                    canUpdate = true;
                } else if (roleId == 2) { // Staff
                    // Staff chỉ có thể update từ "Đang chuẩn bị" sang "Chờ giao hàng"
                    String currentStatus = orderDAO.getOrderStatusById(orderId);
                    if ("Đang chuẩn bị".equals(currentStatus) && "Chờ giao hàng".equals(newStatus)) {
                        canUpdate = true;
                    }
                } else if (roleId == 4) { // Shipper
                    // Shipper chỉ có thể update từ "Chờ giao hàng" sang "Đã mua"
                    String currentStatus = orderDAO.getOrderStatusById(orderId);
                    if ("Chờ giao hàng".equals(currentStatus) && "Đã mua".equals(newStatus)) {
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
        
        // Redirect về trang order
        response.sendRedirect("orders");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
