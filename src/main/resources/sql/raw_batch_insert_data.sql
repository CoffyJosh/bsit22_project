-- =========================================================
-- INSERT DATA
-- =========================================================

-- =========================
-- INSERT INTO guests
-- =========================

INSERT INTO guests 
(first_name, last_name, email, phone_number)
VALUES
('John', 'Santos', 'john.santos@gmail.com', '09171234561'),
('Maria', 'Reyes', 'maria.reyes@gmail.com', '09171234562'),
('James', 'Garcia', 'james.garcia@gmail.com', '09171234563'),
('Anna', 'Mendoza', 'anna.mendoza@gmail.com', '09171234564'),
('Michael', 'Torres', 'michael.torres@gmail.com', '09171234565'),
('Sophia', 'Cruz', 'sophia.cruz@gmail.com', '09171234566'),
('Daniel', 'Ramos', 'daniel.ramos@gmail.com', '09171234567'),
('Laura', 'Bautista', 'laura.bautista@gmail.com', '09171234568'),
('Chris', 'Flores', 'chris.flores@gmail.com', '09171234569'),
('Angela', 'Gonzales', 'angela.gonzales@gmail.com', '09171234570'),
('Kevin', 'Lim', 'kevin.lim@gmail.com', '09171234571'),
('Patricia', 'Ong', 'patricia.ong@gmail.com', '09171234572'),
('Brian', 'Tan', 'brian.tan@gmail.com', '09171234573'),
('Catherine', 'Sy', 'catherine.sy@gmail.com', '09171234574'),
('Joshua', 'Lee', NULL, '09171234575'),
('Carla', 'Aquino', 'carla.aquino@gmail.com', '09171234576'),
('Victor', 'Salazar', 'victor.salazar@gmail.com', '09171234577'),
('Diane', 'Velasco', 'diane.velasco@gmail.com', '09171234578'),
('Ronnie', 'Mercado', 'ronnie.mercado@gmail.com', '09171234579'),
('Ella', 'Fernandez', 'ella.fernandez@gmail.com', '09171234580'),
('Jason', 'Pineda', 'jason.pineda@gmail.com', '09171234581'),
('Kim', 'Alvarez', 'kim.alvarez@gmail.com', '09171234582'),
('Leo', 'Gutierrez', 'leo.gutierrez@gmail.com', '09171234583'),
('Nina', 'Padilla', 'nina.padilla@gmail.com', '09171234584'),
('Arvin', 'Domingo', NULL, '09171234585');

-- =========================
-- INSERT INTO room_types
-- =========================

INSERT INTO room_types
(type_name, price_per_night, max_capacity)
VALUES
('Standard Room', 2500, 2),
('Deluxe Room', 4500, 3),
('Executive Suite', 8500, 4),
('Family Room', 6500, 6),
('Presidential Suite', 15000, 8);

-- =========================
-- INSERT INTO rooms
-- =========================

INSERT INTO rooms
(room_number, floor_number, room_status, room_type_id)
VALUES
('101', 1, 'available', 1),
('102', 1, 'occupied', 1),
('103', 1, 'maintenance', 1),

('201', 2, 'occupied', 2),
('202', 2, 'available', 2),
('203', 2, 'available', 2),

('301', 3, 'occupied', 3),
('302', 3, 'available', 3),

('401', 4, 'occupied', 4),
('402', 4, 'available', 4),

('501', 5, 'available', 5),
('502', 5, 'maintenance', 5),

('104', 1, 'available', 1),
('105', 1, 'occupied', 1),

('204', 2, 'maintenance', 2),
('205', 2, 'available', 2),

('303', 3, 'occupied', 3),
('304', 3, 'available', 3),

('403', 4, 'occupied', 4),
('404', 4, 'available', 4),

('503', 5, 'occupied', 5),
('504', 5, 'available', 5);

-- =========================
-- INSERT INTO reservations
-- =========================

INSERT INTO reservations
(guest_id, check_in_date, check_out_date, reservation_status, special_request)
VALUES
(1, '2025-10-01', '2025-10-03', 'completed', 'Near elevator'),
(2, '2025-10-02', '2025-10-05', 'confirmed', NULL),
(3, '2025-10-03', '2025-10-04', 'cancelled', 'Late check-in'),
(4, '2025-10-05', '2025-10-07', 'completed', NULL),
(5, '2025-10-06', '2025-10-08', 'confirmed', 'Extra pillows'),
(6, '2025-10-08', '2025-10-10', 'pending', NULL),
(7, '2025-10-10', '2025-10-12', 'completed', 'High floor'),
(8, '2025-10-12', '2025-10-15', 'confirmed', NULL),
(9, '2025-10-15', '2025-10-17', 'completed', NULL),
(10, '2025-10-18', '2025-10-20', 'confirmed', 'Airport pickup'),
(11, '2025-10-20', '2025-10-22', 'confirmed', 'Late arrival'),
(12, '2025-10-21', '2025-10-23', 'completed', NULL),
(13, '2025-10-22', '2025-10-24', 'completed', 'Extra towels'),
(14, '2025-10-23', '2025-10-25', 'pending', NULL),
(15, '2025-10-24', '2025-10-26', 'confirmed', 'Sea view'),
(16, '2025-10-25', '2025-10-27', 'cancelled', NULL),
(17, '2025-10-26', '2025-10-28', 'completed', NULL),
(18, '2025-10-27', '2025-10-29', 'confirmed', 'Airport pickup'),
(19, '2025-10-28', '2025-10-30', 'completed', NULL),
(20, '2025-10-29', '2025-10-31', 'pending', 'Quiet room'),
(2, '2025-11-01', '2025-11-03', 'completed', NULL),
(4, '2025-11-02', '2025-11-05', 'confirmed', 'Birthday celebration'),
(7, '2025-11-03', '2025-11-04', 'completed', NULL),
(9, '2025-11-04', '2025-11-06', 'confirmed', NULL),
(1, '2025-11-05', '2025-11-07', 'completed', 'VIP guest');


-- =========================
-- INSERT INTO reservation_rooms
-- =========================

INSERT INTO reservation_rooms
(reservation_id, room_id, number_of_guests, remarks)
VALUES
(1, 2, 2, NULL),
(2, 4, 3, 'Extra bed requested'),
(3, 5, 1, NULL),
(4, 7, 2, NULL),
(5, 9, 4, 'Birthday setup'),
(6, 1, 2, NULL),
(7, 8, 2, NULL),
(8, 10, 5, 'Family booking'),
(9, 4, 2, NULL),
(10, 11, 6, 'VIP guest'),
(11, 12, 2, NULL),
(12, 13, 2, 'Near elevator'),
(13, 15, 3, NULL),
(14, 16, 2, NULL),
(15, 18, 5, 'Family stay'),
(16, 3, 1, 'Cancelled reservation'),
(17, 7, 2, NULL),
(18, 10, 4, 'Airport transfer included'),
(19, 14, 2, NULL),
(20, 5, 2, 'Quiet room requested'),
(21, 9, 3, NULL),
(22, 17, 4, 'Birthday setup'),
(23, 4, 1, NULL),
(24, 20, 2, NULL),
(25, 19, 6, 'VIP booking');

-- =========================
-- INSERT INTO payments
-- =========================

INSERT INTO payments
(reservation_id, payment_amount, payment_method, payment_date, payment_status)
VALUES
(1, 5000, 'credit card', '2025-10-01', 'paid'),
(2, 13500, 'e-wallet', '2025-10-02', 'paid'),
(4, 17000, 'cash', '2025-10-05', 'paid'),
(5, 13000, 'debit card', '2025-10-06', 'partially paid'),
(7, 8500, 'credit card', '2025-10-10', 'paid'),
(8, 19500, 'cash', '2025-10-12', 'paid'),
(11, 9000, 'credit card', '2025-10-20', 'paid'),
(12, 8500, 'cash', '2025-10-21', 'paid'),
(13, 17000, 'e-wallet', '2025-10-22', 'paid'),
(15, 30000, 'debit card', '2025-10-24', 'partially paid'),
(17, 8500, 'credit card', '2025-10-26', 'paid'),
(18, 19500, 'cash', '2025-10-27', 'paid'),
(19, 15000, 'e-wallet', '2025-10-28', 'paid'),
(21, 13000, 'cash', '2025-11-01', 'paid'),
(22, 26000, 'credit card', '2025-11-02', 'paid'),
(23, 4500, 'debit card', '2025-11-03', 'paid'),
(25, 45000, 'credit card', '2025-11-05', 'paid');

-- =========================
-- INSERT INTO hotel_services
-- =========================

INSERT INTO hotel_services
(service_name, service_fee, service_status)
VALUES
('Spa Service', 1500, 'available'),
('Laundry Service', 500, 'available'),
('Airport Transfer', 1200, 'available'),
('Breakfast Buffet', 800, 'available'),
('Room Service', 1000, 'available'),
('Gym Access', 300, 'available'),
('Conference Room', 5000, 'maintenance'),
('Private Pool Access', 2500, 'available'),
('Massage Therapy', 1800, 'available'),
('Pet Accommodation', 1200, 'available');

-- =========================
-- INSERT INTO guest_services
-- =========================

INSERT INTO guest_services
(guest_id, service_id, availed_date, notes)
VALUES
(1, 1, '2025-10-02', NULL),
(1, 4, '2025-10-02', NULL),
(2, 2, '2025-10-03', 'Express service'),
(4, 3, '2025-10-06', NULL),
(5, 5, '2025-10-07', 'Late night request'),
(7, 1, '2025-10-11', NULL),
(8, 6, '2025-10-13', NULL),
(10, 4, '2025-10-19', 'VIP breakfast'),
(11, 2, '2025-10-20', NULL),
(12, 3, '2025-10-21', 'Airport pickup arranged'),
(13, 1, '2025-10-22', NULL),
(13, 4, '2025-10-22', NULL),
(14, 6, '2025-10-23', NULL),
(15, 5, '2025-10-24', 'Late dinner request'),
(17, 8, '2025-10-26', NULL),
(18, 9, '2025-10-27', 'Private access'),
(19, 10, '2025-10-28', NULL),
(9, 1, '2025-11-04', NULL),
(1, 5, '2025-11-05', 'VIP room service');

-- =========================================================
-- END OF SCRIPT
-- =========================================================