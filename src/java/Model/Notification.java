package Model;

import java.sql.Timestamp;

public class Notification {
    private int notificationId;
    private int userId;
    private String content;
    private boolean isRead;
    private Timestamp createdAt;
    private Integer relatedRequestId;

    public int getNotificationId() { return notificationId; }
    public void setNotificationId(int notificationId) { this.notificationId = notificationId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public boolean isRead() { return isRead; }
    public void setIsRead(boolean isRead) { this.isRead = isRead; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Integer getRelatedRequestId() { return relatedRequestId; }
    public void setRelatedRequestId(Integer relatedRequestId) { this.relatedRequestId = relatedRequestId; }
} 