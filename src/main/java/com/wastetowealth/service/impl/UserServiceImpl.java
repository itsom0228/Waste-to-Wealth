package com.wastetowealth.service.impl;

import com.wastetowealth.dto.UserRegistrationDto;
import com.wastetowealth.entity.AuditLog;
import com.wastetowealth.entity.BuyerProfile;
import com.wastetowealth.entity.FarmerProfile;
import com.wastetowealth.entity.User;
import com.wastetowealth.enums.AccountStatus;
import com.wastetowealth.enums.Role;
import com.wastetowealth.enums.VerificationStatus;
import com.wastetowealth.repository.AuditLogRepository;
import com.wastetowealth.repository.BuyerProfileRepository;
import com.wastetowealth.repository.FarmerProfileRepository;
import com.wastetowealth.repository.UserRepository;
import com.wastetowealth.service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final FarmerProfileRepository farmerProfileRepository;
    private final BuyerProfileRepository buyerProfileRepository;
    private final AuditLogRepository auditLogRepository;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository,
                           FarmerProfileRepository farmerProfileRepository,
                           BuyerProfileRepository buyerProfileRepository,
                           AuditLogRepository auditLogRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.farmerProfileRepository = farmerProfileRepository;
        this.buyerProfileRepository = buyerProfileRepository;
        this.auditLogRepository = auditLogRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public User registerUser(UserRegistrationDto dto) {
        String normalizedEmail = dto.getEmail().trim().toLowerCase();

        if (userRepository.existsByEmailIgnoreCase(normalizedEmail)) {
            throw new IllegalArgumentException("Email address is already registered.");
        }

        // Enforce safe role selection (prevent privilege escalation to ADMIN)
        Role assignedRole = Role.FARMER;
        if ("BUYER".equalsIgnoreCase(dto.getRole())) {
            assignedRole = Role.BUYER;
        }

        User user = new User();
        user.setFullName(dto.getFullName().trim());
        user.setEmail(normalizedEmail);
        user.setMobileNumber(dto.getMobileNumber().trim());
        user.setPasswordHash(passwordEncoder.encode(dto.getPassword()));
        user.setRole(assignedRole);
        user.setAccountStatus(AccountStatus.ACTIVE);
        user.setVillage(dto.getVillage());
        user.setTaluka(dto.getTaluka());
        user.setDistrict(dto.getDistrict());
        user.setState(dto.getState());
        user.setPostalCode(dto.getPostalCode());
        user.setPreferredLanguage("en");

        User savedUser = userRepository.save(user);

        if (assignedRole == Role.FARMER) {
            FarmerProfile farmerProfile = new FarmerProfile(savedUser);
            farmerProfile.setFarmName(dto.getFarmName());
            farmerProfile.setPrimaryCrop(dto.getPrimaryCrop());
            farmerProfile.setVerificationStatus(VerificationStatus.PENDING);
            farmerProfileRepository.save(farmerProfile);
        } else {
            BuyerProfile buyerProfile = new BuyerProfile(savedUser);
            buyerProfile.setOrganizationName(dto.getOrganizationName());
            buyerProfile.setBusinessType(dto.getBusinessType());
            buyerProfile.setGstNumber(dto.getGstNumber());
            buyerProfile.setVerificationStatus(VerificationStatus.PENDING);
            buyerProfileRepository.save(buyerProfile);
        }

        auditLogRepository.save(new AuditLog(
                savedUser.getId(),
                "USER_REGISTERED",
                "User",
                savedUser.getId(),
                "Registered with role " + assignedRole
        ));

        return savedUser;
    }

    @Override
    public Optional<User> findByEmail(String email) {
        if (email == null) return Optional.empty();
        return userRepository.findByEmailIgnoreCase(email.trim());
    }

    @Override
    @Transactional
    public void updateLastLogin(String email) {
        findByEmail(email).ifPresent(user -> {
            user.setLastLoginAt(LocalDateTime.now());
            userRepository.save(user);
        });
    }
}
