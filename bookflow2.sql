-- =========================================================
-- DBSE & DBD - WEEK 2 PRACTICAL
-- BOOKFLOW DATABASE
-- =========================================================

-- STEP 1: Select the existing database
CREATE DATABASE IF NOT EXISTS bookflow_db;
USE bookflow_db;


-- =========================================================
-- STEP 2: Remove old Week-2 tables if they exist
-- =========================================================

DROP TABLE IF EXISTS Donation_History;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Books;


-- =========================================================
-- STEP 3: CREATE BOOKS TABLE
-- =========================================================

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    published_year INT CHECK (published_year < 2027)
);


-- =========================================================
-- STEP 4: INSERT BOOKS
-- =========================================================

INSERT INTO Books (book_id, title, isbn, published_year)
VALUES
(1, 'The Great Gatsby', '9780743273565', 1925),
(2, 'To Kill a Mockingbird', '9780061120084', 1960),
(3, '1984', '9780451524935', 1949);

SELECT * FROM Books;


-- =========================================================
-- STEP 5: CREATE MEMBERS TABLE
-- =========================================================

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);


-- =========================================================
-- STEP 6: INSERT MEMBERS
-- =========================================================

INSERT INTO Members (member_id, full_name, email)
VALUES
(101, 'John Smith', 'john.smith@email.com'),
(102, 'Emma Wilson', 'emma.wilson@email.com'),
(103, 'Michael Brown', 'michael.brown@email.com');

SELECT * FROM Members;


-- =========================================================
-- STEP 7: CREATE LOANS TABLE
-- =========================================================

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,

    FOREIGN KEY (member_id)
        REFERENCES Members(member_id),

    FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
);


-- =========================================================
-- STEP 8: INSERT 10 LOANS
-- =========================================================

INSERT INTO Loans (loan_id, member_id, book_id, loan_date)
VALUES
(1, 101, 1, '2025-01-05'),
(2, 102, 2, '2025-01-08'),
(3, 103, 3, '2025-01-10'),
(4, 101, 2, '2025-02-01'),
(5, 102, 1, '2025-02-05'),
(6, 103, 2, '2025-02-12'),
(7, 101, 3, '2025-03-01'),
(8, 102, 3, '2025-03-07'),
(9, 103, 1, '2025-03-15'),
(10, 101, 1, '2025-04-01');

SELECT * FROM Loans;


-- =========================================================
-- STEP 9: INNER JOIN
-- SHOW MEMBER NAME AND BOOK TITLE
-- =========================================================

SELECT
    m.full_name AS Member_Name,
    b.title AS Book_Title
FROM Loans l
INNER JOIN Members m
    ON l.member_id = m.member_id
INNER JOIN Books b
    ON l.book_id = b.book_id;


-- =========================================================
-- STEP 10: GROUP BY + COUNT
-- NUMBER OF BOOKS PUBLISHED IN EACH YEAR
-- =========================================================

SELECT
    published_year,
    COUNT(book_id) AS Total_Books
FROM Books
GROUP BY published_year
ORDER BY published_year;


-- =========================================================
-- STEP 11: CREATE DONATION_HISTORY TABLE
-- =========================================================

CREATE TABLE Donation_History (
    donation_id INT PRIMARY KEY,
    book_id INT,
    donor_name VARCHAR(100),
    donation_date DATE,

    FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
);


-- =========================================================
-- STEP 12: TRANSACTION
-- ADD BOOK + RECORD DONATION TOGETHER
-- =========================================================

START TRANSACTION;

INSERT INTO Books
(book_id, title, isbn, published_year)
VALUES
(4, 'Animal Farm', '9780451526342', 1945);

INSERT INTO Donation_History
(donation_id, book_id, donor_name, donation_date)
VALUES
(1, 4, 'Raj Kumar', CURDATE());

COMMIT;


-- =========================================================
-- STEP 13: DISPLAY DONATION HISTORY
-- =========================================================

SELECT * FROM Donation_History;

SELECT * FROM Books;


-- =========================================================
-- STEP 14: CREATE INDEX ON ISBN
-- =========================================================

CREATE INDEX idx_books_isbn
ON Books(isbn);


-- =========================================================
-- STEP 15: SEARCH BOOK USING ISBN
-- =========================================================

SELECT *
FROM Books
WHERE isbn = '9780451524935';


-- =========================================================
-- STEP 16: FINAL DISPLAY OF ALL TABLES
-- =========================================================

SELECT * FROM Books;

SELECT * FROM Members;

SELECT * FROM Loans;

SELECT * FROM Donation_History;