/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Customer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CustomerDAO extends DBcontext {

    public void signup(String name, String Email, String password,String fullname) {
        String query = "INSERT INTO flower_shop_db.users (username, email,password_hash,full_name,role_id) VALUES (?,?, ?, ?,?)";
        try {
            PreparedStatement ps = getJDBCConnextion().prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, Email);
            ps.setString(3, password);
            ps.setString(4, fullname);
            ps.setString(5, "1");
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public String checkName(String username){
        String query = "select * from flower_shop_db.users where username = ?";
        try {
            PreparedStatement ps = getJDBCConnextion().prepareStatement(query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                return username;
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public String checkEmail(String Email) {
        String query = "select * from flower_shop_db.users where email = ?";
        try {
            PreparedStatement ps = getJDBCConnextion().prepareStatement(query);
            ps.setString(1, Email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return Email;
            }
        } catch (Exception e) {

        }
        return null;
    }
    
    public  Entity.Customer Signin(String email,String password){
        String query = "select * from flower_shop_db.users where email = ? and password_hash = ?";
        try {
            PreparedStatement ps = getJDBCConnextion().prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Customer user = new Customer( rs.getInt(1),rs.getString(2),  rs.getString(3),rs.getString(4),rs.getString(5));
                return user;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Customer> GetUser() {
        List<Customer> list = new ArrayList<>();
        String query = "select * from flower_shop_db.users";
        try {
            PreparedStatement ps = getJDBCConnextion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                list.add(new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        CustomerDAO dao = new CustomerDAO();
        List<Customer> list = new ArrayList<>();
        list = dao.GetUser();
        //System.out.println(list.toString());
        String a = dao.checkEmail("thangbdhe187283@fpt.edu.vn");
        System.out.println(a);
        Customer b = new Customer();
        b = dao.Signin("thangbdhe187283@fpt.edu.vn", "123");
        System.out.println(b);
        String  c = dao.checkName("bui duy thang");
        System.out.println(c);
      
    }
}
