
CREATE DATABASE HotelDatabase;
USE HotelDatabase;

-- Create command 
CREATE TABLE Guests (
    GuestID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Phone VARCHAR(15),
    City VARCHAR(50)
);

-- Insert Multiple Rows 
-- Insert command
INSERT INTO Guests (GuestID, Name, Age, Phone, City) VALUES
(1, 'Akmal Malik', 22, '9876543210', 'Delhi'),
(2, 'Riya Sharma', 28, '9876543211', 'Mumbai'),
(3, 'Arjun Mehta', 35, '9876543212', 'Bangalore'),
(4, 'Neha Verma', 25, '9876543213', 'Chennai'),
(5, 'Karan Singh', 30, '9876543214', 'Kolkata'),
(6, 'Sara Khan', 27, '9876543215', 'Delhi'),
(7, 'Rohan Das', 24, '9876543216', 'Hyderabad'),
(8, 'Priya Nair', 31, '9876543217', 'Pune'),
(9, 'Amit Patel', 29, '9876543218', 'Ahmedabad'),
(10, 'Sneha Roy', 26, '9876543219', 'Jaipur');



-- View Table
SELECT * FROM Guests;
--              ALL DDL(Data Definition Language ) COMMANDS        --
-- Alter Commands (Adds a new coloumn)
ALTER TABLE Guests ADD Email VARCHAR(100);
-- Used to modify a coloumn 
ALTER TABLE Guests MODIFY Phone VARCHAR(20);
-- Used to change name 
ALTER TABLE Guests CHANGE Name FullName VARCHAR(100);
-- Rename the table name 
RENAME TABLE Guests TO HotelGuests;
ALTER TABLE Guests ADD Gmail VARCHAR (100);
UPDATE  Guests SET Gmail = 'akmal' Where GuestID = 1;
SELECT UPPER(NAME) From Guests;
SELECT Name FROM Guests WHERE Name  = '%a';

-- TRUNCATE COMMAND ( This removes all data but keeps the table structure )
TRUNCATE TABLE Guests;

-- Drop (This deletes the entire table )
DROP TABLE Guests;

-- REPLACE INTO (If a row with the same GuestID already exists, this command will delete it and insert the new one)
REPLACE INTO Guests (GuestID, Name, Age, Phone, City)
VALUES (1, 'Ayaan Qureshi', 24, '9998887776', 'Lucknow');




--                  ALL DML(DATA MANIPULATIVE LANGUAGE) COMMANDS                -- 

-- Insert command already used ( used to insert the data into the table )
-- Select * From  (used to select the data to be shown from the table)

-- UPDATE COMMAND ( Used to update the data from the table )
UPDATE Guests SET Age = 23 WHERE GuestID = 1;

-- DELETE COMMAND ( Used to delete a data from the table ) 
DELETE FROM Guests WHERE GuestID = 10;



--                                                                     TABLE 2                                                                      --
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomType VARCHAR(50) NOT NULL,
    PricePerNight DECIMAL(10,2) CHECK (PricePerNight > 0),
    Availability VARCHAR(10) DEFAULT 'Yes',
    UNIQUE(RoomType, PricePerNight)
);

-- Insert All Room Records in a Single Statement
INSERT INTO Rooms (RoomID, RoomType, PricePerNight, Availability) VALUES
(101, 'Deluxe', 2500.00, 'Yes'),
(102, 'Standard', 1500.00, 'Yes'),
(103, 'Suite', 4000.00, 'No'),
(104, 'Deluxe', 2600.00, 'Yes'),
(105, 'Standard', 1600.00, 'No'),
(106, 'Suite', 4200.00, 'Yes'),
(107, 'Deluxe', 2700.00, 'Yes'),
(108, 'Standard', 1700.00, 'Yes'),
(109, 'Suite', 4300.00, 'No'),
(110, 'Deluxe', 2800.00, 'Yes');
-- View the Table Data
SELECT *  FROM Rooms;

--                        ALL THE CONSTRAINTS USED IN THIS TABLE                            -- 
-- 1. PRIMARY KEY (ALREADY USED)
-- Ensures each record is unique and not null.

-- 2. NOT NULL (ALREADY USED)
-- Ensures a column cannot have NULL values.

-- 3. CHECK (ALREADY USED)
-- Ensures values meet a specific condition.

-- 4. DEFAULT (ALREADY USED)
-- Assigns a default value when none is provided.

-- 5. UNIQUE (ALREADY USED)
-- Ensures no duplicate combination of values in the given columns.

-- 6. FOREIGN KEY (Used if connecting two tables)
-- We will use this to connect two tables. For example:- if there's a Bookings table with RoomID as a foreign key.




--                                                                   TABLE 3                                                                        --

-- ---------------------------
-- Creating Bookings Table
-- ---------------------------

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    GuestID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    FOREIGN KEY (GuestID) REFERENCES HotelGuests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- View the table (this will show the current structure)
SELECT * FROM Bookings;

-- Insert Data into Bookings
INSERT INTO Bookings (BookingID, GuestID, RoomID, CheckInDate, CheckOutDate) VALUES
(1, 1, 101, '2025-04-01', '2025-04-05'),
(2, 2, 102, '2025-04-02', '2025-04-06'),
(3, 3, 103, '2025-04-03', '2025-04-07'),
(4, 4, 104, '2025-04-04', '2025-04-08'),
(5, 5, 105, '2025-04-05', '2025-04-09'),
(6, 6, 106, '2025-04-06', '2025-04-10'),
(7, 7, 107, '2025-04-07', '2025-04-11'),
(8, 8, 108, '2025-04-08', '2025-04-12'),
(9, 9, 109, '2025-04-09', '2025-04-13');

-- View Data in Bookings Table
SELECT * FROM Bookings;

-- ---------------------------
-- SQL JOIN Operations on Bookings
-- ---------------------------

-- 1. INNER JOIN (Guests with their bookings)
SELECT g.GuestID, g.Name, b.BookingID, b.CheckInDate, b.CheckOutDate
FROM Guests g
INNER JOIN Bookings b ON g.GuestID = b.GuestID;



-- 2. JOIN with Rooms (Full booking details)
SELECT g.Name, r.RoomType, r.PricePerNight, b.CheckInDate, b.CheckOutDate
FROM Bookings b
JOIN Guests g ON b.GuestID = g.GuestID
JOIN Rooms r ON b.RoomID = r.RoomID;

SELECT g.Name, b.BookingID, r.PricePerNight
FROM Bookings b
LEFT JOIN Guests g ON b.GuestID = g.GuestID
LEFT JOIN Rooms r ON b.RoomID = r.RoomID;


-- 3. LEFT JOIN (All guests, even if they don’t have bookings)
SELECT g.Name, b.BookingID, b.CheckInDate
FROM Guests g
LEFT JOIN Bookings b ON g.GuestID = b.GuestID;

-- 4. RIGHT JOIN (All bookings, even if guest not found)
SELECT g.Name, b.BookingID, b.CheckInDate
FROM Guests g
RIGHT JOIN Bookings b ON g.GuestID = b.GuestID;

-- 5. FULL OUTER JOIN (All guests and bookings — matched or not)
SELECT g.Name, b.BookingID, b.CheckInDate
FROM Guests g
LEFT JOIN Bookings b ON g.GuestID = b.GuestID
UNION
SELECT g.Name, b.BookingID, b.CheckInDate
FROM Guests g
RIGHT JOIN Bookings b ON g.GuestID = b.GuestID;

-- 6. CROSS JOIN (All possible combinations — Cartesian product)
SELECT g.Name, r.RoomType
FROM Guests g
CROSS JOIN Rooms r;







--                                                                   TABLE 4                                                                        --
-- Staff Table (Pattern Matching + Basics)
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(100),
    Role VARCHAR(50),
    Phone VARCHAR(15)
);

-- Insert Data into Staff
INSERT INTO Staff (StaffID, StaffName, Role, Phone) VALUES
(1, 'Amit Kumar', 'Receptionist', '9000000001'),
(2, 'Anjali Singh', 'Housekeeping', '9000000002'),
(3, 'Arun Sharma', 'Chef', '9000000003'),
(4, 'Sneha Pandey', 'Manager', '9000000004'),
(5, 'Ravi Verma', 'Security', '9000000005'),
(6, 'Alok Gupta', 'Receptionist', '9000000006'),
(7, 'Reema Sinha', 'Housekeeping', '9000000007');

-- View all Staff
SELECT * FROM Staff;
UPDATE Staff
SET Phone = CASE StaffID
    WHEN 1 THEN '9084757344'
    WHEN 2 THEN '9384757374'
    WHEN 3 THEN '9033335342'
    WHEN 4 THEN '9044441133'
    WHEN 5 THEN '9055593757'
    WHEN 6 THEN '9064758392'
    WHEN 7 THEN '9384829203'
END;
SET SQL_SAFE_UPDATES = 0;


-- PATTERN MATCHING COMMANDS --
-- 1. Staff names starting with 'A'
SELECT * FROM Staff WHERE StaffName LIKE 'A%';


-- 2. Staff names ending with 'a'
SELECT * FROM Staff WHERE StaffName LIKE '%a';

-- 3. Staff names containing 'e'
SELECT * FROM Staff WHERE StaffName LIKE '%e%';

-- 4. Staff roles starting with 'Re'
SELECT * FROM Staff WHERE Role LIKE 'Re%';

-- 5. Staff names with second letter 'm'
SELECT * FROM Staff WHERE StaffName LIKE '_m%';

-- 6. Staff names with exactly 10 characters
SELECT * FROM Staff
WHERE StaffName LIKE '__________'; -- 10 underscores = 10 characters

-- 7. Staff names where the third letter is 'i'
SELECT * FROM Staff
WHERE StaffName LIKE '__i%';

-- 8. Staff names NOT containing the letter 'a'
SELECT * FROM Staff
WHERE StaffName NOT LIKE '%a%';

-- 9. Staff with roles that contain 'ing' 
SELECT * FROM Staff
WHERE Role LIKE '%ing%';

-- 10. Staff names ending in 'ar' or 'er'
SELECT * FROM Staff
WHERE StaffName LIKE '%ar' OR StaffName LIKE '%er';





-- ALL THE BASIC QUERIES --
-- 1. Display all staff members
SELECT * FROM Staff;

-- 2. Show only staff names and roles
SELECT StaffName, Role FROM Staff;

-- 3. Show staff with role 'Receptionist'
SELECT * FROM Staff WHERE Role = 'Receptionist';

-- 4. Count total staff
SELECT COUNT(*) AS TotalStaff FROM Staff;

-- 5. Count staff in each role
SELECT Role, COUNT(*) AS CountPerRole FROM Staff GROUP BY Role;

-- 6. Sort staff by name alphabetically
SELECT * FROM Staff ORDER BY StaffName ASC;

-- 7. Display staff with phone numbers ending in '5'
SELECT * FROM Staff WHERE Phone LIKE '%5';

-- 8. Staff with names containing two 'a's (approximate)
SELECT * FROM Staff WHERE StaffName LIKE '%a%a%';



--                                                                  TABLE 5                                                                          --

-- Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    GuestID INT,
    Comments VARCHAR(255),
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

-- Insert Data into Feedback
INSERT INTO Feedback VALUES 
(1, 1, 'Very good service'),
(2, 2, 'Nice room and staff'),
(3, 3, 'Food was delicious'),
(4, 4, 'Clean and tidy rooms'),
(5, 5, 'Had a great stay');

-- View Data
SELECT * FROM Feedback;

-- ALL THE CHARACTER FUNCTIONS --
-- 1. UPPER() – Converts text to uppercase
SELECT FeedbackID, UPPER(Comments) AS UpperCaseComments FROM Feedback;

-- 2. LOWER() – Converts text to lowercase
SELECT FeedbackID, LOWER(Comments) AS LowerCaseComments FROM Feedback;


-- 3. LENGTH() – Returns the number of characters in the string
SELECT FeedbackID, LENGTH(Comments) AS CommentLength FROM Feedback;


-- 4. SUBSTRING() / SUBSTR() – Extracts part of the string
SELECT FeedbackID, SUBSTRING(Comments, 1, 10) AS ShortComment FROM Feedback;

-- 5. LEFT() – Returns leftmost characters
SELECT FeedbackID, LEFT(Comments, 5) AS LeftPart FROM Feedback;

-- 6. RIGHT() – Returns rightmost characters
SELECT FeedbackID, RIGHT(Comments, 5) AS RightPart FROM Feedback;

-- 7. TRIM() - Used to remove unwanted spaces
SELECT FeedbackID, TRIM(Comments) AS TrimmedComment FROM Feedback;

-- 8. REPLACE() – Replaces part of a string
SELECT FeedbackID, REPLACE(Comments, 'good', 'excellent') AS UpdatedComment FROM Feedback;
-- 9. CONCAT() – Joins two or more strings
SELECT FeedbackID, CONCAT('Feedback: ', Comments) AS FullComment FROM Feedback;

-- 10. REVERSE() – Reverses the string
SELECT FeedbackID, REVERSE(Comments) AS ReversedComment FROM Feedback;






CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employee (EmployeeID, EmployeeName, Department, Salary) VALUES
(1, 'Aman', 'HR', 45000.00),
(2, 'Suman', 'IT', 60000.00),
(3, 'Dhuman', 'Finance', 55000.00),
(4, 'Ruman', 'IT', 70000.00),
(5, 'Baman', 'HR', 48000.00);
-- STORED PROCEDURES -- 
DELIMITER // -- INSERT STORED PROCEDURE 
CREATE PROCEDURE InsertEmployee(
    IN p_EmployeeID INT,
    IN p_EmployeeName VARCHAR(100),
    IN p_Department VARCHAR(50),
    IN p_Salary DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Employee (EmployeeID, EmployeeName, Department, Salary)
    VALUES (p_EmployeeID, p_EmployeeName, p_Department, p_Salary);
END //
DELIMITER ; 

CALL InsertEmployee(6, 'John', 'IT', 65000.00);
CALL InsertEmployee(5,'akmal', 'BCA',50000.00);
CALL InsertEmployee(7,'Prakhar','BCA',50000.00);
SELECT * FROM Employee;

DELIMITER // -- UPDATE STORED PROCEDURE
CREATE PROCEDURE UpdateEmployee(
    IN p_EmployeeID INT,
    IN p_EmployeeName VARCHAR(100),
    IN p_Department VARCHAR(50),
    IN p_Salary DECIMAL(10, 2)
)
BEGIN
    UPDATE Employee
    SET
        EmployeeName = COALESCE(p_EmployeeName, EmployeeName),
        Department = COALESCE(p_Department, Department),
        Salary = COALESCE(p_Salary, Salary)
    WHERE EmployeeID = p_EmployeeID;
END //
DELIMITER ;
-- Updates only the salary (keeps existing name/department if NULLs are passed)
CALL UpdateEmployee(1, NULL, NULL, 80000.00);
CALL UpdateEmployee(2,'Manoj','IT',2000.00);
SELECT * FROM Employee;

DELIMITER // -- DELETE STORED PROCEDURE
CREATE PROCEDURE DeleteEmployee(IN p_EmployeeID INT)
BEGIN
    DELETE FROM Employee WHERE EmployeeID = p_EmployeeID;
END //
DELIMITER ;
CALL DeleteEmployee(5);  -- Deletes employee with ID = 5
SELECT * FROM Employee;

-- CURSORS -- 
DELIMITER //
CREATE PROCEDURE ShowAllEmployees()
BEGIN
  DECLARE v_name VARCHAR(100);
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT EmployeeName FROM Employee; -- Gets all names
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
  -- Create a temporary table to store results
  CREATE TEMPORARY TABLE TempResults (Name VARCHAR(100));
  
  OPEN cur;
  REPEAT
    FETCH cur INTO v_name;
    IF NOT done THEN 
      INSERT INTO TempResults VALUES (v_name); -- Store each name
    END IF;
  UNTIL done END REPEAT;
  CLOSE cur;
  
  SELECT * FROM TempResults; -- Show all names at once
  DROP TEMPORARY TABLE TempResults;
END //
DELIMITER ;
CALL ShowAllEmployees();


DELIMITER //
CREATE PROCEDURE SumSalary()
BEGIN
  DECLARE s, t DECIMAL(10,2) DEFAULT 0;
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT Salary FROM Employee;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
  OPEN cur;
  REPEAT
    FETCH cur INTO s;
    IF NOT done THEN SET t = t + s; END IF;
  UNTIL done END REPEAT;
  CLOSE cur;
  SELECT t;
END //
DELIMITER ;
CALL SumSalary(); -- Returns total salary


DELIMITER //
CREATE PROCEDURE DeptCount(IN d VARCHAR(50))
BEGIN
  DECLARE x, c INT DEFAULT 0;
  DECLARE done INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT 1 FROM Employee WHERE Department = d;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  
  OPEN cur;
  REPEAT
    FETCH cur INTO x;
    IF NOT done THEN SET c = c + 1; END IF;
  UNTIL done END REPEAT;
  CLOSE cur;
  SELECT c;
END //
DELIMITER ;
CALL DeptCount('HR'); -- Returns number of HR employees

--                                                                    THE END                                                                       --






Create Table Services (
ServiceID Int Primary Key,
ServiceName VARCHAR(200)
);

INSERT INTO Services (ServiceID, ServiceName)VALUES
('1', 'Reception'),
('2', 'Catering');

SELECT * FROM Services;

DELIMITER //
CREATE PROCEDURE InsertServicess (
IN P_ServiceID INT,
IN P_ServiceName Varchar(100)
)
BEGIN
Insert Into Services(ServiceID, ServiceName)
VALUES (P_ServiceID, P_ServiceName);
END //
DELIMITER ;

CALL InsertServicess('3','Room Service');


CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(50),
    Genre VARCHAR(50),
    Price DECIMAL(10, 2),
    AuthorID INT
);

INSERT INTO Books(BookId, Title, Genre, Price, AuthorID)Values
('1','Death Note', 'Anime', 2000.00, '101'),
('1','Death Note', 'Anime', 2000.00, '101'),
('1','Death Note', 'Anime', 2000.00, '101'),
('1','Death Note', 'Anime', 2000.00, '101');


SELECT * FROM Books;


CREATE TABLE Authors (
AuthorID INT PRIMARY KEY,
AuthorName VARCHAR(100),
Country VARCHAR (50)

);





























