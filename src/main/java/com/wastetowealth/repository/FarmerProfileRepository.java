package com.wastetowealth.repository;

import com.wastetowealth.entity.FarmerProfile;
import com.wastetowealth.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FarmerProfileRepository extends JpaRepository<FarmerProfile, Long> {
    Optional<FarmerProfile> findByUser(User user);
    Optional<FarmerProfile> findByUserId(Long userId);
}
