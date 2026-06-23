USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS vouchers;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM vouchers;
ALTER TABLE vouchers AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
-- PERCENT Vouchers
INSERT INTO vouchers (code, discount_value, type, usage_limit, used_count, expiration_date, status, created_at, version) VALUES
('440192837465', 12.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('881920394857', 20.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('342109586741', 5.00,  'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('776049382716', 25.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('129485760192', 15.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('129489374192', 90.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('550192837001', 10.00, 'PERCENT', 3, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('660293948112', 30.00, 'PERCENT', 2, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('770394059223', 50.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('880495160334', 8.00,  'PERCENT', 5, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0);

-- FIXED Vouchers
INSERT INTO vouchers (code, discount_value, type, usage_limit, used_count, expiration_date, status, created_at) VALUES
('990384756102', 120.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('215473829104', 35.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('887102938475', 150.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('632594837261', 20.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('110948372615', 75.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('554109283746', 90.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('783201948576', 65.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('369018273645', 110.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('401293847561', 45.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('441293848123', 50.00,  'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('551394959234', 200.00, 'FIXED', 2, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('661495060345', 25.00,  'FIXED', 5, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('771596171456', 500.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('881697282567', 80.00,  'FIXED', 3, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0),
('991798393678', 30.00,  'FIXED', 4, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW(), 0);
