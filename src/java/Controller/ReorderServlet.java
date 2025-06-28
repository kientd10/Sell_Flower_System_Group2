package Controller;

import dal.OrderDAO;
import dal.BouquetDAO;
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
import Model.ShoppingCart;
import Model.BouquetTemplate;

@WebServlet(name="ReorderServlet", urlPatterns={"/reorder"})
public class ReorderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Integer roleId = (Integer) session.getAttribute("roleId");
        
        if (userId == null || roleId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect("orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDAO orderDAO = new OrderDAO();
            BouquetDAO bouquetDAO = new BouquetDAO();
            
            // Lấy thông tin đơn hàng
            List<Order> userOrders = orderDAO.getOrdersByUserId(userId);
            Order targetOrder = null;
            
            for (Order order : userOrders) {
                if (order.getOrderId() == orderId) {
                    targetOrder = order;
                    break;
                }
            }
            
            if (targetOrder == null) {
                response.sendRedirect("orders");
                return;
            }
            
            // Lấy chi tiết sản phẩm trong đơn hàng
            List<OrderItem> orderItems = orderDAO.getItemsByOrderId(orderId, null);
            
            // Thêm các sản phẩm vào giỏ hàng database
            for (OrderItem item : orderItems) {
                // Lấy thông tin BouquetTemplate
                BouquetTemplate template = bouquetDAO.getBouquetByID(item.getTemplateId());
                if (template != null) {
                    // Thêm vào giỏ hàng - method addToCart đã tự động xử lý trùng lặp
                    bouquetDAO.addToCart(userId, item.getTemplateId(), item.getQuantity());
                }
            }
            
            // Redirect đến giỏ hàng
            response.sendRedirect("cart");
            
        } catch (Exception e) {
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
} 