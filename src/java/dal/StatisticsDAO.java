/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE MONTH(o.created_at) = ? AND YEAR(o.created_at) = ? " +
                     "AND p.payment_status = 'Success' AND s.status_name = 'Đã mua'";
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
                     "FROM orders o " +
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE MONTH(o.created_at) = ? AND YEAR(o.created_at) = ? AND s.status_name = 'Đã mua'";
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
    /**
     * Get revenue for a specific day.
     */
    public double getDailyRevenue(int day, int month, int year) throws SQLException {
        String sql = "SELECT COALESCE(SUM(p.amount), 0) as total_revenue " +
                     "FROM payments p " +
                     "JOIN orders o ON p.order_id = o.order_id " +
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE DAY(o.created_at) = ? AND MONTH(o.created_at) = ? AND YEAR(o.created_at) = ? " +
                     "AND p.payment_status = 'Success' AND s.status_name = 'Đã mua'";
        double revenue = 0;
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, day);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("total_revenue");
            }
        }
        return revenue;
    }

    /**
     * Get order count for a specific day.
     */
    public int getDailyOrderCount(int day, int month, int year) throws SQLException {
        String sql = "SELECT COUNT(*) as order_count " +
                     "FROM orders o " +
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE DAY(o.created_at) = ? AND MONTH(o.created_at) = ? AND YEAR(o.created_at) = ? AND s.status_name = 'Đã mua'";
        int orderCount = 0;
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, day);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                orderCount = rs.getInt("order_count");
            }
        }
        return orderCount;
    }

    /**
     * Get revenue for a specific year.
     */
    public double getYearlyRevenue(int year) throws SQLException {
        String sql = "SELECT COALESCE(SUM(p.amount), 0) as total_revenue " +
                     "FROM payments p " +
                     "JOIN orders o ON p.order_id = o.order_id " +
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE YEAR(o.created_at) = ? AND p.payment_status = 'Success' AND s.status_name = 'Đã mua'";
        double revenue = 0;
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("total_revenue");
            }
        }
        return revenue;
    }

    /**
     * Get order count for a specific year.
     */
    public int getYearlyOrderCount(int year) throws SQLException {
        String sql = "SELECT COUNT(*) as order_count " +
                     "FROM orders o " +
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE YEAR(o.created_at) = ? AND s.status_name = 'Đã mua'";
        int orderCount = 0;
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                orderCount = rs.getInt("order_count");
            }
        }
        return orderCount;
    }

    /**
     * Get monthly revenue data for chart (for a specific year).
     */
    public List<Double> getMonthlyRevenueForChart(int year) throws SQLException {
        String sql = "SELECT MONTH(o.created_at) as month, COALESCE(SUM(p.amount), 0) as total_revenue " +
                     "FROM payments p " +
                     "JOIN orders o ON p.order_id = o.order_id " +
                     "JOIN order_status s ON o.status_id = s.status_id " +
                     "WHERE YEAR(o.created_at) = ? AND p.payment_status = 'Success' AND s.status_name = 'Đã mua' " +
                     "GROUP BY MONTH(o.created_at) " +
                     "ORDER BY MONTH(o.created_at)";
        List<Double> revenues = new ArrayList<>();
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            // Initialize array with 12 zeros (for each month)
            for (int i = 0; i < 12; i++) {
                revenues.add(0.0);
            }
            while (rs.next()) {
                int month = rs.getInt("month");
                double revenue = rs.getDouble("total_revenue");
                revenues.set(month - 1, revenue); // Month is 1-based, list is 0-based
            }
        }
        return revenues;
    }
}
