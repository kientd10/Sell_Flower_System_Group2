/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model;

/**
 *
 * @author PC
 */
import java.util.*;
import java.lang.*;
import java.security.Timestamp;

public class FlowerType {
    private int typeId;
    private String typeName;
    private String description;
    private Timestamp createdAt;

    // Default constructor
    public FlowerType() {
    }

    // Full-args constructor
    public FlowerType(int typeId, String typeName, String description, Timestamp createdAt) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.description = description;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}

