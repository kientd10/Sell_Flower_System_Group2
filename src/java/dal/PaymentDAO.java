/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import dal.DBcontext; // đảm bảo bạn có class DBcontext để lấy connection

/**
 *
 * @author Admin
 */
public class PaymentDAO {

    private Connection conn;

    public PaymentDAO() {
        try {
            conn = new DBcontext().getConnection(); // kết nối CSDL
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertPaypalPayment(int orderId, String transactionId, double amount, String status) {
        String sql = "INSERT INTO payments (order_id, payment_method, amount, transaction_id, payment_status, payment_date) "
                   + "VALUES (?, 'Card', ?, ?, ?, NOW())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setDouble(2, amount);
            ps.setString(3, transactionId);
            ps.setString(4, status); // "Success", "Pending", v.v.
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
