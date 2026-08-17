CREATE DATABASE IF NOT EXISTS analyticalFunctions;
USE analyticalFunctions;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees
(employee_id, employee_name, department, salary)
VALUES
(1, 'Rahul', 'IT', 50000),
(2, 'Priya', 'IT', 60000),
(3, 'Amit', 'IT', 55000),
(4, 'Sneha', 'HR', 45000),
(5, 'Karan', 'HR', 50000),
(6, 'Neha', 'HR', 55000),
(7, 'Rohan', 'Sales', 40000),
(8, 'Pooja', 'Sales', 45000),
(9, 'Arjun', 'Sales', 50000);

SELECT * FROM employees;

##########################################

## Practice Questions

-- 1) Display every employee along with the total salary of all employees.

SELECT e.employee_name, e.salary, 
	SUM(salary) OVER() AS total_salary
FROM employees e;

-- 2) Display every employee along with the average salary of the entire company.

SELECT e.employee_name, e.salary, 
	AVG(salary) OVER() AS company_avg_salary
FROM employees e;

-- 3) Display every employee along with the highest salary in the company.

SELECT e.employee_name, e.salary,
	MAX(e.salary) OVER() AS company_max_salary
FROM employees e;

-- 4) Display every employee along with the lowest salary in the company.

SELECT e.employee_name, e.salary,
	MIN(e.salary) OVER() AS company_min_salary
FROM employees e;

-- 5) Department Total Salary

SELECT e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(PARTITION BY e.department) AS department_total_salary
FROM employees e;

-- 6) Department Average Salary

SELECT e.employee_name, e.department, e.salary,
	AVG(e.salary) OVER(PARTITION BY e.department) AS dpartment_average_salary
FROM employees e;

-- 7) Display every employee along with the highest salary in their department.

SELECT e.employee_name, e.department, e.salary,
	MAX(e.salary) OVER(PARTITION BY e.department) AS max_department_salary
FROM employees e;

-- 8) Salary Difference from Department Average

SELECT e.employee_name,
	   e.department,
       e.salary,
       department_average,
       salary - department_average AS difference
FROM (SELECT e.employee_name,
		e.department,
        e.salary, 
		AVG(e.salary) OVER(PARTITION BY e.department) AS department_average
FROM employees e) e;

-- 9) Salary Difference from Company Average

SELECT e.employee_name,
	   e.department,
       e.salary,
       e.company_average_salary,
       e.salary - e.company_average_salary AS difference
FROM (
SELECT e.employee_name,
	   e.department,
       e.salary,
	AVG(e.salary) OVER() AS company_average_salary
FROM employees e) e;

-- 10) Display every employee and the running total of salary, ordered by salary from lowest to highest.

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary, e.employee_name) AS running_salary
FROM employees e;

-- 11) Display employees ordered by salary from highest to lowest and calculate the running salary total.

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary DESC, e.employee_name DESC) AS running_total
FROM employees e;

-- 12) Display each employee's salary and the running average salary, from lowest salary to highest salary.

SELECT e.employee_name, e.department, e.salary,
	AVG(e.salary) OVER(ORDER BY e.salary, e.employee_name, e.department) AS running_average
FROM employees e;

-- 13) For every employee, show the highest salary encountered so far when employees are ordered by salary ascending.

SELECT e.employee_name, e.department, e.salary,
	MAX(e.salary) OVER(ORDER BY e.salary, e.employee_name, e.department) AS running_max
FROM employees e;

-- 14) For each department, calculate the running salary total ordered by salary ascending.

SELECT e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(PARTITION BY e.department ORDER BY e.salary) AS running_sum
FROM employees e;

-- 15) Calculate the running average salary within each department.

SELECT e.employee_name, e.department, e.salary,
	AVG(e.salary) OVER(PARTITION BY e.department ORDER BY e.salary) AS running_avg
FROM employees e;

-- 16) Find the highest salary encountered so far within each department.

SELECT e.employee_name, e.department, e.salary,
	MAX(e.salary) OVER(PARTITION BY e.department ORDER BY e.salary DESC) AS running_max
FROM employees e;

-- 17) Calculate running salary based on employee_id order.

SELECT e.employee_id, e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(ORDER BY e.employee_id) AS running_sum
FROM employees e;

-- 18) Calculate the running salary within each department, but process employees according to employee_id.

SELECT e.employee_id, e.employee_name, e.department, e.salary,
	SUM(e.salary) OVER(PARTITION BY e.department ORDER BY e.employee_id) AS running_sum_dept
FROM employees e;

-- 19) Employee's Percentage of Running Total

SELECT e.employee_name, e.salary, (e.salary / running_salary) * 100 AS percentage
FROM (

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary, e.employee_name) AS running_salary
FROM employees e
) e;

-- 20) Find the running total of sales ordered from highest to lowest.

SELECT e.employee_name, e.salary,
	SUM(e.salary) OVER(ORDER BY e.salary DESC, e.employee_name DESC) AS running_total
FROM employees e;

-- 21) Use of Row_Number() function

SELECT e.*,
	ROW_NUMBER() OVER() AS rn
FROM employees e;

SELECT e.*,
	ROW_NUMBER() OVER(PARTITION BY e.department ORDER BY e.employee_id) AS rn
FROM employees e;

-- fetch first 2 employees from each department

SELECT e.*
FROM (
	SELECT e.*,
		ROW_NUMBER() OVER(PARTITION BY e.department ORDER BY e.employee_id) AS rn
        FROM employees e
    ) e
WHERE e.rn < 3; 

-- 22) Use of RANK() window function 

SELECT e.*,
	RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS rnk
FROM employees e;

-- top 2 ranks in each department

SELECT e.*
FROM (
SELECT e.*,
	RANK() OVER(PARTITION BY e.department ORDER BY e.salary DESC) AS rnk
FROM employees e
) e
WHERE e.rnk < 3;

-- 23) Use of DENSE_RANK() window function

SELECT e.*,
	RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS rnk,
    DENSE_RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS dense_rnk,
    ROW_NUMBER() OVER(PARTITION BY e.department ORDER BY e.salary) AS rn
FROM employees e;

-- assign first 2 records position/rank using dense_rank()

SELECT e.*
FROM (
SELECT e.*,
	DENSE_RANK() OVER(PARTITION BY e.department ORDER BY e.salary) AS dense_rnk
FROM employees e
) e
WHERE e.dense_rnk < 3;

-- 24) Use of LAG () window function

-- way 1
 
SELECT e.*,
	LAG(e.salary) OVER(
		PARTITION BY e.department
		ORDER BY e.salary
    ) AS prev
FROM employees e;

-- way 2 

SELECT e.*,
	LAG(e.salary, 2, 0) OVER(
		PARTITION BY e.department
        ORDER BY e.salary
    ) AS prev
FROM employees e;

-- 25) Use of LEAD() window function

-- way 1

SELECT e.*,
	LEAD(e.salary) OVER(
				PARTITION BY e.department
                ORDER BY e.salary) AS next
FROM employees e;

-- way 2

SELECT e.*,
	LEAD(e.salary, 2, 0) OVER(
						PARTITION BY e.department
                        ORDER BY e.salary 
						) AS next
FROM employees e;

# Combine LAG() & LEAD()

SELECT e.*,
	LAG(e.salary) OVER(
				  PARTITION BY e.department
				  ORDER BY e.salary
				) AS prev,
	LEAD(e.salary) OVER(
				   PARTITION BY e.department
                   ORDER BY e.salary
                ) AS next
FROM employees e;

-- EG. Fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee

SELECT e.*,
	LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) AS prev,
	
    CASE 
    
    WHEN e.salary > LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) THEN 'Higher then previous employee salary'
	
	WHEN e.salary < LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) THEN 'Less then previous employee salary'
                  
	WHEN e.salary = LAG(e.salary) OVER(
				  PARTITION BY e.department	
                  ORDER BY e.salary
                  ) THEN 'Equal to previous employee salary'
	END sal_range
    
FROM employees e;