-- USE Library;

CREATE TABLE IF NOT EXISTS Book (
  book_id INT PRIMARY KEY,
  isbn VARCHAR(20) UNIQUE,
  title VARCHAR(255),
  author_id INT,
  category_id INT,
  publisher_id INT,
  publication_year YEAR,
  edition VARCHAR(20),
  language VARCHAR(50),
  available_copies INT,
  total_copies INT,
  price DECIMAL(10, 2),

  CHECK (available_copies <= total_copies),
  CHECK (available_copies >= 0),
  CHECK (total_copies >= 0),
  CHECK (price >= 0)
);

CREATE TABLE IF NOT EXISTS Author (
  author_id INT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  date_of_birth DATE,
  nationality VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Category (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(100) UNIQUE NOT NULL,
  description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(20)
);

/*
INSERT INTO Book
(book_id, isbn, title, author_id, category_id, publisher_id, publication_year, edition, language, available_copies, total_copies, price)
VALUES
(1, '9780000000001', 'Database Systems', 1, 1, 1, 2018, '1st', 'English', 4, 5, 599.00),
(2, '9780000000002', 'Learning SQL', 2, 1, 2, 2020, '2nd', 'English', 7, 10, 450.50),
(3, '9780000000003', 'Advanced DBMS', 3, 1, 1, 2021, '1st', 'English', 2, 6, 799.00),
(4, '9780000000004', 'Python Basics', 4, 2, 3, 2019, '3rd', 'English', 5, 8, 399.00),
(5, '9780000000005', 'Java Programming', 5, 2, 2, 2017, '4th', 'English', 6, 10, 699.00),
(6, '9780000000006', 'C Programming', 6, 2, 4, 2015, '5th', 'English', 3, 5, 350.00),
(7, '9780000000007', 'Operating Systems', 7, 3, 1, 2018, '2nd', 'English', 4, 7, 650.00),
(8, '9780000000008', 'Computer Networks', 8, 3, 5, 2022, '1st', 'English', 8, 10, 720.00),
(9, '9780000000009', 'Data Structures', 9, 2, 4, 2016, '3rd', 'English', 5, 9, 560.00),
(10, '9780000000010', 'Algorithms', 10, 2, 5, 2020, '2nd', 'English', 2, 4, 890.00),
(11, '9780000000011', 'Artificial Intelligence', 11, 4, 2, 2023, '1st', 'English', 6, 8, 950.00),
(12, '9780000000012', 'Machine Learning', 12, 4, 3, 2022, '1st', 'English', 4, 6, 1100.00),
(13, '9780000000013', 'Deep Learning', 13, 4, 1, 2021, '2nd', 'English', 3, 5, 1250.00),
(14, '9780000000014', 'Statistics Essentials', 14, 5, 4, 2018, '2nd', 'English', 7, 9, 500.00),
(15, '9780000000015', 'Discrete Mathematics', 15, 5, 5, 2017, '3rd', 'English', 5, 7, 650.00),
(16, '9780000000016', 'Linear Algebra', 16, 5, 2, 2019, '2nd', 'English', 8, 10, 700.00),
(17, '9780000000017', 'Calculus I', 17, 5, 3, 2016, '4th', 'English', 4, 6, 450.00),
(18, '9780000000018', 'Calculus II', 18, 5, 3, 2018, '2nd', 'English', 6, 8, 500.00),
(19, '9780000000019', 'Physics Fundamentals', 19, 6, 4, 2015, '3rd', 'English', 5, 8, 580.00),
(20, '9780000000020', 'Organic Chemistry', 20, 6, 5, 2020, '1st', 'English', 2, 5, 760.00),
(21, '9780000000021', 'Microeconomics', 21, 7, 1, 2019, '2nd', 'English', 3, 7, 430.00),
(22, '9780000000022', 'Macroeconomics', 22, 7, 2, 2021, '1st', 'English', 6, 9, 490.00),
(23, '9780000000023', 'Financial Accounting', 23, 8, 3, 2018, '3rd', 'English', 7, 10, 550.00),
(24, '9780000000024', 'Business Management', 24, 8, 4, 2017, '2nd', 'English', 5, 6, 620.00),
(25, '9780000000025', 'Marketing Principles', 25, 8, 5, 2020, '1st', 'English', 4, 5, 580.00),
(26, '9780000000026', 'Cloud Computing', 26, 2, 2, 2023, '1st', 'English', 8, 10, 980.00),
(27, '9780000000027', 'Cyber Security', 27, 2, 1, 2022, '2nd', 'English', 6, 8, 1050.00),
(28, '9780000000028', 'Ethical Hacking', 28, 2, 4, 2021, '1st', 'English', 3, 5, 890.00),
(29, '9780000000029', 'Linux Administration', 29, 3, 5, 2019, '2nd', 'English', 5, 7, 640.00),
(30, '9780000000030', 'DevOps Handbook', 30, 3, 2, 2022, '1st', 'English', 6, 9, 990.00),
(31, '9780000000031', 'Digital Logic', 31, 9, 3, 2018, '2nd', 'English', 5, 6, 470.00),
(32, '9780000000032', 'Compiler Design', 32, 9, 1, 2017, '3rd', 'English', 4, 5, 810.00),
(33, '9780000000033', 'Software Engineering', 33, 2, 5, 2020, '2nd', 'English', 8, 10, 730.00),
(34, '9780000000034', 'Web Development', 34, 2, 2, 2021, '1st', 'English', 6, 8, 680.00),
(35, '9780000000035', 'React Guide', 35, 2, 4, 2023, '1st', 'English', 5, 7, 840.00),
(36, '9780000000036', 'Node.js in Action', 36, 2, 1, 2022, '2nd', 'English', 4, 6, 870.00),
(37, '9780000000037', 'MongoDB Basics', 37, 1, 3, 2021, '1st', 'English', 5, 5, 650.00),
(38, '9780000000038', 'NoSQL Databases', 38, 1, 2, 2020, '2nd', 'English', 6, 8, 760.00),
(39, '9780000000039', 'Big Data Analytics', 39, 4, 5, 2023, '1st', 'English', 4, 7, 1200.00),
(40, '9780000000040', 'Data Mining', 40, 4, 1, 2019, '3rd', 'English', 5, 9, 980.00),
(41, '9780000000041', 'Internet of Things', 41, 3, 4, 2021, '1st', 'English', 7, 10, 890.00),
(42, '9780000000042', 'Embedded Systems', 42, 9, 3, 2018, '2nd', 'English', 2, 5, 760.00),
(43, '9780000000043', 'Computer Graphics', 43, 9, 2, 2020, '2nd', 'English', 6, 8, 810.00),
(44, '9780000000044', 'Game Development', 44, 2, 5, 2022, '1st', 'English', 4, 6, 940.00),
(45, '9780000000045', 'Blockchain Basics', 45, 4, 4, 2023, '1st', 'English', 3, 5, 1300.00),
(46, '9780000000046', 'Quantum Computing', 46, 4, 1, 2022, '1st', 'English', 2, 4, 1500.00),
(47, '9780000000047', 'Digital Electronics', 47, 9, 2, 2016, '4th', 'English', 5, 8, 610.00),
(48, '9780000000048', 'Computer Architecture', 48, 9, 3, 2019, '2nd', 'English', 4, 7, 780.00),
(49, '9780000000049', 'Research Methodology', 49, 10, 5, 2021, '1st', 'English', 7, 9, 520.00),
(50, '9780000000050', 'Project Management', 50, 8, 4, 2020, '2nd', 'English', 6, 10, 690.00);
*/

/*
INSERT INTO Author (author_id, first_name, last_name, date_of_birth, nationality) VALUES
(1,'John','Smith','1975-04-12','American'),
(2,'Alice','Johnson','1980-07-23','British'),
(3,'Robert','Brown','1972-11-15','Canadian'),
(4,'Emily','Davis','1988-01-08','Australian'),
(5,'Michael','Wilson','1979-09-30','American'),
(6,'Sarah','Moore','1983-05-19','British'),
(7,'David','Taylor','1976-03-27','Canadian'),
(8,'Jessica','Anderson','1985-08-11','Australian'),
(9,'Daniel','Thomas','1978-12-01','American'),
(10,'Sophia','Jackson','1989-06-14','British'),
(11,'James','White','1974-02-22','American'),
(12,'Olivia','Harris','1986-10-10','Canadian'),
(13,'William','Martin','1977-01-18','Australian'),
(14,'Emma','Thompson','1990-03-09','British'),
(15,'Benjamin','Garcia','1982-04-25','American'),
(16,'Charlotte','Martinez','1984-05-20','Spanish'),
(17,'Henry','Robinson','1973-09-13','Canadian'),
(18,'Amelia','Clark','1987-12-30','Australian'),
(19,'Lucas','Rodriguez','1979-07-16','Mexican'),
(20,'Mia','Lewis','1991-02-05','British'),
(21,'Alexander','Lee','1981-08-21','Singaporean'),
(22,'Harper','Walker','1985-06-12','American'),
(23,'Ethan','Hall','1978-11-03','Canadian'),
(24,'Evelyn','Allen','1983-01-29','Australian'),
(25,'Jacob','Young','1976-05-17','American'),
(26,'Abigail','King','1988-09-08','British'),
(27,'Logan','Wright','1980-10-19','American'),
(28,'Ella','Scott','1992-04-14','Australian'),
(29,'Mason','Green','1977-07-26','Canadian'),
(30,'Avery','Baker','1986-12-11','American'),
(31,'Sebastian','Adams','1979-03-18','British'),
(32,'Scarlett','Nelson','1984-06-06','Australian'),
(33,'Jack','Hill','1982-09-25','American'),
(34,'Grace','Ramirez','1990-02-16','Spanish'),
(35,'Owen','Campbell','1975-08-07','Canadian'),
(36,'Lily','Mitchell','1987-05-03','British'),
(37,'Samuel','Carter','1978-01-22','American'),
(38,'Chloe','Roberts','1991-11-09','Australian'),
(39,'Joseph','Phillips','1983-07-28','American'),
(40,'Victoria','Evans','1985-10-04','British'),
(41,'Matthew','Turner','1976-06-15','Canadian'),
(42,'Zoey','Torres','1989-12-20','Mexican'),
(43,'Andrew','Parker','1981-02-11','American'),
(44,'Hannah','Collins','1984-09-02','Australian'),
(45,'Christopher','Edwards','1977-04-27','British'),
(46,'Natalie','Stewart','1990-08-18','Canadian'),
(47,'Ryan','Morris','1982-01-05','American'),
(48,'Leah','Rogers','1986-03-24','British'),
(49,'Nathan','Reed','1979-10-31','Australian'),
(50,'Audrey','Cook','1992-06-09','American');
*/

/*
INSERT INTO Category (category_id, category_name, description) VALUES
(1,'Database','Books on SQL, DBMS and databases'),
(2,'Programming','Programming languages and software development'),
(3,'Networking','Computer networks and communication'),
(4,'Artificial Intelligence','AI, ML and Deep Learning'),
(5,'Mathematics','Mathematics and Statistics'),
(6,'Science','Physics, Chemistry and Biology'),
(7,'Economics','Economics and Finance'),
(8,'Business','Business, Marketing and Management'),
(9,'Computer Engineering','Hardware, Architecture and Electronics'),
(10,'Research','Research methods and academic writing');
*/

/*
INSERT INTO Publisher (publisher_id, publisher_name, city, country, email, phone) VALUES
(1,'Pearson Education','London','United Kingdom','contact@pearson.com','+44-20-1111-1111'),
(2,'McGraw Hill','New York','USA','support@mcgrawhill.com','+1-212-222-2222'),
(3,'Springer Nature','Berlin','Germany','info@springer.com','+49-30-3333-3333'),
(4,'O''Reilly Media','Sebastopol','USA','help@oreilly.com','+1-707-444-4444'),
(5,'Packt Publishing','Birmingham','United Kingdom','contact@packt.com','+44-121-555-5555');
*/

-- DESC Book;

-- SELECT * FROM Book;

-- SELECT * FROM Book
-- WHERE publication_year >= 2020;

-- SELECT * FROM Book
-- WHERE publication_year >= 2020
-- ORDER BY publication_year DESC;

-- SELECT * FROM Book
-- ORDER BY publication_year DESC, price DESC;

-- SELECT title, language, price, edition FROM Book
-- WHERE edition = '1st';

/*
SELECT * FROM Book;
SELECT * FROM Author;
SELECT * FROM Category;
SELECT * FROM Publisher;
*/

SELECT
    b.book_id "Book ID",
    b.title "Title",
    c.category_name "Category",
    CONCAT(a.first_name, ' ', a.last_name) AS "Author",
    b.edition "Edition",
    b.publication_year "Publication Year",
    b.language "Language",
    b.available_copies "Available Copies",
    b.total_copies "Total Copies",
    b.price "Price",
    ROUND((b.available_copies / NULLIF(b.total_copies, 0)) * 100, 2) AS "Percent Stock Available"
FROM Book AS b
INNER JOIN Author AS a
ON b.author_id = a.author_id
INNER JOIN Category AS c
ON b.category_id = c.category_id

WHERE price >= 500
ORDER BY price DESC;
