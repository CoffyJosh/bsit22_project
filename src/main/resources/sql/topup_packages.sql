USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS topup_packages;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM topup_packages;
ALTER TABLE topup_packages AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;


-- ==================== INSERT ====================
-- Game 1: Valorant
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(1, 475, 197.71, 'PH', 'AVAILABLE', NOW()),
(1, 1000, 396.43, 'PH', 'AVAILABLE', NOW()),
(1, 2050, 793.84, 'PH', 'AVAILABLE', NOW()),
(1, 3650, 1389.99, 'PH', 'AVAILABLE', NOW()),
(1, 5350, 1986.12, 'PH', 'AVAILABLE', NOW()),
(1, 11000, 3973.23, 'PH', 'AVAILABLE', NOW());

-- Game 2: Mobile Legends
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(2, 50, 49, 'PH', 'AVAILABLE', NOW()),
(2, 100, 99, 'PH', 'AVAILABLE', NOW()),
(2, 250, 239, 'PH', 'AVAILABLE', NOW()),
(2, 500, 469, 'PH', 'AVAILABLE', NOW()),
(2, 1000, 929, 'PH', 'AVAILABLE', NOW()),
(2, 2000, 1849, 'PH', 'AVAILABLE', NOW());

-- Game 3: Genshin Impact
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(3, 60, 49.00, 'PH', 'AVAILABLE', NOW()),
(3, 300, 249.00, 'PH', 'AVAILABLE', NOW()),
(3, 980, 749.00, 'PH', 'AVAILABLE', NOW()),
(3, 1980, 1490.00, 'PH', 'AVAILABLE', NOW()),
(3, 3280, 2490.00, 'PH', 'AVAILABLE', NOW()),
(3, 6480, 4990.00, 'PH', 'AVAILABLE', NOW());

-- Game 4: League of Legends
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(4, 575, 198, 'PH', 'AVAILABLE', NOW()),
(4, 1380, 445, 'PH', 'AVAILABLE', NOW()),
(4, 2800, 895, 'PH', 'AVAILABLE', NOW()),
(4, 4500, 1390, 'PH', 'AVAILABLE', NOW()),
(4, 6500, 1990, 'PH', 'AVAILABLE', NOW()),
(4, 13500, 3980, 'PH', 'AVAILABLE', NOW());

-- Game 5: Honor of Kings
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(5, 400, 299, 'PH', 'AVAILABLE', NOW()),
(5, 560, 399, 'PH', 'AVAILABLE', NOW()),
(5, 1200, 799, 'PH', 'AVAILABLE', NOW()),
(5, 2400, 1790, 'PH', 'AVAILABLE', NOW()),
(5, 4000, 2990, 'PH', 'AVAILABLE', NOW()),
(5, 8000, 4990, 'PH', 'AVAILABLE', NOW());

-- Game 6: Free Fire
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(6, 100, 50, 'PH', 'AVAILABLE', NOW()),
(6, 205, 100, 'PH', 'AVAILABLE', NOW()),
(6, 420, 200, 'PH', 'AVAILABLE', NOW()),
(6, 650, 300, 'PH', 'AVAILABLE', NOW()),
(6, 1100, 500, 'PH', 'AVAILABLE', NOW()),
(6, 2250, 1000, 'PH', 'AVAILABLE', NOW());

-- Game 7: Marvel Rivals
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(7, 100, 55.98, 'PH', 'AVAILABLE', NOW()),
(7, 500, 280.51, 'PH', 'AVAILABLE', NOW()),
(7, 1000, 561.01, 'PH', 'AVAILABLE', NOW()),
(7, 2180, 1122.02, 'PH', 'AVAILABLE', NOW()),
(7, 5680, 2806.30, 'PH', 'AVAILABLE', NOW()),
(7, 11680, 5612.59, 'PH', 'AVAILABLE', NOW());

-- Game 8: Arena Breakout Infinite
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(8, 60, 51.21, 'PH', 'AVAILABLE', NOW()),
(8, 310, 250.02, 'PH', 'AVAILABLE', NOW()),
(8, 630, 500.02, 'PH', 'AVAILABLE', NOW()),
(8, 1580, 1250.06, 'PH', 'AVAILABLE', NOW()),
(8, 3400, 2500.11, 'PH', 'AVAILABLE', NOW()),
(8, 6500, 4997.21, 'PH', 'AVAILABLE', NOW());

-- Game 9: Rainbow Six Mobile
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(9, 250, 199, 'PH', 'AVAILABLE', NOW()),
(9, 500, 399, 'PH', 'AVAILABLE', NOW()),
(9, 1000, 799, 'PH', 'AVAILABLE', NOW()),
(9, 2500, 1990, 'PH', 'AVAILABLE', NOW()),
(9, 5000, 3990, 'PH', 'AVAILABLE', NOW()),
(9, 7500, 4990, 'PH', 'AVAILABLE', NOW());

-- Game 10: Crossfire Legends
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(10, 120, 100, 'PH', 'AVAILABLE', NOW()),
(10, 180, 145, 'PH', 'AVAILABLE', NOW()),
(10, 300, 280, 'PH', 'AVAILABLE', NOW()),
(10, 500, 400, 'PH', 'AVAILABLE', NOW()),
(10, 680, 550, 'PH', 'AVAILABLE', NOW()),
(10, 1280, 1110, 'PH', 'AVAILABLE', NOW());

-- Game 11: 2XKO
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(11, 500, 199, 'PH', 'AVAILABLE', NOW()),
(11, 1000, 399, 'PH', 'AVAILABLE', NOW()),
(11, 2200, 799, 'PH', 'AVAILABLE', NOW()),
(11, 4500, 1599, 'PH', 'AVAILABLE', NOW()),
(11, 6800, 2399, 'PH', 'AVAILABLE', NOW()),
(11, 11500, 3999, 'PH', 'AVAILABLE', NOW());

-- Game 12: Farlight 84
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(12, 100, 59.10, 'PH', 'AVAILABLE', NOW()),
(12, 165, 90.93, 'PH', 'AVAILABLE', NOW()),
(12, 220, 121.23, 'PH', 'AVAILABLE', NOW()),
(12, 330, 175.79, 'PH', 'AVAILABLE', NOW()),
(12, 880, 466.75, 'PH', 'AVAILABLE', NOW()),
(12, 2240, 1210.82, 'PH', 'AVAILABLE', NOW());

-- Game 13: Magic Chess Go Go
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(13, 223, 202.16, 'PH', 'AVAILABLE', NOW()),
(13, 336, 303.24, 'PH', 'AVAILABLE', NOW()),
(13, 570, 505.40, 'PH', 'AVAILABLE', NOW()),
(13, 1163, 1010.80, 'PH', 'AVAILABLE', NOW()),
(13, 2398, 2021.60, 'PH', 'AVAILABLE', NOW()),
(13, 8042, 5054, 'PH', 'AVAILABLE', NOW());

-- Game 14: Where Winds Meet
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(14, 60, 55.00, 'PH', 'AVAILABLE', NOW()),
(14, 300, 279.00, 'PH', 'AVAILABLE', NOW()),
(14, 680, 619.00, 'PH', 'AVAILABLE', NOW()),
(14, 1280, 1149.00, 'PH', 'AVAILABLE', NOW()),
(14, 3280, 2890.00, 'PH', 'AVAILABLE', NOW()),
(14, 6480, 5590.00, 'PH', 'AVAILABLE', NOW());

-- Game 15: Dragonest M Classic
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(15, 626, 55, 'PH', 'AVAILABLE', NOW()),
(15, 3130, 290, 'PH', 'AVAILABLE', NOW()),
(15, 6366, 590, 'PH', 'AVAILABLE', NOW()),
(15, 12800, 1190, 'PH', 'AVAILABLE', NOW()),
(15, 19500, 1770, 'PH', 'AVAILABLE', NOW()),
(15, 32900, 2990, 'PH', 'AVAILABLE', NOW());

-- Game 16: Teamfight Tactics
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(16, 575, 199, 'PH', 'AVAILABLE', NOW()),
(16, 1380, 449, 'PH', 'AVAILABLE', NOW()),
(16, 2800, 899, 'PH', 'AVAILABLE', NOW()),
(16, 4500, 1399, 'PH', 'AVAILABLE', NOW()),
(16, 6500, 1999, 'PH', 'AVAILABLE', NOW()),
(16, 13500, 3999, 'PH', 'AVAILABLE', NOW());

-- Game 17: Wild Rift
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(17, 425, 200, 'PH', 'AVAILABLE', NOW()),
(17, 1000, 449, 'PH', 'AVAILABLE', NOW()),
(17, 1850, 819, 'PH', 'AVAILABLE', NOW()),
(17, 3275, 1430, 'PH', 'AVAILABLE', NOW()),
(17, 4800, 2050, 'PH', 'AVAILABLE', NOW()),
(17, 10000, 4090, 'PH', 'AVAILABLE', NOW());

-- Game 18: Blood Strike
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(18, 100, 49, 'PH', 'AVAILABLE', NOW()),
(18, 300, 149, 'PH', 'AVAILABLE', NOW()),
(18, 500, 249, 'PH', 'AVAILABLE', NOW()),
(18, 1000, 499, 'PH', 'AVAILABLE', NOW()),
(18, 2000, 999, 'PH', 'AVAILABLE', NOW()),
(18, 5000, 2490, 'PH', 'AVAILABLE', NOW());

-- Game 19: Call of Duty Mobile
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(19, 50, 50, 'PH', 'AVAILABLE', NOW()),
(19, 100, 100, 'PH', 'AVAILABLE', NOW()),
(19, 200, 200, 'PH', 'AVAILABLE', NOW()),
(19, 300, 300, 'PH', 'AVAILABLE', NOW()),
(19, 500, 500, 'PH', 'AVAILABLE', NOW()),
(19, 1000, 1000, 'PH', 'AVAILABLE', NOW());

-- Game 20: Crossfire
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(20, 100, 94.62, 'PH', 'AVAILABLE', NOW()),
(20, 200, 196.34, 'PH', 'AVAILABLE', NOW()),
(20, 300, 294.44, 'PH', 'AVAILABLE', NOW()),
(20, 400, 392.59, 'PH', 'AVAILABLE', NOW()),
(20, 500, 490.74, 'PH', 'AVAILABLE', NOW()),
(20, 1000, 946.06, 'PH', 'AVAILABLE', NOW());

-- Game 21: Honkai Star Rail
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(21, 60, 49, 'PH', 'AVAILABLE', NOW()),
(21, 300, 299, 'PH', 'AVAILABLE', NOW()),
(21, 1000, 799, 'PH', 'AVAILABLE', NOW()),
(21, 2000, 1790, 'PH', 'AVAILABLE', NOW()),
(21, 3280, 2990, 'PH', 'AVAILABLE', NOW()),
(21, 6480, 4990, 'PH', 'AVAILABLE', NOW());

-- Game 22: PUBG Mobile
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(22, 60, 61, 'PH', 'AVAILABLE', NOW()),
(22, 325, 309, 'PH', 'AVAILABLE', NOW()),
(22, 660, 610, 'PH', 'AVAILABLE', NOW()),
(22, 1800, 1520, 'PH', 'AVAILABLE', NOW()),
(22, 3850, 3000, 'PH', 'AVAILABLE', NOW()),
(22, 8100, 6080, 'PH', 'AVAILABLE', NOW());

-- Game 23: Clash of Clans
INSERT INTO topup_packages (game_id, amount, price, region, status, created_at) VALUES
(23, 80, 52.79, 'PH', 'AVAILABLE', NOW()),
(23, 500, 262.65, 'PH', 'AVAILABLE', NOW()),
(23, 1200, 525.29, 'PH', 'AVAILABLE', NOW()),
(23, 2500, 1051.21, 'PH', 'AVAILABLE', NOW()),
(23, 6500, 2628.33, 'PH', 'AVAILABLE', NOW()),
(23, 14000, 5256.66, 'PH', 'AVAILABLE', NOW());