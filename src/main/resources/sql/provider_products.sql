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

INSERT INTO provider_products (provider_id, product_code, product_name) VALUES
-- 1. Valorant — VAL-VP (all 4 providers)
(1, 'VAL-VP', 'Valorant Points'),
(2, 'VAL-VP', 'Valorant Points'),
(3, 'VAL-VP', 'Valorant Points'),
(4, 'VAL-VP', 'Valorant Points'),

-- 2. Mobile Legends: Bang Bang — MLBB-DIA (3 providers)
(1, 'MLBB-DIA', 'Diamonds'),
(2, 'MLBB-DIA', 'Diamonds'),
(4, 'MLBB-DIA', 'Diamonds'),

-- 3. Genshin Impact — GI-GC (3 providers)
(1, 'GI-GC', 'Genesis Crystals'),
(2, 'GI-GC', 'Genesis Crystals'),
(3, 'GI-GC', 'Genesis Crystals'),

-- 4. League of Legends — LOL-RP (all 4 providers)
(1, 'LOL-RP', 'Riot Points'),
(2, 'LOL-RP', 'Riot Points'),
(3, 'LOL-RP', 'Riot Points'),
(4, 'LOL-RP', 'Riot Points'),

-- 5. Honor of Kings — HOK-TOK (3 providers)
(1, 'HOK-TOK', 'Tokens'),
(2, 'HOK-TOK', 'Tokens'),
(3, 'HOK-TOK', 'Tokens'),

-- 6. Free Fire — FF-DIA (3 providers)
(1, 'FF-DIA', 'Diamonds'),
(3, 'FF-DIA', 'Diamonds'),
(4, 'FF-DIA', 'Diamonds'),

-- 7. Marvel Rivals — MR-LAT (all 4 providers)
(1, 'MR-LAT', 'Lattice'),
(2, 'MR-LAT', 'Lattice'),
(3, 'MR-LAT', 'Lattice'),
(4, 'MR-LAT', 'Lattice'),

-- 8. Arena Breakout: Infinite — ABI-BOND (3 providers)
(1, 'ABI-BOND', 'Bonds'),
(2, 'ABI-BOND', 'Bonds'),
(4, 'ABI-BOND', 'Bonds'),

-- 9. Rainbow Six: Mobile — R6M-CRED (3 providers)
(1, 'R6M-CRED', 'Credits'),
(3, 'R6M-CRED', 'Credits'),
(4, 'R6M-CRED', 'Credits'),

-- 10. Crossfire Legends — CFL-CFP (3 providers)
(2, 'CFL-CFP', 'CF Points'),
(3, 'CFL-CFP', 'CF Points'),
(4, 'CFL-CFP', 'CF Points'),

-- 11. 2XKO — 2XKO-KOP (3 providers)
(1, '2XKO-KOP', 'KO Points'),
(2, '2XKO-KOP', 'KO Points'),
(4, '2XKO-KOP', 'KO Points'),

-- 12. Farlight 84 — FL84-DIA (all 4 providers)
(1, 'FL84-DIA', 'Diamonds'),
(2, 'FL84-DIA', 'Diamonds'),
(3, 'FL84-DIA', 'Diamonds'),
(4, 'FL84-DIA', 'Diamonds'),

-- 13. Magic Chess: Go Go — MCGG-DIA (3 providers)
(1, 'MCGG-DIA', 'Diamonds'),
(2, 'MCGG-DIA', 'Diamonds'),
(3, 'MCGG-DIA', 'Diamonds'),

-- 14. Where Winds Meet — WWM-ECHO (3 providers)
(2, 'WWM-ECHO', 'Echo Beads'),
(3, 'WWM-ECHO', 'Echo Beads'),
(4, 'WWM-ECHO', 'Echo Beads'),

-- 15. Dragonest M: Classic — DNM-DIA (3 providers)
(1, 'DNM-DIA', 'Diamonds'),
(2, 'DNM-DIA', 'Diamonds'),
(3, 'DNM-DIA', 'Diamonds'),

-- 16. Teamfight Tactics — TFT-RP (all 4 providers)
(1, 'TFT-RP', 'Riot Points'),
(2, 'TFT-RP', 'Riot Points'),
(3, 'TFT-RP', 'Riot Points'),
(4, 'TFT-RP', 'Riot Points'),

-- 17. League of Legends: Wild Rift — WR-WC (3 providers)
(1, 'WR-WC', 'Wild Cores'),
(2, 'WR-WC', 'Wild Cores'),
(4, 'WR-WC', 'Wild Cores'),

-- 18. Blood Strike — BS-GOLD (3 providers)
(2, 'BS-GOLD', 'Gold'),
(3, 'BS-GOLD', 'Gold'),
(4, 'BS-GOLD', 'Gold'),

-- 19. Call of Duty: Mobile — CODM-CP (3 providers)
(1, 'CODM-CP', 'CP'),
(3, 'CODM-CP', 'CP'),
(4, 'CODM-CP', 'CP'),

-- 20. Crossfire — CF-ZP (3 providers)
(1, 'CF-ZP', 'ZP'),
(2, 'CF-ZP', 'ZP'),
(4, 'CF-ZP', 'ZP'),

-- 21. Honkai: Star Rail — HSR-SJ (all 4 providers)
(1, 'HSR-SJ', 'Stellar Jade'),
(2, 'HSR-SJ', 'Stellar Jade'),
(3, 'HSR-SJ', 'Stellar Jade'),
(4, 'HSR-SJ', 'Stellar Jade'),

-- 22. PUBG Mobile — PUBGM-UC (3 providers)
(1, 'PUBGM-UC', 'UC'),
(2, 'PUBGM-UC', 'UC'),
(3, 'PUBGM-UC', 'UC'),

-- 23. Clash of Clans — COC-GEMS (3 providers)
(2, 'COC-GEMS', 'Gems'),
(3, 'COC-GEMS', 'Gems'),
(4, 'COC-GEMS', 'Gems');