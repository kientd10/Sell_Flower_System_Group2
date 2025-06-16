package Model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Model class representing a raw flower batch in inventory.
 */
public class RawFlower {
    private int rawFlowerId;
    private int typeId;
    private int colorId;
    private String rawFlowerName; 
    private int quantity;
    private double unitPrice;
    private Date importDate;
    private Date expiryDate;
    private String supplierName;
    private boolean isExpired;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public RawFlower() {}

    // Full-args constructor
    public RawFlower(int rawFlowerId, int typeId, int colorId, String rawFlowerName,
                     int quantity, double unitPrice, Date importDate, Date expiryDate,
                     String supplierName, boolean isExpired, String notes,
                     Timestamp createdAt, Timestamp updatedAt) {
        this.rawFlowerId = rawFlowerId;
        this.typeId = typeId;
        this.colorId = colorId;
        this.rawFlowerName = rawFlowerName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.importDate = importDate;
        this.expiryDate = expiryDate;
        this.supplierName = supplierName;
        this.isExpired = isExpired;
        this.notes = notes;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getRawFlowerId() {
        return rawFlowerId;
    }
    public void setRawFlowerId(int rawFlowerId) {
        this.rawFlowerId = rawFlowerId;
    }
    public int getTypeId() {
        return typeId;
    }
    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }
    public int getColorId() {
        return colorId;
    }
    public void setColorId(int colorId) {
        this.colorId = colorId;
    }
    public String getRawFlowerName() {
        return rawFlowerName;
    }
    public void setRawFlowerName(String rawFlowerName) {
        this.rawFlowerName = rawFlowerName;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public double getUnitPrice() {
        return unitPrice;
    }
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
    public Date getImportDate() {
        return importDate;
    }
    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }
    public Date getExpiryDate() {
        return expiryDate;
    }
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    public String getSupplierName() {
        return supplierName;
    }
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    public boolean getIsExpired() {
        return isExpired;
    }
    public void setIsExpired(boolean isExpired) {
        this.isExpired = isExpired;
    }
    public String getNotes() {
        return notes;
    }
    public void setNotes(String notes) {
        this.notes = notes;
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

    @Override
    public String toString() {
        return "RawFlower{" +
               "rawFlowerId=" + rawFlowerId +
               ", rawFlowerName='" + rawFlowerName + '\'' +
               ", quantity=" + quantity +
               ", unitPrice=" + unitPrice +
               ", importDate=" + importDate +
               ", expiryDate=" + expiryDate +
               ", supplierName='" + supplierName + '\'' +
               ", isExpired=" + isExpired +
               ", notes='" + notes + '\'' +
               '}';
    }
}
