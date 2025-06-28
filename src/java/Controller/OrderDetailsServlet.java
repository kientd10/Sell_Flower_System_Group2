/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.OrderDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.Order;
import Model.OrderItem;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="OrderDetailsServlet", urlPatterns={"/orderDetails"})
public class OrderDetailsServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Integer roleId = (Integer) session.getAttribute("roleId");
        
        System.out.println("OrderDetailsServlet - UserId: " + userId + ", RoleId: " + roleId);
        
        if (userId == null || roleId == null) {
            System.out.println("OrderDetailsServlet - Redirecting to login: userId or roleId is null");
            response.sendRedirect("login.jsp");
            return;
        }
        
        String orderIdStr = request.getParameter("orderId");
        System.out.println("OrderDetailsServlet - OrderId parameter: " + orderIdStr);
        
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            System.out.println("OrderDetailsServlet - Redirecting to orders: orderId is null or empty");
            response.sendRedirect("orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            System.out.println("OrderDetailsServlet - Parsed orderId: " + orderId);
            OrderDAO orderDAO = new OrderDAO();
            
            // Lấy thông tin đơn hàng
            List<Order> userOrders = orderDAO.getOrdersByUserId(userId);
            System.out.println("OrderDetailsServlet - Found " + userOrders.size() + " orders for user");
            
            Order targetOrder = null;
            
            for (Order order : userOrders) {
                if (order.getOrderId() == orderId) {
                    targetOrder = order;
                    break;
                }
            }
            
            if (targetOrder == null) {
                System.out.println("OrderDetailsServlet - Order not found, redirecting to orders");
                response.sendRedirect("orders");
                return;
            }
            
            System.out.println("OrderDetailsServlet - Found target order: " + targetOrder.getOrderCode());
            
            // Lấy chi tiết sản phẩm trong đơn hàng
            List<OrderItem> orderItems = orderDAO.getItemsByOrderId(orderId, null);
            System.out.println("OrderDetailsServlet - Found " + orderItems.size() + " items for order");
            targetOrder.setItems(orderItems);
            
            request.setAttribute("order", targetOrder);
            System.out.println("OrderDetailsServlet - Forwarding to orderDetails.jsp");
            request.getRequestDispatcher("orderDetails.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("OrderDetailsServlet - Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("orders");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Order Details Servlet";
    }
} 