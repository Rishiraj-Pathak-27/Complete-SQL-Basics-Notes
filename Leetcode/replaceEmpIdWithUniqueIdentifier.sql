-- 1378. Replace Employee ID With The Unique Identifier

-- Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
-- Return the result table in any order.

SELECT e1.unique_id AS unique_id, e2.name AS name
FROM EmployeeUNI e1
LEFT JOIN Employees e2
ON e1.id=e2.id;

