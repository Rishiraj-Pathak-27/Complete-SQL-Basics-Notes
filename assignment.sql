CREATE DATABASE IF NOT EXISTS Assignment;
USE Assignment;

# SCHEMAS

CREATE TABLE Employees (
 emp_id INT PRIMARY KEY,
 name VARCHAR(50),
 salary INT,
 dept_id INT,
 manager_id INT
);

INSERT INTO Employees VALUES
(101, 'Amit', 50000, 1, NULL),
(102, 'Neha', 60000, 1, 101),
(103, 'Raj', 45000, 2, NULL),
(104, 'Priya', 70000, 2, 103);

CREATE TABLE Departments (
 dept_id INT PRIMARY KEY,
 dept_name VARCHAR(50)
);

INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR');

CREATE TABLE Orders (
 order_id INT PRIMARY KEY,
 emp_id INT,
 order_amount INT,
 order_date DATE
);

INSERT INTO Orders VALUES
(201, 101, 500, '2023-10-01'),
(202, 102, 1500, '2023-10-02'),
(203, 101, 700, '2023-10-03');

# QUESTIONS

# 1) List all employees with salary greater than 50000.
SELECT *
FROM Employees
WHERE salary > 50000;

# 2) Show employee names with their department names.

SELECT e.name AS emp_name, d.dept_name AS dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id;

# 3) Find total salary per department.

SELECT d.dept_name AS dept_name , SUM(salary) AS total_salary_per_dept
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

# 4) List all orders with employee names

SELECT e.name AS emp_name, o.order_id AS order_id, o.order_amount AS order_amount, o.order_date AS order_date
FROM Orders o
LEFT JOIN Employees e
ON o.emp_id = e.emp_id;

# 5) Find employees earning more than average salary.

SELECT name, salary
FROM Employees 
WHERE salary > (SELECT AVG(salary) 
				FROM Employees);
                
# 6) Find employees working in the same department as 'Neha'.

SELECT * FROM Employees;

SELECT *
FROM Employees
WHERE dept_id = (SELECT dept_id 
				FROM Employees 
				WHERE name = "Neha");

# 7) Find second highest salary.

SELECT name,salary
FROM Employees
ORDER BY salary DESC
LIMIT 1,1;

# 8) List employees who have no manager.

SELECT name, manager_id
FROM Employees
WHERE manager_id IS NULL;

# 9) Find employees earning more than their department average salary.

SELECT * FROM Employees;
                
# AVG SALARY OF DEPTS
                
SELECT d.dept_name, AVG(salary)
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

# EMPLOYEES HAVING MORE SALARY THAN AVG SALARY

SELECT name, salary, dept_id
FROM Employees
WHERE salary > (SELECT AVG(salary)
				FROM Employees e
                WHERE dept_id = e.dept_id);
                
# 10) Get highest salary employee in each department.

SELECT d.dept_name AS dept_name, e.name AS emp_name, salary
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id
WHERE e.salary = ( SELECT MAX(salary)
				  FROM Employees
                  WHERE dept_id = d.dept_id);
