-- Display all employees.
-- Display employee names and salary.
-- Find employees with salary greater than 50000.
-- Display employees working in IT department.

-- SELECT * FROM Employee;

-- SELECT emp_name, salary FROM Employee;

-- SELECT * FROM Employee WHERE salary > 50000;

-- SELECT e.emp_name AS EMP_NAME
-- FROM Employee e
-- JOIN Department d
-- ON e.dept_id = d.dept_id
-- WHERE d.dept_name = "IT";

-- Show employee name and department name.

-- SELECT e.emp_name AS EMP_NAME , d.dept_name AS DEPT_NAME
-- FROM Employee e
-- LEFT JOIN Department d
-- ON e.dept_id = d.dept_id;

-- Show all departments and employees in them.

-- SELECT d.dept_id AS DEPT_ID, d.dept_name AS DEPT_NAME , e.emp_name AS EMP_NAME
-- FROM Department d
-- LEFT JOIN Employee e
-- ON d.dept_id = e.dept_id;

-- Display all employees and departments.

-- SELECT e.emp_name AS EMP_NAME, d.dept_name AS DEPT_NAME
-- FROM Employee e
-- JOIN Department d
-- ON e.dept_id = d.dept_id;

-- Show employee name and project name.

-- SELECT e.emp_name AS EMP_NAME , p.project_name AS PROJECT
-- FROM Employee e
-- LEFT JOIN Project p
-- ON e.dept_id = p.dept_id;

-- Show employee name, department name and project name

-- SELECT e.emp_name AS EMP_NAME, d.dept_name AS DEPT_NAME, p.project_name AS PROJECT
-- FROM Employee e
-- JOIN Department d
-- ON e.dept_id = d.dept_id
-- JOIN Works_On w
-- ON e.emp_id = w.emp_id
-- JOIN Project p
-- ON w.project_id = p.project_id;

-- Show employees working more than 20 hours on a project.

-- SELECT e.emp_name AS EMP_NAME , w.hours AS WORKING_HOURS
-- FROM Employee e
-- LEFT JOIN Works_on w
-- ON e.emp_id = w.emp_id
-- WHERE hours > 20;

-- Find average salary of employees.
-- Find highest salary.
-- Count number of employees in each department.
-- Show departments having more than 1 employee.

-- SELECT ROUND(AVG(salary)) AS AVG_SALARY
-- FROM Employee;

-- SELECT MAX(salary) AS HIGHEST_SALARY
-- FROM Employee;

-- SELECT salary AS HIGHEST_SALARY
-- FROM Employee
-- ORDER BY salary DESC
-- LIMIT 1;

-- SELECT d.dept_name AS DEPT_NAME , COUNT(*) AS TOTAL_EMP
-- FROM Department d
-- LEFT JOIN Employee e
-- ON d.dept_id = e.dept_id
-- GROUP BY d.dept_name;

-- SELECT d.dept_name AS DEPT_NAME, COUNT(e.emp_id) AS TOTAL_EMP
-- FROM Department d
-- JOIN Employee e
-- ON d.dept_id = e.dept_id
-- GROUP BY d.dept_name
-- HAVING COUNT(e.emp_id) > 1;

-- UPDATE OPERATIONS

-- Increase salary of IT employees by 10%.

-- UPDATE Employee
-- SET salary = salary*1.10
-- WHERE dept_id = 1;

-- Change department of Rahul to Finance.

-- UPDATE Employee
-- SET dept_id = 3
-- WHERE emp_name = "Rahul";

-- Update project hours for employee 102 to 20.

-- UPDATE Works_On
-- SET hours = 20
-- WHERE emp_id = 102;

-- DELETE OPERATIONS

-- Delete employees with salary less than 45000.

-- DELETE FROM Employee
-- WHERE salary < 45000;

-- Delete projects in Marketing department.

-- DELETE FROM Project
-- WHERE dept_id = (
--  SELECT dept_id
--  FROM Department
--  WHERE dept_name = "Marketing");

-- Get employee names and department names together.

-- SELECT e.emp_name FROM Employee e
-- UNION
-- SELECT d.dept_name FROM Department d;

-- Find department IDs present in both Employee and Project tables.

-- SELECT e.dept_id AS DEPT_ID FROM Employee e
-- INTERSECT
-- SELECT p.dept_id AS DEPRT_ID FROM Project p;

-- Find departments that have no employees.

-- SELECT dept_id AS DEPT_ID FROM Department
-- MINUS
-- SELECT dept_id AS DEPT_ID FROM Employee;

-- Create a view showing employee name and project name.

-- CREATE VIEW employee_showcase AS
--  SELECT e.emp_name AS EMPLOYEE_NAME , p.project_name AS PROJECT_NAME
--  FROM Employee e
--  LEFT JOIN Project p
--  ON e.dept_id = p.dept_id;

-- SELECT * FROM employee_showcase;


-- Query employees from the created view with salary > 50000.

-- CREATE VIEW emp_salary AS
-- SELECT emp_name , salary
-- FROM Employee
-- WHERE salary > 50000;

-- SELECT * FROM emp_salary;

-- Insert 3 new employees using sequence.

CREATE SEQUENCE business_seq
START WITH 101
INCREMENT BY 1
MIN VALUE 101
MAX VALUE 110
NOCACHE
NOCYCLE;

INSERT INTO Business
VALUES
(business_seq.NEXTVAL, "TechPred", 1, "Rishiraj"),
(business_seq.NEXTVAL, "FinanceSathi", 2, "John");

SELECT business_seq.CURRVAL FROM Business;




