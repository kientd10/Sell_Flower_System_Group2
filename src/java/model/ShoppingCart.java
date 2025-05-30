package model;

import java.time.LocalDateTime;

public class ShoppingCart {

    private int CartId;
    private int UserId;
    private Product Product;
    private int Quantity;
    private LocalDateTime AddedAt;

    public ShoppingCart() {
    }

    public ShoppingCart(int CartId, int UserId, Product Product, int Quantity, LocalDateTime AddedAt) {
        this.CartId = CartId;
        this.UserId = UserId;
        this.Product = Product;
        this.Quantity = Quantity;
        this.AddedAt = AddedAt;
    }

    public int getCartId() {
        return CartId;
    }

    public void setCartId(int CartId) {
        this.CartId = CartId;
    }

    public int getUserId() {
        return UserId;
    }

    public void setUserId(int UserId) {
        this.UserId = UserId;
    }

    public Product getProduct() {
        return Product;
    }

    public void setProduct(Product Product) {
        this.Product = Product;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public LocalDateTime getAddedAt() {
        return AddedAt;
    }

    public void setAddedAt(LocalDateTime AddedAt) {
        this.AddedAt = AddedAt;
    }

    public void add(ShoppingCart line) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
