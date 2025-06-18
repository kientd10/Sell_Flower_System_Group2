/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.ProductFeedback;

public class ProductFeedbackDAO {
    public ProductFeedback getFeedback(int productId, int customerId) throws SQLException {
        String sql = "SELECT * FROM product_feedback WHERE product_id = ? AND customer_id = ?";
        try (Connection con = new DBcontext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ProductFeedback f = new ProductFeedback();
                f.setFeedbackId(rs.getInt("feedback_id"));
                f.setProductId(rs.getInt("product_id"));
                f.setCustomerId(rs.getInt("customer_id"));
                f.setRating(rs.getInt("rating"));
                f.setComment(rs.getString("comment"));
                f.setCreatedAt(rs.getTimestamp("created_at"));
                f.setUpdatedAt(rs.getTimestamp("updated_at"));
                return f;
            }
        }
        return null;
    }


    public void insertFeedback(ProductFeedback f) throws SQLException {
        String sql = "INSERT INTO product_feedback (product_id, customer_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection con = new DBcontext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, f.getProductId());
            ps.setInt(2, f.getCustomerId());
            ps.setInt(3, f.getRating());
            ps.setString(4, f.getComment());
            ps.executeUpdate();
        }
    }

    public void updateFeedback(ProductFeedback f) throws SQLException {
        String sql = "UPDATE product_feedback SET rating = ?, comment = ?, updated_at = CURRENT_TIMESTAMP WHERE product_id = ? AND customer_id = ?";
        try (Connection con = new DBcontext().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, f.getRating());
            ps.setString(2, f.getComment());
            ps.setInt(3, f.getProductId());
            ps.setInt(4, f.getCustomerId());
            ps.executeUpdate();
        }
    }
}
    
