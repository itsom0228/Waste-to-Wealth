package com.wastetowealth.service.impl;

import com.wastetowealth.entity.AuditLog;
import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.enums.RequestStatus;
import com.wastetowealth.repository.AuditLogRepository;
import com.wastetowealth.repository.PurchaseRequestRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.repository.WasteListingRepository;
import com.wastetowealth.service.PurchaseRequestService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

@Service
public class PurchaseRequestServiceImpl implements PurchaseRequestService {

    private final PurchaseRequestRepository purchaseRequestRepository;
    private final WasteListingRepository wasteListingRepository;
    private final UserRepository userRepository;
    private final AuditLogRepository auditLogRepository;

    public PurchaseRequestServiceImpl(PurchaseRequestRepository purchaseRequestRepository,
                                      WasteListingRepository wasteListingRepository,
                                      UserRepository userRepository,
                                      AuditLogRepository auditLogRepository) {
        this.purchaseRequestRepository = purchaseRequestRepository;
        this.wasteListingRepository = wasteListingRepository;
        this.userRepository = userRepository;
        this.auditLogRepository = auditLogRepository;
    }

    @Override
    @Transactional
    public PurchaseRequest createPurchaseRequest(Long listingId, String buyerEmail, BigDecimal quantity, String message, String deliveryPreference, BigDecimal advanceAmount, String upiRefId) {
        WasteListing listing = wasteListingRepository.findById(listingId)
                .orElseThrow(() -> new IllegalArgumentException("Waste listing not found with ID: " + listingId));

        User buyer = userRepository.findByEmailIgnoreCase(buyerEmail)
                .orElseThrow(() -> new IllegalArgumentException("Buyer account not found"));

        if (quantity == null || quantity.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than zero");
        }

        if (listing.getAvailableQuantity() != null && quantity.compareTo(listing.getAvailableQuantity()) > 0) {
            throw new IllegalArgumentException("Requested quantity (" + quantity + ") exceeds available farm lot quantity (" + listing.getAvailableQuantity() + ")");
        }

        BigDecimal unitPrice = listing.getPricePerUnit() != null ? listing.getPricePerUnit() : BigDecimal.ZERO;
        BigDecimal total = unitPrice.multiply(quantity);

        // Deduct purchased quantity from the listing inventory
        BigDecimal remainingQuantity = listing.getAvailableQuantity().subtract(quantity);
        listing.setAvailableQuantity(remainingQuantity);
        if (remainingQuantity.compareTo(BigDecimal.ZERO) <= 0) {
            listing.setListingStatus(ListingStatus.SOLD);
        }
        wasteListingRepository.save(listing);

        PurchaseRequest request = new PurchaseRequest();
        request.setListing(listing);
        request.setFarmer(listing.getFarmer());
        request.setBuyer(buyer);
        request.setQuantity(quantity);
        request.setUnit(listing.getUnit() != null ? listing.getUnit() : "Tons");
        request.setOfferedPricePerUnit(unitPrice);
        request.setTotalAmount(total);
        request.setRequestStatus(RequestStatus.PENDING);
        request.setMessage(message != null ? message.trim() : "");
        request.setDeliveryPreference(deliveryPreference != null ? deliveryPreference : "Farm Gate Pickup");

        // Advance payment tracking
        if (advanceAmount != null && advanceAmount.compareTo(BigDecimal.ZERO) > 0) {
            request.setAdvanceAmount(advanceAmount);
            request.setPaymentStatus("ADVANCE_PAID");
        } else {
            // Default 20% advance booking
            BigDecimal defaultAdvance = total.multiply(BigDecimal.valueOf(0.20));
            request.setAdvanceAmount(defaultAdvance);
            request.setPaymentStatus("ADVANCE_PAID");
        }
        request.setUpiRefId((upiRefId != null && !upiRefId.isBlank()) ? upiRefId.trim() : "UPI-TXN-" + System.currentTimeMillis());

        PurchaseRequest saved = purchaseRequestRepository.save(request);

        auditLogRepository.save(new AuditLog(
                buyer.getId(),
                "PURCHASE_REQUEST_CREATED",
                "PurchaseRequest",
                saved.getId(),
                "Buyer " + buyer.getEmail() + " paid advance ₹" + request.getAdvanceAmount() + " (UTR: " + request.getUpiRefId() + ") for " + quantity + " " + request.getUnit() + ". Remaining listing inventory: " + remainingQuantity
        ));

        return saved;
    }

    @Override
    @Transactional
    public PurchaseRequest updateRequestStatus(Long requestId, String userEmail, RequestStatus newStatus) {
        PurchaseRequest request = purchaseRequestRepository.findById(requestId)
                .orElseThrow(() -> new IllegalArgumentException("Purchase request not found with ID: " + requestId));

        User user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Only the assigned farmer or admin can update status
        boolean isFarmer = request.getFarmer() != null && request.getFarmer().getId().equals(user.getId());
        boolean isAdmin = user.getRole() != null && user.getRole().name().equals("ADMIN");

        if (!isFarmer && !isAdmin) {
            throw new IllegalArgumentException("You are not authorized to update this purchase request.");
        }

        request.setRequestStatus(newStatus);
        PurchaseRequest updated = purchaseRequestRepository.save(request);

        auditLogRepository.save(new AuditLog(
                user.getId(),
                "PURCHASE_REQUEST_STATUS_UPDATED",
                "PurchaseRequest",
                updated.getId(),
                "Status changed to " + newStatus + " by " + user.getEmail()
        ));

        return updated;
    }

    @Override
    public List<PurchaseRequest> getRequestsForFarmer(String farmerEmail) {
        return userRepository.findByEmailIgnoreCase(farmerEmail)
                .map(purchaseRequestRepository::findByFarmerOrderByCreatedAtDesc)
                .orElse(Collections.emptyList());
    }

    @Override
    public List<PurchaseRequest> getRequestsForBuyer(String buyerEmail) {
        return userRepository.findByEmailIgnoreCase(buyerEmail)
                .map(purchaseRequestRepository::findByBuyerOrderByCreatedAtDesc)
                .orElse(Collections.emptyList());
    }

    @Override
    public long countPendingRequestsForFarmer(String farmerEmail) {
        return userRepository.findByEmailIgnoreCase(farmerEmail)
                .map(u -> purchaseRequestRepository.countByFarmerAndRequestStatus(u, RequestStatus.PENDING))
                .orElse(0L);
    }
}
