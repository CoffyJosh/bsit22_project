SE topupservicesystem;
 
-- ==================== DROP ====================
DROP TABLE IF EXISTS games;
 
-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM games;
ALTER TABLE games AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;
 
-- ==================== INSERT ====================
INSERT INTO games (name, package_name, platform, status, provider_product_id, created_at) VALUES
('Valorant', 'Valorant Points', 'PC', 'ACTIVE', 1, NOW()),
('Mobile Legends: Bang Bang', 'Diamonds', 'MOBILE', 'ACTIVE', 2, NOW()),
('Genshin Impact', 'Genesis Crystals', 'BOTH', 'ACTIVE', 3, NOW()),
('League of Legends', 'Riot Points', 'PC', 'ACTIVE', 4, NOW()),
('Honor of Kings', 'Tokens', 'MOBILE', 'ACTIVE', 5, NOW()),
('Free Fire', 'Diamonds', 'MOBILE', 'ACTIVE', 6, NOW()),
('Marvel Rivals', 'Lattice', 'PC', 'ACTIVE', 7, NOW()),
('Arena Breakout: Infinite', 'Bonds', 'PC', 'ACTIVE', 8, NOW()),
('Rainbow Six: Mobile', 'Credits', 'MOBILE', 'ACTIVE', 9, NOW()),
('Crossfire Legends', 'CF Points', 'MOBILE', 'ACTIVE', 10, NOW()),
('2XKO', 'KO Points', 'PC', 'ACTIVE', 11, NOW()),
('Farlight 84', 'Diamonds', 'BOTH', 'ACTIVE', 12, NOW()),
('Magic Chess: Go Go', 'Diamonds', 'MOBILE', 'ACTIVE', 13, NOW()),
('Where Winds Meet', 'Echo Beads', 'BOTH', 'ACTIVE', 14, NOW()),
('Dragonest M: Classic', 'Diamonds', 'MOBILE', 'ACTIVE', 15, NOW()),
('Teamfight Tactics', 'Riot Points', 'BOTH', 'ACTIVE', 16, NOW()),
('League of Legends: Wild Rift', 'Wild Cores', 'MOBILE', 'ACTIVE', 17, NOW()),
('Blood Strike', 'Gold', 'MOBILE', 'ACTIVE', 18, NOW()),
('Call of Duty: Mobile', 'CP', 'MOBILE', 'ACTIVE', 19, NOW()),
('Crossfire', 'ZP', 'PC', 'ACTIVE', 20, NOW()),
('Honkai: Star Rail', 'Stellar Jade', 'BOTH', 'ACTIVE', 21, NOW()),
('PUBG Mobile', 'UC', 'MOBILE', 'ACTIVE', 22, NOW()),
('Clash of Clans', 'Gems', 'MOBILE', 'ACTIVE', 23, NOW());

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

PDATE games SET provider_product_id = 1  WHERE name = 'Valorant';
UPDATE games SET provider_product_id = 2  WHERE name = 'Mobile Legends: Bang Bang';
UPDATE games SET provider_product_id = 3  WHERE name = 'Genshin Impact';
UPDATE games SET provider_product_id = 4  WHERE name = 'League of Legends';
UPDATE games SET provider_product_id = 5  WHERE name = 'Honor of Kings';
UPDATE games SET provider_product_id = 6  WHERE name = 'Free Fire';
UPDATE games SET provider_product_id = 7  WHERE name = 'Marvel Rivals';
UPDATE games SET provider_product_id = 8  WHERE name = 'Arena Breakout: Infinite';
UPDATE games SET provider_product_id = 9  WHERE name = 'Rainbow Six: Mobile';
UPDATE games SET provider_product_id = 10 WHERE name = 'Crossfire Legends';
UPDATE games SET provider_product_id = 11 WHERE name = '2XKO';
UPDATE games SET provider_product_id = 12 WHERE name = 'Farlight 84';
UPDATE games SET provider_product_id = 13 WHERE name = 'Magic Chess: Go Go';
UPDATE games SET provider_product_id = 14 WHERE name = 'Where Winds Meet';
UPDATE games SET provider_product_id = 15 WHERE name = 'Dragonest M: Classic';
UPDATE games SET provider_product_id = 16 WHERE name = 'Teamfight Tactics';
UPDATE games SET provider_product_id = 17 WHERE name = 'League of Legends: Wild Rift';
UPDATE games SET provider_product_id = 18 WHERE name = 'Blood Strike';
UPDATE games SET provider_product_id = 19 WHERE name = 'Call of Duty: Mobile';
UPDATE games SET provider_product_id = 20 WHERE name = 'Crossfire';
UPDATE games SET provider_product_id = 21 WHERE name = 'Honkai: Star Rail';
UPDATE games SET provider_product_id = 22 WHERE name = 'PUBG Mobile';
UPDATE games SET provider_product_id = 23 WHERE name = 'Clash of Clans';
 
-- ==================== OPTIONAL: ENFORCE NOT NULL AFTER BACKFILL ====================
-- Once you've confirmed every game row got a valid provider_product_id
-- (no leftover 0s or NULLs — check with the SELECT below first), you can
-- tighten the column if you want it required going forward:
--
-- SELECT id, name, provider_product_id FROM games WHERE provider_product_id IS NULL;
--
-- ALTER TABLE games MODIFY provider_product_id BIGINT NOT NULL;