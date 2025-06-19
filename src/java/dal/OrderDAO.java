/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dal;

/**
 *
 * @author PC
 */
import Model.BouquetTemplate;
import Model.ShoppingCart;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.*;
import java.lang.*;
import java.sql.Connection;
import java.sql.Statement;


public class OrderDAO {
    private Connection conn;

    public OrderDAO() {
        try {
            conn = new DBcontext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //  Tính tổng tiền giỏ hàng
    public double TotalPrice(int user_id) {
        double total = 0;
        String sql = "SELECT d.quantity, bt.base_price "
                   + "FROM shopping_cart d "
                   + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                   + "WHERE d.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user_id);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    double basePrice = rs.getDouble("base_price");
                    int quantity = rs.getInt("quantity");
                    total += basePrice * quantity;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Lấy sản phẩm đã mua thành công (đã giao hàng)
    public List<BouquetTemplate> getPurchasedProductsByUser(int userId) {
        List<BouquetTemplate> list = new ArrayList<>();
        String sql = "SELECT DISTINCT od.template_id, bt.template_name "
                   + "FROM orders o "
                   + "JOIN order_status s ON o.status_id = s.status_id "
                   + "JOIN order_details od ON o.order_id = od.order_id "
                   + "JOIN bouquet_templates bt ON od.template_id = bt.template_id "
                   + "WHERE o.customer_id = ? AND s.status_name = 'Delivered'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BouquetTemplate b = new BouquetTemplate();
                b.setTemplateId(rs.getInt("template_id"));
                b.setTemplateName(rs.getString("template_name"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm đơn hàng mới và chi tiết sản phẩm
    public int insertOrder(int userId, List<ShoppingCart> cartItems, double totalAmount) {
        int orderId = -1;
        try {
            conn.setAutoCommit(false);

            // 1. Thêm đơn hàng vào bảng orders
            String insertOrderSQL = "INSERT INTO orders (customer_id, total_price, status_id, order_date) "
                                  + "VALUES (?, ?, ?, NOW())";
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setDouble(2, totalAmount);
                ps.setInt(3, 2); // status_id = 2 → "Paid"
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            // 2. Thêm chi tiết sản phẩm vào bảng order_details
            String insertDetailSQL = "INSERT INTO order_details (order_id, template_id, quantity, price) "
                                   + "VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertDetailSQL)) {
                for (ShoppingCart item : cartItems) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getTemplateId());
                    ps.setInt(3, item.getQuantity());
                    ps.setDouble(4, item.getPrice());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }
}
