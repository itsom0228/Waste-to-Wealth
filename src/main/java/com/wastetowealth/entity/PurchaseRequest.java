package com.wastetowealth.entity;

import com.wastetowealth.enums.RequestStatus;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "purchase_requests")
public class PurchaseRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "listing_id", nullable = false)
    private WasteListing listing;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "farmer_id", nullable = false)
    private User farmer;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "buyer_id", nullable = false)
    private User buyer;

    @Column(name = "quantity", nullable = false, precision = 12, scale = 2)
    private BigDecimal quantity;

    @Column(name = "unit", nullable = false, length = 20)
    private String unit = "Tons";

    @Column(name = "offered_price_per_unit", nullable = false, precision = 12, scale = 2)
    private BigDecimal offeredPricePerUnit;

    @Column(name = "total_amount", nullable = false, precision = 12, scale = 2)
    private BigDecimal totalAmount;

    @Enumerated(EnumType.STRING)
    @Column(name = "request_status", nullable = false, length = 30)
    private RequestStatus requestStatus = RequestStatus.PENDING;

    @Column(name = "message", columnDefinition = "TEXT")
    private String message;

    @Column(name = "delivery_preference", length = 100)
    private String deliveryPreference = "Farm Gate Pickup";

    @Column(name = "advance_amount", precision = 12, scale = 2)
    private BigDecimal advanceAmount = BigDecimal.ZERO;

    @Column(name = "upi_ref_id", length = 100)
    private String upiRefId;

    @Column(name = "payment_status", length = 30)
    private String paymentStatus = "ADVANCE_PAID";

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    public PurchaseRequest() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public WasteListing getListing() { return listing; }
    public void setListing(WasteListing listing) { this.listing = listing; }

    public User getFarmer() { return farmer; }
    public void setFarmer(User farmer) { this.farmer = farmer; }

    public User getBuyer() { return buyer; }
    public void setBuyer(User buyer) { this.buyer = buyer; }

    public BigDecimal getQuantity() { return quantity; }
    public void setQuantity(BigDecimal quantity) { this.quantity = quantity; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public BigDecimal getOfferedPricePerUnit() { return offeredPricePerUnit; }
    public void setOfferedPricePerUnit(BigDecimal offeredPricePerUnit) { this.offeredPricePerUnit = offeredPricePerUnit; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public RequestStatus getRequestStatus() { return requestStatus; }
    public void setRequestStatus(RequestStatus requestStatus) { this.requestStatus = requestStatus; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getDeliveryPreference() { return deliveryPreference; }
    public void setDeliveryPreference(String deliveryPreference) { this.deliveryPreference = deliveryPreference; }

    public BigDecimal getAdvanceAmount() { return advanceAmount; }
    public void setAdvanceAmount(BigDecimal advanceAmount) { this.advanceAmount = advanceAmount; }

    public String getUpiRefId() { return upiRefId; }
    public void setUpiRefId(String upiRefId) { this.upiRefId = upiRefId; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
