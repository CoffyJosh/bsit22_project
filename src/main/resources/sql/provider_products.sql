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
(1, 'VAL-VP',     'Valorant Points'),         -- 1. Valorant
(2, 'MLBB-DIA',   'Diamonds'),                -- 2. Mobile Legends: Bang Bang
(3, 'GI-GC',      'Genesis Crystals'),        -- 3. Genshin Impact
(1, 'LOL-RP',     'Riot Points'),             -- 4. League of Legends
(2, 'HOK-TOK',    'Tokens'),                  -- 5. Honor of Kings
(4, 'FF-DIA',     'Diamonds'),                -- 6. Free Fire
(1, 'MR-LAT',     'Lattice'),                 -- 7. Marvel Rivals
(1, 'ABI-BOND',   'Bonds'),                   -- 8. Arena Breakout: Infinite
(4, 'R6M-CRED',   'Credits'),                 -- 9. Rainbow Six: Mobile
(4, 'CFL-CFP',    'CF Points'),               -- 10. Crossfire Legends
(1, '2XKO-KOP',   'KO Points'),               -- 11. 2XKO
(3, 'FL84-DIA',   'Diamonds'),                -- 12. Farlight 84
(2, 'MCGG-DIA',   'Diamonds'),                -- 13. Magic Chess: Go Go
(3, 'WWM-ECHO',   'Echo Beads'),              -- 14. Where Winds Meet
(2, 'DNM-DIA',    'Diamonds'),                -- 15. Dragonest M: Classic
(1, 'TFT-RP',     'Riot Points'),             -- 16. Teamfight Tactics
(2, 'WR-WC',      'Wild Cores'),               -- 17. League of Legends: Wild Rift
(4, 'BS-GOLD',    'Gold'),                    -- 18. Blood Strike
(4, 'CODM-CP',    'CP'),                      -- 19. Call of Duty: Mobile
(4, 'CF-ZP',      'ZP'),                      -- 20. Crossfire
(3, 'HSR-SJ',     'Stellar Jade'),            -- 21. Honkai: Star Rail
(4, 'PUBGM-UC',   'UC'),                      -- 22. PUBG Mobile
(4, 'COC-GEMS',   'Gems');                    -- 23. Clash of Clans