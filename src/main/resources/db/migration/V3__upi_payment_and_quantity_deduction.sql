-- ==============================================================================
-- WASTE TO WEALTH - FLYWAY SCHEMA MIGRATION V3
-- Farmer UPI ID & Buyer Advance Payment with Quantity Auto-Deduction
-- ==============================================================================

ALTER TABLE waste_listings
    ADD COLUMN upi_id VARCHAR(100) DEFAULT 'farmer@upi';

ALTER TABLE purchase_requests
    ADD COLUMN advance_amount DECIMAL(12,2) DEFAULT 0.00,
    ADD COLUMN upi_ref_id VARCHAR(100),
    ADD COLUMN payment_status VARCHAR(30) DEFAULT 'ADVANCE_PAID';

-- Set initial UPI ID for existing demo listings
UPDATE waste_listings SET upi_id = 'farmer@okhdfcbank' WHERE upi_id IS NULL OR upi_id = '';
