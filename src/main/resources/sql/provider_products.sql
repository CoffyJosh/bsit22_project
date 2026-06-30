USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS provider_products;

-- ==================== CREATE ====================
CREATE TABLE provider_products (
    id BIGINT NOT NULL AUTO_INCREMENT,
    provider_id BIGINT NOT NULL,
    product_code VARCHAR(255) NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_provider_products_provider
        FOREIGN KEY (provider_id) REFERENCES providers(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM provider_products;
ALTER TABLE provider_products AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
-- NOTE: This assumes providers were inserted in this order:
--   1 = MOL Global
--   2 = Razer Gold
--   3 = Xsolla
--   4 = Coda Payments
-- One row per game's currency/product line. Games will be linked to
-- these via games.provider_product_id in the next script.

INSERT INTO provider_products (provider_id, product_code) VALUES
-- 1. Valorant — VAL-VP
(1, 'VAL-VP'), (2, 'VAL-VP'), (3, 'VAL-VP'), (4, 'VAL-VP'),

-- 2. Mobile Legends: Bang Bang — MLBB-DIA
(1, 'MLBB-DIA'), (2, 'MLBB-DIA'), (4, 'MLBB-DIA'),

-- 3. Genshin Impact — GI-GC
(1, 'GI-GC'), (2, 'GI-GC'), (3, 'GI-GC'),

-- 4. League of Legends — LOL-RP
(1, 'LOL-RP'), (2, 'LOL-RP'), (3, 'LOL-RP'), (4, 'LOL-RP'),

-- 5. Honor of Kings — HOK-TOK
(1, 'HOK-TOK'), (2, 'HOK-TOK'), (3, 'HOK-TOK'),

-- 6. Free Fire — FF-DIA
(1, 'FF-DIA'), (3, 'FF-DIA'), (4, 'FF-DIA'),

-- 7. Marvel Rivals — MR-LAT
(1, 'MR-LAT'), (2, 'MR-LAT'), (3, 'MR-LAT'), (4, 'MR-LAT'),

-- 8. Arena Breakout: Infinite — ABI-BOND
(1, 'ABI-BOND'), (2, 'ABI-BOND'), (4, 'ABI-BOND'),

-- 9. Rainbow Six: Mobile — R6M-CRED
(1, 'R6M-CRED'), (3, 'R6M-CRED'), (4, 'R6M-CRED'),

-- 10. Crossfire Legends — CFL-CFP
(2, 'CFL-CFP'), (3, 'CFL-CFP'), (4, 'CFL-CFP'),

-- 11. 2XKO — 2XKO-KOP
(1, '2XKO-KOP'), (2, '2XKO-KOP'), (4, '2XKO-KOP'),

-- 12. Farlight 84 — FL84-DIA
(1, 'FL84-DIA'), (2, 'FL84-DIA'), (3, 'FL84-DIA'), (4, 'FL84-DIA'),

-- 13. Magic Chess: Go Go — MCGG-DIA
(1, 'MCGG-DIA'), (2, 'MCGG-DIA'), (3, 'MCGG-DIA'),

-- 14. Where Winds Meet — WWM-ECHO
(2, 'WWM-ECHO'), (3, 'WWM-ECHO'), (4, 'WWM-ECHO'),

-- 15. Dragonest M: Classic — DNM-DIA
(1, 'DNM-DIA'), (2, 'DNM-DIA'), (3, 'DNM-DIA'),

-- 16. Teamfight Tactics — TFT-RP
(1, 'TFT-RP'), (2, 'TFT-RP'), (3, 'TFT-RP'), (4, 'TFT-RP'),

-- 17. League of Legends: Wild Rift — WR-WC
(1, 'WR-WC'), (2, 'WR-WC'), (4, 'WR-WC'),

-- 18. Blood Strike — BS-GOLD
(2, 'BS-GOLD'), (3, 'BS-GOLD'), (4, 'BS-GOLD'),

-- 19. Call of Duty: Mobile — CODM-CP
(1, 'CODM-CP'), (3, 'CODM-CP'), (4, 'CODM-CP'),

-- 20. Crossfire — CF-ZP
(1, 'CF-ZP'), (2, 'CF-ZP'), (4, 'CF-ZP'),

-- 21. Honkai: Star Rail — HSR-SJ
(1, 'HSR-SJ'), (2, 'HSR-SJ'), (3, 'HSR-SJ'), (4, 'HSR-SJ'),

-- 22. PUBG Mobile — PUBGM-UC
(1, 'PUBGM-UC'), (2, 'PUBGM-UC'), (3, 'PUBGM-UC'),

-- 23. Clash of Clans — COC-GEMS
(2, 'COC-GEMS'), (3, 'COC-GEMS'), (4, 'COC-GEMS');	