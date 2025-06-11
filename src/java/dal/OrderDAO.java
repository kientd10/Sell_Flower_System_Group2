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
     
}
