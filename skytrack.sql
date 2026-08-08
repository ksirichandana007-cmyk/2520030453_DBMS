-- =========================================================
-- WEEK 2 ASSIGNMENT 1
-- SKYTRACK AIRLINE MANAGEMENT SYSTEM
-- =========================================================

-- Create Schema / Database
CREATE DATABASE IF NOT EXISTS skytrack_db;

USE skytrack_db;


-- =========================================================
-- REMOVE OLD TABLES IF THEY EXIST
-- =========================================================

DROP TABLE IF EXISTS Flight_History;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Passengers;
DROP TABLE IF EXISTS Flights;


-- =========================================================
-- 1. CREATE FLIGHTS TABLE
-- =========================================================

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(20) UNIQUE NOT NULL,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_date DATE NOT NULL,
    ticket_price DECIMAL(10,2) CHECK (ticket_price > 0)
);


-- =========================================================
-- 2. INSERT 10 FLIGHTS
-- =========================================================

INSERT INTO Flights
(flight_id, flight_number, source, destination, departure_date, ticket_price)
VALUES
(1, 'ST101', 'Hyderabad', 'Delhi', '2026-08-10', 5500.00),
(2, 'ST102', 'Mumbai', 'Delhi', '2026-08-11', 6200.00),
(3, 'ST103', 'Bangalore', 'Mumbai', '2026-08-12', 4800.00),
(4, 'ST104', 'Chennai', 'Hyderabad', '2026-08-13', 4500.00),
(5, 'ST105', 'Delhi', 'Kolkata', '2026-08-14', 5800.00),
(6, 'ST106', 'Hyderabad', 'Mumbai', '2026-08-15', 5200.00),
(7, 'ST107', 'Bangalore', 'Delhi', '2026-08-16', 6500.00),
(8, 'ST108', 'Kolkata', 'Chennai', '2026-08-17', 6100.00),
(9, 'ST109', 'Mumbai', 'Hyderabad', '2026-08-18', 4900.00),
(10, 'ST110', 'Chennai', 'Delhi', '2026-08-19', 5700.00);

SELECT * FROM Flights;


-- =========================================================
-- 3. CREATE PASSENGERS TABLE
-- =========================================================

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


-- =========================================================
-- 4. INSERT 10 PASSENGERS
-- =========================================================

INSERT INTO Passengers
(passenger_id, passenger_name, email)
VALUES
(101, 'Rahul Sharma', 'rahul@gmail.com'),
(102, 'Priya Reddy', 'priya@gmail.com'),
(103, 'Arjun Kumar', 'arjun@gmail.com'),
(104, 'Sneha Patel', 'sneha@gmail.com'),
(105, 'Kiran Rao', 'kiran@gmail.com'),
(106, 'Ananya Singh', 'ananya@gmail.com'),
(107, 'Vikram Das', 'vikram@gmail.com'),
(108, 'Meera Nair', 'meera@gmail.com'),
(109, 'Rohit Verma', 'rohit@gmail.com'),
(110, 'Divya Sharma', 'divya@gmail.com');

SELECT * FROM Passengers;


-- =========================================================
-- 5. CREATE BOOKINGS TABLE
-- =========================================================

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATE NOT NULL,

    FOREIGN KEY (passenger_id)
        REFERENCES Passengers(passenger_id),

    FOREIGN KEY (flight_id)
        REFERENCES Flights(flight_id)
);


-- =========================================================
-- 6. INSERT 10 BOOKINGS
-- =========================================================

INSERT INTO Bookings
(booking_id, passenger_id, flight_id, booking_date)
VALUES
(1, 101, 1, '2026-08-01'),
(2, 102, 2, '2026-08-01'),
(3, 103, 3, '2026-08-02'),
(4, 104, 4, '2026-08-02'),
(5, 105, 5, '2026-08-03'),
(6, 106, 6, '2026-08-03'),
(7, 107, 7, '2026-08-04'),
(8, 108, 8, '2026-08-04'),
(9, 109, 9, '2026-08-05'),
(10, 110, 10, '2026-08-05');

SELECT * FROM Bookings;


-- =========================================================
-- 7. INNER JOIN
-- PASSENGER NAME + FLIGHT DETAILS
-- =========================================================

SELECT
    p.passenger_name AS Passenger_Name,
    f.flight_number AS Flight_Number,
    f.source AS Source,
    f.destination AS Destination
FROM Bookings b
INNER JOIN Passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id;


-- =========================================================
-- 8. GROUP BY + COUNT
-- TOTAL FLIGHTS TO EACH DESTINATION
-- =========================================================

SELECT
    destination,
    COUNT(flight_id) AS Total_Flights
FROM Flights
GROUP BY destination
ORDER BY destination;


-- =========================================================
-- 9. CREATE FLIGHT HISTORY
-- =========================================================

CREATE TABLE Flight_History (
    history_id INT PRIMARY KEY,
    flight_id INT,
    action_type VARCHAR(50),
    action_date DATE,

    FOREIGN KEY (flight_id)
        REFERENCES Flights(flight_id)
);


-- =========================================================
-- 10. TRANSACTION
-- ADD NEW FLIGHT + HISTORY RECORD
-- =========================================================

START TRANSACTION;

INSERT INTO Flights
(flight_id, flight_number, source, destination, departure_date, ticket_price)
VALUES
(11, 'ST111', 'Hyderabad', 'Bangalore', '2026-08-20', 5000.00);

INSERT INTO Flight_History
(history_id, flight_id, action_type, action_date)
VALUES
(1, 11, 'NEW FLIGHT ADDED', CURDATE());

COMMIT;


-- =========================================================
-- 11. DISPLAY HISTORY
-- =========================================================

SELECT * FROM Flight_History;


-- =========================================================
-- 12. CREATE INDEX ON FLIGHT NUMBER
-- =========================================================

CREATE INDEX idx_flight_number
ON Flights(flight_number);


-- =========================================================
-- 13. SEARCH USING FLIGHT NUMBER
-- =========================================================

SELECT *
FROM Flights
WHERE flight_number = 'ST103';


-- =========================================================
-- 14. FINAL DISPLAY
-- =========================================================

SELECT * FROM Flights;

SELECT * FROM Passengers;

SELECT * FROM Bookings;

SELECT * FROM Flight_History;