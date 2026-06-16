SELECT * FROM verification_code;
SELECT * FROM users;
SELECT * FROM games;
SELECT * FROM topup_packages;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;


USE topupservicesystem;

ALTER TABLE topup_packages
DROP COLUMN bonus;

ALTER TABLE verification_code
RENAME COLUMN email TO recipient;

-- DROP DATABASE topupservicesystem;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM verification_code;
ALTER TABLE verification_code AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM users;
ALTER TABLE users AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM games;
ALTER TABLE games AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM topup_packages;
ALTER TABLE topup_packages AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM orders;
ALTER TABLE orders AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- REMOVE TRANSACTION STUFF
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;


-- Create the games
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
	('Clash of Clans', 'MOBILE', 'ACTIVE', NOW()
);