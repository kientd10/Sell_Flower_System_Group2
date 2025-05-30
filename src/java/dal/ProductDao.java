package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import model.ShoppingCart;

public class ProductDao extends DBContext {

    public List<ShoppingCart> getCartItemsByUserId(int userId) {
        List<ShoppingCart> cartItems = new ArrayList<>();
        String sql
                = "SELECT d.cart_id, d.user_id, d.template_id, d.quantity, d.added_at, bt.stock , "
                + "bt.template_name, bt.description, bt.base_price, bt.image_url "
                + "FROM shopping_cart d "
                + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                + "WHERE d.user_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setTemplateId(rs.getInt("template_id"));
                p.setTemplateName(rs.getString("template_name"));
                p.setDescription(rs.getString("description"));
                p.setBasePrice(rs.getDouble("base_price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStock(rs.getInt("stock"));
                ShoppingCart line = new ShoppingCart();
                line.setCartId(rs.getInt("cart_id"));
                line.setUserId(rs.getInt("user_id"));
                line.setProduct(p);
                line.setQuantity(rs.getInt("quantity"));
                line.setAddedAt(rs.getTimestamp("added_at").toLocalDateTime());
                cartItems.add(line);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public ShoppingCart getItems(int userId, int templateId) {
        ShoppingCart Item = new ShoppingCart();
        String sql
                = "SELECT d.cart_id, d.user_id, d.template_id, d.quantity, d.added_at, bt.stock , "
                + "bt.template_name, bt.description, bt.base_price, bt.image_url "
                + "FROM shopping_cart d "
                + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                + "WHERE d.user_id = ? and bt.template_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, templateId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setTemplateId(rs.getInt("template_id"));
                p.setTemplateName(rs.getString("template_name"));
                p.setDescription(rs.getString("description"));
                p.setBasePrice(rs.getDouble("base_price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStock(rs.getInt("stock"));
                Item.setCartId(rs.getInt("cart_id"));
                Item.setUserId(rs.getInt("user_id"));
                Item.setProduct(p);
                Item.setQuantity(rs.getInt("quantity"));
                Item.setAddedAt(rs.getTimestamp("added_at").toLocalDateTime());

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Item;
    }

    public void deleteCartItemsByCartId(int CartId) {
        String sql = "DELETE FROM shopping_cart WHERE cart_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, CartId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantityAndStock(int userId, int templateId, int newQuantity) throws SQLException {
        ShoppingCart oldItem = getItems(userId, templateId);
        int oldQuantity = oldItem.getQuantity();
        int delta = newQuantity - oldQuantity;
        String sql
                = "UPDATE shopping_cart sc "
                + " JOIN bouquet_templates bt ON sc.template_id = bt.template_id "
                + "SET sc.quantity = ?, "
                + "    bt.stock    = bt.stock - ? "
                + "WHERE sc.user_id     = ? "
                + "  AND sc.template_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, newQuantity);  
            st.setInt(2, delta);        
            st.setInt(3, userId);
            st.setInt(4, templateId);
            st.executeUpdate();
        }
    }

}
