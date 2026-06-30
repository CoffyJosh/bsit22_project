-- ============================================================
-- SEED: 24 demo transactions (orders + order_items + payments)
-- Dates scattered across 2024-2026 for realistic-looking history
-- Games used: Valorant (1), League of Legends (4), Wild Rift (17), CoC (23)
-- Adjust @user_id and @account_id values as needed before running
-- ============================================================

SET @user_id = 502;          -- your real user_id
SET @email   = 'jrcofreros@gmail.com';

-- ---------- BATCH 1 ----------

-- #1 Valorant 475 VP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-VAL00475A1', @user_id, NULL, 197.71, 0.00, 197.71, 'COMPLETED', @email, '2024-02-14 09:12:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 1, 1, 197.71, 'NeonSlayer#PH1');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 197.71, 'TXN-JAN-0001', 'SUCCESS', '2024-02-14 09:12:30', '2024-02-14 09:12:00');

-- #2 League of Legends 575 RP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-LOL00575A1', @user_id, NULL, 198.00, 0.00, 198.00, 'COMPLETED', @email, '2025-11-03 20:05:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 19, 1, 198.00, 'JhinMain2025');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 198.00, 'TXN-JAN-0002', 'SUCCESS', '2025-11-03 20:05:25', '2025-11-03 20:05:00');

-- #3 Wild Rift 425 WC, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-WR000425A1', @user_id, NULL, 200.00, 0.00, 200.00, 'COMPLETED', @email, '2024-07-22 15:40:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 97, 1, 200.00, 'BotLaneBully');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 200.00, 'TXN-JAN-0003', 'SUCCESS', '2024-07-22 15:40:20', '2024-07-22 15:40:00');

-- #4 CoC 500 Gems, voucher 880495160334 (8% PERCENT)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-COC00500A1', @user_id, (SELECT id FROM vouchers WHERE code = '880495160334'), 262.65, 21.01, 241.64, 'COMPLETED', @email, '2026-01-09 21:30:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 133, 1, 262.65, 'ChiefJuan');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 241.64, 'TXN-JAN-0004', 'SUCCESS', '2026-01-09 21:30:25', '2026-01-09 21:30:00');

-- ---------- BATCH 2 ----------

-- #5 Valorant 1000 VP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-VAL01000B1', @user_id, NULL, 396.43, 0.00, 396.43, 'COMPLETED', @email, '2025-03-30 11:55:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 2, 1, 396.43, 'NeonSlayer#PH1');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 396.43, 'TXN-FEB-0001', 'SUCCESS', '2025-03-30 11:55:20', '2025-03-30 11:55:00');

-- #6 League of Legends 1380 RP, voucher 550192837001 (10% PERCENT)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-LOL01380B1', @user_id, (SELECT id FROM vouchers WHERE code = '550192837001'), 445.00, 44.50, 400.50, 'COMPLETED', @email, '2024-09-17 19:20:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 20, 1, 445.00, 'JhinMain2025');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 400.50, 'TXN-FEB-0002', 'SUCCESS', '2024-09-17 19:20:30', '2024-09-17 19:20:00');

-- #7 Wild Rift 1000 WC, no voucher -- PENDING (not yet paid)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-WR001000B1', @user_id, NULL, 449.00, 0.00, 449.00, 'PENDING', @email, '2026-04-11 16:10:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 98, 1, 449.00, 'BotLaneBully');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 449.00, 'TXN-FEB-0003', 'PENDING', NULL, '2026-04-11 16:10:00');

-- #8 CoC 1200 Gems, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-COC01200B1', @user_id, NULL, 525.29, 0.00, 525.29, 'COMPLETED', @email, '2025-06-05 08:45:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 134, 1, 525.29, 'ChiefJuan');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 525.29, 'TXN-FEB-0004', 'SUCCESS', '2025-06-05 08:45:25', '2025-06-05 08:45:00');

-- ---------- BATCH 3 ----------

-- #9 Valorant 2050 VP -- the funny 90% OFF voucher (one-time use, demo only)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-VAL02050C1', @user_id, (SELECT id FROM vouchers WHERE code = '129489374192'), 793.84, 714.46, 79.38, 'COMPLETED', @email, '2024-12-24 13:25:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 3, 1, 793.84, 'NeonSlayer#PH1');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 79.38, 'TXN-MAR-0001', 'SUCCESS', '2024-12-24 13:25:20', '2024-12-24 13:25:00');

-- #10 League of Legends 2800 RP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-LOL02800C1', @user_id, NULL, 895.00, 0.00, 895.00, 'COMPLETED', @email, '2025-08-19 18:00:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 21, 1, 895.00, 'JhinMain2025');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 895.00, 'TXN-MAR-0002', 'SUCCESS', '2025-08-19 18:00:25', '2025-08-19 18:00:00');

-- #11 Wild Rift 1850 WC, voucher 660293948112 (30% PERCENT)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-WR001850C1', @user_id, (SELECT id FROM vouchers WHERE code = '660293948112'), 819.00, 245.70, 573.30, 'COMPLETED', @email, '2026-02-27 15:05:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 99, 1, 819.00, 'BotLaneBully');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 573.30, 'TXN-MAR-0003', 'SUCCESS', '2026-02-27 15:05:20', '2026-02-27 15:05:00');

-- #12 CoC 80 Gems, no voucher -- FAILED payment
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-COC00080C1', @user_id, NULL, 52.79, 0.00, 52.79, 'FAILED', @email, '2024-04-02 07:50:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 132, 1, 52.79, 'ChiefJuan');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 52.79, 'TXN-MAR-0004', 'FAILED', NULL, '2024-04-02 07:50:00');

-- ---------- BATCH 4 ----------

-- #13 Valorant 1000 VP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-VAL01000D1', @user_id, NULL, 396.43, 0.00, 396.43, 'COMPLETED', @email, '2025-01-14 12:15:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 2, 1, 396.43, 'NeonSlayer#PH1');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 396.43, 'TXN-APR-0001', 'SUCCESS', '2025-01-14 12:15:25', '2025-01-14 12:15:00');

-- #14 League of Legends 575 RP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-LOL00575D1', @user_id, NULL, 198.00, 0.00, 198.00, 'COMPLETED', @email, '2024-10-29 19:40:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 19, 1, 198.00, 'JhinMain2025');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 198.00, 'TXN-APR-0002', 'SUCCESS', '2024-10-29 19:40:20', '2024-10-29 19:40:00');

-- #15 Wild Rift 425 WC, voucher 342109586741 (5% PERCENT)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-WR000425D1', @user_id, (SELECT id FROM vouchers WHERE code = '342109586741'), 200.00, 10.00, 190.00, 'COMPLETED', @email, '2026-05-18 17:20:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 97, 1, 200.00, 'BotLaneBully');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 190.00, 'TXN-APR-0003', 'SUCCESS', '2026-05-18 17:20:20', '2026-05-18 17:20:00');

-- #16 CoC 500 Gems, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-COC00500D1', @user_id, NULL, 262.65, 0.00, 262.65, 'COMPLETED', @email, '2025-05-07 22:10:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 133, 1, 262.65, 'ChiefJuan');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 262.65, 'TXN-APR-0004', 'SUCCESS', '2025-05-07 22:10:25', '2025-05-07 22:10:00');

-- ---------- BATCH 5 ----------

-- #17 Valorant 3650 VP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-VAL03650E1', @user_id, NULL, 1389.99, 0.00, 1389.99, 'COMPLETED', @email, '2024-06-11 10:35:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 4, 1, 1389.99, 'NeonSlayer#PH1');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 1389.99, 'TXN-MAY-0001', 'SUCCESS', '2024-06-11 10:35:25', '2024-06-11 10:35:00');

-- #18 League of Legends 1380 RP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-LOL01380E1', @user_id, NULL, 445.00, 0.00, 445.00, 'COMPLETED', @email, '2025-12-21 20:50:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 20, 1, 445.00, 'JhinMain2025');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 445.00, 'TXN-MAY-0002', 'SUCCESS', '2025-12-21 20:50:20', '2025-12-21 20:50:00');

-- #19 Wild Rift 1000 WC, no voucher -- PENDING
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-WR001000E1', @user_id, NULL, 449.00, 0.00, 449.00, 'PENDING', @email, '2026-03-03 14:00:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 98, 1, 449.00, 'BotLaneBully');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 449.00, 'TXN-MAY-0003', 'PENDING', NULL, '2026-03-03 14:00:00');

-- #20 CoC 1200 Gems, voucher 215473829104 (35 FIXED)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-COC01200E1', @user_id, (SELECT id FROM vouchers WHERE code = '215473829104'), 525.29, 35.00, 490.29, 'COMPLETED', @email, '2024-08-08 09:30:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 134, 1, 525.29, 'ChiefJuan');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 490.29, 'TXN-MAY-0004', 'SUCCESS', '2024-08-08 09:30:25', '2024-08-08 09:30:00');

-- ---------- BATCH 6 ----------

-- #21 Valorant 2050 VP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-VAL02050F1', @user_id, NULL, 793.84, 0.00, 793.84, 'COMPLETED', @email, '2025-09-26 16:45:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 3, 1, 793.84, 'NeonSlayer#PH1');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 793.84, 'TXN-JUN-0001', 'SUCCESS', '2025-09-26 16:45:25', '2025-09-26 16:45:00');

-- #22 League of Legends 2800 RP, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-LOL02800F1', @user_id, NULL, 895.00, 0.00, 895.00, 'COMPLETED', @email, '2024-03-15 21:05:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 21, 1, 895.00, 'JhinMain2025');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 895.00, 'TXN-JUN-0002', 'SUCCESS', '2024-03-15 21:05:20', '2024-03-15 21:05:00');

-- #23 Wild Rift 1850 WC, no voucher
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-WR001850F1', @user_id, NULL, 819.00, 0.00, 819.00, 'COMPLETED', @email, '2026-06-09 11:40:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 99, 1, 819.00, 'BotLaneBully');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'GCASH', 819.00, 'TXN-JUN-0003', 'SUCCESS', '2026-06-09 11:40:25', '2026-06-09 11:40:00');

-- #24 CoC 2500 Gems, voucher 632594837261 (20 FIXED)
INSERT INTO orders (tracking_code, user_id, voucher_id, total_amount, discount_amount, final_amount, status, email, created_at)
VALUES ('ORD-COC02500F1', @user_id, (SELECT id FROM vouchers WHERE code = '632594837261'), 1051.21, 20.00, 1031.21, 'COMPLETED', @email, '2025-04-23 13:55:00');
SET @oid = LAST_INSERT_ID();
INSERT INTO order_items (order_id, topup_package_id, quantity, price, account_id) VALUES (@oid, 135, 1, 1051.21, 'ChiefJuan');
INSERT INTO payments (order_id, payment_method, amount, transaction_reference, status, paid_at, created_at)
VALUES (@oid, 'MAYA', 1031.21, 'TXN-JUN-0004', 'SUCCESS', '2025-04-23 13:55:25', '2025-04-23 13:55:00');