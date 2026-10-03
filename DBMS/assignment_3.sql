CREATE DATABASE IF NOT EXISTS DBMS_ASSIGNMENT;

USE DBMS_ASSIGNMENT;








CREATE TABLE colleges (
    college_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(6) NOT NULL UNIQUE,
    name VARCHAR(300),
    total_intake INT,
    address VARCHAR(500),
    district VARCHAR(70),
    status ENUM(
        'Deemed University',
        'Government',
        'Government-Aided',
        'Un-Aided',
        'University',
        'University Department',
        'University Managed',
        'University Managed (Un-Aided)'
    ),
    autonomy_status ENUM(
        'Autonomous',
        'Non-Autonomous'
    ),
    minority_status VARCHAR(100),
    university VARCHAR(150),
    old_data BOOLEAN DEFAULT FALSE,
    new_data_map_id INT
);


CREATE TABLE cap_rounds (
    round_id INT PRIMARY KEY AUTO_INCREMENT,
    year INT NOT NULL,
    round_number INT NOT NULL
);


CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(15) NOT NULL UNIQUE,
    name VARCHAR(300) NOT NULL,
    gender ENUM(
        'Co-Education',
        'Female'
    ),
    total_intake INT,
    college_id INT NOT NULL,
    old_data BOOLEAN DEFAULT FALSE,
    new_data_map_id INT,
    FOREIGN KEY (college_id)
        REFERENCES colleges(college_id)
        ON DELETE CASCADE
);


CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(15) NOT NULL UNIQUE,
    gender ENUM(
        'Any',
        'Ladies'
    ) NOT NULL DEFAULT 'Any',
    quota ENUM(
        'General',
        'TFWS',
        'PWD',
        'DEF',
        'EWS',
        'Orphan',
        'MI'
    ) NOT NULL DEFAULT 'General'
);


CREATE TABLE seat_types (
    seat_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(100) NOT NULL,
    short_form VARCHAR(20) NOT NULL
);


CREATE TABLE state_cutoffs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    college_id INT NOT NULL,
    branch_id INT NOT NULL,
    seat_type_id INT NOT NULL,
    category_id INT NOT NULL,
    percentile DECIMAL(10,2) NOT NULL,
    cap_round_id INT NOT NULL,

    CONSTRAINT uq_state_cutoff
        UNIQUE (
            college_id,
            branch_id,
            seat_type_id,
            category_id,
            cap_round_id
        ),

    FOREIGN KEY (college_id)
        REFERENCES colleges(college_id)
        ON DELETE CASCADE,

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
        ON DELETE CASCADE,

    FOREIGN KEY (seat_type_id)
        REFERENCES seat_types(seat_type_id)
        ON DELETE CASCADE,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE CASCADE,

    FOREIGN KEY (cap_round_id)
        REFERENCES cap_rounds(round_id)
        ON DELETE CASCADE
);


CREATE TABLE all_india_cutoffs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    college_id INT NOT NULL,
    branch_id INT NOT NULL,
    seat_type VARCHAR(20) NOT NULL,
    merit_exam VARCHAR(70) NOT NULL,
    percentile DECIMAL(10,2),
    cap_round_id INT NOT NULL,

    CONSTRAINT uq_all_india_cutoff
        UNIQUE (
            college_id,
            branch_id,
            seat_type,
            cap_round_id
        ),

    FOREIGN KEY (college_id)
        REFERENCES colleges(college_id)
        ON DELETE CASCADE,

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
        ON DELETE CASCADE,

    FOREIGN KEY (cap_round_id)
        REFERENCES cap_rounds(round_id)
        ON DELETE CASCADE
);