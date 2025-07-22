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
            // Lấy thông tin đơn hàng
            Order targetOrder = orderDAO.getOrderById(orderId);
            if (targetOrder == null) {
                response.sendRedirect("orders");
                return;
            }
            // Nếu là đơn hoa yêu cầu
            if (targetOrder.getRequestId() != null) {
                dal.FlowerRequestDAO frDao = new dal.FlowerRequestDAO();
                Model.FlowerRequest fr = frDao.getRequestById(targetOrder.getRequestId());
                if (fr != null) {
                    session.setAttribute("customFlowerRequestId", fr.getRequestId());
                    session.setAttribute("customFlowerQuantity", fr.getQuantity());
                    session.setAttribute("customFlowerPrice", fr.getSuggestedPrice());
                    session.removeAttribute("cart");
                    session.removeAttribute("selectedCartIds");
                    response.sendRedirect("checkout.jsp");
                    return;
                }
            }
            // Đơn thường: giữ logic cũ
            BouquetDAO bouquetDAO = new BouquetDAO();
            List<OrderItem> orderItems = orderDAO.getItemsByOrderId(orderId, null);
            for (OrderItem item : orderItems) {
                BouquetTemplate template = bouquetDAO.getBouquetByID(item.getTemplateId());
                if (template != null) {
                    bouquetDAO.addToCart(userId, item.getTemplateId(), item.getQuantity());
                }
            }
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