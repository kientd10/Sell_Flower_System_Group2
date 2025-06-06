/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;
import java.sql.Timestamp;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import dal.DBcontext;
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
@WebServlet(name="PlaceOder", urlPatterns={"/placeOrder"})
public class PlaceOder extends HttpServlet {
   
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
            out.println("<title>Servlet PlaceOder</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PlaceOder at " + request.getContextPath () + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId == null) {
            userId = 1; // Giả lập nếu chưa có session đăng nhập
        }

        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");
        String deliveryTime = request.getParameter("deliveryTime");

        try (Connection conn = DBcontext.getJDBCConnection()) {
            conn.setAutoCommit(false);

            // 1. Lấy giỏ hàng của user
            String getCartSQL = "SELECT template_id, quantity FROM shopping_cart WHERE user_id = ?";
            PreparedStatement psCart = conn.prepareStatement(getCartSQL);
            psCart.setInt(1, userId);
            ResultSet rsCart = psCart.executeQuery();

            List<Integer> templateIds = new ArrayList<>();
            Map<Integer, Integer> quantities = new HashMap<>();

            while (rsCart.next()) {
                int templateId = rsCart.getInt("template_id");
                int quantity = rsCart.getInt("quantity");
                templateIds.add(templateId);
                quantities.put(templateId, quantity);
            }

            if (templateIds.isEmpty()) {
                response.getWriter().println("Giỏ hàng đang trống!");
                return;
            }

            // 2. Tính tổng tiền
            double totalAmount = 0;
            String getPriceSQL = "SELECT template_id, base_price FROM bouquet_templates WHERE template_id = ?";
            PreparedStatement psPrice = conn.prepareStatement(getPriceSQL);

            for (int id : templateIds) {
                psPrice.setInt(1, id);
                ResultSet rs = psPrice.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("base_price");
                    totalAmount += price * quantities.get(id);
                }
            }

            // 3. Tạo đơn hàng
            String insertOrder = "INSERT INTO orders (user_id, total_amount, status, created_at) VALUES (?, ?, 'Pending', NOW())";
            PreparedStatement psOrder = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, totalAmount);
            psOrder.executeUpdate();

            ResultSet rsOrder = psOrder.getGeneratedKeys();
            int orderId = -1;
            if (rsOrder.next()) {
                orderId = rsOrder.getInt(1);
            }

            // 4. Tạo chi tiết đơn hàng
            String insertDetail = "INSERT INTO order_details (order_id, template_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(insertDetail);

            for (int id : templateIds) {
                int qty = quantities.get(id);
                psPrice.setInt(1, id);
                ResultSet rs = psPrice.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("base_price");
                    double subtotal = qty * price;

                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, id);
                    psDetail.setInt(3, qty);
                    psDetail.setDouble(4, price);
                    psDetail.setDouble(5, subtotal);
                    psDetail.addBatch();
                }
            }
            psDetail.executeBatch();

            // 5. Ghi thông tin giao hàng
            String insertDelivery = "INSERT INTO deliveries (order_id, delivery_address, delivery_date, shipper_name) VALUES (?, ?, ?, ?)";
            PreparedStatement psDelivery = conn.prepareStatement(insertDelivery);
            psDelivery.setInt(1, orderId);
            psDelivery.setString(2, receiverAddress);
            psDelivery.setTimestamp(3, Timestamp.valueOf(deliveryTime.replace("T", " ") + ":00"));
            psDelivery.setString(4, receiverName + " (" + receiverPhone + ")");
            psDelivery.executeUpdate();

            conn.commit();

            // 6. Thông báo thành công
            response.getWriter().println("<h2>Đặt hàng thành công!</h2>");
            response.getWriter().println("<p>Mã đơn hàng: " + orderId + "</p>");
            response.getWriter().println("<p>Tổng tiền: " + totalAmount + " VNĐ</p>");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi đặt hàng: " + e.getMessage());
        }
    }
}
