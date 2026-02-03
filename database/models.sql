CREATE DATABASE IF NOT EXISTS car_rental;
USE car_rental;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'member') NOT NULL
);

CREATE TABLE IF NOT EXISTS cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    status ENUM('available', 'rented') NOT NULL
);

CREATE TABLE IF NOT EXISTS rentals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    car_id INT NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('pending', 'approved', 'rejected','complete') NOT NULL,
    CONSTRAINT fk_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_car
        FOREIGN KEY (car_id) REFERENCES cars(id)
        ON DELETE RESTRICT
);

INSERT INTO users (username, password, role)
SELECT 'admin', 'admin123', 'admin'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE username = 'admin'
);

INSERT INTO cars (name, category, status)
SELECT 'Toyota Avanza', 'SUV', 'available'
WHERE NOT EXISTS (
    SELECT 1 FROM cars WHERE name = 'Toyota Avanza'
);

INSERT INTO cars (name, category, status)
SELECT 'Honda Jazz', 'Hatchback', 'available'
WHERE NOT EXISTS (
    SELECT 1 FROM cars WHERE name = 'Honda Jazz'
);
