/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.List;

/**
 *
 * @author ADMIN
 */
public class BouquetTemplate {

    private int templateId;
    private String templateName;
    private String description;
    private double basePrice;
    private String imageUrl;
    private int Stock;
    private String categoryName;
    private List<TemplateIngredient> ingredients;
    private int categoryId;
    private int createdBy;

    public BouquetTemplate() {
    }

    public BouquetTemplate(int templateId, String templateName, String description, double basePrice, String imageUrl, int Stock) {
        this.templateId = templateId;
        this.templateName = templateName;
        this.description = description;
        this.basePrice = basePrice;
        this.imageUrl = imageUrl;
        this.Stock = Stock;
    }

    public BouquetTemplate(int templateId, String templateName, String description, double basePrice, String imageUrl) {
        this.templateId = templateId;
        this.templateName = templateName;
        this.description = description;
        this.basePrice = basePrice;
        this.imageUrl = imageUrl;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int Stock) {
        this.Stock = Stock;
    }

    public int getTemplateId() {
        return templateId;
    }

    public void setTemplateId(int templateId) {
        this.templateId = templateId;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<TemplateIngredient> getIngredients() {
        return ingredients;
    }

    public void setIngredients(List<TemplateIngredient> ingredients) {
        this.ingredients = ingredients;
    }
    private double avgRating;

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

}
