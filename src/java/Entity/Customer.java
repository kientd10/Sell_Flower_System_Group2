/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author ADMIN
 */
public class Customer {
    int CustomerID;
    String Customer_Name ;
    String Customer_Email;
    String Customer_Password;
    String IsAdmin;

    public Customer() {
    }

    public Customer(int CustomerID, String Customer_Name, String Customer_Email, String Customer_Password, String IsAdmin) {
        this.CustomerID = CustomerID;
        this.Customer_Name = Customer_Name;
        this.Customer_Email = Customer_Email;
        this.Customer_Password = Customer_Password;
        this.IsAdmin = IsAdmin;
    }

    public Customer( String Customer_Email, String Customer_Password) {
        this.Customer_Email = Customer_Email;
        this.Customer_Password = Customer_Password;
    }

    public Customer(int CustomerID, String Customer_Name, String Customer_Email, String Customer_Password) {
        this.CustomerID = CustomerID;
        this.Customer_Name = Customer_Name;
        this.Customer_Email = Customer_Email;
        this.Customer_Password = Customer_Password;
    }
    
    
    
    

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getCustomer_Name() {
        return Customer_Name;
    }

    public void setCustomer_Name(String Customer_Name) {
        this.Customer_Name = Customer_Name;
    }

    public String getCustomer_Email() {
        return Customer_Email;
    }

    public void setCustomer_Email(String Customer_Email) {
        this.Customer_Email = Customer_Email;
    }

    public String getCustomer_Password() {
        return Customer_Password;
    }

    public void setCustomer_Password(String Customer_Password) {
        this.Customer_Password = Customer_Password;
    }

    public String getIsAdmin() {
        return IsAdmin;
    }

    public void setIsAdmin(String IsAdmin) {
        this.IsAdmin = IsAdmin;
    }

    @Override
    public String toString() {
        return "Customer{" + "CustomerID=" + CustomerID + ", Customer_Name=" + Customer_Name + ", Customer_Email=" + Customer_Email + ", Customer_Password=" + Customer_Password + '}';
    }
    
    
}
