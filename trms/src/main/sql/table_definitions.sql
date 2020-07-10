-- Choose the test schema
SET search_path TO test;



-- Table Definitions
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    username VARCHAR(64) PRIMARY KEY,
    password VARCHAR(64) NOT NULL,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    address VARCHAR(64),
    phone VARCHAR(64),
    email VARCHAR(64)
);

DROP TABLE IF EXISTS benco;
CREATE TABLE benco (
    username VARCHAR(64) PRIMARY KEY,
    password VARCHAR(64) NOT NULL,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    address VARCHAR(64),
    email VARCHAR(64)

);



-- Enumeration Tables
DROP TABLE IF EXISTS status;
CREATE TABLE status (
    id INT PRIMARY KEY,
    status_name VARCHAR(64)
);

DROP TABLE IF EXISTS event;
CREATE TABLE event (
    id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(64),
    coverage DECIMAL(6,2)
);

DROP TABLE IF EXISTS grading_format;
CREATE TABLE grading_format (
    id INT PRIMARY KEY,
    grading_format VARCHAR(64) UNIQUE,
    default_passing_grade VARCHAR(8)
);

DROP TABLE IF EXISTS grades;
CREATE TABLE grades (
    id INT PRIMARY KEY,
    grading_format VARCHAR(64) UNIQUE,
    grade VARCHAR(8),
    FOREIGN KEY (grading_format) REFERENCES grading_format(grading_format)
);



-- One To Many Table
DROP TABLE IF EXISTS reimbursement;
CREATE TABLE reimbursement (
    id SERIAL PRIMARY KEY,
    employee_id VARCHAR(64),
    supervisor_id VARCHAR(64),
    benco_id VARCHAR(64),

    -- Required from form
    description VARCHAR(64),
    location VARCHAR(64),
    start_date DATE,
    start_time TIME,

    cost DECIMAL(10,2),
    grading_format VARCHAR(64),
    passing_grade VARCHAR(8),
    final_grade VARCHAR(8),
    type_of_event VARCHAR(8),
    justification TEXT,
    status_id VARCHAR(64),
    award_amount DECIMAL(6,2),

    -- Optional form entries
    event_attachment VARCHAR(256),
    approval_attachment VARCHAR(256),
    preapproval_type VARCHAR(64),
    work_missed TEXT,

    FOREIGN KEY (employee_id) REFERENCES employee(username),
    FOREIGN KEY (benco_id) REFERENCES benco(username),
    FOREIGN KEY (status_id) REFERENCES status(status_type),
    FOREIGN KEY (type_of_event) REFERENCES event(id),
    FOREIGN KEY (grading_format) REFERENCES grading_format(grading_format)
);

