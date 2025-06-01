package model;

import java.time.LocalDateTime;


public class Product {
    private int TemplateId;
    private String TemplateName;
    private String Description;
    private double BasePrice;
    private String ImageUrl;
    private boolean IsActive;
    private int CreatedBy;
    private int Stock;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Product() {
    }

    public Product(int TemplateId, String TemplateName, String Description, double BasePrice, String ImageUrl, boolean IsActive, int CreatedBy, int Stock, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.TemplateId = TemplateId;
        this.TemplateName = TemplateName;
        this.Description = Description;
        this.BasePrice = BasePrice;
        this.ImageUrl = ImageUrl;
        this.IsActive = IsActive;
        this.CreatedBy = CreatedBy;
        this.Stock = Stock;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }

    public int getTemplateId() {
        return TemplateId;
    }

    public void setTemplateId(int TemplateId) {
        this.TemplateId = TemplateId;
    }

    public String getTemplateName() {
        return TemplateName;
    }

    public void setTemplateName(String TemplateName) {
        this.TemplateName = TemplateName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public double getBasePrice() {
        return BasePrice;
    }

    public void setBasePrice(double BasePrice) {
        this.BasePrice = BasePrice;
    }

    public String getImageUrl() {
        return ImageUrl;
    }

    public void setImageUrl(String ImageUrl) {
        this.ImageUrl = ImageUrl;
    }

    public boolean isIsActive() {
        return IsActive;
    }

    public void setIsActive(boolean IsActive) {
        this.IsActive = IsActive;
    }

    public int getCreatedBy() {
        return CreatedBy;
    }

    public void setCreatedBy(int CreatedBy) {
        this.CreatedBy = CreatedBy;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int Stock) {
        this.Stock = Stock;
    }

    public LocalDateTime getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(LocalDateTime CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return UpdatedAt;
    }

    public void setUpdatedAt(LocalDateTime UpdatedAt) {
        this.UpdatedAt = UpdatedAt;
    }

    
}
    
   
