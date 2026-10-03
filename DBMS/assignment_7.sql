USE CETStats_DBMS;

-- ============================================================
-- LAB ASSIGNMENT NO. 7
-- ============================================================


-- ============================================================
-- VIEWS
-- ============================================================

-- Create a view showing college, branch and cutoff details

CREATE VIEW College_Cutoff_View AS
SELECT
    c.name AS college_name,
    b.name AS branch_name,
    sc.percentile,
    cr.year,
    cr.round_number
FROM colleges c
INNER JOIN state_cutoffs sc
    ON c.college_id = sc.college_id
INNER JOIN branches b
    ON sc.branch_id = b.branch_id
INNER JOIN cap_rounds cr
    ON sc.cap_round_id = cr.round_id;

-- Display the view
SELECT * FROM College_Cutoff_View;


-- Create a view containing Pune colleges

CREATE VIEW Pune_College_View AS
SELECT
    college_id,
    code,
    name,
    total_intake,
    address,
    district,
    status,
    autonomy_status,
    university
FROM colleges
WHERE district = 'Pune';

-- Display Pune colleges
SELECT * FROM Pune_College_View;


-- Create a view containing high cutoff records

CREATE VIEW High_Cutoff_View AS
SELECT
    id,
    college_id,
    branch_id,
    seat_type_id,
    category_id,
    percentile,
    cap_round_id
FROM state_cutoffs
WHERE percentile > 95;

-- Display high cutoff records
SELECT * FROM High_Cutoff_View;


-- Retrieve records from the High_Cutoff_View having percentile greater than 98

SELECT *
FROM High_Cutoff_View
WHERE percentile > 98;


-- Modify the existing College_Cutoff_View

CREATE OR REPLACE VIEW College_Cutoff_View AS
SELECT
    c.name AS college_name,
    c.district,
    b.name AS branch_name,
    sc.percentile,
    cr.year,
    cr.round_number
FROM colleges c
INNER JOIN state_cutoffs sc
    ON c.college_id = sc.college_id
INNER JOIN branches b
    ON sc.branch_id = b.branch_id
INNER JOIN cap_rounds cr
    ON sc.cap_round_id = cr.round_id;

-- Display modified view
SELECT * FROM College_Cutoff_View;


-- Delete High_Cutoff_View

DROP VIEW High_Cutoff_View;

-- Verify that the view has been deleted

SELECT TABLE_NAME
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'High_Cutoff_View';



-- ============================================================
-- PART B: INDEXES
-- ============================================================

-- Create an index on college district

CREATE INDEX idx_colleges_district
ON colleges(district);

-- Query using district
SELECT *
FROM colleges
WHERE district = 'Pune';


-- Create an index on CAP round ID

CREATE INDEX idx_state_cutoffs_cap_round
ON state_cutoffs(cap_round_id);

-- Query using CAP round
SELECT *
FROM state_cutoffs
WHERE cap_round_id = 1;


-- Create an index on percentile

CREATE INDEX idx_state_cutoffs_percentile
ON state_cutoffs(percentile);

-- Query using percentile
SELECT *
FROM state_cutoffs
WHERE percentile > 95;


-- Create a composite index on college_id and percentile

CREATE INDEX idx_state_cutoffs_college_percentile
ON state_cutoffs(college_id, percentile);

-- Query using both indexed columns

SELECT *
FROM state_cutoffs
WHERE college_id = 290
AND percentile > 90;

SHOW INDEXES IN CETStats_DBMS.colleges;
SHOW INDEXES IN CETStats_DBMS.state_cutoffs;


-- ============================================================
-- QUERY PERFORMANCE / EXECUTION PLAN
-- ============================================================

-- Display execution plan for a query

EXPLAIN
SELECT *
FROM colleges
WHERE district = 'Pune';


-- EXPLAIN ANALYZE

EXPLAIN ANALYZE
SELECT *
FROM colleges
WHERE district = 'Pune';


-- Check performance of percentile search

EXPLAIN ANALYZE
SELECT *
FROM state_cutoffs
WHERE percentile > 95;


-- Check performance using composite index

EXPLAIN ANALYZE
SELECT *
FROM state_cutoffs
WHERE college_id = 11
AND percentile > 90;


-- ============================================================
-- DCL - USER ACCESS CONTROL
-- ============================================================

-- Create a database user

CREATE USER 'cutoff_user'@'localhost'
IDENTIFIED BY 'Cutoff@123';


-- Grant SELECT privilege on colleges

GRANT SELECT
ON colleges
TO 'cutoff_user'@'localhost';


-- Check college records

SELECT *
FROM colleges;


-- Grant SELECT and INSERT privileges on state_cutoffs

GRANT SELECT, INSERT
ON state_cutoffs
TO 'cutoff_user'@'localhost';


-- Grant SELECT privilege on the view

GRANT SELECT
ON College_Cutoff_View
TO 'cutoff_user'@'localhost';


-- Check the view

SELECT *
FROM College_Cutoff_View;


-- Revoke INSERT privilege

REVOKE INSERT
ON state_cutoffs
FROM 'cutoff_user'@'localhost';


-- Check state cutoff records

SELECT *
FROM state_cutoffs;


-- Revoke SELECT privilege on colleges

REVOKE SELECT
ON colleges
FROM 'cutoff_user'@'localhost';



-- ============================================================
-- INTEGRATED PROBLEM
-- ============================================================

-- Create an integrated summary view

CREATE VIEW College_Cutoff_Summary AS
SELECT
    c.name AS college_name,
    c.district,
    b.name AS branch_name,
    sc.percentile,
    cr.year,
    cr.round_number
FROM colleges c
INNER JOIN state_cutoffs sc
    ON c.college_id = sc.college_id
INNER JOIN branches b
    ON sc.branch_id = b.branch_id
INNER JOIN cap_rounds cr
    ON sc.cap_round_id = cr.round_id;


-- Display summary view

SELECT *
FROM College_Cutoff_Summary;


-- Create an index on college_id

CREATE INDEX idx_state_cutoffs_college
ON state_cutoffs(college_id);


-- Check query performance of the integrated query

EXPLAIN ANALYZE
SELECT
    c.name AS college_name,
    b.name AS branch_name,
    sc.percentile
FROM state_cutoffs sc
INNER JOIN colleges c
    ON sc.college_id = c.college_id
INNER JOIN branches b
    ON sc.branch_id = b.branch_id
WHERE sc.college_id = 290;


-- ============================================================
-- DCL FOR REPORT USER
-- ============================================================

-- Create report user

CREATE USER 'report_user'@'localhost'
IDENTIFIED BY 'Report@123';


-- Give SELECT permission on summary view

GRANT SELECT
ON College_Cutoff_Summary
TO 'report_user'@'localhost';


-- Access the summary view

SELECT *
FROM College_Cutoff_Summary;


-- Revoke SELECT permission

REVOKE SELECT
ON College_Cutoff_Summary
FROM 'report_user'@'localhost';


-- ============================================================
-- VERIFY PRIVILEGES
-- ============================================================

-- Display privileges of report_user

SHOW GRANTS FOR 'report_user'@'localhost';


-- Display privileges of cutoff_user

SHOW GRANTS FOR 'cutoff_user'@'localhost';



-- ============================================================
-- VERIFY INDEXES
-- ============================================================

SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    SEQ_IN_INDEX
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME IN ('colleges', 'state_cutoffs')
ORDER BY
    TABLE_NAME,
    INDEX_NAME,
    SEQ_IN_INDEX;



-- ============================================================
-- VERIFY VIEWS
-- ============================================================

SELECT TABLE_NAME
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = DATABASE()
ORDER BY TABLE_NAME;