/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

/**
 *
 * @author tuanh
 */
public class PasswordResetDAO {

    private DBContext dbContext = new DBContext();
    // Sử dụng Timer để lập lịch xóa token
    private Timer tokenCleanupTimer = new Timer(true); // Timer chạy nền (daemon thread)

    public String generateResetToken(String email) {
        String checkUserSql = "SELECT COUNT(*) FROM users WHERE email = ?";
        String insertSql = "INSERT INTO password_reset_tokens (email, token, created_at, expires_at) "
                + "VALUES (?, ?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE token = VALUES(token), created_at = VALUES(created_at), expires_at = VALUES(expires_at)";

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            if (conn == null) {
                System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }

            // Kiểm tra email
            System.out.println("Checking email: " + email);
            checkStmt = conn.prepareStatement(checkUserSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                System.err.println("Email không tồn tại: " + email);
                return null; // Email không tồn tại
            }

            // Tạo token
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            StringBuilder code = new StringBuilder(6);
            for (int i = 0; i < 6; i++) {
                code.append(characters.charAt(random.nextInt(characters.length())));
            }
            String token = code.toString();

            Timestamp createdAt = new Timestamp(System.currentTimeMillis());
            Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000); // 5 minutes expiry

            System.out.println("Generated token: " + token);
            System.out.println("Created at: " + createdAt);
            System.out.println("Expires at: " + expiresAt);

            // Chèn token
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, email);
            insertStmt.setString(2, token);
            insertStmt.setTimestamp(3, createdAt);
            insertStmt.setTimestamp(4, expiresAt);
            int rowsAffected = insertStmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            // Lập lịch xóa token sau 5 phút
            scheduleTokenCleanup(token);

            return token;

        } catch (SQLException e) {
            System.err.println("Lỗi SQL: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (checkStmt != null) {
                    checkStmt.close();
                }
                if (insertStmt != null) {
                    insertStmt.close();
                }
                dbContext.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Lập lịch xóa token sau 5 phút
    private void scheduleTokenCleanup(String token) {
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                deleteToken(token);
                System.out.println("Token " + token + " has been deleted due to expiration.");
            }
        };
        // Lập lịch chạy sau 5 phút (300,000 milliseconds)
        tokenCleanupTimer.schedule(task, 300000); // 5 phút = 300,000 ms
    }

    // Validate reset token
    public String validateResetToken(String token) {
        String sql = "SELECT email, expires_at FROM password_reset_tokens WHERE token = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbContext.getConnection();
            if (conn == null) {
                System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
                return null;
            }
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, token);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                if (expiresAt.after(new Timestamp(System.currentTimeMillis()))) {
                    return rs.getString("email"); // Token hợp lệ
                }
            }
            return null; // Token không hợp lệ hoặc đã hết hạn
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                dbContext.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Delete token
    public boolean deleteToken(String token) {
        String sql = "DELETE FROM password_reset_tokens WHERE token = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getConnection();
            if (conn == null) {
                System.err.println("Không thể kết nối đến cơ sở dữ liệu.");
                return false;
            }
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, token);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                dbContext.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
