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
import Model.ShoppingCart;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.*;
import java.lang.*;
import java.sql.Connection;

public class OrderDAO {
     private Connection conn;

    public OrderDAO() {
        try {
            conn = new DBcontext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public double TotalPrice(int user_id){
        double total = 0;
        String sql
                = "SELECT d.quantity,"
                + " bt.base_price "
                + "FROM shopping_cart d "
                + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                + "WHERE d.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user_id);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BouquetTemplate p = new BouquetTemplate();
                    p.setBasePrice(rs.getDouble("base_price"));
                    ShoppingCart line = new ShoppingCart();
                    line.setQuantity(rs.getInt("quantity"));
                    total += p.getBasePrice() * line.getQuantity();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
    public List<BouquetTemplate> getPurchasedProductsByUser(int userId) {
    List<BouquetTemplate> list = new ArrayList<>();
    String sql = "SELECT DISTINCT od.template_id, bt.template_name " +
                 "FROM orders o " +
                 "JOIN order_status s ON o.status_id = s.status_id " +
                 "JOIN order_details od ON o.order_id = od.order_id " +
                 "JOIN bouquet_templates bt ON od.template_id = bt.template_id " +
                 "WHERE o.customer_id = ? AND s.status_name = 'Delivered'";
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
     
}
