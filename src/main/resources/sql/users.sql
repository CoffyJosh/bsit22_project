USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS users;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM users;
ALTER TABLE users AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
-- Passwords are BCrypt hashed but non-functional placeholders for mock data
INSERT INTO users (name, email, password, role, status, created_at) VALUES
('Juan Dela Cruz',  'juan.delacruz@gmail.com',  '$2a$10$dummyhashJuanDelaC1234xyz', 'USER',  'ACTIVE', '2025-08-15 10:00:00'),
('Maria Santos',    'maria.santos@gmail.com',    '$2a$10$dummyhashMariaSanto5678ab', 'USER',  'ACTIVE', '2025-08-20 11:00:00'),
('Carlo Reyes',     'carlo.reyes@gmail.com',     '$2a$10$dummyhashCarloReyes9012cd', 'USER',  'ACTIVE', '2025-09-01 09:00:00'),
('Ana Gonzales',    'ana.gonzales@gmail.com',    '$2a$10$dummyhashAnaGonzale3456ef', 'USER',  'ACTIVE', '2025-09-10 14:00:00'),
('Miguel Bautista', 'miguel.bautista@gmail.com', '$2a$10$dummyhashMiguelBaut7890gh', 'USER',  'ACTIVE', '2025-09-15 08:00:00'),
('Admin User',      'admin@auragames.ph',        '$2a$10$dummyhashAdminUser1234ij',  'ADMIN', 'ACTIVE', '2025-08-01 00:00:00');
