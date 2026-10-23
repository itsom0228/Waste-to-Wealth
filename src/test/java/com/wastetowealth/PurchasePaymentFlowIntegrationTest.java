package com.wastetowealth;

import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.entity.WasteType;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.enums.RequestStatus;
import com.wastetowealth.repository.PurchaseRequestRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.repository.WasteListingRepository;
import com.wastetowealth.repository.WasteTypeRepository;
import com.wastetowealth.service.PurchaseRequestService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("dev")
@Transactional
class PurchasePaymentFlowIntegrationTest {

    @Autowired
    private PurchaseRequestService purchaseRequestService;

    @Autowired
    private WasteListingRepository wasteListingRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private WasteTypeRepository wasteTypeRepository;

    @Autowired
    private PurchaseRequestRepository purchaseRequestRepository;

    @Test
    @DisplayName("Farmer posts listing with UPI ID, Buyer pays advance, and listing quantity is subtracted")
    void testFarmerListingAndBuyerAdvancePaymentStockDeduction() {
        // 1. Fetch existing seeded farmer
        User farmer = userRepository.findByEmailIgnoreCase("farmer@wastetowealth.com")
                .orElseThrow(() -> new IllegalStateException("Default farmer not found"));

        // 2. Fetch existing seeded category
        WasteType wasteType = wasteTypeRepository.findAll().stream().findFirst()
                .orElseThrow(() -> new IllegalStateException("No waste types seeded"));

        // 3. Farmer creates a new waste listing with UPI ID and initial stock of 100 Tons
        WasteListing listing = new WasteListing();
        listing.setFarmer(farmer);
        listing.setWasteType(wasteType);
        listing.setTitle("Fresh Bio-Baled Sugarcane Trash");
        listing.setDescription("High caloric value dry agricultural residue");
        listing.setAvailableQuantity(new BigDecimal("100.00"));
        listing.setUnit("Tons");
        listing.setPricePerUnit(new BigDecimal("1500.00"));
        listing.setDistrict("Kolhapur");
        listing.setState("Maharashtra");
        listing.setListingStatus(ListingStatus.ACTIVE);
        listing.setUpiId("farmer.patil@oksbi"); // Farmer specifies their UPI ID
        listing = wasteListingRepository.save(listing);

        assertNotNull(listing.getId());
        assertEquals("farmer.patil@oksbi", listing.getUpiId());
        assertEquals(new BigDecimal("100.00"), listing.getAvailableQuantity());

        // 4. Buyer purchases 30 Tons with 20% advance payment (₹9,000 out of ₹45,000 total)
        String buyerEmail = "buyer@wastetowealth.com";
        BigDecimal purchaseQuantity = new BigDecimal("30.00");
        BigDecimal advancePayment = new BigDecimal("9000.00");
        String utrReference = "UPI-SBI-202610230001";

        PurchaseRequest order = purchaseRequestService.createPurchaseRequest(
                listing.getId(),
                buyerEmail,
                purchaseQuantity,
                "Need 30 tons delivered or gate pickup by next Monday",
                "Farm Gate Pickup",
                advancePayment,
                utrReference
        );

        // 5. Verify Purchase Request Details
        assertNotNull(order.getId());
        assertEquals(RequestStatus.PENDING, order.getRequestStatus());
        assertEquals("ADVANCE_PAID", order.getPaymentStatus());
        assertEquals(0, new BigDecimal("9000.00").compareTo(order.getAdvanceAmount()));
        assertEquals(utrReference, order.getUpiRefId());
        assertEquals(0, new BigDecimal("45000.00").compareTo(order.getTotalAmount()));

        // 6. Verify Listing Inventory is automatically subtracted (minus)
        WasteListing updatedListing = wasteListingRepository.findById(listing.getId()).orElseThrow();
        assertEquals(0, new BigDecimal("70.00").compareTo(updatedListing.getAvailableQuantity()),
                "Listing inventory must be reduced by 30 tons (100 - 30 = 70 tons)");
        assertEquals(ListingStatus.ACTIVE, updatedListing.getListingStatus());

        // 7. Buyer purchases the remaining 70 Tons
        PurchaseRequest secondOrder = purchaseRequestService.createPurchaseRequest(
                listing.getId(),
                buyerEmail,
                new BigDecimal("70.00"),
                "Buying remaining stock",
                "Farmer Delivery",
                new BigDecimal("21000.00"),
                "UPI-HDFC-9988776655"
        );

        // 8. Verify Listing status transitions to SOLD when quantity reaches 0
        WasteListing soldListing = wasteListingRepository.findById(listing.getId()).orElseThrow();
        assertEquals(0, BigDecimal.ZERO.compareTo(soldListing.getAvailableQuantity()),
                "Listing inventory should be 0");
        assertEquals(ListingStatus.SOLD, soldListing.getListingStatus(),
                "Listing should automatically transition to SOLD when quantity reaches zero");

        // 9. Farmer accepts the first order
        PurchaseRequest accepted = purchaseRequestService.updateRequestStatus(order.getId(), farmer.getEmail(), RequestStatus.ACCEPTED);
        assertEquals(RequestStatus.ACCEPTED, accepted.getRequestStatus());
    }
}
