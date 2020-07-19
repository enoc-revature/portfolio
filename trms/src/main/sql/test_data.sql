-- Choose the test schema
SET search_path TO test;



-- Enumeration Data
DELETE FROM status;
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

DELETE FROM event;
INSERT INTO event
VALUES (1, 'University Courses', 0.80),
       (2, 'Seminars', 0.60),
       (3, 'Certificate Preparation Classes', 0.75),
       (4, 'Certification', 1.00),
       (5, 'Technical Training', 0.90),
       (6, 'Other', 0.30);

DELETE FROM grading_format;
INSERT INTO grading_format
VALUES (1, 'Standard', 'C'),
       (2, 'Pass/Fail', 'Pass');

DELETE FROM grades;
INSERT INTO grades
VALUES (1, 1, 'A'),
       (2, 1, 'B'),
       (3, 1, 'C'),
       (4, 1, 'D'),
       (5, 1, 'F'),
       (6, 2, 'Pass'),
       (7, 2, 'Fail');



-- User TABLES
DELETE FROM employee;
INSERT INTO employee
VALUES  ('TEST_USERNAME', 'TEST_PASSWORD', 'TEST_FIRST', 'TEST_LAST','123 PLACE', '123-456-7890','TEST@email.com'),
        ('TEST_USERNAME2', 'TEST_PASSWORD2', 'TEST_FIRST2', 'TEST_LAST2','999 PLACE', '000-000-0000','TEST2@email.com'), 
        ('TEST_SUPERVISOR', 'TEST_SUPERVISOR', 'TEST_SUPER1', 'TEST_SUPER2','555 PLACE', '999-999-9999','SUPERVISOR@email.com'); 

DELETE FROM benco;
INSERT INTO benco
VALUES  ('BENCO_USERNAME', 'BENCO_PASSWORD', 'Ben', 'Co', 'BENCO@email.com'),
        ('BENCO_USERNAME2', 'BENCO_PASSWORD2', 'Benette', 'Cola', 'BENCO2@email.com');


-- One To Many
DELETE FROM reimbursement;
INSERT INTO reimbursement (
    employee_id, supervisor_id, benco_id, description,
    location, start_date, start_time, cost, grading_format_id,
    passing_grade, final_grade, type_of_event, justification,
    status_id, award_amount)
VALUES  ('TEST_USERNAME', 'TEST_SUPERVISOR', 'BENCO_USERNAME', 'TEST_DESCRIPTION1',
            '555 TEST EVENT STREET', '2020-08-01', '09:00:00', 250.00, 1,
            'C', null, 4, 'TEST_JUSTIFICATION1',
            1,250.00),
        ('TEST_USERNAME', 'TEST_SUPERVISOR', 'BENCO_USERNAME', 'TEST_DESCRIPTION2',
            '555 TEST EVENT STREET', '2020-08-01', '11:00:00', 300.00, 1,
            'C', null, 4, 'TEST_JUSTIFICATION2',
            1,300.00);