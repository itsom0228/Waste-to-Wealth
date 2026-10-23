package com.wastetowealth.service;

import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.enums.RequestStatus;

import java.math.BigDecimal;
import java.util.List;

public interface PurchaseRequestService {

    PurchaseRequest createPurchaseRequest(Long listingId, String buyerEmail, BigDecimal quantity, String message, String deliveryPreference, BigDecimal advanceAmount, String upiRefId);

    PurchaseRequest updateRequestStatus(Long requestId, String userEmail, RequestStatus newStatus);

    List<PurchaseRequest> getRequestsForFarmer(String farmerEmail);

    List<PurchaseRequest> getRequestsForBuyer(String buyerEmail);

    long countPendingRequestsForFarmer(String farmerEmail);
}
