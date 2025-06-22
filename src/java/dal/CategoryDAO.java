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
import Model.Category;
import dal.DBcontext;

public class CategoryDAO {

    private Connection conn;

    public CategoryDAO() {
        try {
            conn = new DBcontext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT category_id, category_name FROM categories ORDER BY category_id ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getInt("category_id"), rs.getString("category_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
        // Create a new category
    public boolean createCategory(Category category) throws Exception {
    String sql = "INSERT INTO categories (category_name) VALUES (?)";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, category.getCategoryName());
        return stmt.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }
    }
    
        // Read category by ID
    public Category getCategoryById(int categoryId) throws Exception {
        String sql = "SELECT * FROM categories WHERE category_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    return category;
                }
            }
        }
        return null;
    }
    
        // Update a category
    public boolean updateCategory(Category category) throws Exception {
    String sql = "UPDATE categories SET category_name = ? WHERE category_id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, category.getCategoryName());
        stmt.setInt(2, category.getCategoryId());
        return stmt.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }
    }
    
        // Delete a category
    public boolean deleteCategory(int categoryId) throws Exception {
    if (isCategoryInUse(categoryId)) {
        throw new Exception("Category is used in bouquet templates!");
    }
    String sql = "DELETE FROM categories WHERE category_id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, categoryId);
        return stmt.executeUpdate() > 0;
    }
    }
    
        // Check if category is used in bouquet_templates
    public boolean isCategoryInUse(int categoryId) throws Exception {
        String sql = "SELECT COUNT(*) FROM bouquet_templates WHERE category_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        List<Category> categories = dao.getAllCategories();
        for (Category c : categories) {
            System.out.println("ID: " + c.getCategoryId() + ", Name: " + c.getCategoryName());
        }
    }
}
