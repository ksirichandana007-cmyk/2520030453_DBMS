-- ============================================================
-- BANK DATABASE - SQL VIEWS PRACTICAL
-- DATABASE: BankViewsDB
-- ============================================================

CREATE DATABASE IF NOT EXISTS BankViewsDB;

USE BankViewsDB;


-- ============================================================
-- REMOVE OLD VIEWS
-- ============================================================

DROP VIEW IF EXISTS
Customer_View,
Customer_Basic_View,
Account_View,
Savings_Account_View,
Current_Account_View,
High_Balance_View,
Hyderabad_Account_View,
Low_Balance_View,
Customer_Account_View,
Hyderabad_Customer_Accounts,
Customer_Loan_View,
Customer_Banking_View,
Total_Bank_Balance,
Average_Account_Balance,
Maximum_Balance_View,
Minimum_Balance_View,
Account_Count_View,
Branch_Account_Count,
Branch_Total_Balance,
Account_Type_Count,
Account_Type_Balance,
Multiple_Account_Branches,
Rich_Branches,
Deposit_Transaction_View,
Withdrawal_Transaction_View,
Customer_Transaction_View,
High_Value_Transaction_View,
Balance_Ranking_View,
Customer_Name_View,
Loan_Interest_View,
Loan_Total_Amount_View,
Simple_Account_View,
High_Balance_Accounts_Practice,
Savings_Above_50000_View,
Hyderabad_Current_View,
Top_Balance_Accounts_View,
Customers_With_Loans_View,
Large_Loans_View,
Branch_Total_Balance_Practice,
Account_Type_Average_View,
City_Customer_Count_View,
Branches_Above_200000_View,
Deposit_Transactions_Practice,
Large_Withdrawals_View,
Customer_Account_Transaction_View,
Customer_Account_Loan_View,
Annual_Loan_Interest_View,
Loan_Total_Calculation_View,
Branches_More_Than_Two_View,
Account_Types_Above_200000_View,
Balance_Between_50000_100000_View,
Highest_Balance_By_Branch_View;


-- ============================================================
-- REMOVE OLD TABLES
-- ============================================================

DROP TABLE IF EXISTS Bank_Transaction;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Customer;


-- ============================================================
-- 1. CREATE CUSTOMER TABLE
-- ============================================================

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
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
-- 3. CREATE BANK TRANSACTION TABLE
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
-- 4. CREATE LOAN TABLE
-- ============================================================

CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Loan_Type VARCHAR(30),
    Loan_Amount DECIMAL(12,2),
    Interest_Rate DECIMAL(5,2),

    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);


-- ============================================================
-- 5. INSERT CUSTOMER DATA
-- ============================================================

INSERT INTO Customer
(Customer_ID, Customer_Name, Phone, Email, City)
VALUES
(101, 'Ravi Kumar', '9876543210', 'ravi@gmail.com', 'Hyderabad'),
(102, 'Priya Sharma', '9876543211', 'priya@gmail.com', 'Vijayawada'),
(103, 'Arjun Reddy', '9876543212', 'arjun@gmail.com', 'Bangalore'),
(104, 'Sneha Rao', '9876543213', 'sneha@gmail.com', 'Chennai'),
(105, 'Kiran Kumar', '9876543214', 'kiran@gmail.com', 'Hyderabad'),
(106, 'Anil Kumar', '9876543215', 'anil@gmail.com', 'Delhi'),
(107, 'Meena Reddy', '9876543216', 'meena@gmail.com', 'Mumbai'),
(108, 'Rahul Sharma', '9876543217', 'rahul@gmail.com', 'Pune'),
(109, 'Lakshmi Devi', '9876543218', 'lakshmi@gmail.com', 'Hyderabad'),
(110, 'Suresh Babu', '9876543219', 'suresh@gmail.com', 'Vijayawada');


-- ============================================================
-- 6. INSERT ACCOUNT DATA
-- ============================================================

INSERT INTO Account
(Account_No, Customer_ID, Account_Type, Balance, Branch)
VALUES
(10001, 101, 'Savings', 50000, 'Hyderabad'),
(10002, 102, 'Savings', 75000, 'Vijayawada'),
(10003, 103, 'Current', 120000, 'Bangalore'),
(10004, 104, 'Savings', 45000, 'Chennai'),
(10005, 105, 'Current', 90000, 'Hyderabad'),
(10006, 106, 'Savings', 65000, 'Delhi'),
(10007, 107, 'Current', 150000, 'Mumbai'),
(10008, 108, 'Savings', 35000, 'Pune'),
(10009, 109, 'Savings', 85000, 'Hyderabad'),
(10010, 110, 'Current', 110000, 'Vijayawada');


-- ============================================================
-- 7. INSERT TRANSACTION DATA
-- ============================================================

INSERT INTO Bank_Transaction
(Account_No, Transaction_Type, Amount)
VALUES
(10001, 'DEPOSIT', 10000),
(10001, 'WITHDRAW', 5000),
(10002, 'DEPOSIT', 15000),
(10003, 'WITHDRAW', 20000),
(10004, 'DEPOSIT', 5000),
(10005, 'WITHDRAW', 10000),
(10006, 'DEPOSIT', 12000),
(10007, 'DEPOSIT', 25000),
(10008, 'WITHDRAW', 5000),
(10009, 'DEPOSIT', 20000),
(10010, 'WITHDRAW', 15000);


-- ============================================================
-- 8. INSERT LOAN DATA
-- ============================================================

INSERT INTO Loan
(Loan_ID, Customer_ID, Loan_Type, Loan_Amount, Interest_Rate)
VALUES
(501, 101, 'Home Loan', 5000000, 7.5),
(502, 102, 'Education Loan', 1000000, 6.5),
(503, 103, 'Car Loan', 800000, 8.2),
(504, 104, 'Personal Loan', 500000, 10.5),
(505, 105, 'Home Loan', 4000000, 7.2),
(506, 106, 'Car Loan', 900000, 8.5),
(507, 107, 'Business Loan', 3000000, 9.0),
(508, 109, 'Personal Loan', 600000, 10.0);


-- ============================================================
-- 9. DISPLAY ORIGINAL TABLES
-- ============================================================

SELECT * FROM Customer;
SELECT * FROM Account;
SELECT * FROM Bank_Transaction;
SELECT * FROM Loan;


-- ============================================================
-- PART A - SIMPLE VIEWS
-- ============================================================

CREATE VIEW Customer_View AS
SELECT *
FROM Customer;

SELECT * FROM Customer_View;


CREATE VIEW Customer_Basic_View AS
SELECT
    Customer_ID,
    Customer_Name,
    City
FROM Customer;

SELECT * FROM Customer_Basic_View;


CREATE VIEW Account_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance,
    Branch
FROM Account;

SELECT * FROM Account_View;


CREATE VIEW Savings_Account_View AS
SELECT *
FROM Account
WHERE Account_Type = 'Savings';

SELECT * FROM Savings_Account_View;


CREATE VIEW Current_Account_View AS
SELECT *
FROM Account
WHERE Account_Type = 'Current';

SELECT * FROM Current_Account_View;


-- ============================================================
-- PART B - VIEWS WITH CONDITIONS
-- ============================================================

CREATE VIEW High_Balance_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
WHERE Balance > 100000;

SELECT * FROM High_Balance_View;


CREATE VIEW Hyderabad_Account_View AS
SELECT *
FROM Account
WHERE Branch = 'Hyderabad';

SELECT * FROM Hyderabad_Account_View;


CREATE VIEW Low_Balance_View AS
SELECT
    Account_No,
    Customer_ID,
    Balance
FROM Account
WHERE Balance < 50000;

SELECT * FROM Low_Balance_View;


-- ============================================================
-- PART C - VIEWS USING JOINS
-- ============================================================

CREATE VIEW Customer_Account_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    A.Branch
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID;

SELECT * FROM Customer_Account_View;


CREATE VIEW Hyderabad_Customer_Accounts AS
SELECT
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
WHERE A.Branch = 'Hyderabad';

SELECT * FROM Hyderabad_Customer_Accounts;


CREATE VIEW Customer_Loan_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    L.Loan_ID,
    L.Loan_Type,
    L.Loan_Amount,
    L.Interest_Rate
FROM Customer C
JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customer_Loan_View;


CREATE VIEW Customer_Banking_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    C.City,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    A.Branch,
    L.Loan_Type,
    L.Loan_Amount
FROM Customer C
LEFT JOIN Account A
ON C.Customer_ID = A.Customer_ID
LEFT JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customer_Banking_View;


-- ============================================================
-- PART D - AGGREGATE FUNCTION VIEWS
-- ============================================================

CREATE VIEW Total_Bank_Balance AS
SELECT
    SUM(Balance) AS Total_Balance
FROM Account;

SELECT * FROM Total_Bank_Balance;


CREATE VIEW Average_Account_Balance AS
SELECT
    AVG(Balance) AS Average_Balance
FROM Account;

SELECT * FROM Average_Account_Balance;


CREATE VIEW Maximum_Balance_View AS
SELECT
    MAX(Balance) AS Maximum_Balance
FROM Account;

SELECT * FROM Maximum_Balance_View;


CREATE VIEW Minimum_Balance_View AS
SELECT
    MIN(Balance) AS Minimum_Balance
FROM Account;

SELECT * FROM Minimum_Balance_View;


CREATE VIEW Account_Count_View AS
SELECT
    COUNT(*) AS Total_Accounts
FROM Account;

SELECT * FROM Account_Count_View;


-- ============================================================
-- PART E - GROUP BY VIEWS
-- ============================================================

CREATE VIEW Branch_Account_Count AS
SELECT
    Branch,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Branch;

SELECT * FROM Branch_Account_Count;


CREATE VIEW Branch_Total_Balance AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch;

SELECT * FROM Branch_Total_Balance;


CREATE VIEW Account_Type_Count AS
SELECT
    Account_Type,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Account_Type;

SELECT * FROM Account_Type_Count;


CREATE VIEW Account_Type_Balance AS
SELECT
    Account_Type,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Account_Type;

SELECT * FROM Account_Type_Balance;


-- ============================================================
-- PART F - HAVING VIEWS
-- ============================================================

CREATE VIEW Multiple_Account_Branches AS
SELECT
    Branch,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Branch
HAVING COUNT(*) > 1;

SELECT * FROM Multiple_Account_Branches;


CREATE VIEW Rich_Branches AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch
HAVING SUM(Balance) > 100000;

SELECT * FROM Rich_Branches;


-- ============================================================
-- PART G - TRANSACTION VIEWS
-- ============================================================

CREATE VIEW Deposit_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Transaction_Type = 'DEPOSIT';

SELECT * FROM Deposit_Transaction_View;


CREATE VIEW Withdrawal_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Transaction_Type = 'WITHDRAW';

SELECT * FROM Withdrawal_Transaction_View;


CREATE VIEW Customer_Transaction_View AS
SELECT
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    T.Transaction_ID,
    T.Transaction_Type,
    T.Amount,
    T.Transaction_Date
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
JOIN Bank_Transaction T
ON A.Account_No = T.Account_No;

SELECT * FROM Customer_Transaction_View;


CREATE VIEW High_Value_Transaction_View AS
SELECT *
FROM Bank_Transaction
WHERE Amount > 10000;

SELECT * FROM High_Value_Transaction_View;


-- ============================================================
-- PART H - ORDER BY VIEWS
-- ============================================================

CREATE VIEW Balance_Ranking_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
ORDER BY Balance DESC;

SELECT * FROM Balance_Ranking_View;


CREATE VIEW Customer_Name_View AS
SELECT
    Customer_ID,
    Customer_Name,
    City
FROM Customer
ORDER BY Customer_Name;

SELECT * FROM Customer_Name_View;


-- ============================================================
-- PART I - CALCULATED COLUMN VIEWS
-- ============================================================

CREATE VIEW Loan_Interest_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    (Loan_Amount * Interest_Rate / 100) AS Annual_Interest
FROM Loan;

SELECT * FROM Loan_Interest_View;


CREATE VIEW Loan_Total_Amount_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    Loan_Amount +
    (Loan_Amount * Interest_Rate / 100) AS Total_Amount
FROM Loan;

SELECT * FROM Loan_Total_Amount_View;


-- ============================================================
-- PART J - USING VIEWS WITH QUERIES
-- ============================================================

SELECT *
FROM High_Balance_View
WHERE Balance > 120000;


SELECT *
FROM Savings_Account_View
WHERE Balance > 60000;


SELECT *
FROM Hyderabad_Account_View
WHERE Balance > 50000;


SELECT *
FROM Customer_Basic_View
WHERE City = 'Hyderabad';


SELECT *
FROM Customer_Account_View
ORDER BY Balance DESC;


SELECT *
FROM Customer_Loan_View
WHERE Loan_Amount > 1000000;


-- ============================================================
-- PART K - UPDATE THROUGH SIMPLE VIEW
-- ============================================================

UPDATE Account_View
SET Balance = 60000
WHERE Account_No = 10001;

SELECT *
FROM Account
WHERE Account_No = 10001;


-- ============================================================
-- PART L - INSERT THROUGH SIMPLE VIEW
-- ============================================================

CREATE VIEW Simple_Account_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance,
    Branch
FROM Account;


INSERT INTO Simple_Account_View
(Account_No, Customer_ID, Account_Type, Balance, Branch)
VALUES
(10011, 101, 'Savings', 55000, 'Hyderabad');

SELECT *
FROM Account
WHERE Account_No = 10011;


-- ============================================================
-- PART M - DELETE THROUGH SIMPLE VIEW
-- ============================================================

DELETE FROM Simple_Account_View
WHERE Account_No = 10011;

SELECT *
FROM Account
WHERE Account_No = 10011;


-- ============================================================
-- PART N - VIEW INFORMATION
-- ============================================================

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


SHOW CREATE VIEW Customer_Account_View;


DESCRIBE Customer_Account_View;


-- ============================================================
-- PART O - ADDITIONAL PRACTICE QUESTIONS
-- ============================================================

-- QUESTION 1
-- Customer + Account details

CREATE VIEW High_Balance_Accounts_Practice AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    A.Balance
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID;

SELECT * FROM High_Balance_Accounts_Practice;


-- QUESTION 2
-- Savings accounts above 50000

CREATE VIEW Savings_Above_50000_View AS
SELECT *
FROM Account
WHERE Account_Type = 'Savings'
AND Balance > 50000;

SELECT * FROM Savings_Above_50000_View;


-- QUESTION 3
-- Current accounts from Hyderabad

CREATE VIEW Hyderabad_Current_View AS
SELECT *
FROM Account
WHERE Account_Type = 'Current'
AND Branch = 'Hyderabad';

SELECT * FROM Hyderabad_Current_View;


-- QUESTION 4
-- Top balance accounts

CREATE VIEW Top_Balance_Accounts_View AS
SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
WHERE Balance = (
    SELECT MAX(Balance)
    FROM Account
);

SELECT * FROM Top_Balance_Accounts_View;


-- QUESTION 5
-- Customers who have loans

CREATE VIEW Customers_With_Loans_View AS
SELECT
    C.Customer_Name,
    C.City,
    L.Loan_Type,
    L.Loan_Amount
FROM Customer C
JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customers_With_Loans_View;


-- QUESTION 6
-- Loans greater than 1000000

CREATE VIEW Large_Loans_View AS
SELECT
    C.Customer_Name,
    L.Loan_Type,
    L.Loan_Amount
FROM Customer C
JOIN Loan L
ON C.Customer_ID = L.Customer_ID
WHERE L.Loan_Amount > 1000000;

SELECT * FROM Large_Loans_View;


-- QUESTION 7
-- Total balance for every branch

CREATE VIEW Branch_Total_Balance_Practice AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch;

SELECT * FROM Branch_Total_Balance_Practice;


-- QUESTION 8
-- Average balance for each account type

CREATE VIEW Account_Type_Average_View AS
SELECT
    Account_Type,
    AVG(Balance) AS Average_Balance
FROM Account
GROUP BY Account_Type;

SELECT * FROM Account_Type_Average_View;


-- QUESTION 9
-- Number of customers in each city

CREATE VIEW City_Customer_Count_View AS
SELECT
    City,
    COUNT(*) AS Number_of_Customers
FROM Customer
GROUP BY City;

SELECT * FROM City_Customer_Count_View;


-- QUESTION 10
-- Branches with total balance > 200000

CREATE VIEW Branches_Above_200000_View AS
SELECT
    Branch,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Branch
HAVING SUM(Balance) > 200000;

SELECT * FROM Branches_Above_200000_View;


-- QUESTION 11
-- Deposit transactions

CREATE VIEW Deposit_Transactions_Practice AS
SELECT
    Transaction_ID,
    Account_No,
    Amount,
    Transaction_Date
FROM Bank_Transaction
WHERE Transaction_Type = 'DEPOSIT';

SELECT * FROM Deposit_Transactions_Practice;


-- QUESTION 12
-- Withdrawals greater than 10000

CREATE VIEW Large_Withdrawals_View AS
SELECT
    Transaction_ID,
    Account_No,
    Amount,
    Transaction_Date
FROM Bank_Transaction
WHERE Transaction_Type = 'WITHDRAW'
AND Amount > 10000;

SELECT * FROM Large_Withdrawals_View;


-- QUESTION 13
-- Customer + Account + Transaction

CREATE VIEW Customer_Account_Transaction_View AS
SELECT
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    T.Transaction_Type,
    T.Amount,
    T.Transaction_Date
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
JOIN Bank_Transaction T
ON A.Account_No = T.Account_No;

SELECT * FROM Customer_Account_Transaction_View;


-- QUESTION 14
-- Customer + Account + Loan

CREATE VIEW Customer_Account_Loan_View AS
SELECT
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    A.Balance,
    L.Loan_Type,
    L.Loan_Amount
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
LEFT JOIN Loan L
ON C.Customer_ID = L.Customer_ID;

SELECT * FROM Customer_Account_Loan_View;


-- QUESTION 15
-- Annual loan interest

CREATE VIEW Annual_Loan_Interest_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    Loan_Amount * Interest_Rate / 100 AS Annual_Interest
FROM Loan;

SELECT * FROM Annual_Loan_Interest_View;


-- QUESTION 16
-- Loan total calculation

CREATE VIEW Loan_Total_Calculation_View AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    Loan_Amount * Interest_Rate / 100 AS Annual_Interest,
    Loan_Amount +
    (Loan_Amount * Interest_Rate / 100) AS Total_Amount
FROM Loan;

SELECT * FROM Loan_Total_Calculation_View;


-- QUESTION 17
-- Branches having more than two accounts

CREATE VIEW Branches_More_Than_Two_View AS
SELECT
    Branch,
    COUNT(*) AS Number_of_Accounts
FROM Account
GROUP BY Branch
HAVING COUNT(*) > 2;

SELECT * FROM Branches_More_Than_Two_View;


-- QUESTION 18
-- Account types with total balance > 200000

CREATE VIEW Account_Types_Above_200000_View AS
SELECT
    Account_Type,
    SUM(Balance) AS Total_Balance
FROM Account
GROUP BY Account_Type
HAVING SUM(Balance) > 200000;

SELECT * FROM Account_Types_Above_200000_View;


-- QUESTION 19
-- Customers with balance between 50000 and 100000

CREATE VIEW Balance_Between_50000_100000_View AS
SELECT
    C.Customer_ID,
    C.Customer_Name,
    A.Account_No,
    A.Account_Type,
    A.Balance
FROM Customer C
JOIN Account A
ON C.Customer_ID = A.Customer_ID
WHERE A.Balance BETWEEN 50000 AND 100000;

SELECT * FROM Balance_Between_50000_100000_View;


-- QUESTION 20
-- Highest balance account in each branch

CREATE VIEW Highest_Balance_By_Branch_View AS
SELECT
    A.Branch,
    A.Account_No,
    A.Customer_ID,
    A.Account_Type,
    A.Balance
FROM Account A
WHERE A.Balance = (
    SELECT MAX(B.Balance)
    FROM Account B
    WHERE B.Branch = A.Branch
);

SELECT * FROM Highest_Balance_By_Branch_View;


-- ============================================================
-- FINAL CHECK
-- ============================================================

SELECT *
FROM Customer;

SELECT *
FROM Account;

SELECT *
FROM Bank_Transaction;

SELECT *
FROM Loan;


SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


-- ============================================================
-- END OF BANK VIEWS PRACTICAL
-- ============================================================