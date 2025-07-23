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
import Model.Category;
import Model.FlowerColor;
import Model.FlowerType;
import Model.RawFlower;
import Model.TemplateIngredient;
import java.util.*;
import java.lang.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StorageDAO {

    private Connection conn;

    public StorageDAO() {
        try {
            conn = new DBcontext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<RawFlower> getAllRawFlower() {
        List<RawFlower> list = new ArrayList<>();
        String sql
                = "SELECT rf.type_id, ft.type_name, "
                + "rf.color_id, fc.color_name, rf.quantity, rf.raw_flower_id, "
                + "rf.unit_price,rf.notes,rf.import_date,rf.status,rf.dayleft, rf.expiry_date , rf.supplier_name "
                + "FROM raw_flowers rf "
                + "JOIN flower_types  ft ON rf.type_id  = ft.type_id "
                + "JOIN flower_colors fc ON rf.color_id = fc.color_id "
                + "where rf.is_deleted=0";
        try (Connection conn = DBcontext.getJDBCConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                RawFlower rf = new RawFlower();
                rf.setTypeId(rs.getInt("type_id"));
                rf.setRawFlowerId(rs.getInt("raw_flower_id"));
                rf.setRawFlowerName(rs.getString("type_name"));
                rf.setColorName(rs.getString("color_name"));
                rf.setColorId(rs.getInt("color_id"));
                rf.setQuantity(rs.getInt("quantity"));
                rf.setUnitPrice(rs.getDouble("unit_price"));
                rf.setImportDate(rs.getDate("import_date"));
                rf.setExpiryDate(rs.getDate("expiry_date"));
                rf.setDayleft(rs.getLong("dayleft"));
                rf.setStatus(rs.getString("status"));
                rf.setNotes(rs.getString("notes"));
                rf.setSupplierName(rs.getString("supplier_name"));
                list.add(rf);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<TemplateIngredient> getAllTemplateIngredient(int templateID) throws SQLException {
        List<TemplateIngredient> list = new ArrayList<>();
        String sql
                = "SELECT ft.type_id, ft.type_name, "
                + "fc.color_id, fc.color_name, ti.required_quantity "
                + "FROM template_ingredients ti "
                + "JOIN flower_types  ft ON ti.type_id  = ft.type_id "
                + "JOIN bouquet_templates  bt ON bt.template_id  = ti.template_id "
                + "JOIN flower_colors fc ON ti.color_id = fc.color_id "
                + "WHERE ti.template_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, templateID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TemplateIngredient rf = new TemplateIngredient();
                    rf.setName(rs.getString("type_name") + " " + rs.getString("color_name"));
                    rf.setRequiredQuantity(rs.getInt("required_quantity"));
                    list.add(rf);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return list;
        }
    }

    public void UpdateRawFlower(RawFlower flower) {
        String sql = "UPDATE raw_flowers\n"
                + "SET\n"
                + "    type_id = ?,\n"
                + "    color_id = ?,\n"
                + "    quantity = ?,\n"
                + "    unit_price = ?,\n"
                + "    import_date = ?,\n"
                + "    expiry_date = ?,\n"
                + "    supplier_name = ?,\n"
                + "    notes=?\n"
                + "WHERE raw_flower_id = ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flower.getTypeId());
            ps.setInt(2, flower.getColorId());
            ps.setInt(3, flower.getQuantity());
            ps.setDouble(4, flower.getUnitPrice());
            ps.setDate(5, flower.getImportDate());
            ps.setDate(6, flower.getExpiryDate());
            ps.setString(7, flower.getSupplierName());
            ps.setString(8, flower.getNotes());
            ps.setInt(9, flower.getRawFlowerId());
            ps.executeUpdate();
            UpdateStatus();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void UpdateStatus() {
        String sql = "UPDATE flower_shop_db.raw_flowers\n"
                + "SET \n"
                + "    flower_shop_db.raw_flowers.dayleft = DATEDIFF(flower_shop_db.raw_flowers.expiry_date, CURDATE()), \n"
                + "    flower_shop_db.raw_flowers.is_expired = CASE \n"
                + "        WHEN flower_shop_db.raw_flowers.expiry_date <= CURDATE() THEN 1 \n"
                + "        ELSE 0 \n"
                + "    END, \n"
                + "    flower_shop_db.raw_flowers.status = CASE \n"
                + "        WHEN DATEDIFF(flower_shop_db.raw_flowers.expiry_date, CURDATE()) <= 0 THEN 'Hết hạn' \n"
                + "        WHEN DATEDIFF(flower_shop_db.raw_flowers.expiry_date, CURDATE()) <= 3 THEN 'Sắp hết hạn' \n"
                + "        ELSE CONCAT('Còn ', DATEDIFF(flower_shop_db.raw_flowers.expiry_date, CURDATE()), ' ngày') \n"
                + "    END;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteRawflower(int id) {
        String sql = "UPDATE raw_flowers\n"
                + "SET\n"
                + "    is_deleted=?\n"
                + "WHERE raw_flower_id = ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void addRawflower(RawFlower flower) {
        String sql = "INSERT INTO raw_flowers "
                + "(type_id, color_id, quantity, unit_price, import_date, expiry_date, supplier_name, notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flower.getTypeId());
            ps.setInt(2, flower.getColorId());
            ps.setInt(3, flower.getQuantity());
            ps.setDouble(4, flower.getUnitPrice());
            ps.setDate(5, flower.getImportDate());
            ps.setDate(6, flower.getExpiryDate());
            ps.setString(7, flower.getSupplierName());
            ps.setString(8, flower.getNotes());
            ps.executeUpdate(); // sử dụng executeUpdate cho lệnh INSERT
            UpdateStatus();
        } catch (Exception e) {
            e.printStackTrace(); // in lỗi ra để dễ debug
        }
    }
    
    public void updateBouquet(BouquetTemplate bq) {
        String sql = "UPDATE bouquet_templates SET stock = stock + ? "
                + "WHERE template_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bq.getStock());
            ps.setInt(2, bq.getTemplateId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<RawFlower> getRawFlowers(int typeId, int colorId) {
    List<RawFlower> list = new ArrayList<>();
    String sql = "SELECT raw_flower_id, quantity, expiry_date FROM raw_flowers "
               + "WHERE type_id = ? AND color_id = ? AND quantity > 0 "
               + "ORDER BY expiry_date ASC";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, typeId);
        ps.setInt(2, colorId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            RawFlower rf = new RawFlower();
            rf.setRawFlowerId(rs.getInt("raw_flower_id"));
            rf.setQuantity(rs.getInt("quantity"));
            rf.setExpiryDate(rs.getDate("expiry_date"));
            list.add(rf);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}
    
    public List<TemplateIngredient> getIngredientsByTemplateId(int templateId) {
    List<TemplateIngredient> list = new ArrayList<>();
    String sql = "SELECT ingredient_id, template_id, type_id, color_id, quantity " +
                 "FROM template_ingredients WHERE template_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, templateId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            TemplateIngredient ing = new TemplateIngredient();
            ing.setIngredientId(rs.getInt("ingredient_id"));
            ing.setTemplateId(rs.getInt("template_id"));
            ing.setTypeId(rs.getInt("type_id"));
            ing.setColorId(rs.getInt("color_id"));
            ing.setRequiredQuantity(rs.getInt("quantity"));
            list.add(ing);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    
    
    public List<FlowerType> getAllFlowerType() {
        List<FlowerType> list = new ArrayList<>();
        String sql
                = "SELECT * "
                + "FROM flower_types  ";

        try (Connection conn = DBcontext.getJDBCConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                FlowerType rf = new FlowerType();
                rf.setTypeName(rs.getString("type_name"));
                rf.setTypeId(rs.getInt("type_id"));
                list.add(rf);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<FlowerColor> getAllFlowerColor() {
        List<FlowerColor> list = new ArrayList<>();
        String sql
                = "SELECT * "
                + "FROM flower_colors  ";

        try (Connection conn = DBcontext.getJDBCConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                FlowerColor rf = new FlowerColor();
                rf.setColorName(rs.getString("color_name"));
                rf.setColorId(rs.getInt("color_id"));
                list.add(rf);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void AddIngredientByProduct(int templateId, int typeID, int colorID, int quantity) throws SQLException {
        String sql = "INSERT INTO template_ingredients SET template_id = ? , type_id = ? , color_id = ? , required_quantity = ? ";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, templateId);
            stmt.setInt(2, typeID);
            stmt.setInt(3, colorID);
            stmt.setInt(4, quantity);
            stmt.executeUpdate();
        }
    }

    public void AddTemplateByProduct(int templateId, String templateName, double price, int stock, int CategoryID) throws SQLException {
        String sql = "INSERT INTO bouquet_templates "
                + "(template_id, template_name, base_price, stock, created_by, category_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, templateId);
            stmt.setString(2, templateName);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);
            stmt.setInt(5, 1); // created_by
            stmt.setInt(6, CategoryID);
            stmt.executeUpdate();
        }
    }

}
