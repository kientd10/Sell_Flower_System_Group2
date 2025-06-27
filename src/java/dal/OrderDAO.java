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
import Model.Order;
import Model.OrderItem;
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

    public int insertOrder(int userId, List<ShoppingCart> cartItems, double totalAmount, String deliveryAddress, String deliveryPhone) {
        int orderId = -1;
        Connection conn = null;
        try {
            conn = new DBcontext().getConnection();
            conn.setAutoCommit(false);

            // 1. Thêm vào bảng orders
            String orderCode = "ORD" + System.currentTimeMillis();
            String insertOrderSQL = "INSERT INTO orders (order_code, customer_id, total_amount, status_id, delivery_address, delivery_phone) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, orderCode);
                ps.setInt(2, userId);
                ps.setDouble(3, totalAmount);
                ps.setInt(4, 1); // status_id = 1 (chờ xác nhận) -- nếu pay success
                ps.setString(5, deliveryAddress);
                ps.setString(6, deliveryPhone);
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            // 2. Thêm vào order_details
            String insertDetailSQL = "INSERT INTO order_details (order_id, template_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertDetailSQL)) {
                for (ShoppingCart item : cartItems) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getTemplateId());
                    ps.setInt(3, item.getQuantity());
                    ps.setDouble(4, item.getPrice());
                    ps.setDouble(5, item.getQuantity() * item.getPrice());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }

    public List<Order> getOrdersByUserId(int userId) throws Exception {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address,
            os.status_name,o.created_At
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            WHERE o.customer_id = ?
            """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));

                // Load danh sách sản phẩm trong đơn hàng
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        } finally {
            // Đóng kết nối
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close(); // hoặc DBcontext().closeConnection(conn);
            }
        }

        return orders;
    }

    // Lấy tất cả đơn hàng (cho Manager)
    public List<Order> getAllOrders() throws Exception {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address,
            os.status_name, o.created_At, u.full_name as customer_name
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            JOIN users u ON o.customer_id = u.user_id
            ORDER BY o.created_at DESC
            """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));

                // Load danh sách sản phẩm trong đơn hàng
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }

        return orders;
    }

    // Lấy đơn hàng theo trạng thái (cho Staff và Shipper)
    public List<Order> getOrdersByStatus(String status) throws Exception {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address,
            os.status_name, o.created_At, u.full_name as customer_name
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            JOIN users u ON o.customer_id = u.user_id
            WHERE os.status_name = ?
            ORDER BY o.created_at DESC
            """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));

                // Load danh sách sản phẩm trong đơn hàng
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }

        return orders;
    }

    // Lấy trạng thái hiện tại của đơn hàng
    public String getOrderStatusById(int orderId) throws Exception {
        String sql = """
            SELECT os.status_name
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            WHERE o.order_id = ?
            """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("status_name");
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }

        return null;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String newStatus) throws Exception {
        String sql = """
            UPDATE orders o
            JOIN order_status os ON os.status_name = ?
            SET o.status_id = os.status_id
            WHERE o.order_id = ?
            """;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // Lấy tất cả trạng thái đơn hàng (cho dropdown)
    public List<String> getAllOrderStatuses() throws Exception {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT status_name FROM order_status ORDER BY status_id";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                statuses.add(rs.getString("status_name"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }

        return statuses;
    }

    private List<OrderItem> getItemsByOrderId(int orderId, Connection conn) throws Exception {
        List<OrderItem> items = new ArrayList<>();

        String sql = """
            SELECT od.quantity, od.unit_price, bt.template_name, bt.image_url
            FROM order_details od
            JOIN bouquet_templates bt ON od.template_id = bt.template_id
            WHERE od.order_id = ?
            """;

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setProductName(rs.getString("template_name"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                items.add(item);
            }

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }

        return items;
    }

}
