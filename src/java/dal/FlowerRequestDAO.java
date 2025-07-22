package dal;

import Model.FlowerRequest;
import java.sql.*;
import java.util.*;

public class FlowerRequestDAO {
    private Connection conn;

    public FlowerRequestDAO() throws Exception {
        conn = new DBcontext().getConnection();
    }

    // Thêm yêu cầu mới
    public void insertRequest(FlowerRequest req) throws Exception {
        String sql = "INSERT INTO flower_requests (customer_id, image_url, description, color_preference, event_type, note, quantity, suggested_price, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW())";
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, req.getCustomerId());
        ps.setString(2, req.getImageUrl());
        ps.setString(3, req.getDescription());
        ps.setString(4, req.getColorPreference());
        ps.setString(5, req.getEventType());
        ps.setString(6, req.getNote());
        ps.setInt(7, req.getQuantity());
        ps.setBigDecimal(8, req.getSuggestedPrice());
        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) req.setRequestId(rs.getInt(1));
        rs.close(); ps.close();
    }

    // Staff/manager phản hồi (ảnh shop gửi + text)
    public void updateShopReply(int requestId, String sampleImageUrl, String shopReply) throws Exception {
        String sql = "UPDATE flower_requests SET sample_image_url=?, shop_reply=?, status='sample_sent', updated_at=NOW() WHERE request_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sampleImageUrl);
            ps.setString(2, shopReply);
            ps.setInt(3, requestId);
            ps.executeUpdate();
        }
    }

    // Lấy danh sách yêu cầu cho staff/manager
    public List<FlowerRequest> getAllRequests() throws Exception {
        List<FlowerRequest> list = new ArrayList<>();
        String sql = "SELECT fr.*, u.full_name AS customerName FROM flower_requests fr JOIN users u ON fr.customer_id = u.user_id ORDER BY fr.created_at DESC";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                FlowerRequest fr = mapResultSet(rs);
                fr.setCustomerName(rs.getString("customerName"));
                list.add(fr);
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách yêu cầu hoa mẫu: " + e.getMessage());
            throw e;
        }
        System.out.println("Số lượng yêu cầu lấy được: " + list.size());
        return list;
    }

    // Lấy chi tiết 1 yêu cầu
    public FlowerRequest getRequestById(int requestId) throws Exception {
        String sql = "SELECT * FROM flower_requests WHERE request_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        FlowerRequest fr = null;
        if (rs.next()) fr = mapResultSet(rs);
        rs.close(); ps.close();
        return fr;
    }

    // Lấy danh sách yêu cầu của 1 khách hàng
    public List<FlowerRequest> getRequestsForUser(int userId) throws Exception {
        List<FlowerRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM flower_requests WHERE customer_id=? ORDER BY created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            FlowerRequest fr = mapResultSet(rs);
            list.add(fr);
        }
        rs.close(); ps.close();
        return list;
    }

    // Lấy các yêu cầu đã được shop phản hồi cho user
    public List<FlowerRequest> getShopRepliesForUser(int userId) throws Exception {
        List<FlowerRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM flower_requests WHERE customer_id=? AND status='sample_sent' ORDER BY updated_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FlowerRequest fr = mapResultSet(rs);
                list.add(fr);
            }
        }
        return list;
    }

    // Xóa yêu cầu (chỉ khi chưa có đơn hàng liên kết), đồng thời xóa notification liên quan
    public boolean deleteRequestAndNotificationsIfNoOrder(int requestId) throws Exception {
        Connection conn = null;
        PreparedStatement psCheck = null, psDeleteNotif = null, psDeleteReq = null;
        ResultSet rs = null;
        try {
            conn = DBcontext.getJDBCConnection();
            // Kiểm tra có đơn hàng nào liên kết không
            String sqlCheck = "SELECT COUNT(*) FROM orders WHERE request_id=?";
            psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setInt(1, requestId);
            rs = psCheck.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Đã có đơn hàng, không xóa
            }
            // Xóa notifications liên kết
            String sqlDeleteNotif = "DELETE FROM notifications WHERE related_request_id=?";
            psDeleteNotif = conn.prepareStatement(sqlDeleteNotif);
            psDeleteNotif.setInt(1, requestId);
            psDeleteNotif.executeUpdate();
            // Xóa yêu cầu hoa
            String sqlDeleteReq = "DELETE FROM flower_requests WHERE request_id=?";
            psDeleteReq = conn.prepareStatement(sqlDeleteReq);
            psDeleteReq.setInt(1, requestId);
            psDeleteReq.executeUpdate();
            return true;
        } finally {
            if (rs != null) rs.close();
            if (psCheck != null) psCheck.close();
            if (psDeleteNotif != null) psDeleteNotif.close();
            if (psDeleteReq != null) psDeleteReq.close();
            if (conn != null) conn.close();
        }
    }

    // Cập nhật trạng thái yêu cầu
    public void updateStatus(int requestId, String status) throws Exception {
        String sql = "UPDATE flower_requests SET status=?, updated_at=NOW() WHERE request_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, requestId);
        ps.executeUpdate();
        ps.close();
    }

    // Helper: mapping ResultSet -> FlowerRequest
    private FlowerRequest mapResultSet(ResultSet rs) throws Exception {
        FlowerRequest fr = new FlowerRequest();
        fr.setRequestId(rs.getInt("request_id"));
        fr.setCustomerId(rs.getInt("customer_id"));
        fr.setImageUrl(rs.getString("image_url"));
        fr.setDescription(rs.getString("description"));
        fr.setColorPreference(rs.getString("color_preference"));
        fr.setEventType(rs.getString("event_type"));
        fr.setNote(rs.getString("note"));
        fr.setStatus(rs.getString("status"));
        fr.setSampleImageUrl(rs.getString("sample_image_url"));
        fr.setShopReply(rs.getString("shop_reply"));
        fr.setCreatedAt(rs.getTimestamp("created_at"));
        fr.setUpdatedAt(rs.getTimestamp("updated_at"));
        try { fr.setCustomerName(rs.getString("customerName")); } catch (Exception ignore) {}
        try { fr.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
        try { fr.setSuggestedPrice(rs.getBigDecimal("suggested_price")); } catch (Exception ignore) {}
        return fr;
    }
} 