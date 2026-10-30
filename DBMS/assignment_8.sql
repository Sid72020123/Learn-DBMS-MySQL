/* PART A: DataBase Creation and DDL Operations */

-- Create the database
CREATE DATABASE RailwayReservationSystem;

-- Use the DB
USE RailwayReservationSystem;

-- Create Tables
CREATE TABLE Passenger (
  id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  age INT CHECK(age >= 1 AND age <= 120),
  gender VARCHAR(10) NOT NULL,
  contact_number VARCHAR(15) UNIQUE,
  email VARCHAR(100) UNIQUE
);

CREATE TABLE Train (
  train_no INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  source VARCHAR(100) NOT NULL,
  destination VARCHAR(100) NOT NULL,
  train_type VARCHAR(30) NOT NULL DEFAULT 'Express'
);

CREATE TABLE Station (
  station_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  station_city VARCHAR(50) NOT NULL,
  station_state VARCHAR(50) NOT NULL
);

CREATE TABLE Reservation (
  reservation_id INT PRIMARY KEY,
  passenger_id INT NOT NULL,
  train_no INT NOT NULL,
  journey_date DATE NOT NULL,
  seat_no VARCHAR(10) NOT NULL,
  class VARCHAR(20) NOT NULL DEFAULT 'SL',
  fare DECIMAL(10, 2) NOT NULL,
  booking_status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',

  FOREIGN KEY (passenger_id)
      REFERENCES Passenger(id),

  FOREIGN KEY (train_no)
      REFERENCES Train(train_no),

  CHECK (booking_status IN
        ('CONFIRMED', 'WAITING', 'CANCELLED'))
);

CREATE TABLE TrainSchedule (
  schedule_id INT PRIMARY KEY,
  train_no INT NOT NULL,
  station_id INT NOT NULL,
  arrival_time TIME NOT NULL,
  departure_time TIME NOT NULL,
  platform_number VARCHAR(10),

  FOREIGN KEY (train_no)
      REFERENCES Train(train_no),

  FOREIGN KEY (station_id)
      REFERENCES Station(station_id)
);

-- Add new column using ALTER
ALTER TABLE Passenger
ADD address VARCHAR(200);

-- Modify an existing column
ALTER TABLE Passenger
MODIFY contact_number VARCHAR(20);

-- Modify an existing column
ALTER TABLE Passenger
RENAME COLUMN name TO full_name;

-- Create Temporary Table
CREATE TABLE ReservationTemp (
  temp_id INT PRIMARY KEY
);

-- Truncate Table
TRUNCATE TABLE ReservationTemp;

-- Drop table
DROP TABLE ReservationTemp;


/* PART B: DML Operations */

-- Passenger table
INSERT INTO Passenger
(id, full_name, age, gender, contact_number, email, address)
VALUES
(1, 'Aarav Sharma', 24, 'Male', '9000000001', 'aarav@gmail.com', 'Pune, Maharashtra'),
(2, 'Priya Patil', 29, 'Female', '9000000002', 'priya@gmail.com', 'Mumbai, Maharashtra'),
(3, 'Rahul Verma', 35, 'Male', '9000000003', 'rahul@gmail.com', 'Delhi, Delhi'),
(4, 'Sneha Joshi', 22, 'Female', '9000000004', 'sneha@gmail.com', 'Nashik, Maharashtra'),
(5, 'Vikram Singh', 42, 'Male', '9000000005', 'vikram@gmail.com', 'Jaipur, Rajasthan'),
(6, 'Neha Gupta', 31, 'Female', '9000000006', 'neha@gmail.com', 'Bhopal, Madhya Pradesh'),
(7, 'Arjun Desai', 27, 'Male', '9000000007', 'arjun@gmail.com', 'Surat, Gujarat'),
(8, 'Pooja Kulkarni', 33, 'Female', '9000000008', 'pooja@gmail.com', 'Nagpur, Maharashtra'),
(9, 'Karan Mehta', 38, 'Male', '9000000009', 'karan@gmail.com', 'Ahmedabad, Gujarat'),
(10, 'Anjali Rao', 26, 'Female', '9000000010', 'anjali@gmail.com', 'Hyderabad, Telangana'),
(11, 'Rohan Deshmukh', 45, 'Male', '9000000011', 'rohan@gmail.com', 'Kolhapur, Maharashtra'),
(12, 'Kavita Nair', 30, 'Female', '9000000012', 'kavita@gmail.com', 'Kochi, Kerala'),
(13, 'Siddharth Mishra', 21, 'Male', '9000000013', 'siddharth@gmail.com', 'Lucknow, Uttar Pradesh'),
(14, 'Meera Iyer', 36, 'Female', '9000000014', 'meera@gmail.com', 'Chennai, Tamil Nadu'),
(15, 'Aditya Kapoor', 28, 'Male', '9000000015', 'aditya@gmail.com', 'Chandigarh, Punjab'),
(16, 'Riya Banerjee', 25, 'Female', '9000000016', 'riya@gmail.com', 'Kolkata, West Bengal'),
(17, 'Manish Yadav', 40, 'Male', '9000000017', 'manish@gmail.com', 'Patna, Bihar'),
(18, 'Simran Kaur', 23, 'Female', '9000000018', 'simran@gmail.com', 'Amritsar, Punjab'),
(19, 'Nikhil Pawar', 34, 'Male', '9000000019', 'nikhil@gmail.com', 'Aurangabad, Maharashtra'),
(20, 'Ishita Shah', 32, 'Female', '9000000020', 'ishita@gmail.com', 'Vadodara, Gujarat');

-- Train Table
INSERT INTO Train
(train_no, name, source, destination, train_type)
VALUES
(12001, 'Deccan Express', 'Pune', 'Mumbai', 'Express'),
(12002, 'Rajdhani Express', 'Delhi', 'Mumbai', 'Superfast'),
(12003, 'Shatabdi Express', 'Mumbai', 'Ahmedabad', 'Superfast'),
(12004, 'Duronto Express', 'Pune', 'Delhi', 'Superfast'),
(12005, 'Garib Rath Express', 'Mumbai', 'Nagpur', 'Express'),
(12006, 'Intercity Express', 'Pune', 'Nashik', 'Express'),
(12007, 'Konkan Express', 'Mumbai', 'Madgaon', 'Express'),
(12008, 'Chennai Mail', 'Mumbai', 'Chennai', 'Mail'),
(12009, 'Howrah Express', 'Pune', 'Kolkata', 'Express'),
(12010, 'Punjab Mail', 'Delhi', 'Amritsar', 'Mail'),
(12011, 'Gitanjali Express', 'Mumbai', 'Howrah', 'Express'),
(12012, 'Karnataka Express', 'New Delhi', 'Bengaluru', 'Superfast'),
(12013, 'Goa Express', 'Delhi', 'Vasco da Gama', 'Express'),
(12014, 'Mysore Express', 'Chennai', 'Mysuru', 'Express'),
(12015, 'Jaipur Express', 'Mumbai', 'Jaipur', 'Express'),
(12016, 'Lucknow Mail', 'Mumbai', 'Lucknow', 'Mail'),
(12017, 'Bihar Express', 'Delhi', 'Patna', 'Express'),
(12018, 'Kerala Express', 'New Delhi', 'Thiruvananthapuram', 'Superfast'),
(12019, 'Ahmedabad Express', 'Pune', 'Ahmedabad', 'Express'),
(12020, 'Bhopal Express', 'Mumbai', 'Bhopal', 'Express');

-- Station Table
INSERT INTO Station
(station_id, name, station_city, station_state)
VALUES
(1, 'Pune Junction', 'Pune', 'Maharashtra'),
(2, 'Chhatrapati Shivaji Maharaj Terminus', 'Mumbai', 'Maharashtra'),
(3, 'New Delhi Railway Station', 'New Delhi', 'Delhi'),
(4, 'Ahmedabad Junction', 'Ahmedabad', 'Gujarat'),
(5, 'Nagpur Junction', 'Nagpur', 'Maharashtra'),
(6, 'Nashik Road', 'Nashik', 'Maharashtra'),
(7, 'Madgaon Junction', 'Madgaon', 'Goa'),
(8, 'Chennai Central', 'Chennai', 'Tamil Nadu'),
(9, 'Howrah Junction', 'Howrah', 'West Bengal'),
(10, 'Amritsar Junction', 'Amritsar', 'Punjab'),
(11, 'Bengaluru City Junction', 'Bengaluru', 'Karnataka'),
(12, 'Vasco da Gama Station', 'Vasco da Gama', 'Goa'),
(13, 'Mysuru Junction', 'Mysuru', 'Karnataka'),
(14, 'Jaipur Junction', 'Jaipur', 'Rajasthan'),
(15, 'Lucknow Charbagh', 'Lucknow', 'Uttar Pradesh'),
(16, 'Patna Junction', 'Patna', 'Bihar'),
(17, 'Thiruvananthapuram Central', 'Thiruvananthapuram', 'Kerala'),
(18, 'Vadodara Junction', 'Vadodara', 'Gujarat'),
(19, 'Bhopal Junction', 'Bhopal', 'Madhya Pradesh'),
(20, 'Surat Railway Station', 'Surat', 'Gujarat');

-- Reservation Table
INSERT INTO Reservation
(reservation_id, passenger_id, train_no, journey_date,
 seat_no, class, fare, booking_status)
VALUES
(1, 1, 12001, '2026-11-01', 'A1', 'AC', 850.00, 'CONFIRMED'),
(2, 2, 12002, '2026-11-02', 'B2', 'AC', 1500.00, 'CONFIRMED'),
(3, 3, 12003, '2026-11-03', 'S3', 'SL', 450.00, 'CONFIRMED'),
(4, 4, 12004, '2026-11-04', 'A4', 'AC', 1800.00, 'WAITING'),
(5, 5, 12005, '2026-11-05', 'B5', 'SL', 600.00, 'CONFIRMED'),
(6, 6, 12006, '2026-11-06', 'S6', 'SL', 350.00, 'CONFIRMED'),
(7, 7, 12007, '2026-11-07', 'A7', 'AC', 1200.00, 'CANCELLED'),
(8, 8, 12008, '2026-11-08', 'B8', 'AC', 2000.00, 'CONFIRMED'),
(9, 9, 12009, '2026-11-09', 'S9', 'SL', 700.00, 'CONFIRMED'),
(10, 10, 12010, '2026-11-10', 'A10', 'AC', 950.00, 'CONFIRMED'),
(11, 11, 12011, '2026-11-11', 'B11', 'AC', 1650.00, 'CONFIRMED'),
  (12, 12, 12012, '2026-11-12', 'S12', 'SL', 550.00, 'WAITING'),
(13, 13, 12013, '2026-11-13', 'A13', 'AC', 1350.00, 'CONFIRMED'),
(14, 14, 12014, '2026-11-14', 'B14', 'SL', 480.00, 'CONFIRMED'),
(15, 15, 12015, '2026-11-15', 'S15', 'SL', 750.00, 'CANCELLED'),
(16, 16, 12016, '2026-11-16', 'A16', 'AC', 1750.00, 'CONFIRMED'),
(17, 17, 12017, '2026-11-17', 'B17', 'AC', 1100.00, 'CONFIRMED'),
(18, 18, 12018, '2026-11-18', 'S18', 'SL', 650.00, 'WAITING'),
(19, 19, 12019, '2026-11-19', 'A19', 'AC', 1250.00, 'CONFIRMED'),
(20, 20, 12020, '2026-11-20', 'B20', 'SL', 500.00, 'CONFIRMED');

-- TrainSchedule Table
INSERT INTO TrainSchedule
(schedule_id, train_no, station_id,
 arrival_time, departure_time, platform_number)
VALUES
(1, 12001, 1, '05:45:00', '06:00:00', '1'),
(2, 12001, 2, '09:15:00', '09:30:00', '3'),
(3, 12002, 3, '16:00:00', '16:15:00', '2'),
(4, 12002, 2, '08:00:00', '08:15:00', '5'),
(5, 12003, 2, '06:45:00', '07:00:00', '4'),
(6, 12003, 4, '12:45:00', '13:00:00', '1'),
(7, 12004, 1, '19:45:00', '20:00:00', '2'),
(8, 12004, 3, '09:45:00', '10:00:00', '6'),
(9, 12005, 2, '20:45:00', '21:00:00', '7'),
(10, 12005, 5, '08:15:00', '08:30:00', '2'),
(11, 12006, 1, '07:15:00', '07:30:00', '4'),
(12, 12006, 6, '10:15:00', '10:30:00', '1'),
(13, 12007, 2, '22:00:00', '22:15:00', '6'),
(14, 12007, 7, '07:00:00', '07:15:00', '2'),
(15, 12008, 2, '18:00:00', '18:15:00', '8'),
(16, 12008, 8, '10:00:00', '10:15:00', '3'),
(17, 12009, 1, '17:30:00', '17:45:00', '5'),
(18, 12009, 9, '11:30:00', '11:45:00', '4'),
(19, 12010, 3, '19:00:00', '19:15:00', '7'),
(20, 12010, 10, '08:00:00', '08:15:00', '2');

-- Check whether all records were inserted or not
SELECT COUNT(*) AS total_passengers FROM Passenger;
SELECT COUNT(*) AS total_trains FROM Train;
SELECT COUNT(*) AS total_stations FROM Station;
SELECT COUNT(*) AS total_reservations FROM Reservation;
SELECT COUNT(*) AS total_schedules FROM TrainSchedule;

/* PART C: DQL OPERATIONS */

-- Display passenger names and their ages
SELECT full_name, age
FROM Passenger;

-- Find passengers aged between 25 and 35
SELECT *
FROM Passenger
WHERE age BETWEEN 25 AND 35;

-- Display female passengers
SELECT id, full_name, contact_number
FROM Passenger
WHERE gender = 'Female';

-- Find passengers living in Maharashtra
SELECT full_name, address
FROM Passenger
WHERE address LIKE '%Maharashtra%';

-- Find passengers whose names end with 'a'
SELECT *
FROM Passenger
WHERE full_name LIKE '%a';

-- Display passengers from oldest to youngest
SELECT id, full_name, age
FROM Passenger
ORDER BY age DESC;

-- Display the five youngest passengers
SELECT full_name, age
FROM Passenger
ORDER BY age ASC
LIMIT 5;

-- Find trains travelling from Mumbai to destinations other than Chennai
SELECT train_no, name, destination
FROM Train
WHERE source = 'Mumbai'
  AND destination <> 'Chennai';

-- Find trains whose names contain 'Express'
SELECT train_no, name, train_type
FROM Train
WHERE name LIKE '%Express%';

-- Display trains of type Superfast or Mail
SELECT *
FROM Train
WHERE train_type IN ('Superfast', 'Mail');

-- Find trains travelling from Pune or Delhi
SELECT train_no, name, source, destination
FROM Train
WHERE source IN ('Pune', 'Delhi');

-- Display trains in alphabetical order of their names
SELECT train_no, name, source, destination
FROM Train
ORDER BY name ASC;

-- Find reservations booked for AC class
SELECT reservation_id, passenger_id, train_no, class, fare
FROM Reservation
WHERE class = 'AC';

-- Find reservations with fares between ₹600 and ₹1500
SELECT reservation_id, passenger_id, train_no, fare
FROM Reservation
WHERE fare BETWEEN 600 AND 1500;

-- Display reservations that are waiting or cancelled
SELECT reservation_id, passenger_id, train_no, booking_status
FROM Reservation
WHERE booking_status IN ('WAITING', 'CANCELLED');

-- Find reservations scheduled after 10 November 2026
SELECT reservation_id, passenger_id, journey_date, fare
FROM Reservation
WHERE journey_date > '2026-11-10';

-- Display reservations for November 2026
SELECT reservation_id, passenger_id, train_no, journey_date
FROM Reservation
WHERE journey_date >= '2026-11-01'
  AND journey_date < '2026-12-01'
ORDER BY journey_date;

-- Display the three most expensive reservations
SELECT reservation_id, passenger_id, train_no, fare
FROM Reservation
ORDER BY fare DESC
LIMIT 3;

-- Find stations located in Maharashtra or Gujarat
SELECT station_id, name, station_city, station_state
FROM Station
WHERE station_state IN ('Maharashtra', 'Gujarat')
ORDER BY station_state, station_city;

-- Display train schedules with departure times after noon
SELECT schedule_id, train_no, station_id,
       arrival_time, departure_time, platform_number
FROM TrainSchedule
WHERE departure_time > '12:00:00'
ORDER BY departure_time ASC;

/* PART D: Aggregate Functions */

-- Count the total number of passengers
SELECT COUNT(*) AS total_passengers
FROM Passenger;

-- Count the total number of trains
SELECT COUNT(*) AS total_trains
FROM Train;

-- Count the total number of reservations
SELECT COUNT(*) AS total_reservations
FROM Reservation;

-- Calculate the average age of passengers
SELECT AVG(age) AS average_passenger_age
FROM Passenger;

-- Find the highest and lowest passenger ages
SELECT MAX(age) AS highest_age,
       MIN(age) AS lowest_age
FROM Passenger;

-- Calculate the average reservation fare
SELECT ROUND(AVG(fare), 2) AS average_fare
FROM Reservation;

-- Find the highest and lowest reservation fares
SELECT MAX(fare) AS highest_fare,
       MIN(fare) AS lowest_fare
FROM Reservation;

-- Calculate the total fare amount of all reservations
SELECT SUM(fare) AS total_fare_amount
FROM Reservation;

-- Count reservations for each booking status
SELECT booking_status, COUNT(*) AS total_bookings
FROM Reservation
GROUP BY booking_status;

-- Count reservations for each travel class
SELECT class, COUNT(*) AS total_reservations
FROM Reservation
GROUP BY class;

-- Calculate the total fare collected for each travel class
SELECT class, SUM(fare) AS total_fare
FROM Reservation
GROUP BY class;

-- Find the average fare for each booking status
SELECT booking_status, ROUND(AVG(fare), 2) AS average_fare
FROM Reservation
GROUP BY booking_status;

-- Count reservations for each train
SELECT train_no, COUNT(*) AS reservation_count
FROM Reservation
GROUP BY train_no
ORDER BY reservation_count DESC;

-- Find trains having more than one reservation
SELECT train_no, COUNT(*) AS reservation_count
FROM Reservation
GROUP BY train_no
HAVING COUNT(*) > 1;

-- Find booking statuses with more than two reservations
SELECT booking_status, COUNT(*) AS total_bookings
FROM Reservation
GROUP BY booking_status
HAVING COUNT(*) > 2;

-- Find travel classes whose average fare exceeds ₹1000
SELECT class, ROUND(AVG(fare), 2) AS average_fare
FROM Reservation
GROUP BY class
HAVING AVG(fare) > 1000;

-- Count passengers by gender
SELECT gender, COUNT(*) AS passenger_count
FROM Passenger
GROUP BY gender;

-- Count stations in each state
SELECT station_state, COUNT(*) AS total_stations
FROM Station
GROUP BY station_state
ORDER BY total_stations DESC;

-- Count train schedules for each train
SELECT train_no, COUNT(*) AS total_schedules
FROM TrainSchedule
GROUP BY train_no
ORDER BY total_schedules DESC;

-- Find the total fare of confirmed reservations
SELECT SUM(fare) AS confirmed_fare_total
FROM Reservation
WHERE booking_status = 'CONFIRMED';

/* PART E: SQL Joins */

-- Display passenger details along with their reservation details
SELECT P.id, P.full_name, R.reservation_id, R.journey_date, R.fare
FROM Passenger P
INNER JOIN Reservation R
ON P.id = R.passenger_id;

-- Display train details along with reservation information
SELECT T.train_no, T.name, T.source, T.destination,
       R.reservation_id, R.booking_status
FROM Train T
INNER JOIN Reservation R
ON T.train_no = R.train_no;

-- Display passenger names, train names, and reservation details
SELECT P.full_name, T.name AS train_name,
       R.journey_date, R.seat_no, R.fare, R.booking_status
FROM Passenger P
INNER JOIN Reservation R
ON P.id = R.passenger_id
INNER JOIN Train T
ON R.train_no = T.train_no;

-- Display all passengers, including those without reservations
SELECT P.id, P.full_name, R.reservation_id, R.journey_date
FROM Passenger P
LEFT JOIN Reservation R
ON P.id = R.passenger_id;

-- Display pairs of trains that have the same train type
SELECT T1.name AS train_one, T2.name AS train_two,
       T1.train_type
FROM Train T1
INNER JOIN Train T2
ON T1.train_type = T2.train_type
AND T1.train_no < T2.train_no;

/* PART F: Subqueries */

-- Find passengers whose age is greater than the average passenger age
SELECT id, full_name, age
FROM Passenger
WHERE age > (
    SELECT AVG(age)
    FROM Passenger
);

-- Find trains whose destination matches the destination of train number 12001
SELECT train_no, name, source, destination
FROM Train
WHERE destination = (
    SELECT destination
    FROM Train
    WHERE train_no = 12001
)
AND train_no <> 12001;

-- Find passengers who have a reservation with a fare greater than ₹1000
SELECT id, full_name
FROM Passenger
WHERE id IN (
    SELECT passenger_id
    FROM Reservation
    WHERE fare > 1000
);

-- Find trains whose reservation fare is lower than the average fare of all reservations
SELECT train_no, name
FROM Train
WHERE train_no IN (
    SELECT train_no
    FROM Reservation
    WHERE fare < (
        SELECT AVG(fare)
        FROM Reservation
    )
);

-- Find passengers whose reservation fare is equal to the lowest reservation fare
SELECT id, full_name
FROM Passenger
WHERE id IN (
    SELECT passenger_id
    FROM Reservation
    WHERE fare = (
        SELECT MIN(fare)
        FROM Reservation
    )
);

/* PART G: Views */

-- Create a view displaying passengers with confirmed reservations
CREATE VIEW Confirmed_Passengers_View AS
SELECT P.id, P.full_name, P.contact_number,
       R.reservation_id, R.journey_date, R.fare
FROM Passenger P
JOIN Reservation R
ON P.id = R.passenger_id
WHERE R.booking_status = 'CONFIRMED';

-- Retrieve data from the confirmed passengers view
SELECT *
FROM Confirmed_Passengers_View;

-- Create a view displaying train details and the number of reservations
CREATE VIEW Train_Reservation_Count_View AS
SELECT T.train_no, T.name AS train_name,
       T.source, T.destination,
       COUNT(R.reservation_id) AS total_reservations
FROM Train T
LEFT JOIN Reservation R
ON T.train_no = R.train_no
GROUP BY T.train_no, T.name, T.source, T.destination;

-- Retrieve data from the above created view
SELECT *
FROM Train_Reservation_Count_View;

/* PART H: Indexing */

-- Create an index on train destination
CREATE INDEX idx_train_destination
ON Train(destination);

-- Create a composite index on reservation status and journey date
CREATE INDEX idx_reservation_status_date
ON Reservation(booking_status, journey_date);

-- Demonstrate index usage with an execution plan
EXPLAIN
SELECT reservation_id, journey_date, fare
FROM Reservation
WHERE booking_status = 'CONFIRMED'
  AND journey_date = '2026-11-05';

/* PART I: DCL Operations */

-- Create a database user
CREATE USER 'railway_manager'@'localhost'
IDENTIFIED BY 'Railway@123';

-- Grant SELECT and UPDATE privileges on the Passenger table
GRANT SELECT, UPDATE
ON RailwayReservationSystem.Passenger
TO 'railway_manager'@'localhost';

-- Revoke UPDATE privilege from the user
REVOKE UPDATE
ON RailwayReservationSystem.Passenger
FROM 'railway_manager'@'localhost';

/* PART J: TCL Operations */

-- COMMIT: Insert a new reservation and save the transaction permanently
START TRANSACTION;

INSERT INTO Reservation
VALUES (101, 3, 12003, '2026-11-21',
        'C15', 'AC', 950, 'CONFIRMED');

COMMIT;

-- Verify the committed reservation
SELECT *
FROM Reservation
WHERE reservation_id = 101;


-- ROLLBACK: Update a reservation fare and undo the change
START TRANSACTION;

UPDATE Reservation
SET fare = 1200
WHERE reservation_id = 101;

-- Check the updated fare before rollback
SELECT reservation_id, fare
FROM Reservation
WHERE reservation_id = 101;

ROLLBACK;

-- Verify that the original fare has been restored
SELECT reservation_id, fare
FROM Reservation
WHERE reservation_id = 101;


-- SAVEPOINT: Insert a reservation, create a savepoint, and undo a later change
START TRANSACTION;

INSERT INTO Reservation
VALUES (102, 4, 12004, '2026-11-22',
        'D08', 'SL', 700, 'CONFIRMED');

SAVEPOINT before_fare_update;

UPDATE Reservation
SET fare = 800
WHERE reservation_id = 102;

-- Undo only the update, keeping the inserted reservation
ROLLBACK TO before_fare_update;

COMMIT;

-- Verify the final reservation details
SELECT *
FROM Reservation
WHERE reservation_id = 102;