-- ============================================================
-- LAB ASSIGNMENT NO. 9
-- ============================================================

-- ============================================================
-- STORED PROCEDURES
-- ============================================================

-- Display all college records

DELIMITER //

CREATE PROCEDURE DisplayColleges()
BEGIN
    SELECT *
    FROM colleges;
END //

DELIMITER ;

-- Execute the procedure
CALL DisplayColleges();

-- Display college details using college ID

DELIMITER //

CREATE PROCEDURE GetCollegeByID(IN cid INT)
BEGIN
    SELECT *
    FROM colleges
    WHERE college_id = cid;
END //

DELIMITER ;

-- Execute the procedure
CALL GetCollegeByID(290);

-- Display branches belonging to a particular college

DELIMITER //

CREATE PROCEDURE GetBranchesByCollege(IN cid INT)
BEGIN
    SELECT
        branch_id,
        code,
        name,
        gender,
        total_intake,
        college_id
    FROM branches
    WHERE college_id = cid;
END //

DELIMITER ;

-- Execute the procedure
CALL GetBranchesByCollege(290);

-- Insert a new college

DELIMITER //

CREATE PROCEDURE InsertCollege(
    IN cid INT,
    IN ccode VARCHAR(6),
    IN cname VARCHAR(300),
    IN intake INT,
    IN caddress VARCHAR(500),
    IN cdistrict VARCHAR(70)
)
BEGIN
    INSERT INTO colleges
        (college_id, code, name, total_intake, address, district)
    VALUES
        (cid, ccode, cname, intake, caddress, cdistrict);
END //

DELIMITER ;

-- Execute the procedure
-- Use an unused college_id and college code.

CALL InsertCollege(
    100,
    'P100',
    'Demo Engineering College',
    600,
    'Pune, Maharashtra',
    'Pune'
);

-- Verify insertion
SELECT *
FROM colleges
WHERE college_id = 100;

-- Count the total number of colleges using an OUT parameter

DELIMITER //

CREATE PROCEDURE CountColleges(OUT total INT)
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM colleges;
END //

DELIMITER ;

-- Execute the procedure
CALL CountColleges(@college_count);

SELECT @college_count AS Total_Colleges;



-- ============================================================
-- TRIGGERS
-- ============================================================

-- Automatically convert college names to uppercase
-- before inserting a college record.

DELIMITER //

CREATE TRIGGER BeforeCollegeInsert
BEFORE INSERT ON colleges
FOR EACH ROW
BEGIN
    IF NEW.name IS NOT NULL THEN
        SET NEW.name = UPPER(NEW.name);
    END IF;
END //

DELIMITER ;

-- Test the trigger using an unused college ID and code.
-- The inserted name will be converted to uppercase.

INSERT INTO colleges
    (college_id, code, name, total_intake, address, district, old_data)
VALUES
    (1001, 'P101', 'demo technology college',
     500, 'Pune, Maharashtra', 'Pune', False);

-- Verify the result
SELECT *
FROM colleges
WHERE college_id = 1001;

-- Validate college intake before insertion.
-- Negative intake values are not allowed.

DELIMITER //

CREATE TRIGGER ValidateCollegeIntake
BEFORE INSERT ON colleges
FOR EACH ROW
BEGIN
    IF NEW.total_intake < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'College intake cannot be negative';
    END IF;
END //

DELIMITER ;

-- Test the trigger with invalid data.
-- This statement should generate an error.

INSERT INTO colleges
    (college_id, code, name, total_intake, address, district, old_data)
VALUES
    (1002, 'P102', 'Invalid Intake College',
     -100, 'Pune, Maharashtra', 'Pune', False);

-- Automatically validate cutoff percentile before insertion.
-- Percentiles must be between 0 and 100.

DELIMITER //

CREATE TRIGGER ValidateStateCutoff
BEFORE INSERT ON state_cutoffs
FOR EACH ROW
BEGIN
    IF NEW.percentile < 0 OR NEW.percentile > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Cutoff percentile must be between 0 and 100';
    END IF;
END //

DELIMITER ;

-- Test the trigger with invalid data.
-- This statement should generate an error.
-- The IDs used must exist in their respective tables.

INSERT INTO state_cutoffs
    (college_id, branch_id, seat_type_id,
     category_id, percentile, cap_round_id)
VALUES
    (11, 11, 1, 1, 150.00, 1);

DELIMITER //

CREATE TRIGGER ValidateStateCutoffUpdate
BEFORE UPDATE ON state_cutoffs
FOR EACH ROW
BEGIN
    IF NEW.percentile < 0 OR NEW.percentile > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Cutoff percentile must be between 0 and 100';
    END IF;
END //

DELIMITER ;

-- Test with an invalid percentile.
-- This should generate an error.

UPDATE state_cutoffs
SET percentile = 120.00
WHERE id = 1;


-- ============================================================
-- VERIFY THE RESULTS
-- ============================================================

-- Display colleges
SELECT *
FROM colleges;

-- Display branches
SELECT *
FROM branches;

-- Display state cutoff records
SELECT *
FROM state_cutoffs;

-- Display created triggers
SHOW TRIGGERS;

-- Display created stored procedures
SHOW PROCEDURE STATUS
WHERE Db = DATABASE();