USE topupservicesystem;

SELECT * FROM users;
SELECT * FROM games;
SELECT * FROM topup_packages;
SELECT * FROM vouchers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;

SELECT * FROM token;
SELECT * FROM verification_code;


-- DEBUG
SET SQL_SAFE_UPDATES = 0;
DELETE FROM token;
ALTER TABLE token AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SELECT MIN(id), MAX(id), COUNT(*) FROM users;
SELECT MIN(id), MAX(id), COUNT(*) FROM topup_packages;
SELECT MIN(id), MAX(id), COUNT(*) FROM vouchers;
SELECT MIN(id), MAX(id), COUNT(*) FROM orders;