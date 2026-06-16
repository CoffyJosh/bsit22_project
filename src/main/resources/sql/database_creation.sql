DROP DATABASE stayease_db;

CREATE DATABASE stayease_db;
USE stayease_db;

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE room_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    max_capacity INT NOT NULL
);

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(20) UNIQUE NOT NULL,
    floor_number INT NOT NULL,
    room_status VARCHAR(50) NOT NULL,
    room_type_id INT NOT NULL,
    
	CONSTRAINT fk_room_type
		FOREIGN KEY (room_type_id)
		REFERENCES room_types(id)
);

CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    reservation_status VARCHAR(50) NOT NULL,
    special_request TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_guest
		FOREIGN KEY (guest_id)
		REFERENCES guests(id),
		CHECK(check_out_date > check_in_date)
);

CREATE TABLE reservation_rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    room_id INT NOT NULL,
    number_of_guests INT NOT NULL CHECK (number_of_guests > 0),
    remarks VARCHAR(255),

    CONSTRAINT fk_reservation_id
        FOREIGN KEY (reservation_id)
        REFERENCES reservations(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_room_id
        FOREIGN KEY (room_id)
        REFERENCES rooms(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_reservation_room 
		UNIQUE (reservation_id, room_id)
);

CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL CHECK(payment_amount > 0),
    payment_method VARCHAR(50) NOT NULL,
    payment_date DATE,
    payment_status VARCHAR(50) NOT NULL,

    CONSTRAINT fk_payment_reservation
		FOREIGN KEY (reservation_id)
		REFERENCES reservations(id)
);

CREATE TABLE hotel_services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    service_fee DECIMAL(10,2) NOT NULL CHECK (service_fee >= 0),
    service_status VARCHAR(50) NOT NULL
);

CREATE TABLE guest_services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    service_id INT NOT NULL,
    availed_date DATE NOT NULL,
    notes VARCHAR(255),

    CONSTRAINT fk_guest_id
		FOREIGN KEY (guest_id)
        REFERENCES guests(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_service_id
        FOREIGN KEY (service_id)
        REFERENCES hotel_services(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_guest_service UNIQUE (guest_id, service_id, availed_date)
);

