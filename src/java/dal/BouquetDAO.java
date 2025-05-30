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
import dal.DBContext;

public class BouquetDAO {

    private Connection conn;

    public BouquetDAO() {
        try {
            conn = new DBContext().getConnection();
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
}
