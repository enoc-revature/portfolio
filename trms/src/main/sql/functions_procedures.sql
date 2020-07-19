-- Choose the test schema
SET search_path TO test;


-- Return user info if passwords MATCH
DROP FUNCTION login_auth;
CREATE OR REPLACE FUNCTION login_auth(un VARCHAR, pw VARCHAR)
RETURNS TABLE (
    username VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    address VARCHAR,
    phone VARCHAR,
    email VARCHAR
) AS
$$
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



-- Return user info if passwords MATCH



-- Get reimbursement for user/supervisor



-- Get reimbursement to populate BenCo page



-- Create a new reimbursement request



-- Update reimbursement status




