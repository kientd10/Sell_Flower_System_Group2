/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;

/**
 *
 * @author PC
 */
import java.util.*;
import java.lang.*;
import java.time.LocalDateTime;
public class ShoppingCart {
   private int Cart_id;
   private int User_id;
   private int Template_id;
   private int Quantity;
   private LocalDateTime Add_at;

    public ShoppingCart() {
    }

    public ShoppingCart(int Cart_id, int User_id, int Template_id, int Quantity, LocalDateTime Add_at) {
        this.Cart_id = Cart_id;
        this.User_id = User_id;
        this.Template_id = Template_id;
        this.Quantity = Quantity;
        this.Add_at = Add_at;
    }

    public int getCart_id() {
        return Cart_id;
    }

    public void setCart_id(int Cart_id) {
        this.Cart_id = Cart_id;
    }

    public int getUser_id() {
        return User_id;
    }

    public void setUser_id(int User_id) {
        this.User_id = User_id;
    }

    public int getTemplate_id() {
        return Template_id;
    }

    public void setTemplate_id(int Template_id) {
        this.Template_id = Template_id;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public LocalDateTime getAdd_at() {
        return Add_at;
    }

    public void setAdd_at(LocalDateTime Add_at) {
        this.Add_at = Add_at;
    }
   
}
