package com.wastetowealth.config;

import com.wastetowealth.entity.BuyerProfile;
import com.wastetowealth.entity.FarmerProfile;
import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.entity.WasteType;
import com.wastetowealth.enums.AccountStatus;
import com.wastetowealth.enums.ListingStatus;
import com.wastetowealth.enums.Role;
import com.wastetowealth.enums.VerificationStatus;
import com.wastetowealth.repository.BuyerProfileRepository;
import com.wastetowealth.repository.FarmerProfileRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.repository.WasteListingRepository;
import com.wastetowealth.repository.WasteTypeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);

    private final UserRepository userRepository;
    private final FarmerProfileRepository farmerProfileRepository;
    private final BuyerProfileRepository buyerProfileRepository;
    private final WasteTypeRepository wasteTypeRepository;
    private final WasteListingRepository wasteListingRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository,
                           FarmerProfileRepository farmerProfileRepository,
                           BuyerProfileRepository buyerProfileRepository,
                           WasteTypeRepository wasteTypeRepository,
                           WasteListingRepository wasteListingRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.farmerProfileRepository = farmerProfileRepository;
        this.buyerProfileRepository = buyerProfileRepository;
        this.wasteTypeRepository = wasteTypeRepository;
        this.wasteListingRepository = wasteListingRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) {
        seedAdminUser();
        seedDemoFarmer();
        seedDemoBuyer();
        seedWasteTypesAndDemoListings();
    }

    private void seedAdminUser() {
        if (!userRepository.existsByEmailIgnoreCase("admin@wastetowealth.com")) {
            User admin = new User();
            admin.setFullName("Platform Administrator");
            admin.setEmail("admin@wastetowealth.com");
            admin.setMobileNumber("9800000001");
            admin.setPasswordHash(passwordEncoder.encode("Admin@123"));
            admin.setRole(Role.ADMIN);
            admin.setAccountStatus(AccountStatus.ACTIVE);
            admin.setDistrict("Pune");
            admin.setState("Maharashtra");
            userRepository.save(admin);
            log.info("Default development administrator created: admin@wastetowealth.com");
        }
    }

    private void seedDemoFarmer() {
        if (!userRepository.existsByEmailIgnoreCase("farmer@wastetowealth.com")) {
            User farmer = new User();
            farmer.setFullName("Rameshwar Patil (Farmer)");
            farmer.setEmail("farmer@wastetowealth.com");
            farmer.setMobileNumber("9822001122");
            farmer.setPasswordHash(passwordEncoder.encode("Farmer@123"));
            farmer.setRole(Role.FARMER);
            farmer.setAccountStatus(AccountStatus.ACTIVE);
            farmer.setVillage("Dindori");
            farmer.setTaluka("Niphad");
            farmer.setDistrict("Nashik");
            farmer.setState("Maharashtra");
            farmer.setPostalCode("422206");
            User savedFarmer = userRepository.save(farmer);

            FarmerProfile profile = new FarmerProfile(savedFarmer);
            profile.setFarmName("Patil Agro Farms");
            profile.setPrimaryCrop("Wheat & Grapes");
            profile.setVerificationStatus(VerificationStatus.VERIFIED);
            farmerProfileRepository.save(profile);
            log.info("Demo farmer created: farmer@wastetowealth.com");
        }
    }

    private void seedDemoBuyer() {
        if (!userRepository.existsByEmailIgnoreCase("buyer@wastetowealth.com")) {
            User buyer = new User();
            buyer.setFullName("GreenBio Fuels Pvt Ltd");
            buyer.setEmail("buyer@wastetowealth.com");
            buyer.setMobileNumber("9833004455");
            buyer.setPasswordHash(passwordEncoder.encode("Buyer@123"));
            buyer.setRole(Role.BUYER);
            buyer.setAccountStatus(AccountStatus.ACTIVE);
            buyer.setDistrict("Pune");
            buyer.setState("Maharashtra");
            User savedBuyer = userRepository.save(buyer);

            BuyerProfile profile = new BuyerProfile(savedBuyer);
            profile.setOrganizationName("GreenBio Energy Solutions");
            profile.setBusinessType("Biomass Pellets & Bio-Coal");
            profile.setGstNumber("27AAACG0123M1Z5");
            profile.setContactPerson("Anil Deshmukh");
            profile.setVerificationStatus(VerificationStatus.VERIFIED);
            buyerProfileRepository.save(profile);
            log.info("Demo buyer created: buyer@wastetowealth.com");
        }
    }

    private void seedWasteTypesAndDemoListings() {
        if (wasteTypeRepository.count() == 0) {
            log.info("Initializing default agricultural waste types...");
            List<WasteType> types = List.of(
                    createWasteType("Wheat Straw", "Baled straw ideal for mushroom farming, paper manufacturing, and livestock feed.", "Tons"),
                    createWasteType("Rice Husk", "High calorific value fuel for industrial boilers, silica extraction, and cement kilns.", "Tons"),
                    createWasteType("Sugarcane Leaves", "Rich biomass resource for briquetting, cogeneration power plants, and mulching.", "Tons"),
                    createWasteType("Cotton Stalks", "Hardy lignocellulosic stalks utilized for particle boards and thermal bio-energy.", "Tons"),
                    createWasteType("Corn Residue", "Stover and cobs processed for bio-plastics, cattle silage, and chemical recovery.", "Tons"),
                    createWasteType("Soybean Stems", "High protein residue prized for soil enrichment compost and fodder mixes.", "Tons"),
                    createWasteType("Banana Waste", "Fibrous stems extracted for natural textiles, sanitary paper, and liquid fertilizer.", "Tons"),
                    createWasteType("Dry Leaves", "Dry seasonal horticulture foliage and leaves for organic composting.", "Tons"),
                    createWasteType("Other Agricultural Waste", "Other mixed crop residues and agricultural byproducts.", "Tons")
            );
            wasteTypeRepository.saveAll(types);
            log.info("Successfully seeded {} waste types.", types.size());
        }

        if (wasteListingRepository.count() == 0) {
            userRepository.findByEmailIgnoreCase("farmer@wastetowealth.com").ifPresent(farmer -> {
                wasteTypeRepository.findByNameIgnoreCase("Wheat Straw").ifPresent(wt -> {
                    WasteListing listing = new WasteListing();
                    listing.setFarmer(farmer);
                    listing.setWasteType(wt);
                    listing.setTitle("Premium Quality Golden Wheat Straw Bales");
                    listing.setDescription("Freshly harvested dry wheat straw, moisture < 10%, perfectly baled for biomass or livestock feed.");
                    listing.setAvailableQuantity(new BigDecimal("50.00"));
                    listing.setUnit("Tons");
                    listing.setPricePerUnit(new BigDecimal("2200.00"));
                    listing.setLocation("Patil Agro Farms, Niphad");
                    listing.setVillage("Dindori");
                    listing.setTaluka("Niphad");
                    listing.setDistrict("Nashik");
                    listing.setState("Maharashtra");
                    listing.setPostalCode("422206");
                    listing.setUpiId("farmer@okhdfcbank");
                    listing.setListingStatus(ListingStatus.ACTIVE);
                    listing.setAvailableFrom(LocalDate.now());
                    wasteListingRepository.save(listing);
                    log.info("Initialized demo waste listing for marketplace.");
                });
            });
        }
    }

    private WasteType createWasteType(String name, String description, String unit) {
        WasteType wt = new WasteType();
        wt.setName(name);
        wt.setDescription(description);
        wt.setDefaultUnit(unit);
        wt.setActive(true);
        return wt;
    }
}
