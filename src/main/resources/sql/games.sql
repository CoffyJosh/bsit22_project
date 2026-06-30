USE topupservicesystem;
 
-- ==================== DROP ====================
DROP TABLE IF EXISTS games;
 
-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM games;
ALTER TABLE games AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== RESET STATUS ====================
SET SQL_SAFE_UPDATES = 0;
UPDATE games
SET status = 'ACTIVE';
SET SQL_SAFE_UPDATES = 1;
 
-- ==================== INSERT ====================
INSERT INTO games (name, package_name, platform, status, product_code, provider_id, created_at) VALUES
('Valorant', 'Valorant Points', 'PC', 'ACTIVE', 'VAL-VP', 1, NOW()),
('Mobile Legends: Bang Bang', 'Diamonds', 'MOBILE', 'ACTIVE', 'MLBB-DIA', 2, NOW()),
('Genshin Impact', 'Genesis Crystals', 'BOTH', 'ACTIVE', 'GI-GC', 3, NOW()),
('League of Legends', 'Riot Points', 'PC', 'ACTIVE', 'LOL-RP', 1, NOW()),
('Honor of Kings', 'Tokens', 'MOBILE', 'ACTIVE', 'HOK-TOK', 2, NOW()),
('Free Fire', 'Diamonds', 'MOBILE', 'ACTIVE', 'FF-DIA', 4, NOW()),
('Marvel Rivals', 'Lattice', 'PC', 'ACTIVE', 'MR-LAT', 1, NOW()),
('Arena Breakout: Infinite', 'Bonds', 'PC', 'ACTIVE', 'ABI-BOND', 1, NOW()),
('Rainbow Six: Mobile', 'Credits', 'MOBILE', 'ACTIVE', 'R6M-CRED', 4, NOW()),
('Crossfire Legends', 'CF Points', 'MOBILE', 'ACTIVE', 'CFL-CFP', 4, NOW()),
('2XKO', 'KO Points', 'PC', 'ACTIVE', '2XKO-KOP', 1, NOW()),
('Farlight 84', 'Diamonds', 'BOTH', 'ACTIVE', 'FL84-DIA', 3, NOW()),
('Magic Chess: Go Go', 'Diamonds', 'MOBILE', 'ACTIVE', 'MCGG-DIA', 2, NOW()),
('Where Winds Meet', 'Echo Beads', 'BOTH', 'ACTIVE', 'WWM-ECHO', 3, NOW()),
('Dragonest M: Classic', 'Diamonds', 'MOBILE', 'ACTIVE', 'DNM-DIA', 2, NOW()),
('Teamfight Tactics', 'Riot Points', 'BOTH', 'ACTIVE', 'TFT-RP', 1, NOW()),
('League of Legends: Wild Rift', 'Wild Cores', 'MOBILE', 'ACTIVE', 'WR-WC', 2, NOW()),
('Blood Strike', 'Gold', 'MOBILE', 'ACTIVE', 'BS-GOLD', 4, NOW()),
('Call of Duty: Mobile', 'CP', 'MOBILE', 'ACTIVE', 'CODM-CP', 4, NOW()),
('Crossfire', 'ZP', 'PC', 'ACTIVE', 'CF-ZP', 4, NOW()),
('Honkai: Star Rail', 'Stellar Jade', 'BOTH', 'ACTIVE', 'HSR-SJ', 3, NOW()),
('PUBG Mobile', 'UC', 'MOBILE', 'ACTIVE', 'PUBGM-UC', 4, NOW()),
('Clash of Clans', 'Gems', 'MOBILE', 'ACTIVE', 'COC-GEMS', 4, NOW());

-- Explicitly requested corrections and completions
UPDATE games SET package_name = 'Valorant Points' WHERE id = 1;   -- Valorant
UPDATE games SET package_name = 'Diamonds' WHERE id = 2;          -- Mobile Legends
UPDATE games SET package_name = 'Genesis Crystals' WHERE id = 3;  -- Genshin Impact (Fixed)
UPDATE games SET package_name = 'Riot Points' WHERE id = 4;       -- League of Legends
UPDATE games SET package_name = 'Tokens' WHERE id = 5;            -- Honor of Kings
UPDATE games SET package_name = 'Diamonds' WHERE id = 6;          -- Free Fire
UPDATE games SET package_name = 'Lattice' WHERE id = 7;           -- Marvel Rivals (Fixed from Credits)
UPDATE games SET package_name = 'Bonds' WHERE id = 8;             -- Arena Breakout Infinite (Fixed from Coins)
UPDATE games SET package_name = 'Credits' WHERE id = 9;           -- Rainbow Six Mobile
UPDATE games SET package_name = 'CF Points' WHERE id = 10;        -- Crossfire Legends
UPDATE games SET package_name = 'KO Points' WHERE id = 11;        -- 2XKO
UPDATE games SET package_name = 'Diamonds' WHERE id = 12;         -- Farlight 84
UPDATE games SET package_name = 'Diamonds' WHERE id = 13;         -- Magic Chess Go Go
UPDATE games SET package_name = 'Echo Beads' WHERE id = 14;       -- Where Winds Meet (Fixed)
UPDATE games SET package_name = 'Diamonds' WHERE id = 15;         -- Dragonest M Classic
UPDATE games SET package_name = 'Riot Points' WHERE id = 16;      -- Teamfight Tactics
UPDATE games SET package_name = 'Wild Cores' WHERE id = 17;       -- Wild Rift
UPDATE games SET package_name = 'Gold' WHERE id = 18;             -- Blood Strike (Fixed from Coins)
UPDATE games SET package_name = 'CP' WHERE id = 19;               -- Call of Duty Mobile
UPDATE games SET package_name = 'ZP' WHERE id = 20;               -- Crossfire
UPDATE games SET package_name = 'Stellar Jade' WHERE id = 21;     -- Honkai Star Rail
UPDATE games SET package_name = 'UC' WHERE id = 22;               -- PUBG Mobile
UPDATE games SET package_name = 'Gems' WHERE id = 23;             -- Clash of Clans

-- ADDING CODE 
UPDATE games SET product_code = 'VAL-VP'     WHERE id = 1;  -- Valorant
UPDATE games SET product_code = 'MLBB-DIA'   WHERE id = 2;  -- Mobile Legends: Bang Bang
UPDATE games SET product_code = 'GI-GC'      WHERE id = 3;  -- Genshin Impact
UPDATE games SET product_code = 'LOL-RP'     WHERE id = 4;  -- League of Legends
UPDATE games SET product_code = 'HOK-TOK'    WHERE id = 5;  -- Honor of Kings
UPDATE games SET product_code = 'FF-DIA'     WHERE id = 6;  -- Free Fire
UPDATE games SET product_code = 'MR-LAT'     WHERE id = 7;  -- Marvel Rivals
UPDATE games SET product_code = 'ABI-BOND'   WHERE id = 8;  -- Arena Breakout: Infinite
UPDATE games SET product_code = 'R6M-CRED'   WHERE id = 9;  -- Rainbow Six: Mobile
UPDATE games SET product_code = 'CFL-CFP'    WHERE id = 10; -- Crossfire Legends
UPDATE games SET product_code = '2XKO-KOP'   WHERE id = 11; -- 2XKO
UPDATE games SET product_code = 'FL84-DIA'   WHERE id = 12; -- Farlight 84
UPDATE games SET product_code = 'MCGG-DIA'   WHERE id = 13; -- Magic Chess: Go Go
UPDATE games SET product_code = 'WWM-ECHO'   WHERE id = 14; -- Where Winds Meet
UPDATE games SET product_code = 'DNM-DIA'    WHERE id = 15; -- Dragonest M: Classic
UPDATE games SET product_code = 'TFT-RP'     WHERE id = 16; -- Teamfight Tactics
UPDATE games SET product_code = 'WR-WC'      WHERE id = 17; -- League of Legends: Wild Rift
UPDATE games SET product_code = 'BS-GOLD'    WHERE id = 18; -- Blood Strike
UPDATE games SET product_code = 'CODM-CP'    WHERE id = 19; -- Call of Duty: Mobile
UPDATE games SET product_code = 'CF-ZP'      WHERE id = 20; -- Crossfire
UPDATE games SET product_code = 'HSR-SJ'     WHERE id = 21; -- Honkai: Star Rail
UPDATE games SET product_code = 'PUBGM-UC'   WHERE id = 22; -- PUBG Mobile
UPDATE games SET product_code = 'COC-GEMS'   WHERE id = 23; -- Clash of Clans


-- ADDING PROVIDERS
UPDATE games SET provider_id = 3 WHERE id = 1;  -- Valorant (VAL-VP -> Xsolla)
UPDATE games SET provider_id = 2 WHERE id = 2;  -- Mobile Legends: Bang Bang (MLBB-DIA -> Razer Gold)
UPDATE games SET provider_id = 1 WHERE id = 3;  -- Genshin Impact (GI-GC -> MOL Global)
UPDATE games SET provider_id = 4 WHERE id = 4;  -- League of Legends (LOL-RP -> Coda Payments)
UPDATE games SET provider_id = 3 WHERE id = 5;  -- Honor of Kings (HOK-TOK -> Xsolla)
UPDATE games SET provider_id = 1 WHERE id = 6;  -- Free Fire (FF-DIA -> MOL Global)
UPDATE games SET provider_id = 2 WHERE id = 7;  -- Marvel Rivals (MR-LAT -> Razer Gold)
UPDATE games SET provider_id = 4 WHERE id = 8;  -- Arena Breakout: Infinite (ABI-BOND -> Coda Payments)
UPDATE games SET provider_id = 3 WHERE id = 9;  -- Rainbow Six: Mobile (R6M-CRED -> Xsolla)
UPDATE games SET provider_id = 2 WHERE id = 10; -- Crossfire Legends (CFL-CFP -> Razer Gold)
UPDATE games SET provider_id = 1 WHERE id = 11; -- 2XKO (2XKO-KOP -> MOL Global)
UPDATE games SET provider_id = 3 WHERE id = 12; -- Farlight 84 (FL84-DIA -> Xsolla)
UPDATE games SET provider_id = 2 WHERE id = 13; -- Magic Chess: Go Go (MCGG-DIA -> Razer Gold)
UPDATE games SET provider_id = 4 WHERE id = 14; -- Where Winds Meet (WWM-ECHO -> Coda Payments)
UPDATE games SET provider_id = 1 WHERE id = 15; -- Dragonest M: Classic (DNM-DIA -> MOL Global)
UPDATE games SET provider_id = 4 WHERE id = 16; -- Teamfight Tactics (TFT-RP -> Coda Payments)
UPDATE games SET provider_id = 2 WHERE id = 17; -- League of Legends: Wild Rift (WR-WC -> Razer Gold)
UPDATE games SET provider_id = 3 WHERE id = 18; -- Blood Strike (BS-GOLD -> Xsolla)
UPDATE games SET provider_id = 4 WHERE id = 19; -- Call of Duty: Mobile (CODM-CP -> Coda Payments)
UPDATE games SET provider_id = 1 WHERE id = 20; -- Crossfire (CF-ZP -> MOL Global)
UPDATE games SET provider_id = 2 WHERE id = 21; -- Honkai: Star Rail (HSR-SJ -> Razer Gold)
UPDATE games SET provider_id = 3 WHERE id = 22; -- PUBG Mobile (PUBGM-UC -> Xsolla)
UPDATE games SET provider_id = 4 WHERE id = 23; -- Clash of Clans (COC-GEMS -> Coda Payments)

