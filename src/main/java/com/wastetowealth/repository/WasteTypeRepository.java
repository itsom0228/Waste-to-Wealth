package com.wastetowealth.repository;

import com.wastetowealth.entity.WasteType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WasteTypeRepository extends JpaRepository<WasteType, Long> {
    Optional<WasteType> findByNameIgnoreCase(String name);
    List<WasteType> findByActiveTrue();
}
