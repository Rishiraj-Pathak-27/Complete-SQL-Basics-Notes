-- 181. Employees Earning More Than Their Managers

-- Write a solution to find the employees who earn more than their managers.
-- Return the result table in any order.

-- self join approach

SELECT e1.name AS Employee
FROM Employee e1
JOIN Employee e2
ON e1.managerId = e2.id
WHERE e1.salary>e2.salary;

