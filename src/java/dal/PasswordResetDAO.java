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
import java.util.UUID;
/**
 *
 * @author tuanh
 */
public class PasswordResetDAO {
    private DBContext dbContext = new DBContext();

    // Generate and store a password reset token
    public String generateResetToken(String email) throws SQLException {
        String token = UUID.randomUUID().toString();
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());
        Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + 3600 * 1000); // 1 hour expiry

        String sql = "INSERT INTO password_reset_tokens (email, token, created_at, expires_at) " +
                     "VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE token = ?, created_at = ?, expires_at = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, token);
            stmt.setTimestamp(3, createdAt);
            stmt.setTimestamp(4, expiresAt);
            stmt.setString(5, token);
            stmt.setTimestamp(6, createdAt);
            stmt.setTimestamp(7, expiresAt);
            stmt.executeUpdate();
            return token;
        } finally {
            if (stmt != null) stmt.close();
            dbContext.closeConnection(conn);
        }
    }

    // Validate reset token
    public String validateResetToken(String token) throws SQLException {
        String sql = "SELECT email, expires_at FROM password_reset_tokens WHERE token = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, token);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                if (expiresAt.after(new Timestamp(System.currentTimeMillis()))) {
                    return rs.getString("email"); // Token is valid
                }
            }
            return null; // Token is invalid or expired
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            dbContext.closeConnection(conn);
        }
    }

    // Delete token after use
    public void deleteToken(String token) throws SQLException {
        String sql = "DELETE FROM password_reset_tokens WHERE token = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, token);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) stmt.close();
            dbContext.closeConnection(conn);
        }
    }
}
