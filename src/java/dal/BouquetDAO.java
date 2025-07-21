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
import Model.Category;
import Model.RawFlower;
import Model.ShoppingCart;
import java.sql.SQLException;

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
    String sql = "SELECT t.template_id, t.template_name, t.description, t.base_price, t.image_url, " +
                 "       (SELECT AVG(CAST(f.rating AS FLOAT)) FROM product_feedback f WHERE f.product_id = t.template_id) AS avg_rating " +
                 "FROM bouquet_templates t " +
                 "WHERE t.category_id = ? AND t.is_active = TRUE";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, categoryId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                BouquetTemplate b = new BouquetTemplate(
                        rs.getInt("template_id"),
                        rs.getString("template_name"),
                        rs.getString("description"),
                        rs.getDouble("base_price"),
                        rs.getString("image_url")
                );
                // Thêm dòng này để set sao trung bình
                
                b.setAvgRating(rs.getDouble("avg_rating"));
                bouquets.add(b);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return bouquets;
}

public List<BouquetTemplate> getAllBouquets() {
        System.out.println("DEBUG: === Called getAllBouquets ===");

    List<BouquetTemplate> bouquets = new ArrayList<>();
    String sql = "SELECT t.template_id, t.template_name, t.description, t.base_price, t.image_url, t.stock, "
               + "       (SELECT AVG(CAST(f.rating AS FLOAT)) "
               + "        FROM product_feedback f "
               + "        WHERE f.product_id = t.template_id) AS avg_rating "
               + "FROM bouquet_templates t "
               + "WHERE t.is_active = TRUE";
    try (PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            BouquetTemplate b = new BouquetTemplate(
                rs.getInt("template_id"),
                rs.getString("template_name"),
                rs.getString("description"),
                rs.getDouble("base_price"),
                rs.getString("image_url"),
                rs.getInt("stock")
            );
double avgRating = rs.getDouble("avg_rating");
if (rs.wasNull()) {
    avgRating = 0.0;
}
b.setAvgRating(avgRating);

// Debug
System.out.println("DEBUG: Template ID = " + b.getTemplateId() + ", Avg Rating = " + avgRating);            bouquets.add(b);
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
    List<BouquetTemplate> bouquets = new ArrayList<>();
    String sql = "SELECT t.template_id, t.template_name, t.description, t.base_price, t.image_url, t.stock, "
               + "       (SELECT AVG(CAST(f.rating AS FLOAT)) "
               + "        FROM product_feedback f "
               + "        WHERE f.product_id = t.template_id) AS avg_rating "
               + "FROM bouquet_templates t "
               + "WHERE t.is_active = TRUE "
               + "ORDER BY t.template_id "
               + "LIMIT ?, ?"; // ✅ MySQL dùng LIMIT offset, limit

    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, offset);
        stmt.setInt(2, limit);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                BouquetTemplate b = new BouquetTemplate(
                    rs.getInt("template_id"),
                    rs.getString("template_name"),
                    rs.getString("description"),
                    rs.getDouble("base_price"),
                    rs.getString("image_url"),
                    rs.getInt("stock")
                );
                double avgRating = rs.getDouble("avg_rating");
                if (rs.wasNull()) {
                    avgRating = 0.0;
                }
                b.setAvgRating(avgRating);
                bouquets.add(b);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return bouquets;
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
                + "bt.template_name, bt.description, bt.base_price, bt.image_url ,bt.Stock "
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
                    p.setStock(rs.getInt("Stock"));
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
    public String getCategoryNameById(int templateId) {
        String p = new String();
        String sql
                = "SELECT d.category_name "
                + "FROM categories d "
                + "JOIN bouquet_templates bt ON d.category_id = bt.category_id "
                + "WHERE bt.template_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, templateId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    p = rs.getString("category_name");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }


    public List<Category> getAllCategory() {
        List<Category> C = new ArrayList<>();
        String sql
                = "SELECT  * FROM  categories ";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Category p = new Category();
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setCategoryName(rs.getString("category_name"));
                    C.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return C;
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

    public BouquetTemplate getBouquetByID(int templateId) {
        BouquetTemplate p = new BouquetTemplate();
        String sql
                = "SELECT template_id, "
                + "template_name,description, base_price, image_url "
                + "FROM bouquet_templates "
                + "WHERE  bt.template_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, templateId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    p.setTemplateId(rs.getInt("template_id"));
                    p.setTemplateName(rs.getString("template_name"));
                    p.setDescription(rs.getString("description"));
                    p.setBasePrice(rs.getDouble("base_price"));
                    p.setImageUrl(rs.getString("image_url"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
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

    public void deleteCartItems(int templateId, int user_id) {
        String sql = "DELETE FROM shopping_cart  WHERE user_id = ? and template_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user_id);
            stmt.setInt(2, templateId);
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
                        updateStmt.setInt(1, quantity);
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
        
        // Thử lấy sản phẩm bán chạy từ order_details trước
        String sql = "SELECT bt.template_id, bt.template_name, bt.description, bt.base_price, bt.image_url "
                + "FROM order_details od "
                + "JOIN bouquet_templates bt ON od.template_id = bt.template_id "
                + "WHERE bt.is_active = TRUE "
                + "GROUP BY bt.template_id, bt.template_name, bt.description, bt.base_price, bt.image_url "
                + "ORDER BY SUM(od.quantity) DESC "
                + "LIMIT ?";
        
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
            System.out.println("Error getting top selling bouquets: " + e.getMessage());
        }
        
        // Nếu không có sản phẩm bán chạy, lấy sản phẩm mới nhất làm fallback
        if (bouquets.isEmpty()) {
            String fallbackSql = "SELECT template_id, template_name, description, base_price, image_url "
                    + "FROM bouquet_templates "
                    + "WHERE is_active = TRUE "
                    + "ORDER BY template_id DESC "
                    + "LIMIT ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(fallbackSql)) {
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
                System.out.println("Error getting fallback bouquets: " + e.getMessage());
            }
        }
        
        return bouquets;
    }

    public List<BouquetTemplate> searchBouquetTemplates(String searchQuery) throws SQLException {
        List<BouquetTemplate> results = new ArrayList<>();

        // Sửa SQL để chỉ tìm kiếm theo tên (template_name)
        String query = "SELECT template_id, template_name, description, base_price, image_url "
                + "FROM bouquet_templates WHERE is_active = TRUE AND template_name LIKE ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            // Thêm ký tự % để tìm kiếm phần tên có chứa từ khóa tìm kiếm
            String searchPattern = "%" + searchQuery + "%";
            stmt.setString(1, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy dữ liệu và thêm vào danh sách kết quả
                    BouquetTemplate template = new BouquetTemplate();
                    template.setTemplateId(rs.getInt("template_id"));
                    template.setTemplateName(rs.getString("template_name"));
                    template.setDescription(rs.getString("description"));
                    template.setBasePrice(rs.getDouble("base_price"));
                    template.setImageUrl(rs.getString("image_url"));
                    results.add(template);
                }
            }
        }
        return results;
    }

    public List<BouquetTemplate> filterBouquets(int categoryId, Double minPrice, Double maxPrice, int offset, int limit) {
        List<BouquetTemplate> bouquets = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT template_id, template_name, description, base_price, image_url FROM bouquet_templates WHERE is_active = TRUE");

        if (categoryId != -1) {
            sql.append(" AND category_id = ?");
        }
        if (minPrice != null) {
            sql.append(" AND base_price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND base_price <= ?");
        }
        sql.append(" ORDER BY template_id LIMIT " + limit + " OFFSET " + offset);

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != -1) {
                stmt.setInt(paramIndex++, categoryId);
            }
            if (minPrice != null) {
                stmt.setDouble(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                stmt.setDouble(paramIndex++, maxPrice);
            }

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

    public int countFilteredBouquets(int categoryId, Double minPrice, Double maxPrice) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM bouquet_templates WHERE is_active = TRUE");
        if (categoryId != -1) {
            sql.append(" AND category_id = ?");
        }
        if (minPrice != null) {
            sql.append(" AND base_price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND base_price <= ?");
        }

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (categoryId != -1) {
                stmt.setInt(paramIndex++, categoryId);
            }
            if (minPrice != null) {
                stmt.setDouble(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                stmt.setDouble(paramIndex++, maxPrice);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public BouquetTemplate getBouquetById(int id) {
        String sql = "SELECT * FROM bouquet_templates WHERE template_id = ?";
        try (Connection conn = DBcontext.getJDBCConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new BouquetTemplate(
                            rs.getInt("template_id"),
                            rs.getString("template_name"),
                            rs.getString("description"),
                            rs.getDouble("base_price"),
                            rs.getString("image_url")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Debug: No template found with ID " + id);
        return null;
    }

    public List<BouquetTemplate> getRecommendedTemplates(int currentTemplateId) throws SQLException {
        List<BouquetTemplate> recommendations = new ArrayList<>();

        try (Connection conn = DBcontext.getJDBCConnection()) {
            String currentTemplateSql = "SELECT category_id, base_price FROM bouquet_templates WHERE template_id = ? AND is_active = TRUE";
            double currentPrice = 0.0;
            int categoryId = 0;

            try (PreparedStatement stmt = conn.prepareStatement(currentTemplateSql)) {
                stmt.setInt(1, currentTemplateId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        categoryId = rs.getInt("category_id");
                        currentPrice = rs.getDouble("base_price");
                        System.out.println("Debug: Template ID=" + currentTemplateId + ", category_id=" + categoryId + ", base_price=" + currentPrice);
                    } else {
                        System.out.println("Debug: No active template found for ID=" + currentTemplateId);
                        return recommendations;
                    }
                }
            }

            double minPrice = currentPrice * 0.8;
            double maxPrice = currentPrice * 1.2;
            System.out.println("Debug: minPrice=" + minPrice + ", maxPrice=" + maxPrice);

            String sql = "SELECT template_id, template_name, description, base_price, image_url FROM bouquet_templates "
                    + "WHERE is_active = TRUE AND template_id != ? AND category_id = ? AND base_price BETWEEN ? AND ? "
                    + "ORDER BY ABS(base_price - ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, currentTemplateId);
                stmt.setInt(2, categoryId);
                stmt.setDouble(3, minPrice);
                stmt.setDouble(4, maxPrice);
                stmt.setDouble(5, currentPrice);

                try (ResultSet rs = stmt.executeQuery()) {
                    int count = 0;
                    while (rs.next()) {
                        BouquetTemplate template = new BouquetTemplate(
                                rs.getInt("template_id"),
                                rs.getString("template_name"),
                                rs.getString("description"),
                                rs.getDouble("base_price"),
                                rs.getString("image_url")
                        );
                        recommendations.add(template);
                        count++;
                    }
                    System.out.println("Debug: Found " + count + " recommendations for template ID=" + currentTemplateId);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching recommended templates: " + e.getMessage());
            throw e;
        }

        return recommendations;
    }

    public void addBouquet(BouquetTemplate b) {
        String sql = "INSERT INTO bouquet_templates (template_name, description, base_price, image_url, is_active, category_id, created_by) "
                + "VALUES (?, ?, ?, ?, TRUE, 1, 1)"; // category_id và created_by bạn có thể tùy chỉnh

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, b.getTemplateName());
            ps.setString(2, b.getDescription());
            ps.setDouble(3, b.getBasePrice());
            ps.setString(4, b.getImageUrl());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateBouquet(int template_id, String template_name, String description, double baseprice, String imageUrl, int stock) {
        String sql = "UPDATE bouquet_templates SET template_name = ?, description = ?, base_price = ?, image_url = ? , stock = ? "
                + "WHERE template_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, template_name);
            ps.setString(2, description);
            ps.setDouble(3, baseprice);
            ps.setString(4, imageUrl);
            ps.setInt(5, stock);
            ps.setInt(6, template_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void softDeleteBouquet(int id) {
        String sql = "UPDATE bouquet_templates SET is_active = FALSE WHERE template_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<BouquetTemplate> getAllBouquetTemplate() {
        List<BouquetTemplate> list = new ArrayList<>();
        String sql
                = "SELECT * "
                + "FROM  bouquet_template ";
        try (Connection conn = DBcontext.getJDBCConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                BouquetTemplate rf = new BouquetTemplate();
                rf.setTemplateId(rs.getInt("template_id"));
                rf.setTemplateName(rs.getString("template_name"));
                rf.setBasePrice(rs.getInt("base_price"));
                rf.setStock(rs.getInt("Stock"));
                rf.setImageUrl(rs.getString("image_url"));
                rf.setDescription(rs.getString("description"));
                list.add(rf);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
  public List<BouquetTemplate> searchBouquetTemplatesWithPaging(String keyword, int offset, int limit) {
    List<BouquetTemplate> list = new ArrayList<>();
    String sql = "SELECT * FROM bouquet_templates "
               + "WHERE is_active = TRUE AND template_name COLLATE utf8mb4_unicode_ci LIKE ? "
               + "ORDER BY template_id DESC LIMIT ?, ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, "%" + keyword + "%");
        stmt.setInt(2, offset);
        stmt.setInt(3, limit);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                BouquetTemplate b = new BouquetTemplate(
                    rs.getInt("template_id"),
                    rs.getString("template_name"),
                    rs.getString("description"),
                    rs.getDouble("base_price"),
                    rs.getString("image_url"),
                    rs.getInt("stock")
                );
                list.add(b);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}
public int countSearchResults(String keyword) {
    String sql = "SELECT COUNT(*) FROM bouquet_templates "
               + "WHERE is_active = TRUE AND template_name COLLATE utf8mb4_unicode_ci LIKE ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, "%" + keyword + "%");
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}





}
