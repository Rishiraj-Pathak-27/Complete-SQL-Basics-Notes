-- 176. Second Highest Salary
-- Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
-- The result format is in the following example.

-- Approach 1

-- SELECT (
--     SELECT DISTINCT salary
--     FROM Employee 
--     ORDER BY salary DESC
--     LIMIT 1,1
-- ) AS SecondHighestSalary;

-- Approach 2

-- SELECT MAX(salary) AS SecondHighestSalary
-- FROM Employee
-- WHERE salary < (SELECT MAX(salary) FROM Employee);