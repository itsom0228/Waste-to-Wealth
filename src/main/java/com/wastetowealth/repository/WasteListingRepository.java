package com.wastetowealth.repository;

import com.wastetowealth.entity.User;
import com.wastetowealth.entity.WasteListing;
import com.wastetowealth.enums.ListingStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WasteListingRepository extends JpaRepository<WasteListing, Long> {

    List<WasteListing> findByFarmer(User farmer);

    List<WasteListing> findByFarmerId(Long farmerId);

    List<WasteListing> findByListingStatus(ListingStatus status);

    long countByListingStatus(ListingStatus status);

    @Query("SELECT DISTINCT l.district FROM WasteListing l WHERE l.listingStatus = 'ACTIVE' AND l.district IS NOT NULL")
    List<String> findDistinctDistricts();

    @Query("SELECT l FROM WasteListing l WHERE l.listingStatus = :status " +
           "AND (:district IS NULL OR l.district = :district) " +
           "AND (:keyword IS NULL OR LOWER(l.title) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "     OR LOWER(l.description) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "     OR LOWER(l.location) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    Page<WasteListing> searchActiveListings(@Param("status") ListingStatus status,
                                            @Param("keyword") String keyword,
                                            @Param("district") String district,
                                            Pageable pageable);
}
