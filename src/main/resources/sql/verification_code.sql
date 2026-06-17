USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS verification_code;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM verification_code;
ALTER TABLE verification_code AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;
