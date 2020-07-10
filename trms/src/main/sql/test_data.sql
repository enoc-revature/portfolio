-- Choose the test schema
SET search_path TO test;



-- Enumeration Data
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

INSERT INTO event
VALUES (1, 'University Courses', 0.80),
       (2, 'Seminars', 0.60),
       (3, 'Certificate Preparation Classes', 0.75),
       (4, 'Certification', 1.00),
       (5, 'Technical Training', 0.90),
       (6, 'Other', 0.30);


INSERT INTO grading_format
VALUES (1, 'Standard', 'C'),
       (2, 'Pass/Fail', 'Pass');

INSERT INTO grades
VALUES (1, 'Standard', 'A'),
       (2, 'Standard', 'B'),
       (3, 'Standard', 'C'),
       (4, 'Standard', 'D'),
       (5, 'Standard', 'F'),
       (6, 'Pass/Fail', 'Pass'),
       (7, 'Pass/Fail', 'Fail');