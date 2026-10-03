/* === DDL (Data Definition Language) === */

CREATE DATABASE CollegeDB;

USE CollegeDB;

CREATE TABLE Department (
  DeptID INT PRIMARY KEY,
  DeptName VARCHAR(100) NOT NULL,
  HOD VARCHAR(100)
);

CREATE TABLE Student (
  StudentID INT PRIMARY KEY,
  StudentName VARCHAR(100) NOT NULL,
  Gender VARCHAR(10),
  Age INT,
  Email VARCHAR(100),
  DeptID INT
);

CREATE TABLE Course (
  CourseID INT PRIMARY KEY,
  CourseName VARCHAR(100) NOT NULL,
  Credits INT
);

CREATE TABLE Enrollment (
  EnrollmentID INT PRIMARY KEY,
  StudentID INT,
  CourseID INT,
  EnrollmentDate DATE
);

ALTER TABLE Student
ADD Phone VARCHAR(15);

ALTER TABLE Student
ADD DateOfBirth DATE;

ALTER TABLE Student
ADD Address VARCHAR(200);

ALTER TABLE Student
MODIFY StudentName VARCHAR(150);

ALTER TABLE Student
MODIFY Email VARCHAR(150);

ALTER TABLE Enrollment
ADD Semester INT;

RENAME TABLE Student TO Students;

RENAME TABLE Course TO Courses;

ALTER TABLE Students
DROP COLUMN Phone;

ALTER TABLE Students
DROP COLUMN Address;

TRUNCATE TABLE Enrollment;

TRUNCATE TABLE Students;

DROP TABLE Enrollment;

DROP TABLE Courses;


/* === DML (Data Manipulation Language) === */

INSERT INTO
  Department (DeptID, DeptName, HOD)
VALUES
  (1, 'Computer Science', 'Dr. Sharma'),
  (2, 'Information Technology', 'Dr. Patil'),
  (3, 'Mechanical Engineering', 'Dr. Joshi'),
  (4, 'Civil Engineering', 'Dr. Deshmukh'),
  (5, 'Electronics Engineering', 'Dr. Kulkarni');

INSERT INTO Students (StudentID, StudentName, Gender, Age, Email, DeptID, DateOfBirth)
VALUES
(101, 'Aarav Sharma', 'Male', 20, 'aarav@gmail.com', 1, '2005-04-12'),
(102, 'Priya Patil', 'Female', 21, 'priya@gmail.com', 2, '2004-08-20'),
(103, 'Rahul Joshi', 'Male', 20, 'rahul@gmail.com', 3, '2005-01-15'),
(104, 'Sneha Deshmukh', 'Female', 19, 'sneha@gmail.com', 4, '2006-03-10'),
(105, 'Rohan Kulkarni', 'Male', 21, 'rohan@gmail.com', 5, '2004-11-25'),
(106, 'Ananya Shah', 'Female', 20, 'ananya@gmail.com', 1, '2005-06-18'),
(107, 'Aditya Patil', 'Male', 19, 'aditya@gmail.com', 2, '2006-02-05'),
(108, 'Neha Joshi', 'Female', 21, 'neha@gmail.com', 3, '2004-09-14'),
(109, 'Karan More', 'Male', 20, 'karan@gmail.com', 4, '2005-12-02'),
(110, 'Isha Kulkarni', 'Female', 19, 'isha@gmail.com', 5, '2006-07-22'),
(111, 'Vivek Sharma', 'Male', 22, 'vivek@gmail.com', 1, '2003-05-17'),
(112, 'Pooja Patil', 'Female', 20, 'pooja@gmail.com', 2, '2005-10-09'),
(113, 'Akash Joshi', 'Male', 21, 'akash@gmail.com', 3, '2004-04-28'),
(114, 'Meera Deshmukh', 'Female', 20, 'meera@gmail.com', 4, '2005-08-16'),
(115, 'Sahil Kulkarni', 'Male', 22, 'sahil@gmail.com', 5, '2003-12-30');


/* === DQL (Data Query Language) === */

SELECT *
FROM Students;

SELECT StudentName
FROM Students;

SELECT StudentName, Email
FROM Students;

SELECT *
FROM Students
WHERE Age > 20;

SELECT *
FROM Students
WHERE Age BETWEEN 18 AND 22;

SELECT *
FROM Students
WHERE Gender = 'Female';

SELECT *
FROM Students
WHERE DeptID = 5;

SELECT *
FROM Students
WHERE StudentName LIKE 'A%';

SELECT *
FROM Students
WHERE StudentName LIKE '%an%';

SELECT *
FROM Students
ORDER BY StudentName ASC;

SELECT *
FROM Students
ORDER BY Age DESC;

SELECT DISTINCT DeptID
FROM Students;

SELECT COUNT(*) AS TotalStudents
FROM Students;

SELECT AVG(Age) AS AverageAge
FROM Students;

SELECT MAX(Age) AS MaximumAge
FROM Students;

SELECT MIN(Age) AS MinimumAge
FROM Students;

SELECT DeptID, COUNT(*) AS NumberOfStudents
FROM Students
GROUP BY DeptID;

SELECT DeptID, COUNT(*) AS NumberOfStudents
FROM Students
GROUP BY DeptID
HAVING COUNT(*) > 5;

SELECT S.StudentName, D.DeptName
FROM Students S
JOIN Department D
ON S.DeptID = D.DeptID;


/* === TCL (Transaction Control Language) === */

START TRANSACTION;

INSERT INTO Students (StudentID, StudentName, Gender, Age, Email, DeptID, DateOfBirth)
VALUES (116, 'Rahul', 'Male', 20, 'rahul@gmail.com', 1, '2005-04-12');

COMMIT;

START TRANSACTION;

UPDATE Students
SET DeptID = 20
WHERE StudentID = 101;

ROLLBACK;

START TRANSACTION;

INSERT INTO Students (StudentID, StudentName, Gender, Age, Email, DeptID, DateOfBirth)
VALUES (117, 'Priya', 'Female', 21, 'priya@gmail.com', 2, '2004-08-20');

SAVEPOINT SP1;

ROLLBACK TO SP1;

/* === DCL (Data Control Language) === */

-- SELECT * FROM mysql.user;
-- DROP USER 'test'@'localhost';

-- CREATE USER 'test'@'localhost' IDENTIFIED BY 'TestAcc@123';

GRANT SELECT
ON CollegeDB.Students
TO 'test'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON CollegeDB.Students
TO 'test'@'localhost';

GRANT ALL PRIVILEGES
ON CollegeDB.Students
TO 'test'@'localhost';

REVOKE UPDATE
ON CollegeDB.Students
FROM 'test'@'localhost';

REVOKE SELECT, UPDATE
ON CollegeDB.Students
FROM 'test'@'localhost';