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

SELECT * FROM login_auth('TEST_USERNAME', 'TEST_PASSWORD');



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
select * from benco;
SELECT * FROM benco_auth('BENCO_USERNAME', 'BENCO_PASSWORD');



-- Get reimbursement for user/supervisor



-- Get reimbursement to populate BenCo page



-- Create a new reimbursement request



-- An array of updates to reimbursement status




