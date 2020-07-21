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
CREATE FUNCTION fill_emp_details(reim_id INT)
RETURNS TABLE (

)
AS $$
BEGIN

END
$$
LANGUAGE plpgsql;




-- TODO: Populate reimbursement details for employee



-- TODO: Fill dropdown menu



-- TODO: An array of updates to reimbursement status





