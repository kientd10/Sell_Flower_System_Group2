
package dal;

import Model.Invoice;
import java.sql.Connection;
import java.sql.PreparedStatement;
import dal.DBcontext; // đảm bảo bạn có class DBcontext để lấy connection
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

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
                + "VALUES (?, ?, ?, ?, ?, NOW())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);              // ✅ order_id
            ps.setString(2, "PayPal");          // ✅ payment_method
            ps.setDouble(3, amount);            // ✅ amount
            ps.setString(4, transactionId);     // ✅ transaction_id
            ps.setString(5, status);            // ✅ payment_status
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //in ra list invoice
    public List<Invoice> DisplayInvoice() {
        List<Invoice> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    \n"
                + "    p.payment_status,\n"
                + "    \n"
                + "    p.payment_id,\n"
                + "    p.payment_method,\n"
                + "\n"
                + "    \n"
                + "    o.order_code,\n"
                + "    \n"
                + "    o.created_at,\n"
                + "    o.total_amount,\n"
                + "    \n"
                + "    u.username\n"
                + "	\n"
                + "FROM \n"
                + "      flower_shop_db.payments p\n"
                + "JOIN \n"
                + "    orders o ON p.order_id = o.order_id\n"
                + "JOIN \n"
                + "    users u ON o.customer_id = u.user_id";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setStatus(rs.getString(1));
                invoice.setPayment_id(rs.getString(2));
                invoice.setPayment(rs.getString(3));
                invoice.setOrder_code(rs.getString(4));
                invoice.setDate(rs.getDate(5));
                invoice.setTotalPayment(rs.getDouble(6));
                invoice.setCustomer_name(rs.getString(7));
                list.add(invoice);
            }
        } catch (Exception e) {
        }
        return list;
    }

     //filter 
    public List<Invoice> FilterInvoice(String Date, String price) {
        List<Invoice> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    \n"
                + "    p.payment_status,\n"
                + "    \n"
                + "    p.payment_id,\n"
                + "    p.payment_method,\n"
                + "\n"
                + "    \n"
                + "    o.order_code,\n"
                + "    \n"
                + "    o.created_at,\n"
                + "    o.total_amount,\n"
                + "    \n"
                + "    u.username\n"
                + "	\n"
                + "FROM \n"
                + "      flower_shop_db.payments p\n"
                + "JOIN \n"
                + "    orders o ON p.order_id = o.order_id\n"
                + "JOIN \n"
                + "    users u ON o.customer_id = u.user_id\n"
                + "    \n"
                + "where 1=1";

        if (Date != null && !Date.equals("all")) {
            switch (Date) {
                case "today":
                    sql += " AND DATE(o.created_at) = CURDATE()";
                    break;
                case "yesterday":
                    sql += " AND DATE(o.created_at) = CURDATE() - INTERVAL 1 DAY";
                    break;
                case "week":
                    sql += " AND WEEK(o.created_at, 1) = WEEK(CURDATE(), 1) AND YEAR(o.created_at) = YEAR(CURDATE())";
                    break;
                case "month":
                    sql += " AND MONTH(o.created_at) = MONTH(CURDATE()) AND YEAR(o.created_at) = YEAR(CURDATE())";
                    break;
                case "quarter":
                    sql += " AND QUARTER(o.created_at) = QUARTER(CURDATE()) AND YEAR(o.created_at) = YEAR(CURDATE())";
                    break;
            }
        }

        if (price != null && !price.equals("all")) {
            switch (price) {
                case "price1": // 0 - 99,000
                    sql += " AND o.total_amount BETWEEN 0 AND 99000";
                    break;
                case "price2": // 100,000 - 499,000
                    sql += " AND o.total_amount BETWEEN 100000 AND 499000";
                    break;
                case "price3": // 500,000 trở lên
                    sql += " AND o.total_amount >= 500000";
                    break;

            }
        }
        
        sql +=" ORDER BY o.total_amount DESC";   
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setStatus(rs.getString(1));
                invoice.setPayment_id(rs.getString(2));
                invoice.setPayment(rs.getString(3));
                invoice.setOrder_code(rs.getString(4));
                invoice.setDate(rs.getDate(5));
                invoice.setTotalPayment(rs.getDouble(6));
                invoice.setCustomer_name(rs.getString(7));
                list.add(invoice);
            }
        } catch (Exception e) {
        }
        return list;
    }
    public static void main(String[] args) {
        PaymentDAO d = new PaymentDAO();
        List<Invoice> list = d.FilterInvoice("quarter", "price3");
        System.out.println(list);
    }

    
   
}


