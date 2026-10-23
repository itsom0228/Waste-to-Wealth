-- ==============================================================================
-- WASTE TO WEALTH - FLYWAY SCHEMA MIGRATION V1
-- ==============================================================================

CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    mobile_number VARCHAR(20) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    account_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    address VARCHAR(255),
    village VARCHAR(100),
    taluka VARCHAR(100),
    district VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    preferred_language VARCHAR(10) DEFAULT 'en',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login_at TIMESTAMP NULL,
    INDEX idx_user_email (email),
    INDEX idx_user_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS farmer_profiles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    farm_name VARCHAR(150),
    primary_crop VARCHAR(100),
    farm_address TEXT,
    verification_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS buyer_profiles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    organization_name VARCHAR(150),
    business_type VARCHAR(100),
    gst_number VARCHAR(50),
    contact_person VARCHAR(100),
    business_address TEXT,
    verification_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS waste_types (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    default_unit VARCHAR(20) NOT NULL DEFAULT 'Tons',
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS waste_listings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    farmer_id BIGINT NOT NULL,
    waste_type_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    available_quantity DECIMAL(12,2) NOT NULL,
    unit VARCHAR(20) NOT NULL DEFAULT 'Tons',
    price_per_unit DECIMAL(12,2) NOT NULL,
    location VARCHAR(255),
    village VARCHAR(100),
    taluka VARCHAR(100),
    district VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    image_path VARCHAR(255),
    listing_status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
    available_from DATE,
    version BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (waste_type_id) REFERENCES waste_types(id),
    INDEX idx_listing_status (listing_status),
    INDEX idx_listing_district (district)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    actor_user_id BIGINT,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id BIGINT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    safe_metadata TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Initial Seed Data: Waste Types
INSERT INTO waste_types (name, description, default_unit, active) VALUES
('Wheat Straw', 'Baled straw ideal for mushroom farming, paper manufacturing, and livestock feed.', 'Tons', TRUE),
('Rice Husk', 'High calorific value fuel for industrial boilers, silica extraction, and cement kilns.', 'Tons', TRUE),
('Sugarcane Leaves', 'Rich biomass resource for briquetting, cogeneration power plants, and mulching.', 'Tons', TRUE),
('Cotton Stalks', 'Hardy lignocellulosic stalks utilized for particle boards and thermal bio-energy.', 'Tons', TRUE),
('Corn Residue', 'Stover and cobs processed for bio-plastics, cattle silage, and chemical recovery.', 'Tons', TRUE),
('Soybean Stems', 'High protein residue prized for soil enrichment compost and fodder mixes.', 'Tons', TRUE),
('Banana Waste', 'Fibrous stems extracted for natural textiles, sanitary paper, and liquid fertilizer.', 'Tons', TRUE),
('Dry Leaves', 'Dry seasonal horticulture foliage and leaves for organic composting.', 'Tons', TRUE),
('Other Agricultural Waste', 'Other mixed crop residues and agricultural byproducts.', 'Tons', TRUE)
ON DUPLICATE KEY UPDATE name=name;
