package model;

import java.time.LocalDateTime;

/**
 * Represents a user in the system, mapping to the `users` table. Fields
 * correspond to columns in the database schema.
 */
public class User {

    private int UserId;
    private String Username;
    private String Email;
    private String PasswordHash;
    private String FullName;
    private String Phone;
    private String Address;
    private int RoleId;
    private boolean IsActive;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    /**
     * Default constructor.
     */
    public User() {
    }

    public User(int UserId, String Username, String Email, String PasswordHash, String FullName, String Phone, String Address, int RoleId, boolean IsActive, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.UserId = UserId;
        this.Username = Username;
        this.Email = Email;
        this.PasswordHash = PasswordHash;
        this.FullName = FullName;
        this.Phone = Phone;
        this.Address = Address;
        this.RoleId = RoleId;
        this.IsActive = IsActive;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }

    public int getUserId() {
        return UserId;
    }

    public void setUserId(int UserId) {
        this.UserId = UserId;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPasswordHash() {
        return PasswordHash;
    }

    public void setPasswordHash(String PasswordHash) {
        this.PasswordHash = PasswordHash;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public int getRoleId() {
        return RoleId;
    }

    public void setRoleId(int RoleId) {
        this.RoleId = RoleId;
    }

    public boolean isIsActive() {
        return IsActive;
    }

    public void setIsActive(boolean IsActive) {
        this.IsActive = IsActive;
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
