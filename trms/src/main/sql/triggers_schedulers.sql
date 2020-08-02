-- Choose the test schema
SET search_path TO test;

CREATE EXTENSION IF NOT EXISTS pgagent;


-- //TODO: Mark an unapproved request as urgent if the event occurs within 2 weeks.  
UPDATE reimbursement
SET urgent=true
WHERE EXISTS (
    SELECT id, start_date FROM reimbursement
    WHERE start_date-current_date < 14
);




-- //TODO: Send an escalation email to a BenCo's direct supervisor if the the BenCo doesn't approve a request in "a timely manner" (within 1 week of event).



-- //TODO: If the request is left in AWAITING_DECISION status within 3 days of event by the supervisor, the request is auto-approved, which moves the request to the department head's view.



-- //TODO: If the department head doesn't make a decision in time (by the date of event), the request is auto-approved, which is final.
