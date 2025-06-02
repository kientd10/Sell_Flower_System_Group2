/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author ADMIN
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Model.BouquetTemplate;
import Model.ShoppingCart;
import dal.DBcontext;

public class BouquetDAO {

    private Connection conn;

    public BouquetDAO() {
        try {
            conn = new DBcontext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<BouquetTemplate> getBouquetsByCategoryId(int categoryId) {
        List<BouquetTemplate> bouquets = new ArrayList<>();
        String sql = "SELECT template_id, template_name, description, base_price, image_url "
                + "FROM bouquet_templates WHERE category_id = ? AND is_active = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bouquets.add(new BouquetTemplate(
                            rs.getInt("template_id"),
                            rs.getString("template_name"),
                            rs.getString("description"),
                            rs.getDouble("base_price"),
                            rs.getString("image_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bouquets;
    }

    public List<BouquetTemplate> getAllBouquets() {
        List<BouquetTemplate> bouquets = new ArrayList<>();
        String sql = "SELECT template_id, template_name, description, base_price, image_url "
                + "FROM bouquet_templates WHERE is_active = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bouquets.add(new BouquetTemplate(
                            rs.getInt("template_id"),
                            rs.getString("template_name"),
                            rs.getString("description"),
                            rs.getDouble("base_price"),
                            rs.getString("image_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bouquets;
    }
    
    public List<BouquetTemplate> getBouquetsByCategoryIdPaging(int categoryId, int offset, int limit) {
        List<BouquetTemplate> list = new ArrayList<>();
        String sql = "SELECT template_id, template_name, description, base_price, image_url "
                + "FROM bouquet_templates "
                + "WHERE category_id = ? AND is_active = TRUE "
                + "ORDER BY template_id "
                + "LIMIT ?, ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.setInt(2, offset);
            stmt.setInt(3, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new BouquetTemplate(
                            rs.getInt("template_id"),
                            rs.getString("template_name"),
                            rs.getString("description"),
                            rs.getDouble("base_price"),
                            rs.getString("image_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BouquetTemplate> getAllBouquetsPaging(int offset, int limit) {
        List<BouquetTemplate> list = new ArrayList<>();
        String sql = "SELECT template_id, template_name, description, base_price, image_url "
                + "FROM bouquet_templates "
                + "WHERE is_active = TRUE "
                + "ORDER BY template_id "
                + "LIMIT ?, ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, offset);
            stmt.setInt(2, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new BouquetTemplate(
                            rs.getInt("template_id"),
                            rs.getString("template_name"),
                            rs.getString("description"),
                            rs.getDouble("base_price"),
                            rs.getString("image_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAllBouquets() {
        String sql = "SELECT COUNT(*) FROM bouquet_templates WHERE is_active = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countBouquetsByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM bouquet_templates WHERE category_id = ? AND is_active = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ShoppingCart> getCartItemsByUserId(int userId) {
        List<ShoppingCart> cartItems = new ArrayList<>();
        String sql
                = "SELECT d.cart_id, d.user_id, d.template_id, d.quantity, d.added_at,"
                + "bt.template_name, bt.description, bt.base_price, bt.image_url "
                + "FROM shopping_cart d "
                + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                + "WHERE d.user_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BouquetTemplate p = new BouquetTemplate();
                    p.setTemplateId(rs.getInt("template_id"));
                    p.setTemplateName(rs.getString("template_name"));
                    p.setDescription(rs.getString("description"));
                    p.setBasePrice(rs.getDouble("base_price"));
                    p.setImageUrl(rs.getString("image_url"));
                    ShoppingCart line = new ShoppingCart();
                    line.setCartId(rs.getInt("cart_id"));
                    line.setUserId(rs.getInt("user_id"));
                    line.setBouquetTemplate(p);
                    line.setQuantity(rs.getInt("quantity"));
                    line.setAddedAt(rs.getTimestamp("added_at").toLocalDateTime());
                    cartItems.add(line);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public ShoppingCart getItems(int userId, int templateId) {
        ShoppingCart Item = new ShoppingCart();
        String sql
                = "SELECT d.cart_id, d.user_id, d.template_id, d.quantity, d.added_at, "
                + "bt.template_name, bt.description, bt.base_price, bt.image_url "
                + "FROM shopping_cart d "
                + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                + "WHERE d.user_id = ? and bt.template_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, templateId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BouquetTemplate p = new BouquetTemplate();
                    p.setTemplateId(rs.getInt("template_id"));
                    p.setTemplateName(rs.getString("template_name"));
                    p.setDescription(rs.getString("description"));
                    p.setBasePrice(rs.getDouble("base_price"));
                    p.setImageUrl(rs.getString("image_url"));
                    Item.setCartId(rs.getInt("cart_id"));
                    Item.setUserId(rs.getInt("user_id"));
                    Item.setBouquetTemplate(p);
                    Item.setQuantity(rs.getInt("quantity"));
                    Item.setAddedAt(rs.getTimestamp("added_at").toLocalDateTime());

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Item;
    }

   public void updateQuantity(int userId, int templateId, int newQuantity) throws Exception {
    String sql = "UPDATE shopping_cart SET quantity = ? WHERE user_id = ? AND template_id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, newQuantity);
        stmt.setInt(2, userId);
        stmt.setInt(3, templateId);
        stmt.executeUpdate();
        System.out.println("Updated quantity successfully: " + newQuantity);
    }
}


    public void deleteCartItemsByCartId(int CartId) {
        String sql = "DELETE FROM shopping_cart WHERE cart_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, CartId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addToCart(int userId, int templateId, int quantity) {
        String checkSql = "SELECT quantity FROM shopping_cart WHERE user_id = ? AND template_id = ?";
        String updateSql = "UPDATE shopping_cart SET quantity = quantity + ? WHERE user_id = ? AND template_id = ?";
        String insertSql = "INSERT INTO shopping_cart (user_id, template_id, quantity, added_at) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, templateId);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, quantity);     // tăng thêm quantity
                        updateStmt.setInt(2, userId);
                        updateStmt.setInt(3, templateId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, templateId);
                        insertStmt.setInt(3, quantity);
                        insertStmt.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<BouquetTemplate> getTopSellingBouquets(int limit) {
        List<BouquetTemplate> bouquets = new ArrayList<>();
        String sql = "SELECT bt.template_id, bt.template_name, bt.description, bt.base_price, bt.image_url " +
                     "FROM order_details od " +
                     "JOIN bouquet_templates bt ON od.template_id = bt.template_id " +
                     "WHERE bt.is_active = TRUE " +
                     "GROUP BY bt.template_id, bt.template_name, bt.description, bt.base_price, bt.image_url " +
                     "ORDER BY SUM(od.quantity) DESC " +
                     "LIMIT ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bouquets.add(new BouquetTemplate(
                            rs.getInt("template_id"),
                            rs.getString("template_name"),
                            rs.getString("description"),
                            rs.getDouble("base_price"),
                            rs.getString("image_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bouquets;
    }

}
