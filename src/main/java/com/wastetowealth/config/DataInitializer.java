package com.wastetowealth.config;

import com.wastetowealth.entity.BuyerProfile;
import com.wastetowealth.entity.FarmerProfile;
import com.wastetowealth.entity.User;
import com.wastetowealth.enums.AccountStatus;
import com.wastetowealth.enums.Role;
import com.wastetowealth.enums.VerificationStatus;
import com.wastetowealth.repository.BuyerProfileRepository;
import com.wastetowealth.repository.FarmerProfileRepository;
import com.wastetowealth.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class DataInitializer implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);

    private final UserRepository userRepository;
    private final FarmerProfileRepository farmerProfileRepository;
    private final BuyerProfileRepository buyerProfileRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository,
                           FarmerProfileRepository farmerProfileRepository,
                           BuyerProfileRepository buyerProfileRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.farmerProfileRepository = farmerProfileRepository;
        this.buyerProfileRepository = buyerProfileRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) {
        seedAdminUser();
        seedDemoFarmer();
        seedDemoBuyer();
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
}
