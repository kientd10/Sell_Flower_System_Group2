package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    public Connection connection;

    public DBContext() {
        try {
            String username = "root";
            String password = "123456";
            String url = "jdbc:mysql://localhost:3306/flower_shop_db ?useSSL=false&serverTimezone=UTC";
            
            // Tải driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Kết nối DB
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
        System.out.println(db.connection != null ? "Kết nối thành công" : "Kết nối thất bại");
    }
}


