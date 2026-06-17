USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS order_items;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM order_items;
ALTER TABLE order_items AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES
-- September 2025
(1,  2,  1, 396.43,  'JuanDC#1234'),
(2,  8,  1, 99.00,   'MariaPH'),
(3,  3,  1, 793.84,  'GuestPlayer01'),
(4,  1,  1, 197.71,  'CarloReyes99'),
(5,  9,  1, 469.00,  'AnaG2025'),
(6,  2,  1, 396.43,  'JuanDC#1234'),
(7,  2,  1, 396.43,  'JuanDC#1234'),
-- October 2025
(8,  11, 1, 929.00,  'MiguelB'),
(9,  4,  1, 1389.99, 'GuestPlayer02'),
(10, 8,  1, 239.00,  'MariaPH'),
(11, 15, 1, 895.00,  'CarloReyes99'),
(12, 9,  1, 469.00,  'AnaG2025'),
(13, 9,  1, 469.00,  'AnaG2025'),
(14, 19, 1, 299.00,  'GuestPlayer03'),
-- November 2025
(15, 5,  1, 1986.12, 'JuanDC#1234'),
(16, 26, 1, 500.00,  'MariaPH'),
(17, 25, 1, 199.00,  'GuestPlayer04'),
(18, 12, 1, 1849.00, 'MiguelB'),
(19, 3,  1, 793.84,  'CarloReyes99'),
-- December 2025
(20, 6,  1, 3973.23, 'JuanDC#1234'),
(21, 11, 1, 929.00,  'GuestPlayer05'),
(22, 16, 1, 1390.00, 'AnaG2025'),
(23, 114,1, 4990.00, 'MariaPH'),
(24, 12, 1, 1849.00, 'MiguelB'),
(25, 12, 1, 1849.00, 'MiguelB'),
-- January 2026
(26, 14, 1, 449.00,  'CarloReyes99'),
(27, 43, 1, 799.00,  'GuestPlayer06'),
(28, 5,  1, 1986.12, 'JuanDC#1234'),
(29, 51, 1, 309.00,  'AnaG2025'),
-- February 2026
(30, 87, 1, 2990.00, 'MariaPH'),
(31, 43, 1, 799.00,  'MiguelB'),
(32, 82, 1, 1190.00, 'GuestPlayer07'),
(33, 15, 1, 895.00,  'CarloReyes99'),
(34, 15, 1, 895.00,  'CarloReyes99'),
-- March 2026
(35, 3,  1, 793.84,  'JuanDC#1234'),
(36, 12, 1, 1849.00, 'GuestPlayer08'),
(37, 114,1, 4990.00, 'AnaG2025'),
(38, 44, 1, 399.00,  'MariaPH'),
-- April 2026
(39, 6,  1, 3973.23, 'MiguelB'),
(40, 33, 1, 610.00,  'CarloReyes99'),
(41, 19, 1, 299.00,  'GuestPlayer09'),
(42, 16, 1, 1390.00, 'JuanDC#1234'),
-- May 2026
(43, 11, 1, 929.00,  'MariaPH'),
(44, 3,  1, 793.84,  'GuestPlayer10'),
(45, 58, 1, 1599.00, 'AnaG2025'),
(46, 11, 1, 929.00,  'MiguelB'),
(47, 11, 1, 929.00,  'MiguelB'),
-- June 2026
(48, 6,  1, 3973.23, 'JuanDC#1234'),
(49, 9,  1, 469.00,  'CarloReyes99'),
(50, 12, 1, 1849.00, 'GuestPlayer11');
