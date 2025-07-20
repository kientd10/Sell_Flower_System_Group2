package dal;

import Model.Notification;
import java.sql.*;
import java.util.*;

public class NotificationDAO {
    private Connection conn;

    public NotificationDAO() throws Exception {
        conn = new DBcontext().getConnection();
    }

    // Tạo notification cho 1 user cụ thể (hoặc cho staff/manager nếu user_id là id của họ)
    public void create(int userId, String content, Integer relatedRequestId) throws Exception {
        String sql = "INSERT INTO notifications (user_id, content, is_read, created_at, related_request_id) VALUES (?, ?, 0, NOW(), ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2, content);
        if (relatedRequestId != null) ps.setInt(3, relatedRequestId); else ps.setNull(3, Types.INTEGER);
        ps.executeUpdate();
        ps.close();
    }

    // Lấy danh sách user_id của manager/staff
    public List<Integer> getAllManagerUserIds() throws Exception {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT user_id FROM users WHERE role_id IN (2,3)"; // 2: staff, 3: manager
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ids.add(rs.getInt("user_id"));
        }
        rs.close(); ps.close();
        return ids;
    }

    // Tạo notification cho tất cả manager/staff (user_id hợp lệ)
    public void createForManager(String content, int relatedRequestId) throws Exception {
        List<Integer> managerIds = getAllManagerUserIds();
        for (int userId : managerIds) {
            create(userId, content, relatedRequestId);
        }
    }

    // Lấy danh sách notification cho user (user_id hoặc user_id=0 là thông báo chung)
    public List<Notification> getNotificationsForUser(int userId) throws Exception {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id=? OR user_id=0 ORDER BY created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Notification n = mapResultSet(rs);
            list.add(n);
        }
        rs.close(); ps.close();
        return list;
    }

    // Đánh dấu đã đọc
    public void markAsRead(int notificationId) throws Exception {
        String sql = "UPDATE notifications SET is_read=1 WHERE notification_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, notificationId);
        ps.executeUpdate();
        ps.close();
    }

    // Helper: mapping ResultSet -> Notification
    private Notification mapResultSet(ResultSet rs) throws Exception {
        Notification n = new Notification();
        n.setNotificationId(rs.getInt("notification_id"));
        n.setUserId(rs.getInt("user_id"));
        n.setContent(rs.getString("content"));
        n.setIsRead(rs.getBoolean("is_read"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        int relId = rs.getInt("related_request_id");
        n.setRelatedRequestId(rs.wasNull() ? null : relId);
        return n;
    }
} 