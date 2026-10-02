-- =========================================================
-- STUDENT MARKS SQL PRACTICAL
-- =========================================================

-- 1. CREATE SCHEMA / DATABASE
CREATE DATABASE IF NOT EXISTS student_db;

-- Select the schema
USE student_db;


-- =========================================================
-- 2. REMOVE OLD TABLE IF IT EXISTS
-- =========================================================

DROP TABLE IF EXISTS student_marks;


-- =========================================================
-- 3. CREATE TABLE
-- =========================================================

CREATE TABLE student_marks (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    subject VARCHAR(50),
    marks DECIMAL(5,2)
);


-- =========================================================
-- 4. INSERT DATA
-- =========================================================

INSERT INTO student_marks
(roll_no, name, subject, marks)
VALUES
(1, 'Ravi', 'Math', 85.50),
(2, 'Sita', 'Math', 92.75),
(3, 'Anil', 'Math', 78.40),
(4, 'Priya', 'Math', 88.90),
(5, 'Vijay', 'Math', 80.25),
(6, 'subbusir', 'aws', 98.50),
(7, 'dwaraka', 'dbms', 95.75),
(8, 'ranjani', 'english', 97.40),
(9, 'kavithamam', 'aws1', 99.90),
(10, 'seetha', 'azure', 82.25);


-- =========================================================
-- 5. SIMPLE SELECT
-- =========================================================

SELECT * FROM student_marks;


-- =========================================================
-- 6. AGGREGATE FUNCTIONS
-- =========================================================

SELECT COUNT(*) AS total_students
FROM student_marks;

SELECT SUM(marks) AS total_marks
FROM student_marks;

SELECT AVG(marks) AS average_marks
FROM student_marks;

SELECT MAX(marks) AS maximum_marks
FROM student_marks;

SELECT MIN(marks) AS minimum_marks
FROM student_marks;


-- =========================================================
-- 7. WHERE FILTERING
-- =========================================================

-- Marks greater than 85
SELECT *
FROM student_marks
WHERE marks > 85;

-- Marks greater than or equal to 90
SELECT *
FROM student_marks
WHERE marks >= 90;

-- Marks less than 80
SELECT *
FROM student_marks
WHERE marks < 80;

-- Marks between 80 and 90
SELECT *
FROM student_marks
WHERE marks BETWEEN 80 AND 90;

-- Names starting with P
SELECT *
FROM student_marks
WHERE name LIKE 'P%';

-- Names in the given list
SELECT *
FROM student_marks
WHERE name IN ('Ravi', 'Sita', 'Vijay');

-- Combined condition
SELECT *
FROM student_marks
WHERE marks > 85
AND (subject = 'Math' OR name LIKE 'P%');


-- =========================================================
-- 8. UPDATE QUERIES
-- =========================================================

-- Change Anil's marks from 78.40 to 90.00
UPDATE student_marks
SET marks = 90.00
WHERE roll_no = 3;

-- Change subject to Remedial Math for marks below 80
UPDATE student_marks
SET subject = 'Remedial Math'
WHERE marks < 80;

-- Display after update
SELECT * FROM student_marks;


-- =========================================================
-- 9. DELETE QUERIES
-- =========================================================

-- Delete Vijay
DELETE FROM student_marks
WHERE roll_no = 5;

-- Delete anyone with marks below 75
DELETE FROM student_marks
WHERE marks < 75;

-- Display after delete
SELECT * FROM student_marks;


-- =========================================================
-- 10. SORTING
-- =========================================================

-- Marks ascending
SELECT *
FROM student_marks
ORDER BY marks ASC;

-- Marks descending
SELECT *
FROM student_marks
ORDER BY marks DESC;

-- Name ascending
SELECT *
FROM student_marks
ORDER BY name ASC;

-- Name descending
SELECT *
FROM student_marks
ORDER BY name DESC;


-- =========================================================
-- 11. GROUP BY
-- =========================================================

-- Total marks per subject
SELECT
    subject,
    SUM(marks) AS total_marks
FROM student_marks
GROUP BY subject;

-- Average marks per subject
SELECT
    subject,
    AVG(marks) AS avg_marks
FROM student_marks
GROUP BY subject;

-- Number of students per subject
SELECT
    subject,
    COUNT(*) AS num_students
FROM student_marks
GROUP BY subject;


-- =========================================================
-- 12. HAVING
-- =========================================================

-- Subjects having average marks greater than 90
SELECT
    subject,
    AVG(marks) AS avg_marks
FROM student_marks
GROUP BY subject
HAVING AVG(marks) > 90;


-- Subjects having more than 1 student
SELECT
    subject,
    COUNT(*) AS num_students
FROM student_marks
GROUP BY subject
HAVING COUNT(*) > 1;


-- =========================================================
-- FINAL TABLE
-- =========================================================

SELECT * FROM student_marks;