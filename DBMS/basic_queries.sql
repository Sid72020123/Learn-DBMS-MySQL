CREATE DATABASE CollegeDB;

USE CollegeDB;

CREATE TABLE Student (
  StudentID INT PRIMARY KEY,
  Name VARCHAR(50),
  Department VARCHAR(30),
  Age INT,
  CGPA DECIMAL(3, 2)
);

DESCRIBE Student;

INSERT INTO
  Student
VALUES
  (101, "Amit", "Computer", 20, 8.50),
  (102, "Priya", "IT", 21, 9.10),
  (103, "Rahul", "Computer", 19, 7.80),
  (104, "Sneha", "Electronics", 20, 8.90);

SELECT * FROM Student;

SELECT Name, Department FROM Student;

SELECT * FROM Student
WHERE Department = "Computer";

SELECT * FROM Student
WHERE CGPA > 8.5;

UPDATE Student
SET CGPA = 9.20
WHERE StudentID = 101;

DELETE FROM Student
WHERE StudentID = 104;

SELECT * FROM Student
ORDER BY CGPA DESC;

SELECT COUNT(*) AS TotalStudents
FROM Student;

SELECT MAX(CGPA) AS HighestCGPA
FROM Student;

SELECT MIN(CGPA) AS LowestCGPA
FROM Student;

SELECT AVG(CGPA) AS AverageCGPA
FROM Student;

SELECT Department, COUNT(*) AS TotalStudents
FROM Student
GROUP BY Department;

SELECT * FROM Student
WHERE Name LIKE 'A%';

SELECT DISTINCT Department
FROM Student;

SELECT Name AS StudentName,
CGPA AS GradePoint
FROM Student;

ALTER TABLE Student
ADD Email VARCHAR(50);

ALTER TABLE Student
MODIFY Name VARCHAR(100);

ALTER TABLE Student
DROP COLUMN Email;

ALTER TABLE Student
RENAME TO Students;

TRUNCATE TABLE Students;

DROP TABLE Students;

DROP DATABASE CollegeDB;