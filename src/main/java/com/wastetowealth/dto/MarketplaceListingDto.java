package com.wastetowealth.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Data Transfer Object representing an agricultural waste listing in the public marketplace.
 */
public class MarketplaceListingDto {

    private Long id;
    private String title;
    private String wasteCategory;
    private String description;
    private BigDecimal availableQuantity;
    private String unit;
    private BigDecimal pricePerUnit;
    private String location;
    private String village;
    private String taluka;
    private String district;
    private String state;
    private String postalCode;
    private String imagePath;
    private String farmerName;
    private String farmerContact;
    private String listingStatus;
    private LocalDate availableFrom;
    private String suitability;
    private String moistureGrade;
    private String upiId = "farmer@okhdfcbank";

    public MarketplaceListingDto() {
    }

    public MarketplaceListingDto(Long id, String title, String wasteCategory, String description,
                                 BigDecimal availableQuantity, String unit, BigDecimal pricePerUnit,
                                 String village, String taluka, String district, String state,
                                 String postalCode, String imagePath, String farmerName,
                                 String listingStatus, LocalDate availableFrom,
                                 String suitability, String moistureGrade) {
        this.id = id;
        this.title = title;
        this.wasteCategory = wasteCategory;
        this.description = description;
        this.availableQuantity = availableQuantity;
        this.unit = unit;
        this.pricePerUnit = pricePerUnit;
        this.village = village;
        this.taluka = taluka;
        this.district = district;
        this.state = state;
        this.postalCode = postalCode;
        this.location = village + ", " + taluka + ", " + district + ", " + state;
        this.imagePath = imagePath;
        this.farmerName = farmerName;
        this.listingStatus = listingStatus;
        this.availableFrom = availableFrom;
        this.suitability = suitability;
        this.moistureGrade = moistureGrade;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWasteCategory() {
        return wasteCategory;
    }

    public void setWasteCategory(String wasteCategory) {
        this.wasteCategory = wasteCategory;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(BigDecimal availableQuantity) {
        this.availableQuantity = availableQuantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public BigDecimal getPricePerUnit() {
        return pricePerUnit;
    }

    public void setPricePerUnit(BigDecimal pricePerUnit) {
        this.pricePerUnit = pricePerUnit;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getVillage() {
        return village;
    }

    public void setVillage(String village) {
        this.village = village;
    }

    public String getTaluka() {
        return taluka;
    }

    public void setTaluka(String taluka) {
        this.taluka = taluka;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getFarmerName() {
        return farmerName;
    }

    public void setFarmerName(String farmerName) {
        this.farmerName = farmerName;
    }

    public String getFarmerContact() {
        return farmerContact;
    }

    public void setFarmerContact(String farmerContact) {
        this.farmerContact = farmerContact;
    }

    public String getListingStatus() {
        return listingStatus;
    }

    public void setListingStatus(String listingStatus) {
        this.listingStatus = listingStatus;
    }

    public LocalDate getAvailableFrom() {
        return availableFrom;
    }

    public void setAvailableFrom(LocalDate availableFrom) {
        this.availableFrom = availableFrom;
    }

    public String getSuitability() {
        return suitability;
    }

    public void setSuitability(String suitability) {
        this.suitability = suitability;
    }

    public String getMoistureGrade() {
        return moistureGrade;
    }

    public void setMoistureGrade(String moistureGrade) {
        this.moistureGrade = moistureGrade;
    }

    public String getUpiId() {
        return upiId;
    }

    public void setUpiId(String upiId) {
        this.upiId = upiId;
    }
}
