-- ============================================================
-- INNER JOIN
-- ============================================================

-- Display colleges with their branches
SELECT c.college_id,
       c.name AS college,
       b.branch_id,
       b.name AS branch
FROM colleges c
INNER JOIN branches b
ON c.college_id = b.college_id;


-- Display state cutoffs with college information
SELECT c.name AS college,
       s.percentile
FROM state_cutoffs s
INNER JOIN colleges c
ON s.college_id = c.college_id;


-- Display cutoff details with college, branch and category
SELECT c.name AS college,
       b.name AS branch,
       cat.code AS category,
       s.percentile
FROM state_cutoffs s
INNER JOIN colleges c
ON s.college_id = c.college_id
INNER JOIN branches b
ON s.branch_id = b.branch_id
INNER JOIN categories cat
ON s.category_id = cat.category_id;


-- Display cutoff details with college, branch and seat type
SELECT c.name AS college,
       b.name AS branch,
       st.short_form AS seat_type,
       s.percentile
FROM state_cutoffs s
INNER JOIN colleges c
ON s.college_id = c.college_id
INNER JOIN branches b
ON s.branch_id = b.branch_id
INNER JOIN seat_types st
ON s.seat_type_id = st.seat_type_id;


-- Find average cutoff for each category using INNER JOIN
SELECT cat.code AS category,
       AVG(s.percentile) AS average_cutoff
FROM categories cat
INNER JOIN state_cutoffs s
ON cat.category_id = s.category_id
GROUP BY cat.category_id, cat.code;


-- ============================================================
-- OUTER JOIN
-- ============================================================

-- Display all colleges, including colleges without branches
SELECT c.college_id,
       c.name AS college,
       b.name AS branch
FROM colleges c
LEFT OUTER JOIN branches b
ON c.college_id = b.college_id;


-- Display all branches, including branches without matching colleges
SELECT b.branch_id,
       b.name AS branch,
       c.name AS college
FROM colleges c
RIGHT OUTER JOIN branches b
ON c.college_id = b.college_id;


-- Display all colleges and their cutoff records
SELECT c.name AS college,
       s.percentile
FROM colleges c
LEFT OUTER JOIN state_cutoffs s
ON c.college_id = s.college_id;


-- Find colleges that have no cutoff records
SELECT c.college_id,
       c.name AS college
FROM colleges c
LEFT JOIN state_cutoffs s
ON c.college_id = s.college_id
WHERE s.id IS NULL;


-- ============================================================
-- SELF JOIN
-- ============================================================

-- Display pairs of colleges located in the same district
SELECT c1.name AS college_1,
       c2.name AS college_2,
       c1.district
FROM colleges c1
INNER JOIN colleges c2
ON c1.district = c2.district
AND c1.college_id < c2.college_id;


-- Find colleges having the same autonomy status
SELECT c1.name AS college_1,
       c2.name AS college_2,
       c1.autonomy_status
FROM colleges c1
INNER JOIN colleges c2
ON c1.autonomy_status = c2.autonomy_status
AND c1.college_id < c2.college_id;


-- Find colleges having the same university
SELECT c1.name AS college_1,
       c2.name AS college_2,
       c1.university
FROM colleges c1
INNER JOIN colleges c2
ON c1.university = c2.university
AND c1.college_id < c2.college_id;


-- ============================================================
-- NESTED QUERIES
-- ============================================================

-- Find colleges having at least one cutoff record
SELECT name
FROM colleges
WHERE college_id IN
(
    SELECT college_id
    FROM state_cutoffs
);


-- Find colleges having a cutoff above 95 percentile
SELECT name
FROM colleges
WHERE college_id IN
(
    SELECT college_id
    FROM state_cutoffs
    WHERE percentile > 95
);


-- Find the college having the highest state cutoff
SELECT name
FROM colleges
WHERE college_id IN
(
    SELECT college_id
    FROM state_cutoffs
    WHERE percentile =
    (
        SELECT MAX(percentile)
        FROM state_cutoffs
    )
);


-- ============================================================
-- SINGLE-ROW SUBQUERIES
-- ============================================================

-- Find cutoff records whose percentile is greater than
-- the average state cutoff
SELECT id,
       college_id,
       branch_id,
       percentile
FROM state_cutoffs
WHERE percentile >
(
    SELECT AVG(percentile)
    FROM state_cutoffs
);


-- Find the state cutoff record having the highest percentile
SELECT id,
       college_id,
       percentile
FROM state_cutoffs
WHERE percentile =
(
    SELECT MAX(percentile)
    FROM state_cutoffs
);


-- Find branches whose intake is greater than
-- the average branch intake
SELECT branch_id,
       name,
       total_intake
FROM branches
WHERE total_intake >
(
    SELECT AVG(total_intake)
    FROM branches
);


-- ============================================================
-- MULTI-ROW SUBQUERIES
-- ============================================================

-- Find colleges having branches located in the database
-- with more than 100 total intake
SELECT name
FROM colleges
WHERE college_id IN
(
    SELECT college_id
    FROM branches
    WHERE total_intake > 100
);


-- Find branches belonging to colleges located in Pune
SELECT name,
       college_id
FROM branches
WHERE college_id IN
(
    SELECT college_id
    FROM colleges
    WHERE district = 'Pune'
);


-- Find cutoff records belonging to OPEN or EWS categories
SELECT id,
       college_id,
       category_id,
       percentile
FROM state_cutoffs
WHERE category_id IN
(
    SELECT category_id
    FROM categories
    WHERE code IN ('OPEN', 'EWS')
);


-- Find cutoff records whose percentile is greater than
-- ANY cutoff of the EWS category
SELECT id,
       college_id,
       percentile
FROM state_cutoffs
WHERE percentile > ANY
(
    SELECT s.percentile
    FROM state_cutoffs s
    INNER JOIN categories c
    ON s.category_id = c.category_id
    WHERE c.code = 'EWS'
);


-- Find cutoff records whose percentile is greater than
-- ALL cutoff records of the EWS category
SELECT id,
       college_id,
       percentile
FROM state_cutoffs
WHERE percentile > ALL
(
    SELECT s.percentile
    FROM state_cutoffs s
    INNER JOIN categories c
    ON s.category_id = c.category_id
    WHERE c.code = 'EWS'
);


-- ============================================================
-- CORRELATED SUBQUERIES
-- ============================================================

-- Find branches whose intake is greater than the
-- average intake of branches in the same college
SELECT b.branch_id,
       b.name AS branch,
       b.college_id,
       b.total_intake
FROM branches b
WHERE b.total_intake >
(
    SELECT AVG(b2.total_intake)
    FROM branches b2
    WHERE b2.college_id = b.college_id
);

-- Find colleges having at least one branch whose intake
-- is greater than the average intake of that college
SELECT c.college_id,
       c.name
FROM colleges c
WHERE EXISTS
(
    SELECT 1
    FROM branches b
    WHERE b.college_id = c.college_id
    AND b.total_intake >
    (
        SELECT AVG(b2.total_intake)
        FROM branches b2
        WHERE b2.college_id = c.college_id
    )
);
