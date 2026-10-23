package com.wastetowealth.controller;

import com.wastetowealth.dto.UserRegistrationDto;
import com.wastetowealth.entity.AuditLog;
import com.wastetowealth.entity.PurchaseRequest;
import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.enums.AccountStatus;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.enums.Role;
import com.wastetowealth.repository.AuditLogRepository;
import com.wastetowealth.repository.PurchaseRequestRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.repository.WasteListingRepository;
import com.wastetowealth.service.UserService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Controller for Admin Operations & Platform Governance:
 * Add, edit, update, delete Farmers and Buyers; manage listings; view orders and logs.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserRepository userRepository;
    private final WasteListingRepository wasteListingRepository;
    private final PurchaseRequestRepository purchaseRequestRepository;
    private final AuditLogRepository auditLogRepository;
    private final UserService userService;

    public AdminController(UserRepository userRepository,
                           WasteListingRepository wasteListingRepository,
                           PurchaseRequestRepository purchaseRequestRepository,
                           AuditLogRepository auditLogRepository,
                           UserService userService) {
        this.userRepository = userRepository;
        this.wasteListingRepository = wasteListingRepository;
        this.purchaseRequestRepository = purchaseRequestRepository;
        this.auditLogRepository = auditLogRepository;
        this.userService = userService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication, Model model) {
        long totalUsers = userRepository.count();
        long totalFarmers = userRepository.countByRole(Role.FARMER);
        long totalBuyers = userRepository.countByRole(Role.BUYER);
        long activeListings = wasteListingRepository.countByListingStatus(ListingStatus.ACTIVE);
        long totalOrders = purchaseRequestRepository.count();

        List<User> allUsers = userRepository.findAll(Sort.by(Sort.Direction.DESC, "createdAt"));
        List<WasteListing> allListings = wasteListingRepository.findAll(Sort.by(Sort.Direction.DESC, "createdAt"));
        List<PurchaseRequest> allOrders = purchaseRequestRepository.findAll(Sort.by(Sort.Direction.DESC, "createdAt"));
        List<AuditLog> recentAuditLogs = auditLogRepository.findAll(
                PageRequest.of(0, 20, Sort.by(Sort.Direction.DESC, "timestamp"))
        ).getContent();

        model.addAttribute("pageTitle", "Admin Control Center — Waste to Wealth");
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalFarmers", totalFarmers);
        model.addAttribute("totalBuyers", totalBuyers);
        model.addAttribute("activeListings", activeListings);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("allUsers", allUsers);
        model.addAttribute("allListings", allListings);
        model.addAttribute("allOrders", allOrders);
        model.addAttribute("auditLogs", recentAuditLogs);

        return "admin/dashboard";
    }

    // --- USER CRUD OPERATIONS (Farmer / Buyer) ---

    @PostMapping("/users/create")
    public String createUser(
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("mobileNumber") String mobileNumber,
            @RequestParam("password") String password,
            @RequestParam(value = "role", defaultValue = "FARMER") String role,
            @RequestParam(value = "district", required = false) String district,
            @RequestParam(value = "village", required = false) String village,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        try {
            UserRegistrationDto dto = new UserRegistrationDto();
            dto.setFullName(fullName);
            dto.setEmail(email);
            dto.setMobileNumber(mobileNumber);
            dto.setPassword(password);
            dto.setRole(role.toUpperCase());
            dto.setDistrict(district);
            dto.setVillage(village);

            userService.registerUser(dto);
            redirectAttributes.addFlashAttribute("successMessage", "New user '" + fullName + "' (" + role + ") successfully added to platform!");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add user: " + ex.getMessage());
        }
        return "redirect:/admin/dashboard#usersTab";
    }

    @PostMapping("/users/{id}/update")
    @Transactional
    public String updateUser(
            @PathVariable("id") Long id,
            @RequestParam("fullName") String fullName,
            @RequestParam("mobileNumber") String mobileNumber,
            @RequestParam("role") String role,
            @RequestParam("accountStatus") String accountStatus,
            @RequestParam(value = "district", required = false) String district,
            @RequestParam(value = "village", required = false) String village,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "User not found with ID: " + id);
            return "redirect:/admin/dashboard#usersTab";
        }

        User user = userOpt.get();
        user.setFullName(fullName.trim());
        user.setMobileNumber(mobileNumber.trim());
        try {
            user.setRole(Role.valueOf(role.toUpperCase()));
        } catch (Exception ignored) {}
        try {
            user.setAccountStatus(AccountStatus.valueOf(accountStatus.toUpperCase()));
        } catch (Exception ignored) {}
        user.setDistrict(district);
        user.setVillage(village);

        userRepository.save(user);

        redirectAttributes.addFlashAttribute("successMessage", "User '" + fullName + "' (ID: " + id + ") updated successfully!");
        return "redirect:/admin/dashboard#usersTab";
    }

    @PostMapping("/users/{id}/delete")
    @Transactional
    public String deleteUser(
            @PathVariable("id") Long id,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "User not found.");
            return "redirect:/admin/dashboard#usersTab";
        }

        User user = userOpt.get();
        // Prevent deleting oneself
        if (user.getEmail().equalsIgnoreCase(authentication.getName())) {
            redirectAttributes.addFlashAttribute("errorMessage", "You cannot delete your own logged-in administrator account!");
            return "redirect:/admin/dashboard#usersTab";
        }

        String name = user.getFullName();
        userRepository.delete(user);

        redirectAttributes.addFlashAttribute("successMessage", "User '" + name + "' (ID: " + id + ") permanently deleted.");
        return "redirect:/admin/dashboard#usersTab";
    }

    // --- LISTING CRUD OPERATIONS ---

    @PostMapping("/listings/{id}/update")
    @Transactional
    public String updateListing(
            @PathVariable("id") Long id,
            @RequestParam("pricePerUnit") BigDecimal pricePerUnit,
            @RequestParam("availableQuantity") BigDecimal availableQuantity,
            @RequestParam("listingStatus") String listingStatus,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        Optional<WasteListing> listingOpt = wasteListingRepository.findById(id);
        if (listingOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Listing not found with ID: " + id);
            return "redirect:/admin/dashboard#listingsTab";
        }

        WasteListing listing = listingOpt.get();
        listing.setPricePerUnit(pricePerUnit);
        listing.setAvailableQuantity(availableQuantity);
        try {
            listing.setListingStatus(ListingStatus.valueOf(listingStatus.toUpperCase()));
        } catch (Exception ignored) {}

        wasteListingRepository.save(listing);

        redirectAttributes.addFlashAttribute("successMessage", "Listing #" + id + " updated successfully!");
        return "redirect:/admin/dashboard#listingsTab";
    }

    @PostMapping("/listings/{id}/delete")
    @Transactional
    public String deleteListing(
            @PathVariable("id") Long id,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        if (wasteListingRepository.existsById(id)) {
            wasteListingRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Listing #" + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Listing not found.");
        }
        return "redirect:/admin/dashboard#listingsTab";
    }
}
