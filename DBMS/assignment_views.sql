CREATE DATABASE Company_2;

USE Company_2;

CREATE TABLE Employees
(
  EmpID INT PRIMARY KEY AUTO_INCREMENT,
  EmpName VARCHAR(30),
  Salary DECIMAL(10, 2),
  DeptID INT
);

CREATE TABLE Department
(
  DeptID INT PRIMARY KEY,
  DeptName VARCHAR(20)
);

INSERT INTO Department (DeptID, DeptName)
VALUES
  (10, "HR"),
  (20, "Sales"),
  (30, "IT");

INSERT INTO Employees (EmpName, Salary, DeptID)
VALUES
  ("Amit", 50000, 10),
  ("Sneha", 60000, 20),
  ("Rahul", 45000, 10),
  ("Priya", 70000, 30);

SELECT * FROM Employees;


-- Creating Employee View

CREATE VIEW Employee_View AS
SELECT EmpName, Salary
FROM Employees;

SELECT * FROM Employee_View;


-- View with a WHERE clause

CREATE VIEW HighSalaryEmployees AS
SELECT EmpID, EmpName, Salary
FROM Employees
WHERE Salary > 50000;

SELECT * FROM HighSalaryEmployees;



-- View to display company name and departments

CREATE VIEW EmployeeDepartment AS
SELECT E.EmpName, D.DeptName
FROM Employees E
JOIN Department D
ON E.DeptID = D.DeptID;

SELECT * FROM EmployeeDepartment;


-- Complex View

CREATE VIEW DepartmentSalary AS
SELECT DeptID, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DeptID;

SELECT * FROM DepartmentSalary;


/*
===== ADVANCED VIEWS QUERIES =====
*/

-- Listing all views in a database
SHOW FULL TABLES WHERE table_type LIKE "%VIEW";