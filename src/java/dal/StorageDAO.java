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
                + "rf.unit_price, rf.expiry_date , rf.supplier_name "
                + "FROM raw_flowers rf "
                + "JOIN flower_types  ft ON rf.type_id  = ft.type_id "
                + "JOIN flower_colors fc ON rf.color_id = fc.color_id";

        try (Connection conn = DBcontext.getJDBCConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                RawFlower rf = new RawFlower();
                rf.setTypeId(rs.getInt("type_id"));
                rf.setRawFlowerId(rs.getInt("raw_flower_id"));
                rf.setRawFlowerName(rs.getString("type_name") + " " + rs.getString("color_name"));
                rf.setColorId(rs.getInt("color_id"));
                rf.setQuantity(rs.getInt("quantity"));
                rf.setUnitPrice(rs.getDouble("unit_price"));
                rf.setExpiryDate(rs.getDate("expiry_date"));
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

    public void AddTemplateByProduct(int templateId, String templateName, double price, int stock , int CategoryID) throws SQLException {
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
