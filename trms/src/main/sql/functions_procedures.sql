-- Choose the test schema
SET search_path TO test;


-- Return user info if passwords match
DROP FUNCTION login_auth;
CREATE OR REPLACE FUNCTION login_auth(un VARCHAR, pw VARCHAR)
RETURNS TABLE (
    username VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    address VARCHAR,
    phone VARCHAR,
    email VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT e.username, e.first_name, e.last_name,
           e.address, e.phone, e.email
        FROM employee e
    WHERE e.username=un
        AND e.password=pw;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM login_auth('TEST_USERNAME', 'TEST_PASSWORD');



-- Return BenCo info if passwords match
DROP FUNCTION benco_auth;
CREATE OR REPLACE FUNCTION benco_auth(ben VARCHAR, pw VARCHAR)
RETURNS TABLE (
    username VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT b.username, b.first_name,
           b.last_name, b.email
        FROM benco b
    WHERE b.username=ben
        AND b.password=pw;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM benco_auth('BENCO_USERNAME', 'BENCO_PASSWORD');



-- Get reimbursement for user/supervisor.  This populates the user's page
DROP FUNCTION user_reim;
CREATE OR REPLACE FUNCTION user_reim(un VARCHAR)
RETURNS TABLE (
    reimbursement_id INT,
    event VARCHAR,
    event_date DATE,
    status_of_request VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT r.id, description, start_date, status_name
    FROM reimbursement r
    JOIN status s
    ON status_id=s.id
    WHERE employee_id=un;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM user_reim('TEST_USERNAME');



-- Get reimbursement to populate BenCo page
DROP FUNCTION benco_reim;
CREATE OR REPLACE FUNCTION benco_reim()
RETURNS TABLE (
    reimbursement_id INT,
    full_name VARCHAR,
    event_name VARCHAR,
    event_date DATE,
    status_of_request VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    SELECT r.id, CAST(CONCAT(first_name, ' ', last_name) AS VARCHAR) full_name, description, start_date, status_name
    -- SELECT r.id, first_name full_name, description, start_date, status_name
    FROM reimbursement r
    JOIN status s
    ON status_id=s.id
    JOIN employee e
    ON employee_id=username;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM benco_reim();



-- Populate reimbursement details for employee
DROP FUNCTION fill_emp_details;
CREATE OR REPLACE FUNCTION fill_emp_details(reim_id INT)
RETURNS TABLE (
    -- Personal Info
    full_name VARCHAR(64),
    status_name VARCHAR(64),
    employee_id VARCHAR(64),
    phone_number VARCHAR(64),
    email VARCHAR(64),
    address VARCHAR(64),

    -- Event Info
    start_date DATE,
    start_time TIME,
    event_address VARCHAR(64),
    event_description VARCHAR(64),
    cost DECIMAL(10,2),
    grading_format VARCHAR(64),
    passing_grade VARCHAR(8),
    type_of_event VARCHAR(64),
    justification TEXT,

    -- Other
    final_grade VARCHAR(8),
    event_attachment VARCHAR(256),
    approval_attachment VARCHAR(256),
    preapproval_type VARCHAR(64),
    work_missed TEXT,
    projected_reimbursement DECIMAL(6,2),
    award_amount DECIMAL(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        CAST(CONCAT(first_name, ' ' , last_name) AS VARCHAR(64)) AS full_name, s.status_name,
        r.employee_id, phone, e.email, e.address, r.start_date, r.start_time,
        location, description, r.cost, gf.grading_format, r.passing_grade,
        event.name, r.justification, r.final_grade, r.event_attachment, r.approval_attachment,
        r.preapproval_type, r.work_missed,
        (r.cost*coverage) AS projected_reimbursement, r.award_amount
    FROM reimbursement r
    JOIN employee e ON r.employee_id=username
    JOIN grading_format gf ON grading_format_id=gf.id
    JOIN event ON r.type_of_event=event.id
    JOIN status s ON status_id=s.id
    WHERE r.id=reim_id;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM fill_emp_details(1);

-- Populate reimbursement details for benco
DROP FUNCTION fill_benco_details;
CREATE OR REPLACE FUNCTION fill_emp_details(reim_id INT)
RETURNS TABLE (
    -- Personal Info
    full_name VARCHAR(64),
    status_name VARCHAR(64),
    employee_id VARCHAR(64),
    phone_number VARCHAR(64),
    email VARCHAR(64),
    address VARCHAR(64),

    -- Event Info
    start_date DATE,
    start_time TIME,
    event_address VARCHAR(64),
    event_description VARCHAR(64),
    cost DECIMAL(10,2),
    grading_format VARCHAR(64),
    passing_grade VARCHAR(8),
    type_of_event VARCHAR(64),
    justification TEXT,

    -- Other
    final_grade VARCHAR(8),
    event_attachment VARCHAR(256),
    approval_attachment VARCHAR(256),
    preapproval_type VARCHAR(64),
    work_missed TEXT,
    projected_reimbursement DECIMAL(6,2),
    award_amount DECIMAL(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        CAST(CONCAT(first_name, ' ' , last_name) AS VARCHAR(64)) AS full_name, s.status_name,
        r.employee_id, phone, e.email, e.address, r.start_date, r.start_time,
        location, description, r.cost, gf.grading_format, r.passing_grade,
        event.name, r.justification, r.final_grade, r.event_attachment, r.approval_attachment,
        r.preapproval_type, r.work_missed,
        (r.cost*coverage) AS projected_reimbursement, r.award_amount
    FROM reimbursement r
    JOIN employee e ON r.employee_id=username
    JOIN grading_format gf ON grading_format_id=gf.id
    JOIN event ON r.type_of_event=event.id
    JOIN status s ON status_id=s.id
    WHERE r.id=reim_id;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM fill_benco_details(1);


-- Event Type
DROP FUNCTION get_events;
CREATE FUNCTION get_events()
RETURNS TABLE (
    name VARCHAR(64),
    coverage DECIMAL(6,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT e.name, e.coverage FROM event e;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM get_events();



-- Grading Format
SELECT * FROM grading_format;
DROP FUNCTION get_grading_format;
CREATE FUNCTION get_grading_format()
RETURNS TABLE (
    grading_format VARCHAR(64),
    default_passing_grade VARCHAR(8)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT g.grading_format, g.default_passing_grade FROM grading_format g;
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM get_grading_format();


-- Passing Grade
DROP FUNCTION get_grades;
CREATE FUNCTION get_grades(format VARCHAR)
RETURNS TABLE (
    grade VARCHAR(8)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT g.grade FROM grades g
    WHERE grading_format_id = (
        SELECT distinct(id) FROM grading_format
        WHERE grading_format=format
    );
END
$$
LANGUAGE plpgsql;
-- SELECT * FROM get_grades('Standard');