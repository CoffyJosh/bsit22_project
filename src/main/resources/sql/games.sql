USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS games;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM games;
ALTER TABLE games AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
INSERT INTO games (name, platform, status, created_at) VALUES
('Valorant', 'PC', 'ACTIVE', NOW()),
('Mobile Legends: Bang Bang', 'MOBILE', 'ACTIVE', NOW()),
('Genshin Impact', 'BOTH', 'ACTIVE', NOW()),
('League of Legends', 'PC', 'ACTIVE', NOW()),
('Honor of Kings', 'MOBILE', 'ACTIVE', NOW()),
('Free Fire', 'MOBILE', 'ACTIVE', NOW()),
('Marvel Rivals', 'PC', 'ACTIVE', NOW()),
('Arena Breakout: Infinite', 'PC', 'ACTIVE', NOW()),
('Rainbow Six: Mobile', 'MOBILE', 'ACTIVE', NOW()),
('Crossfire Legends', 'MOBILE', 'ACTIVE', NOW()),
('2XKO', 'PC', 'ACTIVE', NOW()),
('Farlight 84', 'BOTH', 'ACTIVE', NOW()),
('Magic Chess: Go Go', 'MOBILE', 'ACTIVE', NOW()),
('Where Winds Meet', 'BOTH', 'ACTIVE', NOW()),
('Dragonest M: Classic', 'MOBILE', 'ACTIVE', NOW()),
('Teamfight Tactics', 'BOTH', 'ACTIVE', NOW()),
('League of Legends: Wild Rift', 'MOBILE', 'ACTIVE', NOW()),
('Blood Strike', 'MOBILE', 'ACTIVE', NOW()),
('Call of Duty: Mobile', 'MOBILE', 'ACTIVE', NOW()),
('Crossfire', 'PC', 'ACTIVE', NOW()),
('Honkai: Star Rail', 'BOTH', 'ACTIVE', NOW()),
('PUBG Mobile', 'MOBILE', 'ACTIVE', NOW()),
('Clash of Clans', 'MOBILE', 'ACTIVE', NOW());
