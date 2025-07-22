package Model;
import java.sql.Timestamp;

public class FlowerRequest {
    private int requestId;
    private int customerId;
    private String imageUrl;
    private String description;
    private String colorPreference;
    private String eventType;
    private String note;
    private String status;
    private String sampleImageUrl;
    private String shopReply;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private java.math.BigDecimal suggestedPrice;
    private String customerName;
    private int quantity;

    // Getters and setters
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getColorPreference() { return colorPreference; }
    public void setColorPreference(String colorPreference) { this.colorPreference = colorPreference; }
    public String getEventType() { return eventType; }
    public void setEventType(String eventType) { this.eventType = eventType; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getSampleImageUrl() { return sampleImageUrl; }
    public void setSampleImageUrl(String sampleImageUrl) { this.sampleImageUrl = sampleImageUrl; }
    public String getShopReply() { return shopReply; }
    public void setShopReply(String shopReply) { this.shopReply = shopReply; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    public java.math.BigDecimal getSuggestedPrice() { return suggestedPrice; }
    public void setSuggestedPrice(java.math.BigDecimal suggestedPrice) { this.suggestedPrice = suggestedPrice; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
} 