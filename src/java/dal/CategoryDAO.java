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
        String sql = "SELECT category_id, category_name FROM categories WHERE is_active = TRUE ORDER BY category_id ASC";
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
        if (isCategoryNameExists(category.getCategoryName(), null)) {
            throw new Exception("Tên danh mục đã tồn tại!");
        }
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
        if (isCategoryNameExists(category.getCategoryName(), category.getCategoryId())) {
            throw new Exception("Tên danh mục đã tồn tại!");
        }
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
    
        // Delete a category (soft delete)
    public boolean deleteCategory(int categoryId) throws Exception {
        if (isCategoryInUse(categoryId)) {
            throw new Exception("Category is used in bouquet templates!");
        }
        String sql = "UPDATE categories SET is_active = FALSE WHERE category_id = ?";
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
    
    // Search categories by name
    public List<Category> searchCategoriesByName(String searchTerm) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT category_id, category_name FROM categories WHERE is_active = TRUE AND category_name LIKE ? ORDER BY category_id ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + searchTerm + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    categories.add(new Category(rs.getInt("category_id"), rs.getString("category_name")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    // Get categories with product count and status
    public List<Category> getCategoriesWithProductCount() {
        List<Category> categories = new ArrayList<>();
        String sql = """
            SELECT c.category_id, c.category_name, 
                   COUNT(bt.template_id) as product_count
            FROM categories c
            LEFT JOIN bouquet_templates bt ON c.category_id = bt.category_id
            WHERE c.is_active = TRUE
            GROUP BY c.category_id, c.category_name
            ORDER BY c.category_id ASC
            """;
        try (PreparedStatement stmt = conn.prepareStatement(sql); 
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("category_name"));
                category.setProductCount(rs.getInt("product_count"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    // Filter categories by status (active = has products, inactive = no products)
    public List<Category> filterCategoriesByStatus(String status) {
        List<Category> categories = new ArrayList<>();
        String sql;
        
        if ("active".equals(status)) {
            sql = """
                SELECT c.category_id, c.category_name, 
                       COUNT(bt.template_id) as product_count
                FROM categories c
                INNER JOIN bouquet_templates bt ON c.category_id = bt.category_id
                WHERE c.is_active = TRUE
                GROUP BY c.category_id, c.category_name
                HAVING COUNT(bt.template_id) > 0
                ORDER BY c.category_id ASC
                """;
        } else if ("inactive".equals(status)) {
            sql = """
                SELECT c.category_id, c.category_name, 
                       COUNT(bt.template_id) as product_count
                FROM categories c
                LEFT JOIN bouquet_templates bt ON c.category_id = bt.category_id
                WHERE c.is_active = TRUE
                GROUP BY c.category_id, c.category_name
                HAVING COUNT(bt.template_id) = 0
                ORDER BY c.category_id ASC
                """;
        } else {
            return getCategoriesWithProductCount();
        }
        
        try (PreparedStatement stmt = conn.prepareStatement(sql); 
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("category_name"));
                category.setProductCount(rs.getInt("product_count"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    // Search and filter categories
    public List<Category> searchAndFilterCategories(String searchTerm, String status) {
        List<Category> categories = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("""
            SELECT c.category_id, c.category_name, 
                   COUNT(bt.template_id) as product_count
            FROM categories c
            """);
        
        if ("active".equals(status)) {
            sql.append("INNER JOIN bouquet_templates bt ON c.category_id = bt.category_id ");
        } else if ("inactive".equals(status)) {
            sql.append("LEFT JOIN bouquet_templates bt ON c.category_id = bt.category_id ");
        } else {
            sql.append("LEFT JOIN bouquet_templates bt ON c.category_id = bt.category_id ");
        }
        
        sql.append("WHERE c.is_active = TRUE ");
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append("AND c.category_name LIKE ? ");
            params.add("%" + searchTerm.trim() + "%");
        }
        
        sql.append("GROUP BY c.category_id, c.category_name ");
        
        if ("active".equals(status)) {
            sql.append("HAVING COUNT(bt.template_id) > 0 ");
        } else if ("inactive".equals(status)) {
            sql.append("HAVING COUNT(bt.template_id) = 0 ");
        }
        
        sql.append("ORDER BY c.category_id ASC");
        
        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category(rs.getInt("category_id"), rs.getString("category_name"));
                    category.setProductCount(rs.getInt("product_count"));
                    categories.add(category);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    // Sort categories
    public List<Category> sortCategories(List<Category> categories, String sortBy, String sortOrder) {
        if (categories == null || categories.isEmpty()) {
            return categories;
        }
        
        if ("name".equals(sortBy)) {
            if ("asc".equals(sortOrder)) {
                categories.sort((c1, c2) -> c1.getCategoryName().compareToIgnoreCase(c2.getCategoryName()));
            } else {
                categories.sort((c1, c2) -> c2.getCategoryName().compareToIgnoreCase(c1.getCategoryName()));
            }
        } else if ("id".equals(sortBy)) {
            if ("asc".equals(sortOrder)) {
                categories.sort((c1, c2) -> Integer.compare(c1.getCategoryId(), c2.getCategoryId()));
            } else {
                categories.sort((c1, c2) -> Integer.compare(c2.getCategoryId(), c1.getCategoryId()));
            }
        } else if ("products".equals(sortBy)) {
            if ("asc".equals(sortOrder)) {
                categories.sort((c1, c2) -> Integer.compare(c1.getProductCount(), c2.getProductCount()));
            } else {
                categories.sort((c1, c2) -> Integer.compare(c2.getProductCount(), c1.getProductCount()));
            }
        }
        
        return categories;
    }
    
    // Bulk delete categories
    public boolean bulkDeleteCategories(List<Integer> categoryIds) throws Exception {
        if (categoryIds == null || categoryIds.isEmpty()) {
            return false;
        }
        
        // Check if any category is in use
        for (Integer categoryId : categoryIds) {
            if (isCategoryInUse(categoryId)) {
                throw new Exception("Category ID " + categoryId + " is used in bouquet templates!");
            }
        }
        
        String sql = "DELETE FROM categories WHERE category_id IN (";
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < categoryIds.size(); i++) {
            if (i > 0) placeholders.append(",");
            placeholders.append("?");
        }
        sql += placeholders.toString() + ")";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < categoryIds.size(); i++) {
                stmt.setInt(i + 1, categoryIds.get(i));
            }
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public boolean isCategoryNameExists(String name, Integer excludeId) throws Exception {
        String sql = "SELECT COUNT(*) FROM categories WHERE LOWER(category_name) = LOWER(?)";
        if (excludeId != null) {
            sql += " AND category_id <> ?";
        }
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            if (excludeId != null) stmt.setInt(2, excludeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Restore a soft-deleted category
    public boolean restoreCategory(int categoryId) throws Exception {
        String sql = "UPDATE categories SET is_active = TRUE WHERE category_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy danh mục đã xóa mềm kèm số sản phẩm
    public List<Category> getDeletedCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = """
            SELECT c.category_id, c.category_name, COUNT(bt.template_id) as product_count
            FROM categories c
            LEFT JOIN bouquet_templates bt ON c.category_id = bt.category_id
            WHERE c.is_active = FALSE
            GROUP BY c.category_id, c.category_name
            ORDER BY c.category_id ASC
        """;
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category category = new Category(rs.getInt("category_id"), rs.getString("category_name"));
                category.setProductCount(rs.getInt("product_count"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Đếm tổng số danh mục (kể cả đã xóa mềm)
    public int countAllCategories() {
        String sql = "SELECT COUNT(*) FROM categories";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
