
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Invoice {
    private String Order_code;
    private String Customer_name;
    private Date Date;
    private Double TotalPayment;
    private String Status;
    private String Payment;
    private String Payment_id;
    
    public Invoice() {
    }

    public Invoice(String Order_code, String Customer_name, Date Date, Double TotalPayment, String Status, String Payment,String Payment_id) {
        this.Order_code = Order_code;
        this.Customer_name = Customer_name;
        this.Date = Date;
        this.TotalPayment = TotalPayment;
        this.Status = Status;
        this.Payment = Payment;
        this.Payment_id=Payment_id;
    }

    public String getOrder_code() {
        return Order_code;
    }

    public void setOrder_code(String Order_code) {
        this.Order_code = Order_code;
    }

    public String getCustomer_name() {
        return Customer_name;
    }

    public void setCustomer_name(String Customer_name) {
        this.Customer_name = Customer_name;
    }

    public Date getDate() {
        return Date;
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }

    public Double getTotalPayment() {
        return TotalPayment;
    }

    public void setTotalPayment(Double TotalPayment) {
        this.TotalPayment = TotalPayment;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getPayment() {
        return Payment;
    }

    public void setPayment(String Payment) {
        this.Payment = Payment;
    }

    public String getPayment_id() {
        return Payment_id;
    }

    public void setPayment_id(String Payment_id) {
        this.Payment_id = Payment_id;
    }

    @Override
    public String toString() {
        return "Invoice{" + "Order_code=" + Order_code + ", Customer_name=" + Customer_name + ", Date=" + Date + ", TotalPayment=" + TotalPayment + ", Status=" + Status + ", Payment=" + Payment + ", Payment_id=" + Payment_id + '}';
    }
    

    
    
}


