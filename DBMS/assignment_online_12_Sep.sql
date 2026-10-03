/* JOINS in DBMS */

-- CREATE DATABASE IF NOT EXISTS Company;

USE Company;


CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID VARCHAR(10),
    Manager_ID INT
);

CREATE TABLE Department (
    DeptID VARCHAR(10) PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Employee (EmpID, EmpName, DeptID, Manager_ID)
VALUES
(101, 'Amit', 'D1', NULL),
(102, 'Sneha', 'D2', 101),
(103, 'Rahul', 'D1', 101),
(104, 'Priya', 'D3', 102);

INSERT INTO Department (DeptID, DeptName)
VALUES
('D1', 'HR'),
('D2', 'Sales'),
('D4', 'Finance');


-- INNER Join
SELECT EmpName, DeptName
FROM Employee
INNER JOIN Department
ON Employee.DeptID = Department.DeptID;

-- LEFT Join (LEFT OUTER Join)
SELECT EmpName, DeptName
FROM Employee
LEFT JOIN Department
ON Employee.DeptID = Department.DeptID;

-- RIGHT Join (RIGHT OUTER Join)
SELECT EmpName, DeptName
FROM Employee
RIGHT JOIN Department
ON Employee.DeptID = Department.DeptID;

-- FULL OUTER Join (FULL OUTER OUTER Join)
  (SELECT EmpName, DeptName
FROM Employee
LEFT JOIN Department
ON Employee.DeptID = Department.DeptID)

  UNION 

  (SELECT EmpName, DeptName
FROM Employee
RIGHT JOIN Department
ON Employee.DeptID = Department.DeptID);

-- CROSS Join
SELECT *
FROM Employee
CROSS JOIN Department;

-- SELF Join
SELECT
    E1.EmpName AS Employee,
    E2.EmpName AS Manager
FROM Employee E1
JOIN Employee E2
ON E1.Manager_ID = E2.EmpID;