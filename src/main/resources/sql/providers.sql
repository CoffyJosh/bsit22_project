USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS providers;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM providers;
ALTER TABLE providers AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
INSERT INTO providers (name, merchant_id, api_key, secret_key) VALUES
('MOL Global', 'MOL-MERCHANT-0001', 'mol_live_sk_4f8a9c2b7d1e6f3a', 'mol_secret_9d3e7b1a4c8f2d6e'),
('Razer Gold', 'RZR-MERCHANT-0002', 'rzr_live_sk_2c7e4f9a1b6d8c3f', 'rzr_secret_7a1d9e3b5c8f2a4d'),
('Xsolla', 'XSL-MERCHANT-0003', 'xsl_live_sk_8b3f6c1d9e4a7b2c', 'xsl_secret_3c9a7e1b4d8f6c2a'),
('Coda Payments', 'CDA-MERCHANT-0004', 'cda_live_sk_5e2a8c4f7b1d9e3a', 'cda_secret_1f6b9d3e7a4c8b2f');
