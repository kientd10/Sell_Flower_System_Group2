/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author tuanh
 */
public class StatisticsDAO {
    private DBcontext dbContext = new DBcontext();

    public double getMonthlyRevenue(int month, int year) throws SQLException {
        String sql = "SELECT COALESCE(SUM(p.amount), 0) as total_revenue " +
                     "FROM payments p " +
                     "JOIN orders o ON p.order_id = o.order_id " +
                     "WHERE MONTH(o.created_at) = ? AND YEAR(o.created_at) = ? AND p.payment_status = 'Success'";
        double revenue = 0;
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("total_revenue");
            }
        }
        return revenue;
    }

    public int getMonthlyOrderCount(int month, int year) throws SQLException {
        String sql = "SELECT COUNT(*) as order_count " +
                     "FROM orders " +
                     "WHERE MONTH(created_at) = ? AND YEAR(created_at) = ? AND status_id IN (1,2)"; // 6 = Delivered
        int orderCount = 0;
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                orderCount = rs.getInt("order_count");
            }
        }
        return orderCount;
    }
}
