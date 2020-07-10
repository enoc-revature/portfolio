-- Choose the test schema
SET search_path TO test;



-- Enumeration Data
TRUNCATE TABLE status;
INSERT INTO status
VALUES (1, 'NEW'), -- Not Reviewed
       (2, 'NEEDS_MORE_INFO'),
       (3, 'ALTERED'), -- BenCo altered the reimbursement amount and is waiting for employee approval.  The employee may cancel requests whose amount has been altered.
       (4, 'CANCELLED'), -- Canceled by employee when reimbursement was adjusted by BenCo
       (5, 'CONFIRMED'), -- Employee has confirmed the altered reimbursement amount
       (6, 'AWAITING_DECISION'), -- Approved by BenCo, BenCo cannot deny a request
       (7, 'DENIED'),
       (8, 'DS_APPROVED'), -- Approved by direct supervisor
       (9, 'APPROVED'), -- Approved by department head)
       (10, 'PENDING_PASSING'), -- Approved but waiting for passing grade or presentation
       (11, 'AWARDED');

TRUNCATE TABLE event;
INSERT INTO event
VALUES (1, 'University Courses', 0.80),
       (2, 'Seminars', 0.60),
       (3, 'Certificate Preparation Classes', 0.75),
       (4, 'Certification', 1.00),
       (5, 'Technical Training', 0.90),
       (6, 'Other', 0.30);


TRUNCATE TABLE grading_format;
INSERT INTO grading_format
VALUES (1, 'Standard', 'C'),
       (2, 'Pass/Fail', 'Pass');

TRUNCATE TABLE grades;
INSERT INTO grades
VALUES (1, 'Standard', 'A'),
       (2, 'Standard', 'B'),
       (3, 'Standard', 'C'),
       (4, 'Standard', 'D'),
       (5, 'Standard', 'F'),
       (6, 'Pass/Fail', 'Pass'),
       (7, 'Pass/Fail', 'Fail');


-- User TABLES
TRUNCATE TABLE employee;
INSERT INTO employee
VALUES  ('TEST_USERNAME', 'TEST_PASSWORD', 'TEST_FIRST', 'TEST_LAST','123 PLACE', '123-456-7890','TEST@email.com'),
        ('TEST_USERNAME2', 'TEST_PASSWORD2', 'TEST_FIRST2', 'TEST_LAST2','999 PLACE', '000-000-0000','TEST2@email.com'), 
        ('TEST_SUPERVISOR', 'TEST_SUPERVISOR', 'TEST_SUPER1', 'TEST_SUPER2','555 PLACE', '999-999-9999','SUPERVISOR@email.com'); 

TRUNCATE TABLE benco;
INSERT INTO benco
VALUES  ('BENCO_USERNAME', 'BENCO_PASSWORD', 'BENCO@email.com'),
        ('BENCO_USERNAME2', 'BENCO_PASSWORD2', 'BENCO2@email.com');



-- One To Many
TRUNCATE TABLE reimbursement;
INSERT INTO reimbursement (
    employee_id, supervisor_id, benco_id, description,
    location, start_date, start_time, cost, grading_format,
    passing_grade, final_grade, type_of_event, justification,
    status_id, award_amount)
VALUES  ('TEST_USERNAME', 'TEST_SUPERVISOR', 'BENCO_USERNAME', 'TEST_DESCRIPTION',
            '555 TEST EVENT STREET', '2020-08-01', '09:00:00', 300.00, 1,
            'C', null, 4, 'TEST_JUSTIFICATIONI',
            1,300.00),
        ('TEST_USERNAME', 'TEST_SUPERVISOR', 'BENCO_USERNAME', 'TEST_DESCRIPTION',
            '555 TEST EVENT STREET', '2020-08-01', '09:00:00', 300.00, 1,
            'C', null, 4, 'TEST_JUSTIFICATIONI',
            1,300.00);