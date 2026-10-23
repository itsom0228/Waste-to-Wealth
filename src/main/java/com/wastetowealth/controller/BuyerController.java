package com.wastetowealth.controller;

import com.wastetowealth.entity.BuyerProfile;
import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.repository.BuyerProfileRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.repository.WasteListingRepository;
import com.wastetowealth.service.PurchaseRequestService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Controller for Buyer operations: Dashboard, Browse Lots, and Purchase Requests.
 */
@Controller
@RequestMapping("/buyer")
public class BuyerController {

    private final UserRepository userRepository;
    private final BuyerProfileRepository buyerProfileRepository;
    private final WasteListingRepository wasteListingRepository;
    private final PurchaseRequestService purchaseRequestService;

    public BuyerController(UserRepository userRepository,
                           BuyerProfileRepository buyerProfileRepository,
                           WasteListingRepository wasteListingRepository,
                           PurchaseRequestService purchaseRequestService) {
        this.userRepository = userRepository;
        this.buyerProfileRepository = buyerProfileRepository;
        this.wasteListingRepository = wasteListingRepository;
        this.purchaseRequestService = purchaseRequestService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication, Model model) {
        String email = authentication.getName();
        Optional<User> userOpt = userRepository.findByEmailIgnoreCase(email);

        if (userOpt.isEmpty()) {
            return "redirect:/login";
        }

        User buyer = userOpt.get();
        BuyerProfile profile = buyerProfileRepository.findByUser(buyer).orElse(null);
        List<WasteListing> activeListings = wasteListingRepository.findByListingStatus(ListingStatus.ACTIVE);
        List<PurchaseRequest> myRequests = purchaseRequestService.getRequestsForBuyer(buyer.getEmail());

        long activeOrdersCount = myRequests.stream()
                .filter(r -> r.getRequestStatus().name().equals("ACCEPTED") || r.getRequestStatus().name().equals("PENDING"))
                .count();

        model.addAttribute("pageTitle", "Buyer Procurement Dashboard — Waste to Wealth");
        model.addAttribute("buyer", buyer);
        model.addAttribute("profile", profile);
        model.addAttribute("availableListings", activeListings);
        model.addAttribute("totalAvailable", activeListings.size());
        model.addAttribute("myRequests", myRequests);
        model.addAttribute("activeOrdersCount", activeOrdersCount);

        return "buyer/dashboard";
    }

    @PostMapping("/purchase-request/create")
    public String createPurchaseRequest(
            @RequestParam("listingId") Long listingId,
            @RequestParam("quantity") BigDecimal quantity,
            @RequestParam(value = "deliveryPreference", defaultValue = "Farm Gate Pickup") String deliveryPreference,
            @RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "advanceAmount", required = false) BigDecimal advanceAmount,
            @RequestParam(value = "upiRefId", required = false) String upiRefId,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        try {
            PurchaseRequest req = purchaseRequestService.createPurchaseRequest(
                    listingId,
                    authentication.getName(),
                    quantity,
                    message,
                    deliveryPreference,
                    advanceAmount,
                    upiRefId
            );
            redirectAttributes.addFlashAttribute("successMessage",
                    "Advance Payment of ₹" + req.getAdvanceAmount() + " (UTR: " + req.getUpiRefId() +
                    ") registered! Order of " + quantity + " " + req.getUnit() + " placed directly with Farmer " +
                    req.getFarmer().getFullName() + ". Farm lot inventory updated successfully!");
            return "redirect:/buyer/dashboard?ordered=true";
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
            return "redirect:/marketplace/listing/" + listingId + "?error=true";
        }
    }
}
