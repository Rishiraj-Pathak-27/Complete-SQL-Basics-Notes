-- 584. Find Customer Referee

-- Find the names of the customer that are either:

-- referred by any customer with id != 2.
-- not referred by any customer.
-- Return the result table in any order.

SELECT c.name AS name
FROM Customer c
WHERE c.referee_id IS NULL OR c.referee_id <> 2;