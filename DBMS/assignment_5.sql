-- =========================================================
-- TASK 1: SELECT
-- =========================================================

USE CETStats;

-- Display all records from colleges
SELECT * FROM colleges;

-- Display selected columns from colleges
SELECT code, name, district, total_intake
FROM colleges;

-- Display all branches
SELECT * FROM branches;

-- Display colleges with their branches
SELECT c.name AS college, b.name AS branch
FROM colleges c
JOIN branches b
ON c.college_id = b.college_id;

-- Display state cutoff with college and branch
SELECT c.name AS college,
       b.name AS branch,
       s.percentile
FROM state_cutoffs s
JOIN colleges c
ON s.college_id = c.college_id
JOIN branches b
ON s.branch_id = b.branch_id;



-- =========================================================
-- TASK 2: WHERE
-- =========================================================

-- Display colleges from Pune
SELECT name, district
FROM colleges
WHERE district = 'Pune';

-- Display cutoffs above 90 percentile
SELECT *
FROM state_cutoffs
WHERE percentile > 90;

-- Display cutoffs between 90 and 98 percentile
SELECT *
FROM state_cutoffs
WHERE percentile BETWEEN 90 AND 98;

-- Display colleges with intake greater than 1000
SELECT name, total_intake
FROM colleges
WHERE total_intake > 1000;

-- Display Pune colleges with intake greater than 1000
SELECT name, district, total_intake
FROM colleges
WHERE district = 'Pune'
AND total_intake > 1000;

-- Display colleges with intake greater than 1000 or located in Pune
SELECT name, district, total_intake
FROM colleges
WHERE total_intake > 1000
OR district = 'Pune';

-- Display colleges whose name contains "College"
SELECT name
FROM colleges
WHERE name LIKE '%College%';

-- Display branches whose name contains "Computer"
SELECT code, name
FROM branches
WHERE name LIKE '%Computer%';



-- =========================================================
-- TASK 3: ORDER BY
-- =========================================================

-- Display colleges by intake in ascending order
SELECT name, total_intake
FROM colleges
ORDER BY total_intake ASC;

-- Display colleges by intake in descending order
SELECT name, total_intake
FROM colleges
ORDER BY total_intake DESC;

-- Display cutoffs from highest to lowest
SELECT percentile
FROM state_cutoffs
ORDER BY percentile DESC;

-- Sort colleges by district and intake
SELECT name, district, total_intake
FROM colleges
ORDER BY district ASC, total_intake DESC;



-- =========================================================
-- TASK 4: DISTINCT
-- =========================================================

-- Display unique districts
SELECT DISTINCT district
FROM colleges;

-- Display unique college statuses
SELECT DISTINCT status
FROM colleges;

-- Display unique autonomy statuses
SELECT DISTINCT autonomy_status
FROM colleges;

-- Display unique category and quota combinations
SELECT DISTINCT gender, quota
FROM categories;

-- Display unique universities
SELECT DISTINCT university
FROM colleges;



-- =========================================================
-- TASK 5: AGGREGATE FUNCTIONS
-- =========================================================

-- Count total colleges
SELECT COUNT(*) AS total_colleges
FROM colleges;

-- Count total branches
SELECT COUNT(*) AS total_branches
FROM branches;

-- Calculate total college intake
SELECT SUM(total_intake) AS total_intake
FROM colleges;

-- Calculate average college intake
SELECT AVG(total_intake) AS average_intake
FROM colleges;

-- Find lowest state cutoff
SELECT MIN(percentile) AS lowest_cutoff
FROM state_cutoffs;

-- Find highest state cutoff
SELECT MAX(percentile) AS highest_cutoff
FROM state_cutoffs;

-- Find average state cutoff
SELECT AVG(percentile) AS average_cutoff
FROM state_cutoffs;



-- =========================================================
-- TASK 6: GROUP BY
-- =========================================================

-- Count colleges in each district
SELECT district,
       COUNT(*) AS college_count
FROM colleges
GROUP BY district;

-- Count branches for each college
SELECT college_id,
       COUNT(*) AS branch_count
FROM branches
GROUP BY college_id;

-- Calculate total branch intake for each college
SELECT college_id,
       SUM(total_intake) AS total_branch_intake
FROM branches
GROUP BY college_id;

-- Calculate average cutoff for each category
SELECT category_id,
       AVG(percentile) AS average_cutoff
FROM state_cutoffs
GROUP BY category_id;

-- Find minimum and maximum cutoff for each category
SELECT category_id,
       MIN(percentile) AS minimum_cutoff,
       MAX(percentile) AS maximum_cutoff
FROM state_cutoffs
GROUP BY category_id;

-- Count cutoff records for each CAP round
SELECT cap_round_id,
       COUNT(*) AS cutoff_count
FROM state_cutoffs
GROUP BY cap_round_id;



-- =========================================================
-- TASK 7: HAVING
-- =========================================================

-- Display districts having more than one college
SELECT district,
       COUNT(*) AS college_count
FROM colleges
GROUP BY district
HAVING COUNT(*) > 1;

-- Display categories having average cutoff above 90
SELECT category_id,
       AVG(percentile) AS average_cutoff
FROM state_cutoffs
GROUP BY category_id
HAVING AVG(percentile) > 90;

-- Display colleges having more than one branch
SELECT college_id,
       COUNT(*) AS branch_count
FROM branches
GROUP BY college_id
HAVING COUNT(*) > 1;

-- Display CAP rounds having more than one cutoff record
SELECT cap_round_id,
       COUNT(*) AS cutoff_count
FROM state_cutoffs
GROUP BY cap_round_id
HAVING COUNT(*) > 1;



-- =========================================================
-- TASK 8: MEANINGFUL INFORMATION EXTRACTION
-- =========================================================

-- Find Pune colleges with high intake
SELECT name, total_intake
FROM colleges
WHERE district = 'Pune'
AND total_intake > 1000
ORDER BY total_intake DESC;

-- Find colleges with the highest intake
SELECT name, total_intake
FROM colleges
ORDER BY total_intake DESC
LIMIT 5;

-- Find colleges with cutoff above 95 percentile
SELECT c.name AS college,
       s.percentile
FROM state_cutoffs s
JOIN colleges c
ON s.college_id = c.college_id
WHERE s.percentile > 95
ORDER BY s.percentile DESC;

-- Display cutoff with college and branch
SELECT c.name AS college,
       b.name AS branch,
       s.percentile
FROM state_cutoffs s
JOIN colleges c
ON s.college_id = c.college_id
JOIN branches b
ON s.branch_id = b.branch_id
ORDER BY s.percentile DESC;

-- Display cutoff with category
SELECT c.name AS college,
       cat.code AS category,
       s.percentile
FROM state_cutoffs s
JOIN colleges c
ON s.college_id = c.college_id
JOIN categories cat
ON s.category_id = cat.category_id
ORDER BY s.percentile DESC;

-- Display cutoff with seat type
SELECT c.name AS college,
       st.short_form AS seat_type,
       s.percentile
FROM state_cutoffs s
JOIN colleges c
ON s.college_id = c.college_id
JOIN seat_types st
ON s.seat_type_id = st.seat_type_id
ORDER BY s.percentile DESC;

-- Display average cutoff for each category
SELECT cat.code AS category,
       AVG(s.percentile) AS average_cutoff
FROM state_cutoffs s
JOIN categories cat
ON s.category_id = cat.category_id
GROUP BY cat.code
ORDER BY average_cutoff DESC;

-- Display categories having average cutoff above 90
SELECT cat.code AS category,
       AVG(s.percentile) AS average_cutoff
FROM state_cutoffs s
JOIN categories cat
ON s.category_id = cat.category_id
GROUP BY cat.code
HAVING AVG(s.percentile) > 90
ORDER BY average_cutoff DESC;

-- Count branches for each college
SELECT c.name AS college,
       COUNT(b.branch_id) AS branch_count
FROM colleges c
JOIN branches b
ON c.college_id = b.college_id
GROUP BY c.name
ORDER BY branch_count DESC;

-- Find total branch intake for each college
SELECT c.name AS college,
       SUM(b.total_intake) AS total_branch_intake
FROM colleges c
JOIN branches b
ON c.college_id = b.college_id
GROUP BY c.name
ORDER BY total_branch_intake DESC;

-- Find colleges having total branch intake above 100
SELECT c.name AS college,
       SUM(b.total_intake) AS total_branch_intake
FROM colleges c
JOIN branches b
ON c.college_id = b.college_id
GROUP BY c.name
HAVING SUM(b.total_intake) > 100
ORDER BY total_branch_intake DESC;

-- Display All India cutoffs with college and branch
SELECT c.name AS college,
       b.name AS branch,
       a.percentile
FROM all_india_cutoffs a
JOIN colleges c
ON a.college_id = c.college_id
JOIN branches b
ON a.branch_id = b.branch_id
ORDER BY a.percentile DESC;

-- Display All India cutoffs above 90 percentile
SELECT c.name AS college,
       b.name AS branch,
       a.percentile
FROM all_india_cutoffs a
JOIN colleges c
ON a.college_id = c.college_id
JOIN branches b
ON a.branch_id = b.branch_id
WHERE a.percentile > 90
ORDER BY a.percentile DESC;

-- Find the average All India cutoff
SELECT AVG(percentile) AS average_all_india_cutoff
FROM all_india_cutoffs;

-- Find highest All India cutoff
SELECT MAX(percentile) AS highest_all_india_cutoff
FROM all_india_cutoffs;

-- Find number of cutoff records for each CAP round
SELECT cr.year,
       cr.round_number,
       COUNT(s.id) AS cutoff_count
FROM cap_rounds cr
JOIN state_cutoffs s
ON cr.round_id = s.cap_round_id
GROUP BY cr.year, cr.round_number
ORDER BY cr.year, cr.round_number;

-- Find average cutoff for each CAP round
SELECT cr.year,
       cr.round_number,
       AVG(s.percentile) AS average_cutoff
FROM cap_rounds cr
JOIN state_cutoffs s
ON cr.round_id = s.cap_round_id
GROUP BY cr.year, cr.round_number
ORDER BY cr.year, cr.round_number;

-- Find Pune colleges with their branches
SELECT c.name AS college,
       b.name AS branch
FROM colleges c
JOIN branches b
ON c.college_id = b.college_id
WHERE c.district = 'Pune';

-- Find branches with intake greater than 100
SELECT c.name AS college,
       b.name AS branch,
       b.total_intake
FROM branches b
JOIN colleges c
ON b.college_id = c.college_id
WHERE b.total_intake > 100
ORDER BY b.total_intake DESC;

-- Find high-cutoff branches
SELECT c.name AS college,
       b.name AS branch,
       s.percentile
FROM state_cutoffs s
JOIN colleges c
ON s.college_id = c.college_id
JOIN branches b
ON s.branch_id = b.branch_id
WHERE s.percentile >= 95
ORDER BY s.percentile DESC;

-- Find the number of cutoff records for each category
SELECT cat.code AS category,
       COUNT(s.id) AS cutoff_count
FROM categories cat
JOIN state_cutoffs s
ON cat.category_id = s.category_id
GROUP BY cat.code
ORDER BY cutoff_count DESC;
