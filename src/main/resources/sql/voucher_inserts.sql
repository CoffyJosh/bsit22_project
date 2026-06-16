SET SQL_SAFE_UPDATES = 0;
DELETE FROM vouchers;
ALTER TABLE vouchers AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM vouchers;

-- 1. Insert 5 PERCENT Vouchers (12-Digit Numeric Codes)
INSERT INTO vouchers (code, discount_value, type, usage_limit, used_count, expiration_date, status, created_at) VALUES
('440192837465', 12.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('881920394857', 20.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('342109586741', 5.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('776049382716', 25.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('129485760192', 15.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('129489374192', 90.00, 'PERCENT', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW());

-- 2. Insert 10 FLAT Vouchers (12-Digit Numeric Codes)
INSERT INTO vouchers (code, discount_value, type, usage_limit, used_count, expiration_date, status, created_at) VALUES
('990384756102', 120.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('215473829104', 35.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('887102938475', 150.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('632594837261', 20.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('110948372615', 75.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('554109283746', 90.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('783201948576', 65.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('369018273645', 110.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('401293847561', 45.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW()),
('441293848123', 50.00, 'FIXED', 1, 0, '2026-12-31 23:59:59', 'ACTIVE', NOW());