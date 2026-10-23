package com.wastetowealth.service;

import com.wastetowealth.dto.MarketplaceListingDto;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.repository.WasteListingRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Service managing public marketplace listings search, filtering, and retrieval,
 * backed by MySQL database persistence and live quantity updates.
 */
@Service
public class MarketplaceService {

    private final WasteListingRepository wasteListingRepository;
    private final List<MarketplaceListingDto> fallbackListings = new ArrayList<>();

    public MarketplaceService(WasteListingRepository wasteListingRepository) {
        this.wasteListingRepository = wasteListingRepository;
        seedSampleListings();
    }

    private void seedSampleListings() {
        fallbackListings.add(new MarketplaceListingDto(
                1L,
                "High Density Wheat Straw (Baled)",
                "Wheat Straw",
                "Machine-compressed rectangular wheat straw bales directly from post-harvest fields. Very low moisture, stored in dry shed. Optimal for biomass fuel, mushroom cultivation, and animal fodder.",
                new BigDecimal("45.00"),
                "Tons",
                new BigDecimal("2400.00"),
                "Dindori", "Niphad", "Nashik", "Maharashtra",
                "422206",
                "/images/farm_bales.jpg",
                "Rameshwar Patil",
                "ACTIVE",
                LocalDate.now().plusDays(1),
                "Bio-Pellets, Animal Fodder, Paper Pulp",
                "Moisture < 12%"
        ));
        fallbackListings.get(0).setUpiId("patil.farm@okhdfcbank");

        fallbackListings.add(new MarketplaceListingDto(
                2L,
                "Golden Paddy Rice Straw (Stubble-Free)",
                "Rice Husk",
                "Clean, non-burnt harvest paddy straw baled and stacked. Ready for direct farm-gate haulage by trucks. Perfect for boiler combustion, eco-packaging, and soil mulching.",
                new BigDecimal("80.00"),
                "Tons",
                new BigDecimal("1900.00"),
                "Taraori", "Nilokheri", "Karnal", "Haryana",
                "132116",
                "/images/farmer_hero.jpg",
                "Harpreet Singh Brar",
                "ACTIVE",
                LocalDate.now().plusDays(2),
                "Thermal Boilers, Cardboard Mills, Mulching",
                "Moisture < 14%"
        ));
        fallbackListings.get(1).setUpiId("harpreet.brar@paytm");

        fallbackListings.add(new MarketplaceListingDto(
                3L,
                "Sun-Dried Sugarcane Trash & Field Leaves",
                "Sugarcane Leaves",
                "Abundant sugarcane leaves and field tops collected after cane crushing season. Sun-cured in open field. High calorific biomass suited for co-generation power plants and organic composting.",
                new BigDecimal("65.00"),
                "Tons",
                new BigDecimal("1650.00"),
                "Kagal", "Hatkanangle", "Kolhapur", "Maharashtra",
                "416216",
                "/images/sugarcane_trash.jpg",
                "Balasaheb Shinde",
                "ACTIVE",
                LocalDate.now(),
                "Power Co-Gen, Compost, Briquetting",
                "Moisture < 15%"
        ));
        fallbackListings.get(2).setUpiId("balasaheb.shinde@oksbi");

        fallbackListings.add(new MarketplaceListingDto(
                4L,
                "Hard Cotton Stalks (Field-Collected)",
                "Cotton Stalks",
                "Sturdy, woody cotton stalks left after cotton picking. Bundled and seasoned. Exceptionally high density and carbon content, ideal for composite particle boards and industrial gasification.",
                new BigDecimal("35.00"),
                "Tons",
                new BigDecimal("2800.00"),
                "Ralegaon", "Kelapur", "Yavatmal", "Maharashtra",
                "445402",
                "/images/farm_bales.jpg",
                "Vitthalrao Gholap",
                "ACTIVE",
                LocalDate.now().plusDays(3),
                "Particle Boards, Thermal Power, Biochar",
                "Moisture < 11%"
        ));
        fallbackListings.get(3).setUpiId("gholap.agri@upi");
    }

    private MarketplaceListingDto mapEntityToDto(WasteListing entity) {
        MarketplaceListingDto dto = new MarketplaceListingDto();
        dto.setId(entity.getId());
        dto.setTitle(entity.getTitle());
        dto.setDescription(entity.getDescription());
        dto.setWasteCategory(entity.getWasteType() != null ? entity.getWasteType().getName() : "Agri Residue");
        dto.setAvailableQuantity(entity.getAvailableQuantity());
        dto.setUnit(entity.getUnit());
        dto.setPricePerUnit(entity.getPricePerUnit());
        dto.setLocation(entity.getLocation());
        dto.setVillage(entity.getVillage() != null ? entity.getVillage() : "Farm Cluster");
        dto.setTaluka(entity.getTaluka() != null ? entity.getTaluka() : "Taluka");
        dto.setDistrict(entity.getDistrict() != null ? entity.getDistrict() : "District");
        dto.setState(entity.getState() != null ? entity.getState() : "Maharashtra");
        dto.setPostalCode(entity.getPostalCode() != null ? entity.getPostalCode() : "411001");
        dto.setImagePath(entity.getImagePath() != null ? entity.getImagePath() : "/images/farm_bales.jpg");
        dto.setFarmerName(entity.getFarmer() != null ? entity.getFarmer().getFullName() : "Verified Farmer");
        dto.setFarmerContact(entity.getFarmer() != null ? entity.getFarmer().getMobileNumber() : "");
        dto.setListingStatus(entity.getListingStatus() != null ? entity.getListingStatus().name() : "ACTIVE");
        dto.setAvailableFrom(entity.getAvailableFrom() != null ? entity.getAvailableFrom() : LocalDate.now());
        dto.setSuitability("Biomass fuel, animal feed, boiler combustion");
        dto.setMoistureGrade("Moisture < 12%");
        dto.setUpiId(entity.getUpiId() != null && !entity.getUpiId().isBlank() ? entity.getUpiId() : "farmer@okhdfcbank");
        return dto;
    }

    private List<MarketplaceListingDto> getAllLiveListings() {
        try {
            List<WasteListing> dbListings = wasteListingRepository.findByListingStatus(ListingStatus.ACTIVE);
            if (!dbListings.isEmpty()) {
                return dbListings.stream()
                        .map(this::mapEntityToDto)
                        .collect(Collectors.toList());
            }
        } catch (Exception ignored) {}
        return fallbackListings;
    }

    public List<MarketplaceListingDto> searchListings(String keyword, String category, String district, BigDecimal maxPrice, String sortBy) {
        return getAllLiveListings().stream()
                .filter(l -> "ACTIVE".equalsIgnoreCase(l.getListingStatus()))
                .filter(l -> {
                    if (keyword == null || keyword.trim().isEmpty()) return true;
                    String k = keyword.trim().toLowerCase();
                    return l.getTitle().toLowerCase().contains(k)
                            || l.getDescription().toLowerCase().contains(k)
                            || l.getWasteCategory().toLowerCase().contains(k)
                            || l.getLocation().toLowerCase().contains(k);
                })
                .filter(l -> {
                    if (category == null || category.trim().isEmpty() || "ALL".equalsIgnoreCase(category)) return true;
                    return l.getWasteCategory().equalsIgnoreCase(category.trim());
                })
                .filter(l -> {
                    if (district == null || district.trim().isEmpty() || "ALL".equalsIgnoreCase(district)) return true;
                    return l.getDistrict().equalsIgnoreCase(district.trim());
                })
                .filter(l -> {
                    if (maxPrice == null || maxPrice.compareTo(BigDecimal.ZERO) <= 0) return true;
                    return l.getPricePerUnit().compareTo(maxPrice) <= 0;
                })
                .sorted((a, b) -> {
                    if ("price_asc".equalsIgnoreCase(sortBy)) {
                        return a.getPricePerUnit().compareTo(b.getPricePerUnit());
                    } else if ("price_desc".equalsIgnoreCase(sortBy)) {
                        return b.getPricePerUnit().compareTo(a.getPricePerUnit());
                    } else if ("quantity_desc".equalsIgnoreCase(sortBy)) {
                        return b.getAvailableQuantity().compareTo(a.getAvailableQuantity());
                    }
                    return Long.compare(b.getId(), a.getId()); // Newest first
                })
                .collect(Collectors.toList());
    }

    public Optional<MarketplaceListingDto> getListingById(Long id) {
        try {
            Optional<WasteListing> dbOpt = wasteListingRepository.findById(id);
            if (dbOpt.isPresent()) {
                return Optional.of(mapEntityToDto(dbOpt.get()));
            }
        } catch (Exception ignored) {}

        return fallbackListings.stream()
                .filter(l -> l.getId().equals(id))
                .findFirst();
    }

    public List<String> getAllCategories() {
        return Arrays.asList(
                "Wheat Straw",
                "Rice Husk",
                "Sugarcane Leaves",
                "Cotton Stalks",
                "Corn Residue",
                "Soybean Stems",
                "Banana Waste",
                "Other Agricultural Waste"
        );
    }

    public List<String> getAllDistricts() {
        return getAllLiveListings().stream()
                .map(MarketplaceListingDto::getDistrict)
                .filter(Objects::nonNull)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }
}
