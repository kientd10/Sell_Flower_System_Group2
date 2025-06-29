/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.ShoppingCart;
import java.sql.Timestamp;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import dal.DBcontext;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PlaceOder", urlPatterns = {"/placeOrder"})
public class PlaceOder extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet PlaceOder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PlaceOder at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
        
        // Kiểm tra đăng nhập
        if (userId == null || roleId == null) {
            System.out.println("PlaceOder: User not logged in, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Chỉ cho phép Customer (roleId = 1) đặt hàng
        if (roleId != 1) {
            System.out.println("PlaceOder: User is not a customer, redirecting to home");
            response.sendRedirect("home");
            return;
        }
        
        System.out.println("PlaceOder: Processing order for user " + userId + " with role " + roleId);

        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");
        String deliveryTime = request.getParameter("deliveryTime");
        // ❗️ THÊM dòng này để tránh lỗi
        String province = request.getParameter("province"); 

        String district = request.getParameter("district");
        String ward = request.getParameter("ward");

        String fullDeliveryAddress = receiverAddress + ", " + ward + ", " + district + ", " + province;
        System.out.println("📦 fullDeliveryAddress = " + fullDeliveryAddress);

        // Lưu vào session nếu cần dùng ở trang tiếp theo
        session.setAttribute("receiverName", receiverName);
        session.setAttribute("receiverPhone", receiverPhone);
        session.setAttribute("receiverAddress", fullDeliveryAddress);  // ✅ địa chỉ đầy đủ
        session.setAttribute("deliveryTime", deliveryTime);
        session.setAttribute("fullname", receiverName);

        // Lấy giỏ hàng từ session
        List<String> selectedCartIds = (List<String>) session.getAttribute("selectedCartIds");
        List<ShoppingCart> fullCart = (List<ShoppingCart>) session.getAttribute("cart");
        double total = 0.0;
        if (selectedCartIds != null && fullCart != null) {
            for (ShoppingCart item : fullCart) {
                String cartIdStr = String.valueOf(item.getCartId());

                if (selectedCartIds.contains(cartIdStr)) {
                    if (item.getBouquetTemplate() == null) {
                        System.out.println("⚠ BouquetTemplate bị null với cartId: " + item.getCartId());
                        continue;
                    }

                    double price = item.getBouquetTemplate().getBasePrice();
                    int quantity = item.getQuantity();

                    System.out.println("✅ cartId: " + item.getCartId() + " | Price: " + price + " | Qty: " + quantity);
                    total += price * quantity;
                }
            }
        }

        System.out.println("===> Tổng tiền (total): " + total);

        String amount = String.format("%.2f", total);
        session.setAttribute("amount", amount);
        System.out.println(">> Chuỗi amount: " + amount);
        List<ShoppingCart> selectedItems = new ArrayList<>();
        for (ShoppingCart item : fullCart) {
            if (selectedCartIds.contains(String.valueOf(item.getCartId()))) {
                selectedItems.add(item);
            }
        }

        // ✅ Lưu đơn hàng
        OrderDAO dao = new OrderDAO();
        int orderId = dao.insertOrder(userId, selectedItems, total, fullDeliveryAddress, receiverPhone);
        System.out.println("===> Đã tạo đơn hàng với ID: " + orderId);

        // ✅ Xóa giỏ hàng khỏi session sau khi lưu đơn
        session.removeAttribute("cart");
        session.removeAttribute("selectedCartIds");

        // ✅ Điều hướng đến bước thanh toán tiếp theo
        session.setAttribute("orderId", orderId); // Nếu cần

        // ✅ CHUYỂN SAU KHI SET XONG
        response.sendRedirect("createpaymentservlet");
    }
}
