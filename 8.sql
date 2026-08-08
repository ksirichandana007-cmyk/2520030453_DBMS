-- ============================================================
-- BANK DATABASE - ACID PROPERTIES & ISOLATION
-- DATABASE: Bank_ACID_DB
-- ============================================================

CREATE DATABASE IF NOT EXISTS Bank_ACID_DB;

USE Bank_ACID_DB;


-- ============================================================
-- CLEAN OLD TABLES
-- ============================================================

DROP TABLE IF EXISTS Bank_Transaction;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Customer;


-- ============================================================
-- 1. CREATE CUSTOMER TABLE
-- ============================================================

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    City VARCHAR(50)
);


-- ============================================================
-- 2. CREATE ACCOUNT TABLE
-- ============================================================

CREATE TABLE Account (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2),
    Branch VARCHAR(50),

    FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);


-- ============================================================
-- 3. CREATE TRANSACTION TABLE
-- ============================================================

CREATE TABLE Bank_Transaction (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (Account_No)
        REFERENCES Account(Account_No)
);


-- ============================================================
-- 4. INSERT CUSTOMER DATA
-- ============================================================

INSERT INTO Customer
(Customer_ID, Customer_Name, Phone, City)
VALUES
(101, 'Ravi Kumar', '9876543210', 'Hyderabad'),
(102, 'Priya Sharma', '9876543211', 'Vijayawada'),
(103, 'Arjun Reddy', '9876543212', 'Bangalore'),
(104, 'Sneha Rao', '9876543213', 'Chennai'),
(105, 'Kiran Kumar', '9876543214', 'Hyderabad');


-- ============================================================
-- 5. INSERT ACCOUNT DATA
-- ============================================================

INSERT INTO Account
(Account_No, Customer_ID, Account_Type, Balance, Branch)
VALUES
(10001, 101, 'Savings', 50000.00, 'Hyderabad'),
(10002, 102, 'Savings', 75000.00, 'Vijayawada'),
(10003, 103, 'Current', 120000.00, 'Bangalore'),
(10004, 104, 'Savings', 45000.00, 'Chennai'),
(10005, 105, 'Current', 90000.00, 'Hyderabad');


-- ============================================================
-- 6. INSERT BANK TRANSACTION DATA
-- ============================================================

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 10000.00),
(10002, 'DEPOSIT', 15000.00),
(10003, 'WITHDRAW', 20000.00),
(10004, 'DEPOSIT', 5000.00),
(10005, 'WITHDRAW', 10000.00);


-- ============================================================
-- 7. DISPLAY INITIAL DATA
-- ============================================================

SELECT * FROM Customer;

SELECT * FROM Account;

SELECT * FROM Bank_Transaction;


-- ============================================================
-- PART A - COMMIT
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10001;

SELECT *
FROM Account
WHERE Account_No = 10001;

COMMIT;

SELECT *
FROM Account
WHERE Account_No = 10001;


-- ============================================================
-- PART B - ROLLBACK
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 10000
WHERE Account_No = 10001;

SELECT *
FROM Account
WHERE Account_No = 10001;

ROLLBACK;

SELECT *
FROM Account
WHERE Account_No = 10001;


-- ============================================================
-- PART C - SAVEPOINT
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10001;

SAVEPOINT Deposit1;

UPDATE Account
SET Balance = Balance - 3000
WHERE Account_No = 10002;

SAVEPOINT Withdrawal1;

UPDATE Account
SET Balance = Balance + 10000
WHERE Account_No = 10003;

ROLLBACK TO SAVEPOINT Withdrawal1;

COMMIT;

SELECT *
FROM Account;


-- ============================================================
-- PART D - BANK TRANSFER WITH COMMIT
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 10000
WHERE Account_No = 10001;

UPDATE Account
SET Balance = Balance + 10000
WHERE Account_No = 10002;

SELECT *
FROM Account
WHERE Account_No IN (10001, 10002);

COMMIT;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No IN (10001, 10002);


-- ============================================================
-- PART E - TRANSFER WITH ROLLBACK
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 20000
WHERE Account_No = 10001;

UPDATE Account
SET Balance = Balance + 20000
WHERE Account_No = 10002;

ROLLBACK;

SELECT *
FROM Account
WHERE Account_No IN (10001, 10002);


-- ============================================================
-- PART F - ACID ATOMICITY EXAMPLE
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 10000
WHERE Account_No = 10001;

UPDATE Account
SET Balance = Balance + 10000
WHERE Account_No = 10002;

COMMIT;


-- ============================================================
-- PART G - CONSISTENCY CHECK
-- ============================================================

SELECT
    SUM(Balance) AS Total_Balance
FROM Account;


START TRANSACTION;

UPDATE Account
SET Balance = Balance - 5000
WHERE Account_No = 10001;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10002;

COMMIT;


SELECT
    SUM(Balance) AS Total_Balance
FROM Account;


-- ============================================================
-- PART H - DURABILITY EXAMPLE
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10001;

COMMIT;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No = 10001;


-- ============================================================
-- PART I - CHECK CURRENT ISOLATION LEVEL
-- ============================================================

SELECT @@SESSION.transaction_isolation;

SELECT @@GLOBAL.transaction_isolation;


-- ============================================================
-- PART J - READ UNCOMMITTED
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No = 10001;

COMMIT;


-- ============================================================
-- PART K - READ COMMITTED
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No = 10001;

COMMIT;


-- ============================================================
-- PART L - REPEATABLE READ
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No = 10001;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No = 10001;

COMMIT;


-- ============================================================
-- PART M - SERIALIZABLE
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;

SELECT
    Account_No,
    Balance
FROM Account
WHERE Account_No = 10001;

COMMIT;


-- ============================================================
-- RESET TO MYSQL DEFAULT
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;


-- ============================================================
-- PART N - DEPOSIT TRANSACTION
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 10001;

COMMIT;


-- ============================================================
-- PART O - WITHDRAWAL TRANSACTION
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 5000
WHERE Account_No = 10001;

COMMIT;


-- ============================================================
-- PART P - CANCEL WITHDRAWAL
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 10000
WHERE Account_No = 10001;

ROLLBACK;


-- ============================================================
-- PART Q - TRANSFER WITH SAVEPOINT
-- ============================================================

START TRANSACTION;

UPDATE Account
SET Balance = Balance - 10000
WHERE Account_No = 10001;

SAVEPOINT AfterDebit;

UPDATE Account
SET Balance = Balance + 10000
WHERE Account_No = 10002;

COMMIT;


-- ============================================================
-- FINAL ACCOUNT DATA
-- ============================================================

SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance,
    Branch
FROM Account
ORDER BY Account_No;


-- ============================================================
-- FINAL TRANSACTION DATA
-- ============================================================

SELECT *
FROM Bank_Transaction
ORDER BY Transaction_ID;


-- ============================================================
-- FINAL ISOLATION LEVEL
-- ============================================================

SELECT @@SESSION.transaction_isolation;


-- ============================================================
-- END OF BANK ACID PRACTICAL
-- ============================================================