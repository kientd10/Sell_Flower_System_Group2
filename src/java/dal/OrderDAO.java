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
import Model.Category;
import java.math.BigDecimal;

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
            + "WHERE o.customer_id = ? AND s.status_name = 'Đã mua'"; // ✅ sửa tại đây

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

    // Tìm user (staff hoặc shipper) theo area và role, ưu tiên ít đơn nhất
    private Integer findUserByAreaAndRole(String area, int roleId, Connection conn) throws Exception {
        String sql = "SELECT u.user_id FROM users u LEFT JOIN orders o ON u.user_id = CASE WHEN ? = 2 THEN o.staff_id WHEN ? = 4 THEN o.shipper_id END WHERE u.area = ? AND u.role_id = ? GROUP BY u.user_id ORDER BY COUNT(o.order_id) ASC LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ps.setInt(2, roleId);
            ps.setString(3, area);
            ps.setInt(4, roleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        }
        return null;
    }

    // Sửa hàm insertOrder để tự động assign staff và shipper theo area
    public int insertOrder(int userId, List<ShoppingCart> cartItems, double totalAmount, String deliveryAddress, String deliveryPhone, String deliveryName, Integer requestId) {
        int orderId = -1;
        Connection conn = null;
        try {
            conn = new DBcontext().getConnection();
            conn.setAutoCommit(false);

            // Lấy area từ địa chỉ giao hàng (giả sử tỉnh là phần cuối cùng, sau dấu phẩy)
            String area = null;
            if (deliveryAddress != null && deliveryAddress.contains(",")) {
                String[] parts = deliveryAddress.split(",");
                area = parts[parts.length - 1].trim();
            }

            Integer staffId = null;
            Integer shipperId = null;
            if (area != null && !area.isEmpty()) {
                staffId = findUserByAreaAndRole(area, 2, conn); // 2 = staff
                shipperId = findUserByAreaAndRole(area, 4, conn); // 4 = shipper
            }

            // 1. Thêm vào bảng orders
            String orderCode = "ORD" + System.currentTimeMillis();
            String insertOrderSQL = "INSERT INTO orders (order_code, customer_id, total_amount, status_id, delivery_address, delivery_phone, delivery_name, staff_id, shipper_id, request_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, orderCode);
                ps.setInt(2, userId);
                ps.setDouble(3, totalAmount);
                ps.setInt(4, 1); // status_id = 1 (chờ xác nhận)
                ps.setString(5, deliveryAddress);
                ps.setString(6, deliveryPhone);
                ps.setString(7, deliveryName);
                if (staffId != null) {
                    ps.setInt(8, staffId);
                } else {
                    ps.setNull(8, java.sql.Types.INTEGER);
                }
                if (shipperId != null) {
                    ps.setInt(9, shipperId);
                } else {
                    ps.setNull(9, java.sql.Types.INTEGER);
                }
                if (requestId != null) {
                    ps.setInt(10, requestId);
                } else {
                    ps.setNull(10, java.sql.Types.INTEGER);
                }
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            // 2. Thêm vào order_details
            if (cartItems != null && !cartItems.isEmpty()) {
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

    // Sửa các truy vấn lấy đơn hàng để lấy cả delivery_name
    public List<Order> getOrdersByUserId(int userId) throws Exception {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_phone, o.delivery_name,
            os.status_name,o.created_At, o.request_id
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            WHERE o.customer_id = ?
            ORDER BY o.created_at DESC 
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
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);

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
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_phone, o.delivery_name,
            os.status_name, o.created_At, u.full_name as customer_name, o.request_id
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
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);

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
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_phone, o.delivery_name,
            os.status_name, o.created_At, u.full_name as customer_name,
            s.full_name as staff_name, sh.full_name as shipper_name, o.request_id
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            JOIN users u ON o.customer_id = u.user_id
            LEFT JOIN users s ON o.staff_id = s.user_id
            LEFT JOIN users sh ON o.shipper_id = sh.user_id
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
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                // Load danh sách sản phẩm trong đơn hàng nếu cần
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

    public List<OrderItem> getItemsByOrderId(int orderId, Connection conn) throws Exception {
        List<OrderItem> items = new ArrayList<>();

        // Lấy request_id của order này
        Integer requestId = null;
        String reqSql = "SELECT request_id FROM orders WHERE order_id = ?";
        try (PreparedStatement reqPs = (conn != null ? conn : DBcontext.getJDBCConnection()).prepareStatement(reqSql)) {
            reqPs.setInt(1, orderId);
            try (ResultSet reqRs = reqPs.executeQuery()) {
                if (reqRs.next()) {
                    Object reqObj = reqRs.getObject("request_id");
                    if (reqObj != null) requestId = reqRs.getInt("request_id");
                }
            }
        }

        if (requestId != null) {
            // Nếu là hoa yêu cầu, lấy ảnh từ flower_requests theo requestId của order
            String sql = "SELECT od.quantity, od.unit_price, fr.image_url, fr.description, od.template_id " +
                    "FROM order_details od " +
                    "JOIN flower_requests fr ON fr.request_id = ? " +
                    "WHERE od.order_id = ?";
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean shouldCloseConnection = false;
            try {
                if (conn == null) {
                    conn = DBcontext.getJDBCConnection();
                    shouldCloseConnection = true;
                }
                ps = conn.prepareStatement(sql);
                ps.setInt(1, requestId);
                ps.setInt(2, orderId);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setProductName(rs.getString("description")); // hoặc tên khác nếu có
                    item.setImageUrl(rs.getString("image_url"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setTemplateId(rs.getInt("template_id"));
                    items.add(item);
                }
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (shouldCloseConnection && conn != null) conn.close();
            }
        } else {
            // Hoa thường, lấy như cũ
            String sql = """
                SELECT od.quantity, od.unit_price, bt.template_name, bt.image_url, bt.template_id
                FROM order_details od
                JOIN bouquet_templates bt ON od.template_id = bt.template_id
                WHERE od.order_id = ?
                """;
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean shouldCloseConnection = false;
            try {
                if (conn == null) {
                    conn = DBcontext.getJDBCConnection();
                    shouldCloseConnection = true;
                }
                ps = conn.prepareStatement(sql);
                ps.setInt(1, orderId);
                rs = ps.executeQuery();
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setProductName(rs.getString("template_name"));
                    item.setImageUrl(rs.getString("image_url"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setTemplateId(rs.getInt("template_id"));
                    items.add(item);
                }
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (shouldCloseConnection && conn != null) conn.close();
            }
        }
        return items;
    }

    // Lấy danh sách đơn hàng cho trang quản lý, có lọc và phân trang
    public List<Order> getOrdersForManagement(Integer roleId, String status, String category, String priceRange, String province, String search, String dateFilter, String sortPrice, int page, int pageSize) {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_name, o.delivery_phone, os.status_name, o.created_At, u.full_name as customer_name, u.phone, u.email, ");
        sql.append("s.full_name as staff_name, sh.full_name as shipper_name, o.request_id ");
        sql.append("FROM orders o ");
        sql.append("JOIN order_status os ON o.status_id = os.status_id ");
        sql.append("JOIN users u ON o.customer_id = u.user_id ");
        sql.append("LEFT JOIN users s ON o.staff_id = s.user_id ");
        sql.append("LEFT JOIN users sh ON o.shipper_id = sh.user_id ");
        sql.append("LEFT JOIN order_details od ON o.order_id = od.order_id ");
        sql.append("LEFT JOIN bouquet_templates bt ON od.template_id = bt.template_id ");
        sql.append("LEFT JOIN categories c ON bt.category_id = c.category_id ");
        sql.append("WHERE 1=1 ");
        if (roleId == 2) {
            sql.append("AND os.status_name = 'Đang chuẩn bị' ");
        } else if (roleId == 4) {
            sql.append("AND os.status_name = 'Chờ giao hàng' ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND os.status_name = ? ");
        }
        if (category != null && !category.isEmpty()) {
            sql.append("AND c.category_name = ? ");
        }
        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("Dưới 1 triệu")) {
                sql.append("AND o.total_amount < 1000000 ");
            } else if (priceRange.equals("Từ 1 triệu đến dưới 5 triệu")) {
                sql.append("AND o.total_amount >= 1000000 AND o.total_amount < 5000000 ");
            } else if (priceRange.equals("Từ 5 triệu đến dưới 10 triệu")) {
                sql.append("AND o.total_amount >= 5000000 AND o.total_amount < 10000000 ");
            } else if (priceRange.equals("Trên 10 triệu")) {
                sql.append("AND o.total_amount >= 10000000 ");
            }
        }
        if (province != null && !province.isEmpty()) {
            sql.append("AND LOWER(TRIM(o.delivery_address)) LIKE ? ");
        }
        if (search != null && !search.isEmpty()) {
            sql.append("AND (o.order_code LIKE ? OR o.delivery_name LIKE ? OR o.delivery_phone LIKE ?) ");
        }
        if (dateFilter != null && !dateFilter.isEmpty()) {
            if (dateFilter.equals("today")) {
                sql.append("AND DATE(o.created_at) = CURDATE() ");
            } else if (dateFilter.equals("week")) {
                sql.append("AND YEARWEEK(o.created_at, 1) = YEARWEEK(CURDATE(), 1) ");
            } else if (dateFilter.equals("month")) {
                sql.append("AND YEAR(o.created_at) = YEAR(CURDATE()) AND MONTH(o.created_at) = MONTH(CURDATE()) ");
            }
        }
        sql.append("GROUP BY o.order_id ");
        
        // Xử lý sắp xếp
        if ("asc".equals(sortPrice)) {
            sql.append("ORDER BY o.total_amount ASC ");
        } else if ("desc".equals(sortPrice)) {
            sql.append("ORDER BY o.total_amount DESC ");
        } else {
            sql.append("ORDER BY o.created_at DESC ");
        }
        
        sql.append("LIMIT ? OFFSET ?");

        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) params.add(status);
        if (category != null && !category.isEmpty()) params.add(category);
        if (province != null && !province.isEmpty()) params.add("%" + province.trim().toLowerCase() + "%");
        if (search != null && !search.isEmpty()) {
            params.add("%" + search + "%");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Đếm tổng số đơn hàng cho phân trang
    public int countOrdersForManagement(Integer roleId, String status, String category, String priceRange, String province, String search, String dateFilter) {
        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(DISTINCT o.order_id) as total ");
        sql.append("FROM orders o ");
        sql.append("JOIN order_status os ON o.status_id = os.status_id ");
        sql.append("JOIN users u ON o.customer_id = u.user_id ");
        sql.append("JOIN order_details od ON o.order_id = od.order_id ");
        sql.append("JOIN bouquet_templates bt ON od.template_id = bt.template_id ");
        sql.append("JOIN categories c ON bt.category_id = c.category_id ");
        sql.append("WHERE 1=1 ");
        if (roleId == 2) {
            sql.append("AND os.status_name = 'Đang chuẩn bị' ");
        } else if (roleId == 4) {
            sql.append("AND os.status_name = 'Chờ giao hàng' ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND os.status_name = ? ");
        }
        if (category != null && !category.isEmpty()) {
            sql.append("AND c.category_name = ? ");
        }
        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("Dưới 1 triệu")) {
                sql.append("AND o.total_amount < 1000000 ");
            } else if (priceRange.equals("Từ 1 triệu đến dưới 5 triệu")) {
                sql.append("AND o.total_amount >= 1000000 AND o.total_amount < 5000000 ");
            } else if (priceRange.equals("Từ 5 triệu đến dưới 10 triệu")) {
                sql.append("AND o.total_amount >= 5000000 AND o.total_amount < 10000000 ");
            } else if (priceRange.equals("Trên 10 triệu")) {
                sql.append("AND o.total_amount >= 10000000 ");
            }
        }
        if (province != null && !province.isEmpty()) {
            sql.append("AND o.delivery_address LIKE ? ");
        }
        if (search != null && !search.isEmpty()) {
            sql.append("AND (o.order_code LIKE ? OR o.delivery_name LIKE ? OR o.delivery_phone LIKE ?) ");
        }
        if (dateFilter != null && !dateFilter.isEmpty()) {
            if (dateFilter.equals("today")) {
                sql.append("AND DATE(o.created_at) = CURDATE() ");
            } else if (dateFilter.equals("week")) {
                sql.append("AND YEARWEEK(o.created_at, 1) = YEARWEEK(CURDATE(), 1) ");
            } else if (dateFilter.equals("month")) {
                sql.append("AND YEAR(o.created_at) = YEAR(CURDATE()) AND MONTH(o.created_at) = MONTH(CURDATE()) ");
            }
        }
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) params.add(status);
        if (category != null && !category.isEmpty()) params.add(category);
        if (province != null && !province.isEmpty()) params.add("%" + province + "%");
        if (search != null && !search.isEmpty()) {
            params.add("%" + search + "%");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Lấy tất cả danh mục
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name FROM categories ORDER BY category_name";
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("category_id"));
                c.setCategoryName(rs.getString("category_name"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hủy đơn hàng (chỉ cho phép hủy đơn hàng chưa được xác nhận)
    public boolean cancelOrder(int orderId, int userId) throws Exception {
        String sql = """
            UPDATE orders 
            SET status_id = 5
            WHERE order_id = ? AND customer_id = ? AND status_id = 1
            """;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // Kiểm tra xem đơn hàng có thể hủy không (chỉ đơn hàng chờ xác nhận)
    public boolean canCancelOrder(int orderId, int userId) throws Exception {
        String sql = """
            SELECT COUNT(*) 
            FROM orders o
            WHERE o.order_id = ? AND o.customer_id = ? AND o.status_id = 1
            """;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // Lấy đơn hàng cho staff theo tỉnh (area) - KHÔNG lọc staff_id
    public List<Order> getOrdersForStaffByArea(String area) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_name, o.delivery_phone, os.status_name, o.created_At, u.full_name as customer_name, u.phone, u.email, s.full_name as staff_name, sh.full_name as shipper_name " +
                "FROM orders o " +
                "JOIN order_status os ON o.status_id = os.status_id " +
                "JOIN users u ON o.customer_id = u.user_id " +
                "LEFT JOIN users s ON o.staff_id = s.user_id " +
                "LEFT JOIN users sh ON o.shipper_id = sh.user_id " +
                "WHERE os.status_name = 'Đang chuẩn bị' AND LOWER(TRIM(o.delivery_address)) LIKE ? " +
                "ORDER BY o.created_at DESC";
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + area.trim().toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Lấy đơn hàng cho shipper theo tỉnh (area) - KHÔNG lọc shipper_id
    public List<Order> getOrdersForShipperByArea(String area) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_name, o.delivery_phone, os.status_name, o.created_At, u.full_name as customer_name, u.phone, u.email, s.full_name as staff_name, sh.full_name as shipper_name " +
                "FROM orders o " +
                "JOIN order_status os ON o.status_id = os.status_id " +
                "JOIN users u ON o.customer_id = u.user_id " +
                "LEFT JOIN users s ON o.staff_id = s.user_id " +
                "LEFT JOIN users sh ON o.shipper_id = sh.user_id " +
                "WHERE os.status_name = 'Chờ giao hàng' AND LOWER(TRIM(o.delivery_address)) LIKE ? " +
                "ORDER BY o.created_at DESC";
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + area.trim().toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersByStatusAndArea(String status, String area) throws Exception {
        List<Order> orders = new ArrayList<>();
        String sql = """
            SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_phone, o.delivery_name,
            os.status_name, o.created_At, u.full_name as customer_name,
            s.full_name as staff_name, sh.full_name as shipper_name, o.request_id
            FROM orders o
            JOIN order_status os ON o.status_id = os.status_id
            JOIN users u ON o.customer_id = u.user_id
            LEFT JOIN users s ON o.staff_id = s.user_id
            LEFT JOIN users sh ON o.shipper_id = sh.user_id
            WHERE os.status_name = ? AND LOWER(TRIM(o.delivery_address)) LIKE ?
            ORDER BY o.created_at DESC
        """;
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, "%" + area.trim().toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        }
        return orders;
    }

    // Tạo order mới cho hoa theo yêu cầu
    public int createOrderForCustomRequest(int userId, BigDecimal price, int requestId) throws Exception {
        String sql = "INSERT INTO orders (user_id, total_price, status, order_date, request_id) VALUES (?, ?, 'pending', NOW(), ?)";
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, userId);
        ps.setBigDecimal(2, price);
        ps.setInt(3, requestId);
        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
        int orderId = -1;
        if (rs.next()) orderId = rs.getInt(1);
        rs.close(); ps.close();
        return orderId;
    }

    // Lấy đơn hàng theo orderId
    public Order getOrderById(int orderId) throws Exception {
        String sql = "SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_phone, o.delivery_name, os.status_name, o.created_At, o.request_id FROM orders o JOIN order_status os ON o.status_id = os.status_id WHERE o.order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBcontext.getJDBCConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                // Lấy danh sách sản phẩm trong đơn hàng
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                return order;
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return null;
    }

    // Lấy đơn hàng cho staff theo staff_id
    public List<Order> getOrdersForStaff(int staffId) throws Exception {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_name, o.delivery_phone, os.status_name, o.created_At, u.full_name as customer_name, u.phone, u.email, s.full_name as staff_name, sh.full_name as shipper_name, o.request_id " +
                "FROM orders o " +
                "JOIN order_status os ON o.status_id = os.status_id " +
                "JOIN users u ON o.customer_id = u.user_id " +
                "LEFT JOIN users s ON o.staff_id = s.user_id " +
                "LEFT JOIN users sh ON o.shipper_id = sh.user_id " +
                "WHERE os.status_name = 'Đang chuẩn bị' AND o.staff_id = ? " +
                "ORDER BY o.created_at DESC";
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        }
        return orders;
    }

    // Lấy đơn hàng cho shipper theo shipper_id
    public List<Order> getOrdersForShipper(int shipperId) throws Exception {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.order_code, o.total_amount, o.delivery_address, o.delivery_name, o.delivery_phone, os.status_name, o.created_At, u.full_name as customer_name, u.phone, u.email, s.full_name as staff_name, sh.full_name as shipper_name, o.request_id " +
                "FROM orders o " +
                "JOIN order_status os ON o.status_id = os.status_id " +
                "JOIN users u ON o.customer_id = u.user_id " +
                "LEFT JOIN users s ON o.staff_id = s.user_id " +
                "LEFT JOIN users sh ON o.shipper_id = sh.user_id " +
                "WHERE os.status_name = 'Chờ giao hàng' AND o.shipper_id = ? " +
                "ORDER BY o.created_at DESC";
        try (Connection conn = DBcontext.getJDBCConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shipperId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderCode(rs.getString("order_code"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliveryName(rs.getString("delivery_name"));
                order.setDeliveryPhone(rs.getString("delivery_phone"));
                order.setStatus(rs.getString("status_name"));
                order.setCreatedAt(rs.getString("created_at"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setStaffName(rs.getString("staff_name"));
                order.setShipperName(rs.getString("shipper_name"));
                order.setRequestId(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                order.setItems(getItemsByOrderId(order.getOrderId(), conn));
                orders.add(order);
            }
        }
        return orders;
    }
}
