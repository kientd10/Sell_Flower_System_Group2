/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Role;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author tuanh
 */
public class UserDAO {

    private DBcontext dbContext;

    public UserDAO() {
        dbContext = new DBcontext();
    }

    // Đăng ký người dùng mới
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, email, password, full_name, phone, address, role_id, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // Lưu mật khẩu trực tiếp
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getRoleId()); // Sử dụng roleId từ User
            stmt.setBoolean(8, user.isIsActive());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            dbContext.closeConnection(conn);
        }
    }
    public String getPassword(String email) throws SQLException {
    String sql = "SELECT password FROM users WHERE email = ?";
    try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getString("password");
        }
        return null;
    }
}

    // Kiểm tra email đã tồn tại
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return false;
    }

    // Kiểm tra username đã tồn tại
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return false;
    }

    // Đăng nhập người dùng
    public User loginUser(String email, String password) {
        String sql = "SELECT user_id, username, email, password, full_name, phone, address, role_id, is_active "
                + "FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (password.equals(storedPassword)) { // So sánh mật khẩu trực tiếp
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRoleId(rs.getInt("role_id"));
                    user.setIsActive(rs.getBoolean("is_active"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return null;
    }

    public boolean updatePassword(String email, String newPassword) throws SQLException {
        String sql = "UPDATE users SET password = ?, updated_at = NOW() WHERE email = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            dbContext.closeConnection(conn);
        }
    }

    public User getInfoUserByID(int user_id) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        User h = new User();
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection(); // <-- THÊM DÒNG NÀY
            st = conn.prepareStatement(sql);
            st.setInt(1, user_id);
            rs = st.executeQuery();
            if (rs.next()) {
                h.setUsername(rs.getString("username"));
                h.setFullName(rs.getString("full_name"));
                h.setAddress(rs.getString("address"));
                h.setEmail(rs.getString("email"));
                h.setPhone(rs.getString("phone"));
                h.setCreatedAt(rs.getTimestamp("created_at"));
                h.setIsActive(rs.getBoolean("is_active"));
                h.setUserId(rs.getInt("user_id"));
                h.setPassword(rs.getString("password"));
                h.setRoleId(rs.getInt("role_id"));

            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            dbContext.closeConnection(conn);
        }
        return h;
    }

    public void changeInfoUserByID(int user_id, String username, String fullname, String email, String Address, String phone, String password) {
        String sql = "UPDATE users SET username = ?, full_name = ?, email = ?, address = ?, phone = ?  , password = ? WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = dbContext.getConnection();
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, fullname);
            st.setString(3, email);
            st.setString(4, Address);
            st.setString(5, phone);
            st.setString(6, password);
            st.setInt(7, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            dbContext.closeConnection(conn);
        }
    }
    
    
    
   



}
