-- ==============================================================================
-- WASTE TO WEALTH - FLYWAY SCHEMA MIGRATION V2
-- Purchase Requests & Direct Farm Contracts
-- ==============================================================================

CREATE TABLE IF NOT EXISTS purchase_requests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    listing_id BIGINT NOT NULL,
    farmer_id BIGINT NOT NULL,
    buyer_id BIGINT NOT NULL,
    quantity DECIMAL(12,2) NOT NULL,
    unit VARCHAR(20) NOT NULL DEFAULT 'Tons',
    offered_price_per_unit DECIMAL(12,2) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    request_status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    message TEXT,
    delivery_preference VARCHAR(100) DEFAULT 'Farm Gate Pickup',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (listing_id) REFERENCES waste_listings(id) ON DELETE CASCADE,
    FOREIGN KEY (farmer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_req_farmer (farmer_id),
    INDEX idx_req_buyer (buyer_id),
    INDEX idx_req_status (request_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
