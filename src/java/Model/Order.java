/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author PC
 */
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.*;
import java.lang.*;

public class Order {
    private String name;
    private int orderId;
    private int customerId;
    private String orderCode;
    private BigDecimal totalAmount;
    private int statusId;
    private String deliveryAddress;
    private String deliveryPhone;
    private LocalDate deliveryDate;
    private String specialNotes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Order() {
    }

    public Order( String name , int orderId, int customerId, String orderCode, BigDecimal totalAmount,
            int statusId, String deliveryAddress, String deliveryPhone,
            LocalDate deliveryDate, String specialNotes,
            Timestamp createdAt, Timestamp updatedAt) {
        this.orderId = orderId;
        this.name = name;
        this.customerId = customerId;
        this.orderCode = orderCode;
        this.totalAmount = totalAmount;
        this.statusId = statusId;
        this.deliveryAddress = deliveryAddress;
        this.deliveryPhone = deliveryPhone;
        this.deliveryDate = deliveryDate;
        this.specialNotes = specialNotes;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    public int getOrderId() {
        return orderId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getDeliveryPhone() {
        return deliveryPhone;
    }

    public void setDeliveryPhone(String deliveryPhone) {
        this.deliveryPhone = deliveryPhone;
    }

    public LocalDate getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(LocalDate deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getSpecialNotes() {
        return specialNotes;
    }

    public void setSpecialNotes(String specialNotes) {
        this.specialNotes = specialNotes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
