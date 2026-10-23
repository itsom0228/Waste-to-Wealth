package com.wastetowealth.controller;

import com.wastetowealth.dto.MarketplaceListingDto;
import com.wastetowealth.service.MarketplaceService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Controller handling the public marketplace directory and listing detail views.
 */
@Controller
@RequestMapping("/marketplace")
public class MarketplaceController {

    private final MarketplaceService marketplaceService;

    public MarketplaceController(MarketplaceService marketplaceService) {
        this.marketplaceService = marketplaceService;
    }

    @GetMapping
    public String browseMarketplace(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "district", required = false) String district,
            @RequestParam(value = "maxPrice", required = false) BigDecimal maxPrice,
            @RequestParam(value = "sortBy", required = false, defaultValue = "newest") String sortBy,
            Model model) {

        List<MarketplaceListingDto> results = marketplaceService.searchListings(keyword, category, district, maxPrice, sortBy);

        model.addAttribute("pageTitle", "Agricultural Waste Marketplace — Waste to Wealth");
        model.addAttribute("activeNav", "marketplace");
        model.addAttribute("listings", results);
        model.addAttribute("categories", marketplaceService.getAllCategories());
        model.addAttribute("districts", marketplaceService.getAllDistricts());

        // Echo current filters
        model.addAttribute("currentKeyword", keyword);
        model.addAttribute("currentCategory", category);
        model.addAttribute("currentDistrict", district);
        model.addAttribute("currentMaxPrice", maxPrice);
        model.addAttribute("currentSortBy", sortBy);
        model.addAttribute("totalResults", results.size());

        return "marketplace/index";
    }

    @GetMapping("/listing/{id}")
    public String viewListingDetail(@PathVariable("id") Long id, Model model) {
        Optional<MarketplaceListingDto> listingOpt = marketplaceService.getListingById(id);

        if (listingOpt.isEmpty()) {
            model.addAttribute("pageTitle", "Listing Not Found — Waste to Wealth");
            model.addAttribute("errorMessage", "The agricultural waste listing you requested could not be found or has expired.");
            return "error/404";
        }

        MarketplaceListingDto listing = listingOpt.get();
        model.addAttribute("pageTitle", listing.getTitle() + " — Waste to Wealth");
        model.addAttribute("activeNav", "marketplace");
        model.addAttribute("listing", listing);

        return "marketplace/detail";
    }
}
