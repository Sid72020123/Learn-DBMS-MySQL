-- Insert 10 Pune Colleges
INSERT INTO colleges
(code, name, total_intake, address, district, status,
 autonomy_status, minority_status, university, old_data, new_data_map_id)
VALUES
('P001', 'COEP Technological University', 1800,
 'Shivajinagar, Pune', 'Pune',
 'University', 'Autonomous', 'None',
 'COEP Technological University', FALSE, NULL),

('P002', 'Vishwakarma Institute of Technology', 1500,
 'Bibwewadi, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P003', 'Pune Institute of Computer Technology', 900,
 'Dhankawadi, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P004', 'Pimpri Chinchwad College of Engineering', 1200,
 'Akurdi, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P005', 'AISSMS Institute of Information Technology', 900,
 'Kennedy Road, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P006', 'MIT World Peace University', 1600,
 'Kothrud, Pune', 'Pune',
 'University', 'Autonomous', 'None',
 'MIT World Peace University', FALSE, NULL),

('P007', 'Dr. D. Y. Patil Institute of Engineering', 1200,
 'Akurdi, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P008', 'Rajarshi Shahu College of Engineering', 1200,
 'Tathawade, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P009', 'Sinhgad College of Engineering', 1100,
 'Vadgaon, Pune', 'Pune',
 'Un-Aided', 'Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL),

('P010', 'Modern Education Society College of Engineering', 800,
 'Shivajinagar, Pune', 'Pune',
 'Un-Aided', 'Non-Autonomous', 'None',
 'Savitribai Phule Pune University', FALSE, NULL);


-- Insert 10 CAP Rounds
INSERT INTO cap_rounds
(year, round_number)
VALUES
(2024, 1),
(2024, 2),
(2024, 3),
(2024, 4),
(2025, 1),
(2025, 2),
(2025, 3),
(2025, 4),
(2026, 1),
(2026, 2);


-- Insert 10 Branches
INSERT INTO branches
(code, name, gender, total_intake, college_id)
VALUES
('BR001','Computer Engineering','Co-Education',180,11),
('BR002','Information Technology','Co-Education',120,12),
('BR003','Electronics & Telecommunication','Co-Education',120,13),
('BR004','AI & Data Science','Co-Education',120,14),
('BR005','Mechanical Engineering','Co-Education',120,15),
('BR006','Electrical Engineering','Co-Education',120,16),
('BR007','Civil Engineering','Co-Education',90,17),
('BR008','Computer Science & Engineering','Co-Education',120,18),
('BR009','Instrumentation Engineering','Co-Education',60,19),
('BR010','Chemical Engineering','Co-Education',60,20);


-- Insert 10 Categories
INSERT INTO categories
(code, gender, quota)
VALUES
('OPEN', 'Any', 'General'),
('OBC', 'Any', 'General'),
('SC', 'Any', 'General'),
('ST', 'Any', 'General'),
('EWS', 'Any', 'EWS'),
('VJNT', 'Any', 'General'),
('NT1', 'Any', 'General'),
('NT2', 'Any', 'General'),
('TFWS', 'Any', 'TFWS'),
('PWD', 'Any', 'PWD');

-- Insert 10 Seat Types
INSERT INTO seat_types
(type, short_form)
VALUES
('State Level General', 'G'),
('State Level Reserved', 'R'),
('TFWS Seat', 'TFWS'),
('EWS Seat', 'EWS'),
('Home University', 'HU'),
('Other University', 'OHU'),
('Ladies Seat', 'L'),
('PWD Seat', 'PWD'),
('Minority Seat', 'MIN'),
('Defence Seat', 'DEF');

-- Insert 10 State Cutoff Records
INSERT INTO state_cutoffs
(college_id, branch_id, seat_type_id, category_id, percentile, cap_round_id)
VALUES
(11,11,1,1,98.75,1),
(12,12,1,2,97.40,1),
(13,13,1,3,95.80,2),
(14,14,1,5,94.60,2),
(15,15,2,2,91.25,3),
(16,16,2,3,89.50,3),
(17,17,2,4,85.75,4),
(18,18,3,9,93.20,4),
(19,19,1,6,88.40,5),
(20,20,4,5,82.15,5);


-- Insert 10 All India Cutoff Records
INSERT INTO all_india_cutoffs
(college_id, branch_id, seat_type, merit_exam, percentile, cap_round_id)
VALUES
(11,11,'OPEN','JEE Main',99.10,1),
(12,12,'OPEN','JEE Main',98.30,1),
(13,13,'OPEN','JEE Main',96.80,2),
(14,14,'OPEN','JEE Main',95.60,2),
(15,15,'OPEN','JEE Main',93.25,3),
(16,16,'OPEN','JEE Main',91.70,3),
(17,17,'OPEN','JEE Main',88.50,4),
(18,18,'OPEN','JEE Main',94.15,4),
(19,19,'OPEN','JEE Main',90.40,5),
(20,20,'OPEN','JEE Main',84.75,5);

SELECT * from colleges;

-- 6. Modification of Records

-- Update 1: Modify college intake
UPDATE colleges
SET total_intake = 1900
WHERE college_id = 11;

-- Update 2: Modify branch intake
UPDATE branches
SET total_intake = 150
WHERE branch_id = 14;

-- Update 3: Modify foreign-key value
UPDATE state_cutoffs
SET branch_id = 19
WHERE id = 34;

-- Verify
SELECT * FROM colleges WHERE college_id = 11;
SELECT * FROM branches WHERE branch_id = 14;
SELECT * FROM state_cutoffs WHERE id = 34;


-- 7. Deletion of Records

-- Delete 1: Delete an All India cutoff record
DELETE FROM all_india_cutoffs
WHERE id = 10;

-- Delete 2: Delete a State cutoff record
DELETE FROM state_cutoffs
WHERE id = 10;

-- Delete 3: Delete a category record
DELETE FROM categories
WHERE category_id = 10;

-- Verify
SELECT * FROM all_india_cutoffs;
SELECT * FROM state_cutoffs;
SELECT * FROM categories;


-- 8. Referential Integrity

-- Valid foreign-key insertion
INSERT INTO branches
(code, name, gender, total_intake, college_id)
VALUES
('BR011','Robotics and Automation','Co-Education',60,11);

-- Violation 1: College ID does not exist
INSERT INTO branches
(code, name, gender, total_intake, college_id)
VALUES
('BR012','Data Engineering','Co-Education',60,999);

-- Violation 2: Branch ID does not exist
INSERT INTO state_cutoffs
(college_id, branch_id, seat_type_id, category_id, percentile, cap_round_id)
VALUES
(11,999,1,1,90.00,1);

-- Delete the valid test record
DELETE FROM branches
WHERE code = 'BR011';