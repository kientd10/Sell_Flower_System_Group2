/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Employee;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
/**
 *
 * @author tuanh
 */
public class EmployeeDAO {

    private DBcontext dbContext = new DBcontext();

    public List<Employee> getAllEmployees() throws SQLException {
        List<Employee> employees = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbContext.getJDBCConnection();
            String sql = "SELECT e.*, u.username, u.email, u.password, u.full_name, u.phone, u.address, u.role_id, u.is_active "
                    + "FROM employees e JOIN users u ON e.user_id = u.user_id WHERE u.role_id = 2"; // Chỉ lấy Staff
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmployeeId(rs.getInt("employee_id"));
                emp.setUserId(rs.getInt("user_id"));
                emp.setUsername(rs.getString("username"));
                emp.setEmail(rs.getString("email"));
                emp.setPassword(rs.getString("password"));
                emp.setFullName(rs.getString("full_name"));
                emp.setPhone(rs.getString("phone"));
                emp.setAddress(rs.getString("address"));
                emp.setRoleId(rs.getInt("role_id"));
                emp.setIsActive(rs.getBoolean("is_active"));
                emp.setPosition(rs.getString("position"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getBigDecimal("salary"));
                emp.setWorkingStatus(rs.getString("working_status"));
                emp.setHireDate(rs.getDate("hire_date"));
                emp.setCreatedAt(rs.getTimestamp("created_at"));
                emp.setUpdatedAt(rs.getTimestamp("updated_at"));
                employees.add(emp);
            }
        } finally {
            
            dbContext.closeConnection(conn);
        }
        return employees;
    }

    public void addEmployee(Employee employee) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getJDBCConnection();
            String sql = "INSERT INTO employees (user_id, hire_date, department, salary, position, working_status) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, employee.getUserId());
            stmt.setDate(2, employee.getHireDate());
            stmt.setString(3, employee.getDepartment());
            stmt.setBigDecimal(4, employee.getSalary());
            stmt.setString(5, employee.getPosition());
            stmt.setString(6, employee.getWorkingStatus());
            stmt.executeUpdate();
        } finally {
            
            dbContext.closeConnection(conn);
        }
    }

    public void updateEmployee(Employee employee) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getJDBCConnection();
            String sql = "UPDATE employees SET hire_date = ?, department = ?, salary = ?, position = ?, working_status = ?, updated_at = CURRENT_TIMESTAMP "
                    + "WHERE employee_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setDate(1, employee.getHireDate());
            stmt.setString(2, employee.getDepartment());
            stmt.setBigDecimal(3, employee.getSalary());
            stmt.setString(4, employee.getPosition());
            stmt.setString(5, employee.getWorkingStatus());
            stmt.setInt(6, employee.getEmployeeId());
            stmt.executeUpdate();
        } finally {
           
            dbContext.closeConnection(conn);
        }
    }

    public void deleteEmployee(int employeeId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = dbContext.getJDBCConnection();
            String sql = "DELETE FROM employees WHERE employee_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, employeeId);
            stmt.executeUpdate();
        } finally {
            
            dbContext.closeConnection(conn);
        }
    }

    public Employee getEmployeeById(int employeeId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = dbContext.getJDBCConnection();
            String sql = "SELECT e.*, u.username, u.email, u.password, u.full_name, u.phone, u.address, u.role_id, u.is_active "
                    + "FROM employees e JOIN users u ON e.user_id = u.user_id WHERE e.employee_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, employeeId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Employee emp = new Employee();
                emp.setEmployeeId(rs.getInt("employee_id"));
                emp.setUserId(rs.getInt("user_id"));
                emp.setUsername(rs.getString("username"));
                emp.setEmail(rs.getString("email"));
                emp.setPassword(rs.getString("password"));
                emp.setFullName(rs.getString("full_name"));
                emp.setPhone(rs.getString("phone"));
                emp.setAddress(rs.getString("address"));
                emp.setRoleId(rs.getInt("role_id"));
                emp.setIsActive(rs.getBoolean("is_active"));
                emp.setPosition(rs.getString("position"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getBigDecimal("salary"));
                emp.setWorkingStatus(rs.getString("working_status"));
                emp.setHireDate(rs.getDate("hire_date"));
                emp.setCreatedAt(rs.getTimestamp("created_at"));
                emp.setUpdatedAt(rs.getTimestamp("updated_at"));
                return emp;
            }
        } finally {
            
            dbContext.closeConnection(conn);
        }
        return null;
    }

}
