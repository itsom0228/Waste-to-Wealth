package com.wastetowealth.repository;

import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.entity.User;
import com.wastetowealth.enums.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PurchaseRequestRepository extends JpaRepository<PurchaseRequest, Long> {

    List<PurchaseRequest> findByFarmerOrderByCreatedAtDesc(User farmer);

    List<PurchaseRequest> findByBuyerOrderByCreatedAtDesc(User buyer);

    long countByFarmerAndRequestStatus(User farmer, RequestStatus requestStatus);

    long countByBuyerAndRequestStatus(User buyer, RequestStatus requestStatus);
}
