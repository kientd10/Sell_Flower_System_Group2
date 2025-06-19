package Model;

import java.time.LocalDateTime;

public class ShoppingCart {

    private int CartId;
    private int UserId;
    private BouquetTemplate BouquetTemplate;
    private int Quantity;
    private LocalDateTime AddedAt;

    public ShoppingCart() {
    }

    public ShoppingCart(int CartId, int UserId, BouquetTemplate BouquetTemplate, int Quantity, LocalDateTime AddedAt) {
        this.CartId = CartId;
        this.UserId = UserId;
        this.BouquetTemplate = BouquetTemplate;
        this.Quantity = Quantity;
        this.AddedAt = AddedAt;
    }
    public ShoppingCart( BouquetTemplate BouquetTemplate, int Quantity) {
        this.BouquetTemplate = BouquetTemplate;
        this.Quantity = Quantity;
    }
      public ShoppingCart( int UserId, BouquetTemplate BouquetTemplate, int Quantity) {
        this.UserId = UserId;
        this.BouquetTemplate = BouquetTemplate;
        this.Quantity = Quantity;
    }
      public int getTemplateId() {
    return BouquetTemplate.getTemplateId();
}

public double getPrice() {
    return BouquetTemplate.getBasePrice();
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

    public BouquetTemplate getBouquetTemplate() {
        return BouquetTemplate;
    }

    public void setBouquetTemplate(BouquetTemplate BouquetTemplate) {
        this.BouquetTemplate = BouquetTemplate;
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



     
}
