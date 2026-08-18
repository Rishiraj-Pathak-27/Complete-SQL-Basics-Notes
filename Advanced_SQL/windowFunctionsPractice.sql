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

###############################################################################################################

# Department Table

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales'),
(4, 'Finance');

# Employees Table

CREATE TABLE emp (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO emp
(employee_id, employee_name, department_id, salary)
VALUES
(101, 'Rahul', 1, 50000),
(102, 'Priya', 1, 60000),
(103, 'Amit', 1, 55000),
(104, 'Vikram', 1, 60000),

(105, 'Sneha', 2, 45000),
(106, 'Karan', 2, 50000),
(107, 'Neha', 2, 55000),
(108, 'Riya', 2, 50000),

(109, 'Rohan', 3, 40000),
(110, 'Pooja', 3, 45000),
(111, 'Arjun', 3, 50000),
(112, 'Ankit', 3, 45000),

(113, 'Meera', 4, 55000),
(114, 'Suresh', 4, 65000),
(115, 'Kavya', 4, 60000),
(116, 'Nitin', 4, 65000);

-- QUESTIONS

-- 1) Total salary of the entire company for every employee.

SELECT e.*,
	SUM(e.salary) OVER() AS total_sal
FROM emp e;

-- 2) Average salary of the company for every employee.

SELECT e.*,
	AVG(e.salary) OVER() AS avg_sal
FROM emp e;

-- 3) Total salary of each department.

SELECT e.*,
	SUM(e.salary) OVER(PARTITION BY e.department_id) AS dept_wise_sal
FROM emp e;

-- 4) Average salary of each department.

SELECT e.*,
	AVG(e.salary) OVER(PARTITION BY e.department_id) AS dept_wise_avg
FROM emp e;

-- 5) Running total of company salary, lowest salary first.

SELECT e.*,
	SUM(e.salary) OVER(ORDER BY e.salary, e.employee_id, e.employee_name) AS running_total
FROM emp e;

-- 6) Running total of salary within each department.

SELECT e.*,
	SUM(e.salary) OVER(PARTITION BY e.department_id ORDER BY e.salary, e.employee_id, e.employee_name) AS running_total_dept
FROM emp e;

-- 7) Running average salary within each department.

SELECT e.*,
	AVG(e.salary) OVER(PARTITION BY e.department_id ORDER BY e.salary, e.employee_id, e.employee_name) AS running_avg_dept
FROM emp e;

-- 8) Rank all employees by salary, highest first.

SELECT e.*,
	RANK() OVER(ORDER BY e.salary DESC) AS rnk
FROM emp e;

-- 9) Rank employees within each department.

SELECT e.*,
	RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
FROM emp e;

-- 10) Dense rank employees within each department.

SELECT e.*,
	DENSE_RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
FROM emp e;

-- 11) Assign a unique row number within each department.

SELECT e.*,
	ROW_NUMBER() OVER(PARTITION BY e.department_id) AS row_num
FROM emp e;

-- 12) Find the highest-paid employee(s) in each department.

SELECT e.*
FROM (
	SELECT e.*,
		RANK() OVER(PARTITION BY e.department_id ORDER BY e.salary DESC) AS max
	FROM emp e
) e
WHERE e.max < 2;

-- 13) Find the top 2 salary ranks in each department, including ties.

SELECT e.*
FROM (
	SELECT e.*,
		DENSE_RANK() OVER(
			PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS top_2_sal
	FROM emp e
) e
WHERE e.top_2_sal < 3;

-- 14) Create an employee salary report containing:
-- employee_name
-- department
-- salary
-- company_total_salary
-- department_total_salary
-- department_average_salary
-- department_running_salary
-- department_rank

SELECT e.employee_name,
	   d.department_id AS department,
       d.department_name,
       e.salary,
       e.company_total_salary,
       e.department_total_salary,
       e.department_avg_salary,
       e.department_running_salary,
       e.department_rank
FROM (
	SELECT e.*,
	SUM(e.salary) OVER() AS company_total_salary,
    
    SUM(e.salary) OVER(
		PARTITION BY e.department_id
	) AS department_total_salary,
    
    AVG(e.salary) OVER(
		PARTITION BY e.department_id
	) AS department_avg_salary,
    
    SUM(e.salary) OVER(
		PARTITION BY e.department_id 
        ORDER BY e.salary, e.employee_id, e.employee_name
	) AS department_running_salary,
    
    RANK() OVER(
		PARTITION BY e.department_id
        ORDER BY e.salary DESC
	) AS department_rank
    FROM emp e
) e
JOIN departments d
ON e.department_id=d.department_id;


