-- ==================== USERS ====================
INSERT INTO users (name, email, password, role, status, created_at) VALUES
('Juan Dela Cruz', 'juan.delacruz@gmail.com', '$2a$10$dummyhash1', 'USER', 'ACTIVE', '2025-08-15 10:00:00'),
('Maria Santos', 'maria.santos@gmail.com', '$2a$10$dummyhash2', 'USER', 'ACTIVE', '2025-08-20 11:00:00'),
('Carlo Reyes', 'carlo.reyes@gmail.com', '$2a$10$dummyhash3', 'USER', 'ACTIVE', '2025-09-01 09:00:00'),
('Ana Gonzales', 'ana.gonzales@gmail.com', '$2a$10$dummyhash4', 'USER', 'ACTIVE', '2025-09-10 14:00:00'),
('Miguel Bautista', 'miguel.bautista@gmail.com', '$2a$10$dummyhash5', 'USER', 'ACTIVE', '2025-09-15 08:00:00'),
('Admin User', 'admin@auragames.ph', '$2a$10$dummyhash6', 'ADMIN', 'ACTIVE', '2025-08-01 00:00:00');

-- ==================== ORDERS ====================
-- user_id references: 1=Juan, 2=Maria, 3=Carlo, 4=Ana, 5=Miguel, NULL=Guest
-- package_id references based on inserts (approximate, adjust if your IDs differ):
-- game 1 (Valorant):       pkg 1-6
-- game 2 (MLBB):           pkg 7-12
-- game 4 (LoL):            pkg 13-18
-- game 5 (Honor of Kings): pkg 19-24
-- game 6 (Free Fire):      pkg 25-30
-- game 7 (Marvel Rivals):  pkg 31-36
-- game 8 (Arena Breakout): pkg 37-42
-- game 9 (R6 Mobile):      pkg 43-48
-- game 10 (Crossfire Leg): pkg 49-54
-- game 11 (2XKO):          pkg 55-60
-- game 12 (Farlight 84):   pkg 61-66
-- game 16 (TFT):           pkg 79-84
-- game 17 (Wild Rift):     pkg 85-90
-- game 21 (HSR):           pkg 109-114
-- game 22 (PUBG):          pkg 115-120
-- game 23 (CoC):           pkg 121-126

INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, created_at) VALUES
-- Sept 2025
('ORD-SEP001AAAA', 1,    NULL, 396.43,  0,      396.43,  'COMPLETED', '2025-09-03 10:15:00'),
('ORD-SEP002BBBB', 2,    NULL, 99.00,   0,      99.00,   'COMPLETED', '2025-09-05 14:22:00'),
('ORD-SEP003CCCC', NULL, NULL, 793.84,  0,      793.84,  'COMPLETED', '2025-09-08 09:30:00'),
('ORD-SEP004DDDD', 3,    NULL, 197.71,  0,      197.71,  'COMPLETED', '2025-09-12 16:45:00'),
('ORD-SEP005EEEE', 4,    NULL, 469.00,  0,      469.00,  'COMPLETED', '2025-09-18 11:00:00'),
('ORD-SEP006FAIL', 1,    NULL, 396.43,  0,      396.43,  'FAILED',    '2025-09-20 13:00:00'), -- Juan failed then retried
('ORD-SEP007AAAA', 1,    NULL, 396.43,  0,      396.43,  'COMPLETED', '2025-09-20 13:05:00'), -- Juan retry success

-- Oct 2025
('ORD-OCT001AAAA', 5,    NULL, 929.00,  0,      929.00,  'COMPLETED', '2025-10-02 10:00:00'),
('ORD-OCT002BBBB', NULL, NULL, 1389.99, 0,      1389.99, 'COMPLETED', '2025-10-07 15:30:00'),
('ORD-OCT003CCCC', 2,    NULL, 239.00,  0,      239.00,  'COMPLETED', '2025-10-11 08:45:00'),
('ORD-OCT004DDDD', 3,    NULL, 895.00,  0,      895.00,  'COMPLETED', '2025-10-15 17:20:00'),
('ORD-OCT005FAIL', 4,    NULL, 469.00,  0,      469.00,  'FAILED',    '2025-10-19 12:00:00'), -- Ana failed
('ORD-OCT006EEEE', 4,    NULL, 469.00,  0,      469.00,  'COMPLETED', '2025-10-19 12:08:00'), -- Ana retry
('ORD-OCT007FFFF', NULL, NULL, 299.00,  0,      299.00,  'COMPLETED', '2025-10-25 09:15:00'),

-- Nov 2025
('ORD-NOV001AAAA', 1,    NULL, 1986.12, 0,      1986.12, 'COMPLETED', '2025-11-03 11:00:00'),
('ORD-NOV002BBBB', 2,    NULL, 500.00,  0,      500.00,  'COMPLETED', '2025-11-08 14:00:00'),
('ORD-NOV003CCCC', NULL, NULL, 199.00,  0,      199.00,  'COMPLETED', '2025-11-12 10:30:00'),
('ORD-NOV004DDDD', 5,    NULL, 1849.00, 0,      1849.00, 'COMPLETED', '2025-11-18 16:00:00'),
('ORD-NOV005EEEE', 3,    NULL, 793.84,  0,      793.84,  'COMPLETED', '2025-11-22 09:00:00'),

-- Dec 2025
('ORD-DEC001AAAA', 1,    NULL, 3973.23, 0,      3973.23, 'COMPLETED', '2025-12-05 10:00:00'),
('ORD-DEC002BBBB', NULL, NULL, 929.00,  0,      929.00,  'COMPLETED', '2025-12-10 13:00:00'),
('ORD-DEC003CCCC', 4,    NULL, 1390.00, 0,      1390.00, 'COMPLETED', '2025-12-15 15:30:00'),
('ORD-DEC004DDDD', 2,    NULL, 4990.00, 0,      4990.00, 'COMPLETED', '2025-12-20 11:00:00'),
('ORD-DEC005FAIL', 5,    NULL, 1849.00, 0,      1849.00, 'FAILED',    '2025-12-24 08:00:00'), -- Miguel failed
('ORD-DEC006EEEE', 5,    NULL, 1849.00, 0,      1849.00, 'COMPLETED', '2025-12-24 08:10:00'), -- Miguel retry

-- Jan 2026
('ORD-JAN001AAAA', 3,    NULL, 449.00,  0,      449.00,  'COMPLETED', '2026-01-05 09:00:00'),
('ORD-JAN002BBBB', NULL, NULL, 799.00,  0,      799.00,  'COMPLETED', '2026-01-10 14:30:00'),
('ORD-JAN003CCCC', 1,    NULL, 1986.12, 0,      1986.12, 'COMPLETED', '2026-01-18 10:00:00'),
('ORD-JAN004DDDD', 4,    NULL, 309.00,  0,      309.00,  'COMPLETED', '2026-01-25 16:00:00'),

-- Feb 2026
('ORD-FEB001AAAA', 2,    NULL, 2990.00, 0,      2990.00, 'COMPLETED', '2026-02-03 11:00:00'),
('ORD-FEB002BBBB', 5,    NULL, 799.00,  0,      799.00,  'COMPLETED', '2026-02-14 13:00:00'),
('ORD-FEB003CCCC', NULL, NULL, 1190.00, 0,      1190.00, 'COMPLETED', '2026-02-20 15:00:00'),
('ORD-FEB004FAIL', 3,    NULL, 895.00,  0,      895.00,  'FAILED',    '2026-02-25 09:00:00'), -- Carlo failed
('ORD-FEB005DDDD', 3,    NULL, 895.00,  0,      895.00,  'COMPLETED', '2026-02-25 09:12:00'), -- Carlo retry

-- Mar 2026
('ORD-MAR001AAAA', 1,    NULL, 793.84,  0,      793.84,  'COMPLETED', '2026-03-03 10:00:00'),
('ORD-MAR002BBBB', NULL, NULL, 1849.00, 0,      1849.00, 'COMPLETED', '2026-03-10 14:00:00'),
('ORD-MAR003CCCC', 4,    NULL, 4990.00, 0,      4990.00, 'COMPLETED', '2026-03-18 11:00:00'),
('ORD-MAR004DDDD', 2,    NULL, 399.00,  0,      399.00,  'COMPLETED', '2026-03-25 16:30:00'),

-- Apr 2026
('ORD-APR001AAAA', 5,    NULL, 3973.23, 0,      3973.23, 'COMPLETED', '2026-04-02 09:00:00'),
('ORD-APR002BBBB', 3,    NULL, 610.00,  0,      610.00,  'COMPLETED', '2026-04-10 13:00:00'),
('ORD-APR003CCCC', NULL, NULL, 299.00,  0,      299.00,  'COMPLETED', '2026-04-18 15:00:00'),
('ORD-APR004DDDD', 1,    NULL, 1390.00, 0,      1390.00, 'COMPLETED', '2026-04-25 10:30:00'),

-- May 2026
('ORD-MAY001AAAA', 2,    NULL, 929.00,  0,      929.00,  'COMPLETED', '2026-05-05 11:00:00'),
('ORD-MAY002BBBB', NULL, NULL, 793.84,  0,      793.84,  'COMPLETED', '2026-05-12 14:00:00'),
('ORD-MAY003CCCC', 4,    NULL, 1599.00, 0,      1599.00, 'COMPLETED', '2026-05-20 10:00:00'),
('ORD-MAY004FAIL', 5,    NULL, 929.00,  0,      929.00,  'FAILED',    '2026-05-28 09:00:00'), -- Miguel failed
('ORD-MAY005EEEE', 5,    NULL, 929.00,  0,      929.00,  'COMPLETED', '2026-05-28 09:07:00'), -- Miguel retry

-- Jun 2026
('ORD-JUN001AAAA', 1,    NULL, 3973.23, 0,      3973.23, 'COMPLETED', '2026-06-02 10:00:00'),
('ORD-JUN002BBBB', 3,    NULL, 469.00,  0,      469.00,  'COMPLETED', '2026-06-08 13:00:00'),
('ORD-JUN003CCCC', NULL, NULL, 1849.00, 0,      1849.00, 'COMPLETED', '2026-06-15 11:00:00');

-- ==================== ORDER ITEMS ====================
-- (order_id, topup_package_id, quantity, price, account_id)
-- order_id will be 1-52 assuming clean table; adjust if needed

INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES
-- Sept
(1,  2,  1, 396.43,  'JuanDC#1234'),
(2,  8,  1, 99.00,   'MariaPH'),
(3,  3,  1, 793.84,  'GuestPlayer01'),
(4,  1,  1, 197.71,  'CarloReyes99'),
(5,  9,  1, 469.00,  'AnaG2025'),
(6,  2,  1, 396.43,  'JuanDC#1234'),   -- failed
(7,  2,  1, 396.43,  'JuanDC#1234'),   -- retry

-- Oct
(8,  11, 1, 929.00,  'MiguelB'),
(9,  4,  1, 1389.99, 'GuestPlayer02'),
(10, 8,  1, 239.00,  'MariaPH'),       -- wrong pkg fixed below; using 250 diamonds
(11, 15, 1, 895.00,  'CarloReyes99'),
(12, 9,  1, 469.00,  'AnaG2025'),      -- failed
(13, 9,  1, 469.00,  'AnaG2025'),      -- retry
(14, 19, 1, 299.00,  'GuestPlayer03'),

-- Nov
(15, 5,  1, 1986.12, 'JuanDC#1234'),
(16, 26, 1, 500.00,  'MariaPH'),
(17, 25, 1, 199.00,  'GuestPlayer04'),
(18, 12, 1, 1849.00, 'MiguelB'),
(19, 3,  1, 793.84,  'CarloReyes99'),

-- Dec
(20, 6,  1, 3973.23, 'JuanDC#1234'),
(21, 11, 1, 929.00,  'GuestPlayer05'),
(22, 16, 1, 1390.00, 'AnaG2025'),
(23, 90, 1, 4990.00, 'MariaPH'),       -- HSR 6480 Stellar Jade
(24, 12, 1, 1849.00, 'MiguelB'),       -- failed
(25, 12, 1, 1849.00, 'MiguelB'),       -- retry

-- Jan 2026
(26, 14, 1, 449.00,  'CarloReyes99'),
(27, 43, 1, 799.00,  'GuestPlayer06'),
(28, 5,  1, 1986.12, 'JuanDC#1234'),
(29, 51, 1, 309.00,  'AnaG2025'),

-- Feb 2026
(30, 87, 1, 2990.00, 'MariaPH'),       -- Wild Rift Wild Cores
(31, 43, 1, 799.00,  'MiguelB'),
(32, 82, 1, 1190.00, 'GuestPlayer07'),
(33, 15, 1, 895.00,  'CarloReyes99'),  -- failed
(34, 15, 1, 895.00,  'CarloReyes99'),  -- retry

-- Mar 2026
(35, 3,  1, 793.84,  'JuanDC#1234'),
(36, 12, 1, 1849.00, 'GuestPlayer08'),
(37, 90, 1, 4990.00, 'AnaG2025'),
(38, 44, 1, 399.00,  'MariaPH'),

-- Apr 2026
(39, 6,  1, 3973.23, 'MiguelB'),
(40, 33, 1, 610.00,  'CarloReyes99'),
(41, 19, 1, 299.00,  'GuestPlayer09'),
(42, 16, 1, 1390.00, 'JuanDC#1234'),

-- May 2026
(43, 11, 1, 929.00,  'MariaPH'),
(44, 3,  1, 793.84,  'GuestPlayer10'),
(45, 58, 1, 1599.00, 'AnaG2025'),
(46, 11, 1, 929.00,  'MiguelB'),       -- failed
(47, 11, 1, 929.00,  'MiguelB'),       -- retry

-- Jun 2026
(48, 6,  1, 3973.23, 'JuanDC#1234'),
(49, 9,  1, 469.00,  'CarloReyes99'),
(50, 12, 1, 1849.00, 'GuestPlayer11');

-- ==================== PAYMENTS ====================
-- Only COMPLETED orders get a payment record

INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at) VALUES
-- Sept
(1,  'GCash',      396.43,  'TXN-SEP001AAAA', 'SUCCESS', '2025-09-03 10:16:00', '2025-09-03 10:16:00'),
(2,  'Maya',       99.00,   'TXN-SEP002BBBB', 'SUCCESS', '2025-09-05 14:23:00', '2025-09-05 14:23:00'),
(3,  'Smart Load', 793.84,  'TXN-SEP003CCCC', 'SUCCESS', '2025-09-08 09:31:00', '2025-09-08 09:31:00'),
(4,  'GCash',      197.71,  'TXN-SEP004DDDD', 'SUCCESS', '2025-09-12 16:46:00', '2025-09-12 16:46:00'),
(5,  'Maya',       469.00,  'TXN-SEP005EEEE', 'SUCCESS', '2025-09-18 11:01:00', '2025-09-18 11:01:00'),
-- order 6 FAILED, no payment
(7,  'GCash',      396.43,  'TXN-SEP007AAAA', 'SUCCESS', '2025-09-20 13:06:00', '2025-09-20 13:06:00'),

-- Oct
(8,  'Smart Load', 929.00,  'TXN-OCT001AAAA', 'SUCCESS', '2025-10-02 10:01:00', '2025-10-02 10:01:00'),
(9,  'GCash',      1389.99, 'TXN-OCT002BBBB', 'SUCCESS', '2025-10-07 15:31:00', '2025-10-07 15:31:00'),
(10, 'Maya',       239.00,  'TXN-OCT003CCCC', 'SUCCESS', '2025-10-11 08:46:00', '2025-10-11 08:46:00'),
(11, 'GCash',      895.00,  'TXN-OCT004DDDD', 'SUCCESS', '2025-10-15 17:21:00', '2025-10-15 17:21:00'),
-- order 12 FAILED, no payment
(13, 'Maya',       469.00,  'TXN-OCT006EEEE', 'SUCCESS', '2025-10-19 12:09:00', '2025-10-19 12:09:00'),
(14, 'Smart Load', 299.00,  'TXN-OCT007FFFF', 'SUCCESS', '2025-10-25 09:16:00', '2025-10-25 09:16:00'),

-- Nov
(15, 'GCash',      1986.12, 'TXN-NOV001AAAA', 'SUCCESS', '2025-11-03 11:01:00', '2025-11-03 11:01:00'),
(16, 'Maya',       500.00,  'TXN-NOV002BBBB', 'SUCCESS', '2025-11-08 14:01:00', '2025-11-08 14:01:00'),
(17, 'Smart Load', 199.00,  'TXN-NOV003CCCC', 'SUCCESS', '2025-11-12 10:31:00', '2025-11-12 10:31:00'),
(18, 'GCash',      1849.00, 'TXN-NOV004DDDD', 'SUCCESS', '2025-11-18 16:01:00', '2025-11-18 16:01:00'),
(19, 'Maya',       793.84,  'TXN-NOV005EEEE', 'SUCCESS', '2025-11-22 09:01:00', '2025-11-22 09:01:00'),

-- Dec
(20, 'GCash',      3973.23, 'TXN-DEC001AAAA', 'SUCCESS', '2025-12-05 10:01:00', '2025-12-05 10:01:00'),
(21, 'Smart Load', 929.00,  'TXN-DEC002BBBB', 'SUCCESS', '2025-12-10 13:01:00', '2025-12-10 13:01:00'),
(22, 'Maya',       1390.00, 'TXN-DEC003CCCC', 'SUCCESS', '2025-12-15 15:31:00', '2025-12-15 15:31:00'),
(23, 'GCash',      4990.00, 'TXN-DEC004DDDD', 'SUCCESS', '2025-12-20 11:01:00', '2025-12-20 11:01:00'),
-- order 24 FAILED, no payment
(25, 'Smart Load', 1849.00, 'TXN-DEC006EEEE', 'SUCCESS', '2025-12-24 08:11:00', '2025-12-24 08:11:00'),

-- Jan 2026
(26, 'GCash',      449.00,  'TXN-JAN001AAAA', 'SUCCESS', '2026-01-05 09:01:00', '2026-01-05 09:01:00'),
(27, 'Maya',       799.00,  'TXN-JAN002BBBB', 'SUCCESS', '2026-01-10 14:31:00', '2026-01-10 14:31:00'),
(28, 'GCash',      1986.12, 'TXN-JAN003CCCC', 'SUCCESS', '2026-01-18 10:01:00', '2026-01-18 10:01:00'),
(29, 'Smart Load', 309.00,  'TXN-JAN004DDDD', 'SUCCESS', '2026-01-25 16:01:00', '2026-01-25 16:01:00'),

-- Feb 2026
(30, 'GCash',      2990.00, 'TXN-FEB001AAAA', 'SUCCESS', '2026-02-03 11:01:00', '2026-02-03 11:01:00'),
(31, 'Maya',       799.00,  'TXN-FEB002BBBB', 'SUCCESS', '2026-02-14 13:01:00', '2026-02-14 13:01:00'),
(32, 'Smart Load', 1190.00, 'TXN-FEB003CCCC', 'SUCCESS', '2026-02-20 15:01:00', '2026-02-20 15:01:00'),
-- order 33 FAILED, no payment
(34, 'GCash',      895.00,  'TXN-FEB005DDDD', 'SUCCESS', '2026-02-25 09:13:00', '2026-02-25 09:13:00'),

-- Mar 2026
(35, 'Maya',       793.84,  'TXN-MAR001AAAA', 'SUCCESS', '2026-03-03 10:01:00', '2026-03-03 10:01:00'),
(36, 'Smart Load', 1849.00, 'TXN-MAR002BBBB', 'SUCCESS', '2026-03-10 14:01:00', '2026-03-10 14:01:00'),
(37, 'GCash',      4990.00, 'TXN-MAR003CCCC', 'SUCCESS', '2026-03-18 11:01:00', '2026-03-18 11:01:00'),
(38, 'Maya',       399.00,  'TXN-MAR004DDDD', 'SUCCESS', '2026-03-25 16:31:00', '2026-03-25 16:31:00'),

-- Apr 2026
(39, 'GCash',      3973.23, 'TXN-APR001AAAA', 'SUCCESS', '2026-04-02 09:01:00', '2026-04-02 09:01:00'),
(40, 'Smart Load', 610.00,  'TXN-APR002BBBB', 'SUCCESS', '2026-04-10 13:01:00', '2026-04-10 13:01:00'),
(41, 'Maya',       299.00,  'TXN-APR003CCCC', 'SUCCESS', '2026-04-18 15:01:00', '2026-04-18 15:01:00'),
(42, 'GCash',      1390.00, 'TXN-APR004DDDD', 'SUCCESS', '2026-04-25 10:31:00', '2026-04-25 10:31:00'),

-- May 2026
(43, 'Maya',       929.00,  'TXN-MAY001AAAA', 'SUCCESS', '2026-05-05 11:01:00', '2026-05-05 11:01:00'),
(44, 'Smart Load', 793.84,  'TXN-MAY002BBBB', 'SUCCESS', '2026-05-12 14:01:00', '2026-05-12 14:01:00'),
(45, 'GCash',      1599.00, 'TXN-MAY003CCCC', 'SUCCESS', '2026-05-20 10:01:00', '2026-05-20 10:01:00'),
-- order 46 FAILED, no payment
(47, 'Maya',       929.00,  'TXN-MAY005EEEE', 'SUCCESS', '2026-05-28 09:08:00', '2026-05-28 09:08:00'),

-- Jun 2026
(48, 'GCash',      3973.23, 'TXN-JUN001AAAA', 'SUCCESS', '2026-06-02 10:01:00', '2026-06-02 10:01:00'),
(49, 'Smart Load', 469.00,  'TXN-JUN002BBBB', 'SUCCESS', '2026-06-08 13:01:00', '2026-06-08 13:01:00'),
(50, 'Maya',       1849.00, 'TXN-JUN003CCCC', 'SUCCESS', '2026-06-15 11:01:00', '2026-06-15 11:01:00');
