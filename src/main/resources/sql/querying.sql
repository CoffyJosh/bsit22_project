-- Display all records from guests, rooms, and reservations
SELECT * FROM guests;
SELECT * FROM rooms;
SELECT * FROM reservations;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- Display all guests with complete information
SELECT * FROM guests;

-- Insert  new guest record named: Ethan Villanueva
INSERT INTO guests (first_name, last_name, email, phone_number)
VALUES ('Ethan', 'Villanueva', 'ethanvillanueva1738@yahoo.com', '09691738671');

-- Update room status of room 101 to occupied
UPDATE rooms
SET room_status = 'occupied'
WHERE room_number = '101';

SET SQL_SAFE_UPDATES = 0;

-- Delete all reservation with status: cancelled
DELETE FROM reservations
WHERE reservation_status = 'cancelled';

SELECT * FROM hotel_services
WHERE service_status = 'available';


SELECT * FROM rooms
WHERE room_status = 'available'
ORDER BY floor_number ASC;


SELECT * FROM room_types
ORDER BY price_per_night DESC
LIMIT 5;


SELECT * FROM guests
WHERE last_name LIKE '%Santos%';


SELECT * FROM reservations
WHERE check_in_date BETWEEN '2025-10-01' AND '2025-10-31';


SELECT * FROM payments
WHERE payment_amount > 10000
ORDER BY payment_amount DESC;


SELECT 
	CONCAT(first_name, ' ', last_name) AS guest_name,
    COUNT(r.id) AS total_reservations
FROM guests g
LEFT JOIN reservations r ON g.id = r.guest_id
GROUP BY g.id;


SELECT 
    payment_method,
    SUM(payment_amount) AS total_payment
FROM payments
GROUP BY payment_method;


SELECT 
    type_name,
    AVG(price_per_night) AS avg_price
FROM room_types
GROUP BY type_name
HAVING AVG(price_per_night) > 5000;


SELECT 
    room_id,
    SUM(number_of_guests) AS total_guests
FROM reservation_rooms
GROUP BY room_id;


SELECT 
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    COUNT(r.id) AS total_reservations
FROM guests g
JOIN reservations r ON g.id = r.guest_id
GROUP BY g.id
HAVING COUNT(r.id) > 1;


SELECT 
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    r.check_in_date,
    r.check_out_date,
    r.reservation_status
FROM guests g
INNER JOIN reservations r ON g.id = r.guest_id;


SELECT 
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    r.id AS reservation_id
FROM guests g
LEFT JOIN reservations r ON g.id = r.guest_id;


SELECT 
    r.id AS reservation_id,
    rr.room_id
FROM reservations r
RIGHT JOIN reservation_rooms rr ON r.id = rr.reservation_id;


SELECT 
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    hs.service_name,
    hs.service_fee
FROM guest_services gs
JOIN guests g ON gs.guest_id = g.id
JOIN hotel_services hs ON gs.service_id = hs.id;


SELECT 
    r.id AS reservation_id,
    p.payment_amount,
    p.payment_status
FROM reservations r
JOIN payments p ON r.id = p.reservation_id;


SELECT first_name AS value
FROM guests
UNION
SELECT service_name
FROM hotel_services;


SELECT *
FROM guests
WHERE id IN (
    SELECT guest_id
    FROM reservations
);

SELECT *
FROM room_types
WHERE price_per_night > (
    SELECT AVG(price_per_night)
    FROM room_types
);


WITH total_payments AS (
    SELECT 
        reservation_id,
        SUM(payment_amount) AS total_payment
    FROM payments
    GROUP BY reservation_id
)
SELECT 
    r.id AS reservation_id,
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    tp.total_payment
FROM total_payments tp
JOIN reservations r ON tp.reservation_id = r.id
JOIN guests g ON r.guest_id = g.id
WHERE tp.total_payment > 10000;


WITH guest_counts AS (
    SELECT 
        guest_id,
        COUNT(*) AS total_reservations
    FROM reservations
    GROUP BY guest_id
)
SELECT 
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    gc.total_reservations
FROM guest_counts gc
JOIN guests g ON g.id = gc.guest_id;