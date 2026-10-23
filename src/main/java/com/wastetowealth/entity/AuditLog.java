package com.wastetowealth.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "audit_logs")
public class AuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "actor_user_id")
    private Long actorUserId;

    @Column(name = "action", nullable = false, length = 100)
    private String action;

    @Column(name = "entity_type", length = 50)
    private String entityType;

    @Column(name = "entity_id")
    private Long entityId;

    @Column(name = "timestamp")
    private LocalDateTime timestamp;

    @Column(name = "safe_metadata", columnDefinition = "TEXT")
    private String safeMetadata;

    @PrePersist
    protected void onCreate() {
        this.timestamp = LocalDateTime.now();
    }

    public AuditLog() {}

    public AuditLog(Long actorUserId, String action, String entityType, Long entityId, String safeMetadata) {
        this.actorUserId = actorUserId;
        this.action = action;
        this.entityType = entityType;
        this.entityId = entityId;
        this.safeMetadata = safeMetadata;
    }

    public Long getId() { return id; }
    public Long getActorUserId() { return actorUserId; }
    public String getAction() { return action; }
    public String getEntityType() { return entityType; }
    public Long getEntityId() { return entityId; }
    public LocalDateTime getTimestamp() { return timestamp; }
    public String getSafeMetadata() { return safeMetadata; }
}
