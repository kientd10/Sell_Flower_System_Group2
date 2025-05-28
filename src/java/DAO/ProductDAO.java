/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DBcontext {

    public List<Product> getTopSellingProducts(int limit) {
        List<Product> productList = new ArrayList<>();

        String sql = "SELECT p.product_id, p.name, p.price, p.description, p.stock_quantity, " +
                     "p.category_id, p.purpose, p.is_active, p.image_url, " +
                     "SUM(od.quantity) AS total_sold " +
                     "FROM Product p " +
                     "JOIN OrderDetail od ON p.product_id = od.product_id " +
                     "WHERE p.is_active = TRUE " +
                     "GROUP BY p.product_id, p.name, p.price, p.description, p.stock_quantity, " +
                     "p.category_id, p.purpose, p.is_active, p.image_url " +
                     "ORDER BY total_sold DESC " +
                     "LIMIT ?";

        try (Connection conn = getJDBCConnextion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setDescription(rs.getString("description"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setPurpose(rs.getString("purpose"));
                p.setActive(rs.getBoolean("is_active"));
                p.setImageUrl(rs.getString("image_url"));

                productList.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }
}
