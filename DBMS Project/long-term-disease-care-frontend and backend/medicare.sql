-- =========================================================
-- WEEK 2 ASSIGNMENT 2
-- MEDICARE HOSPITAL MANAGEMENT SYSTEM
-- =========================================================

-- Create Schema / Database
CREATE DATABASE IF NOT EXISTS medicare_db;

USE medicare_db;


-- =========================================================
-- REMOVE OLD TABLES IF THEY EXIST
-- =========================================================

DROP TABLE IF EXISTS Doctor_History;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;


-- =========================================================
-- 1. CREATE DOCTORS TABLE
-- =========================================================

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    consultation_fee DECIMAL(10,2)
        CHECK (consultation_fee > 0)
);


-- =========================================================
-- 2. INSERT 10 DOCTORS
-- =========================================================

INSERT INTO Doctors
(doctor_id, doctor_name, specialization, consultation_fee)
VALUES
(1, 'Dr. Ravi Kumar', 'Cardiology', 800.00),
(2, 'Dr. Priya Sharma', 'Neurology', 900.00),
(3, 'Dr. Anil Reddy', 'Orthopedics', 700.00),
(4, 'Dr. Sneha Patel', 'Dermatology', 600.00),
(5, 'Dr. Kiran Rao', 'Cardiology', 850.00),
(6, 'Dr. Meena Nair', 'Pediatrics', 500.00),
(7, 'Dr. Arjun Singh', 'Neurology', 950.00),
(8, 'Dr. Divya Das', 'Orthopedics', 750.00),
(9, 'Dr. Rohit Verma', 'Dermatology', 650.00),
(10, 'Dr. Ananya Reddy', 'Pediatrics', 550.00);

SELECT * FROM Doctors;


-- =========================================================
-- 3. CREATE PATIENTS TABLE
-- =========================================================

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


-- =========================================================
-- 4. INSERT 10 PATIENTS
-- =========================================================

INSERT INTO Patients
(patient_id, patient_name, email)
VALUES
(101, 'Aarav Kumar', 'aarav@gmail.com'),
(102, 'Diya Sharma', 'diya@gmail.com'),
(103, 'Rohan Reddy', 'rohan@gmail.com'),
(104, 'Isha Patel', 'isha@gmail.com'),
(105, 'Aditya Rao', 'aditya@gmail.com'),
(106, 'Nisha Singh', 'nisha@gmail.com'),
(107, 'Varun Das', 'varun@gmail.com'),
(108, 'Meera Nair', 'meera@gmail.com'),
(109, 'Kavya Verma', 'kavya@gmail.com'),
(110, 'Rahul Gupta', 'rahul@gmail.com');

SELECT * FROM Patients;


-- =========================================================
-- 5. CREATE APPOINTMENTS TABLE
-- =========================================================

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE NOT NULL,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id),

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
);


-- =========================================================
-- 6. INSERT 10 APPOINTMENTS
-- =========================================================

INSERT INTO Appointments
(appointment_id, doctor_id, patient_id, appointment_date)
VALUES
(1, 1, 101, '2026-08-10'),
(2, 2, 102, '2026-08-11'),
(3, 3, 103, '2026-08-12'),
(4, 4, 104, '2026-08-13'),
(5, 5, 105, '2026-08-14'),
(6, 6, 106, '2026-08-15'),
(7, 7, 107, '2026-08-16'),
(8, 8, 108, '2026-08-17'),
(9, 9, 109, '2026-08-18'),
(10, 10, 110, '2026-08-19');

SELECT * FROM Appointments;


-- =========================================================
-- 7. INNER JOIN
-- PATIENT + DOCTOR DETAILS
-- =========================================================

SELECT
    p.patient_name AS Patient_Name,
    d.doctor_name AS Doctor_Name,
    d.specialization AS Specialization,
    a.appointment_date AS Appointment_Date
FROM Appointments a
INNER JOIN Patients p
    ON a.patient_id = p.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id;


-- =========================================================
-- 8. GROUP BY + COUNT
-- NUMBER OF DOCTORS IN EACH SPECIALIZATION
-- =========================================================

SELECT
    specialization,
    COUNT(doctor_id) AS Total_Doctors
FROM Doctors
GROUP BY specialization
ORDER BY specialization;


-- =========================================================
-- 9. CREATE DOCTOR HISTORY
-- =========================================================

CREATE TABLE Doctor_History (
    history_id INT PRIMARY KEY,
    doctor_id INT,
    action_type VARCHAR(50),
    registration_date DATE,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
);


-- =========================================================
-- 10. TRANSACTION
-- REGISTER NEW DOCTOR + HISTORY
-- =========================================================

START TRANSACTION;

INSERT INTO Doctors
(doctor_id, doctor_name, specialization, consultation_fee)
VALUES
(11, 'Dr. Vikram Rao', 'Cardiology', 900.00);

INSERT INTO Doctor_History
(history_id, doctor_id, action_type, registration_date)
VALUES
(1, 11, 'NEW DOCTOR REGISTERED', CURDATE());

COMMIT;


-- =========================================================
-- 11. DISPLAY DOCTOR HISTORY
-- =========================================================

SELECT * FROM Doctor_History;


-- =========================================================
-- 12. CREATE INDEX ON SPECIALIZATION
-- =========================================================

CREATE INDEX idx_doctor_specialization
ON Doctors(specialization);


-- =========================================================
-- 13. SEARCH DOCTOR BY SPECIALIZATION
-- =========================================================

SELECT *
FROM Doctors
WHERE specialization = 'Cardiology';


-- =========================================================
-- 14. FINAL DISPLAY
-- =========================================================

SELECT * FROM Doctors;

SELECT * FROM Patients;

SELECT * FROM Appointments;

SELECT * FROM Doctor_History;