USE topupservicesystem;

SELECT * FROM users;
SELECT * FROM games;
SELECT * FROM topup_packages;
SELECT * FROM vouchers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM providers;
SELECT * FROM provider_products;

SELECT * FROM token;
SELECT * FROM verification_code;

SELECT * FROM users
WHERE role = 'USER';

-- DEBUG
SET SQL_SAFE_UPDATES = 0;
DELETE FROM token;
ALTER TABLE token AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM orders 
ORDER BY id DESC 
LIMIT 500;

SELECT MIN(id), MAX(id), COUNT(*) FROM users;
SELECT MIN(id), MAX(id), COUNT(*) FROM topup_packages;
SELECT MIN(id), MAX(id), COUNT(*) FROM vouchers;
SELECT MIN(id), MAX(id), COUNT(*) FROM orders;

SELECT order_id, COUNT(*) 
FROM order_items 
GROUP BY order_id 
HAVING COUNT(*) > 1;

SELECT COUNT(*) FROM orders;

SELECT * FROM games WHERE status = 'DEPRECATED';

SHOW CREATE TABLE games;
UPDATE games SET provider_id = NULL WHERE provider_id = 0;