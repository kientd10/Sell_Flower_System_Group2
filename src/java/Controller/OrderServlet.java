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
        String role = (String) session.getAttribute("role"); // Lấy role từ session
        
        System.out.println("UserId from session: " + userId);
        System.out.println("Role from session: " + role);
        
        if (userId == null || role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Order> allOrders = new ArrayList<>();
            
            // Lấy đơn hàng theo role
            if (role.equals("Customer")) {
                // Customer chỉ thấy đơn hàng của mình
                allOrders = orderDAO.getOrdersByUserId(userId);
            } else if (role.equals("Manager")) {
                // Manager thấy tất cả đơn hàng
                allOrders = orderDAO.getAllOrders();
            } else if (role.equals("Staff")) {
                // Staff chỉ thấy đơn hàng đang chuẩn bị
                allOrders = orderDAO.getOrdersByStatus("Đang chuẩn bị");
            } else if (role.equals("Shipper")) {
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

            for (Order order : allOrders) {
                switch (order.getStatus()) {
                    case "Chờ xác nhận" -> pendingOrders.add(order);
                    case "Đang chuẩn bị" -> preparingOrders.add(order);
                    case "Chờ giao hàng" -> shippingOrders.add(order);
                    case "Đã mua" -> completedOrders.add(order);
                }
            }

            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("preparingOrders", preparingOrders);
            request.setAttribute("shippingOrders", shippingOrders);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("userRole", role);

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
        String role = (String) session.getAttribute("role");
        
        // Chỉ Manager và Staff mới được update trạng thái
        if (!role.equals("Manager") && !role.equals("Staff")) {
            response.sendRedirect("accessDenied.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String newStatus = request.getParameter("newStatus");
                
                // Kiểm tra quyền update theo role
                boolean canUpdate = false;
                if (role.equals("Manager")) {
                    // Manager có thể update tất cả trạng thái
                    canUpdate = true;
                } else if (role.equals("Staff")) {
                    // Staff chỉ có thể update từ "Đang chuẩn bị" sang "Chờ giao hàng"
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
