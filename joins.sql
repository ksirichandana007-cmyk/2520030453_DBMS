-- =========================================================
-- TOPIC: JOINS AND SET OPERATIONS
-- DATABASE: JOINS_DB
-- =========================================================

-- =========================================================
-- STEP 1: CREATE NEW SCHEMA
-- =========================================================

CREATE DATABASE IF NOT EXISTS joins_db;

USE joins_db;


-- =========================================================
-- STEP 2: REMOVE OLD TABLES IF THEY EXIST
-- =========================================================

DROP TABLE IF EXISTS first_table;
DROP TABLE IF EXISTS second_table;
DROP TABLE IF EXISTS class_info;
DROP TABLE IF EXISTS class;


-- =========================================================
-- PART 1: CROSS JOIN
-- =========================================================

-- Create class table
CREATE TABLE class (
    id INT,
    name VARCHAR(30)
);

-- Create class_info table
CREATE TABLE class_info (
    id INT,
    address VARCHAR(30)
);


-- Insert data
INSERT INTO class VALUES
(1, 'abhi'),
(2, 'adam'),
(3, 'alex'),
(4, 'anu');

INSERT INTO class_info VALUES
(1, 'DELHI'),
(2, 'MUMBAI'),
(3, 'CHENNAI');


-- =========================================================
-- QUESTION 1 - CROSS JOIN
-- =========================================================

SELECT *
FROM class
CROSS JOIN class_info;


-- =========================================================
-- PART 2: INNER JOIN
-- =========================================================

-- QUESTION 2 - INNER JOIN
-- =========================================================

SELECT *
FROM class
INNER JOIN class_info
ON class.id = class_info.id;


-- =========================================================
-- QUESTION 3 - INNER JOIN
-- =========================================================

SELECT
    class.name,
    class_info.address
FROM class
INNER JOIN class_info
ON class.id = class_info.id;


-- =========================================================
-- PART 3: NATURAL JOIN
-- =========================================================

-- QUESTION 4 - NATURAL JOIN
-- =========================================================

SELECT *
FROM class
NATURAL JOIN class_info;


-- =========================================================
-- PART 4: LEFT OUTER JOIN
-- =========================================================

-- Add extra student
INSERT INTO class VALUES
(5, 'ashish');

-- Add extra addresses
INSERT INTO class_info VALUES
(7, 'NOIDA'),
(8, 'PANIPAT');


-- =========================================================
-- QUESTION 5 - LEFT JOIN
-- =========================================================

SELECT *
FROM class
LEFT OUTER JOIN class_info
ON class.id = class_info.id;


-- =========================================================
-- QUESTION 6 - LEFT JOIN
-- Students without address
-- =========================================================

SELECT
    class.id,
    class.name
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL;


-- =========================================================
-- PART 5: RIGHT OUTER JOIN
-- =========================================================

-- QUESTION 7 - RIGHT JOIN
-- =========================================================

SELECT *
FROM class
RIGHT OUTER JOIN class_info
ON class.id = class_info.id;


-- =========================================================
-- QUESTION 8 - RIGHT JOIN
-- Address records without students
-- =========================================================

SELECT
    class_info.id,
    class_info.address
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;


-- =========================================================
-- PART 6: FULL OUTER JOIN
-- =========================================================

-- MySQL does not have FULL OUTER JOIN.
-- We simulate it using LEFT JOIN + RIGHT JOIN.


-- =========================================================
-- QUESTION 9 - FULL OUTER JOIN
-- =========================================================

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
LEFT JOIN class_info
ON class.id = class_info.id

UNION

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id;


-- =========================================================
-- QUESTION 10 - FULL OUTER JOIN
-- Unmatched records only
-- =========================================================

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL

UNION

SELECT
    class.id AS class_id,
    class.name,
    class_info.id AS info_id,
    class_info.address
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;


-- =========================================================
-- PART 7: UNION
-- =========================================================

-- Create first table
CREATE TABLE first_table (
    id INT,
    name VARCHAR(30)
);

-- Create second table
CREATE TABLE second_table (
    id INT,
    name VARCHAR(30)
);


-- Insert data
INSERT INTO first_table VALUES
(1, 'abhi'),
(2, 'adam');

INSERT INTO second_table VALUES
(2, 'adam'),
(3, 'chester');


-- =========================================================
-- QUESTION 11 - UNION
-- =========================================================

SELECT *
FROM first_table

UNION

SELECT *
FROM second_table;


-- =========================================================
-- QUESTION 12 - UNION
-- Names only
-- =========================================================

SELECT name
FROM first_table

UNION

SELECT name
FROM second_table;


-- =========================================================
-- PART 8: UNION ALL
-- =========================================================

-- =========================================================
-- QUESTION 13 - UNION ALL
-- =========================================================

SELECT *
FROM first_table

UNION ALL

SELECT *
FROM second_table;


-- =========================================================
-- QUESTION 14 - UNION ALL + COUNT
-- =========================================================

SELECT COUNT(*) AS Total_Records
FROM
(
    SELECT *
    FROM first_table

    UNION ALL

    SELECT *
    FROM second_table
) AS A;


-- =========================================================
-- PART 9: INTERSECT
-- =========================================================

-- MySQL-compatible INTERSECT using INNER JOIN
-- =========================================================

-- QUESTION 15 - INTERSECT
-- =========================================================

SELECT
    f.id,
    f.name
FROM first_table f
INNER JOIN second_table s
ON f.id = s.id
AND f.name = s.name;


-- =========================================================
-- QUESTION 16 - INTERSECT
-- Common names
-- =========================================================

SELECT DISTINCT
    f.name
FROM first_table f
INNER JOIN second_table s
ON f.name = s.name;


-- =========================================================
-- PART 10: MINUS
-- =========================================================

-- MySQL-compatible MINUS using LEFT JOIN
-- =========================================================

-- QUESTION 17 - MINUS
-- Records only in first_table
-- =========================================================

SELECT
    f.id,
    f.name
FROM first_table f
LEFT JOIN second_table s
ON f.id = s.id
AND f.name = s.name
WHERE s.id IS NULL;


-- =========================================================
-- QUESTION 18 - MINUS
-- Names only in first_table
-- =========================================================

SELECT DISTINCT
    f.name
FROM first_table f
LEFT JOIN second_table s
ON f.name = s.name
WHERE s.name IS NULL;


-- =========================================================
-- PART 11: ADVANCED QUESTIONS
-- =========================================================


-- =========================================================
-- QUESTION 19
-- Find students having matching addresses
-- =========================================================

SELECT
    c.id,
    c.name,
    ci.address
FROM class c
INNER JOIN class_info ci
ON c.id = ci.id;


-- =========================================================
-- QUESTION 20
-- Student address availability
-- =========================================================

SELECT
    c.id,
    c.name,
    CASE
        WHEN ci.address IS NULL
        THEN 'Address Missing'
        ELSE 'Address Available'
    END AS Status
FROM class c
LEFT JOIN class_info ci
ON c.id = ci.id;


-- =========================================================
-- FINAL DISPLAY
-- =========================================================

SELECT * FROM class;

SELECT * FROM class_info;

SELECT * FROM first_table;

SELECT * FROM second_table;


-- =========================================================
-- END OF JOINS AND SET OPERATIONS
-- =========================================================