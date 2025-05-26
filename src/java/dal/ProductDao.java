package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ShoppingCart;

public class ProductDao extends DBContext {
    public List<ShoppingCart> getCartByUserID(int user_id) {
        List<ShoppingCart> cartItems = new ArrayList<>();
        String sql = "SELECT d.quantity, d.added_at "
                   + "FROM users u "
                   + "JOIN shopping_cart d ON u.user_id = d.user_id "
                   + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                   + "WHERE u.user_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, user_id);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    ShoppingCart h = new ShoppingCart();
                    h.setQuantity(rs.getInt("quantity"));
                    h.setAdd_at(rs.getTimestamp("added_at").toLocalDateTime());
                    cartItems.add(h);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public List<Product> getProductsByUserID(int user_id) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT bt.template_name, bt.description, bt.base_price, bt.image_url "
                   + "FROM users u "
                   + "JOIN shopping_cart d ON u.user_id = d.user_id "
                   + "JOIN bouquet_templates bt ON d.template_id = bt.template_id "
                   + "WHERE u.user_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, user_id);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Product h = new Product();
                    h.setTemplateName(rs.getString("template_name"));
                    h.setDescription(rs.getString("description"));
                    h.setBasePrice(rs.getDouble("base_price"));
                    h.setImageUrl(rs.getString("image_url"));
                    products.add(h);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

}
