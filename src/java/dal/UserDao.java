/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author PC
 */
import java.util.*;
import java.lang.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDao extends DBContext {

    public User getInfoUserByID(int user_id) {
        String sql = "SELECT * "
                + "FROM Users u "
                + "WHERE u.user_id = ?;";
        User h = new User();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                h.setUsername(rs.getString("username"));
                h.setFullName(rs.getString("full_name"));
                h.setAddress(rs.getString("address"));
                h.setEmail(rs.getString("email"));
                h.setPhone(rs.getString("phone"));
                h.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                h.setIsActive(rs.getBoolean("is_active"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return h;
    }

    public void changeInfoUserByID(int user_id, String username, String fullname,String email, String Address, String phone) {
        String sql = "UPDATE users SET username = ?,full_name = ?,email = ?, address = ?, phone = ? WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, fullname);
            st.setString(3, email);
            st.setString(4, Address);
            st.setString(5, phone);
            st.setInt(6, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}

