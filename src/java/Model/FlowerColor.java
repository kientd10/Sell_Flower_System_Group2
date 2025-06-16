package Model;

import java.sql.Timestamp;

/**
 * Model class representing a flower color in the system.
 */
public class FlowerColor {
    private int colorId;
    private String colorName;
    private String colorCode;
    private Timestamp createdAt;

    public FlowerColor() {
    }

    // Full-args constructor
    public FlowerColor(int colorId, String colorName, String colorCode, Timestamp createdAt) {
        this.colorId = colorId;
        this.colorName = colorName;
        this.colorCode = colorCode;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getColorCode() {
        return colorCode;
    }

    public void setColorCode(String colorCode) {
        this.colorCode = colorCode;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
