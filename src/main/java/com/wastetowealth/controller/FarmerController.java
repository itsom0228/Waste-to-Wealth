package com.wastetowealth.controller;

import com.wastetowealth.entity.FarmerProfile;
import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.entity.WasteType;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.enums.RequestStatus;
import com.wastetowealth.repository.FarmerProfileRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.repository.WasteListingRepository;
import com.wastetowealth.repository.WasteTypeRepository;
import com.wastetowealth.service.PurchaseRequestService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Controller for Farmer operations: Dashboard, Post Farm Waste, and Purchase Orders management.
 */
@Controller
@RequestMapping("/farmer")
public class FarmerController {

    private final UserRepository userRepository;
    private final FarmerProfileRepository farmerProfileRepository;
    private final WasteListingRepository wasteListingRepository;
    private final WasteTypeRepository wasteTypeRepository;
    private final PurchaseRequestService purchaseRequestService;

    public FarmerController(UserRepository userRepository,
                            FarmerProfileRepository farmerProfileRepository,
                            WasteListingRepository wasteListingRepository,
                            WasteTypeRepository wasteTypeRepository,
                            PurchaseRequestService purchaseRequestService) {
        this.userRepository = userRepository;
        this.farmerProfileRepository = farmerProfileRepository;
        this.wasteListingRepository = wasteListingRepository;
        this.wasteTypeRepository = wasteTypeRepository;
        this.purchaseRequestService = purchaseRequestService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication, Model model) {
        String email = authentication.getName();
        Optional<User> userOpt = userRepository.findByEmailIgnoreCase(email);

        if (userOpt.isEmpty()) {
            return "redirect:/login";
        }

        User farmer = userOpt.get();
        FarmerProfile profile = farmerProfileRepository.findByUser(farmer).orElse(null);
        List<WasteListing> myListings = wasteListingRepository.findByFarmer(farmer);
        List<PurchaseRequest> incomingRequests = purchaseRequestService.getRequestsForFarmer(farmer.getEmail());
        List<WasteType> wasteTypes = wasteTypeRepository.findByActiveTrue();

        double totalQuantity = myListings.stream()
                .mapToDouble(l -> l.getAvailableQuantity() != null ? l.getAvailableQuantity().doubleValue() : 0.0)
                .sum();

        long pendingRequestsCount = incomingRequests.stream()
                .filter(r -> r.getRequestStatus() == RequestStatus.PENDING)
                .count();

        model.addAttribute("pageTitle", "Farmer Dashboard — Waste to Wealth");
        model.addAttribute("farmer", farmer);
        model.addAttribute("profile", profile);
        model.addAttribute("myListings", myListings);
        model.addAttribute("totalListings", myListings.size());
        model.addAttribute("totalQuantity", totalQuantity);
        model.addAttribute("incomingRequests", incomingRequests);
        model.addAttribute("pendingRequestsCount", pendingRequestsCount);
        model.addAttribute("wasteTypes", wasteTypes);

        return "farmer/dashboard";
    }

    @PostMapping("/listings/create")
    public String createListing(
            @RequestParam("wasteTypeId") Long wasteTypeId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("quantity") BigDecimal quantity,
            @RequestParam(value = "unit", defaultValue = "Tons") String unit,
            @RequestParam("pricePerUnit") BigDecimal pricePerUnit,
            @RequestParam(value = "district", required = false) String district,
            @RequestParam(value = "village", required = false) String village,
            @RequestParam(value = "upiId", required = false) String upiId,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        String email = authentication.getName();
        Optional<User> userOpt = userRepository.findByEmailIgnoreCase(email);
        if (userOpt.isEmpty()) {
            return "redirect:/login";
        }
        User farmer = userOpt.get();

        WasteType wasteType = wasteTypeRepository.findById(wasteTypeId)
                .orElse(wasteTypeRepository.findByActiveTrue().get(0));

        WasteListing listing = new WasteListing();
        listing.setFarmer(farmer);
        listing.setWasteType(wasteType);
        listing.setTitle(title.trim());
        listing.setDescription(description.trim());
        listing.setAvailableQuantity(quantity);
        listing.setUnit(unit);
        listing.setPricePerUnit(pricePerUnit);

        String dist = (district != null && !district.isBlank()) ? district.trim() : (farmer.getDistrict() != null ? farmer.getDistrict() : "Maharashtra");
        String vill = (village != null && !village.isBlank()) ? village.trim() : (farmer.getVillage() != null ? farmer.getVillage() : "Farm Cluster");
        listing.setDistrict(dist);
        listing.setVillage(vill);
        listing.setLocation(vill + ", " + dist);
        listing.setState(farmer.getState() != null ? farmer.getState() : "Maharashtra");
        listing.setPostalCode(farmer.getPostalCode() != null ? farmer.getPostalCode() : "411001");
        listing.setListingStatus(ListingStatus.ACTIVE);
        listing.setAvailableFrom(LocalDate.now());

        String finalUpi = (upiId != null && !upiId.isBlank()) ? upiId.trim() : (farmer.getMobileNumber() + "@upi");
        listing.setUpiId(finalUpi);

        // Assign suitable default image based on waste type
        String lowerName = wasteType.getName().toLowerCase();
        if (lowerName.contains("sugarcane")) {
            listing.setImagePath("/images/sugarcane_trash.jpg");
        } else if (lowerName.contains("bales") || lowerName.contains("paddy") || lowerName.contains("rice")) {
            listing.setImagePath("/images/farm_bales.jpg");
        } else {
            listing.setImagePath("/images/farmer_hero.jpg");
        }

        wasteListingRepository.save(listing);

        redirectAttributes.addFlashAttribute("successMessage", "Crop residue lot '" + title + "' successfully posted! It is now live for buyers across the marketplace.");
        return "redirect:/farmer/dashboard?posted=true";
    }

    @PostMapping("/requests/{id}/accept")
    public String acceptRequest(@PathVariable("id") Long id,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        try {
            purchaseRequestService.updateRequestStatus(id, authentication.getName(), RequestStatus.ACCEPTED);
            redirectAttributes.addFlashAttribute("successMessage", "Purchase request #" + id + " ACCEPTED! Buyer contact details have been unlocked.");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/farmer/dashboard";
    }

    @PostMapping("/requests/{id}/reject")
    public String rejectRequest(@PathVariable("id") Long id,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        try {
            purchaseRequestService.updateRequestStatus(id, authentication.getName(), RequestStatus.REJECTED);
            redirectAttributes.addFlashAttribute("successMessage", "Purchase request #" + id + " has been rejected.");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/farmer/dashboard";
    }
}
