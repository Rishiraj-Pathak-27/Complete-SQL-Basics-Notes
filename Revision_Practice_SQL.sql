CREATE DATABASE IF NOT EXISTS practice;
USE practice;

# emp table

CREATE TABLE emp(
emp_id INT PRIMARY KEY,
name VARCHAR(20),
department VARCHAR(50),
salary DOUBLE NOT NULL,
hire_date date NOT NULL
);

INSERT INTO emp VALUES
(1,"Alice", "IT", 70000,"2024-01-15"),
(2,"Bob", "HR", 45000,"2023-06-10"),
(3,"Charlie", "IT", 80000,"2022-08-20"),
(4,"David", "Finance", 60000,"2024-03-12"),
(5,"Emma", "HR", 50000,"2025-01-05"),
(6,"Frank", "IT", 90000,"2021-11-11"),
(7,"Grace", "Finance", 75000,"2023-09-18"),
(8,"Henry", "Marketing", 55000,"2024-05-25");

SELECT * FROM emp;

# cust table

CREATE TABLE cust(
cust_id INT PRIMARY KEY,
cust_name VARCHAR(30),
city VARCHAR(40)
);

INSERT INTO cust VALUES
(101,"Rahul","Nagpur"),
(102,"Priya","Mumbai"),
(103,"Aman","Pune"),
(104,"Sneha","Nagpur"),
(105,"Karan","Delhi");

SELECT * FROM cust;

# orders table

CREATE TABLE orders(
order_id INT PRIMARY KEY,
cust_id INT,
order_date DATE NOT NULL,
amt DOUBLE 
);

INSERT INTO orders VALUES
(1001,101,"2025-01-10",1200),
(1002,102,"2025-01-11",2500),
(1003,101,"2025-01-15",1800),
(1004,103,"2025-02-01",3200),
(1005,104,"2025-02-05",1500),
(1006,101,"2025-02-08",2100),
(1007,102,"2025-02-10",2700);

SELECT * FROM orders;

# dept table

CREATE TABLE dept(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);

INSERT INTO dept VALUES
(1,"IT"),
(2,"HR"),
(3,"Finance"),
(4,"Marketing");

SELECT * FROM dept;


############################################

-- 1. Display all employees. 

SELECT * FROM emp;

-- Display employee names and salaries only.

SELECT name, salary 
FROM emp;

-- 3. Find employees earning more than 60,000.

SELECT *
FROM emp
WHERE salary > 60000;

-- 4. Find employees working in the IT department.

SELECT * 
FROM emp
WHERE department = "IT";

-- 5. Sort employees by salary descending.

SELECT *
FROM emp
ORDER BY salary DESC;

-- 6. Find the highest-paid employee.

SELECT name, salary
FROM emp
ORDER BY salary DESC
LIMIT 1;

-- 7. Count total employees.

SELECT COUNT(*) AS total_emps 
FROM emp;

-- 8. Find average salary department-wise.

SELECT department, AVG(salary) AS avg_salary
FROM emp
GROUP BY department;

-- 9. Find employees hired after 2024-01-01.

SELECT * 
FROM emp
WHERE hire_date > "2024-01-01";

-- Find employees whose names start with 'A'.

SELECT *
FROM emp
WHERE name LIKE 'A%';

-- 11. Count employees in each department.

SELECT department, COUNT(department)
FROM emp
GROUP BY department;

-- 12. Find departments with average salary greater than 65,000.

SELECT department, AVG(salary)
FROM emp
GROUP BY department
HAVING AVG(salary) > 65000;

-- 13. Find customers from Nagpur.

SELECT * 
FROM cust
WHERE city = "Nagpur";

-- 14. Find total order amount for each customer.

SELECT c.cust_name, COALESCE(SUM(o.amt),0) AS total_amount
FROM cust c
LEFT JOIN orders o
ON c.cust_id = o.cust_id
GROUP BY c.cust_name;

-- 15. Find customers who never placed an order.

SELECT c.cust_name, COALESCE(o.order_date,0), COALESCE(o.amt,0)
FROM cust c
LEFT JOIN orders o
ON c.cust_id = o.cust_id
WHERE o.cust_id IS NULL;

-- 16. Find the customer with the highest purchase amount.

SELECT c.cust_name,SUM(o.amt) AS total_amt
FROM cust c
LEFT JOIN orders o
ON c.cust_id = o.cust_id
GROUP BY c.cust_name
ORDER BY total_amt DESC
LIMIT 1;

-- 17. Find the second-highest salary.

SELECT *
FROM emp
ORDER BY salary DESC
LIMIT 1,1;

-- 18. Find employees earning above average salary.

SELECT *
FROM emp
WHERE salary > (SELECT AVG(salary) FROM emp); 

-- 19. Join Employees and Departments.

SELECT *
FROM emp e 
LEFT JOIN dept d
ON e.emp_id = d.dept_id

UNION

SELECT *
FROM emp e
RIGHT JOIN dept d
ON e.emp_id = d.dept_id;

-- 20. Find duplicate cities in Customers table

SELECT city, COUNT(city) AS city_count
FROM cust
GROUP BY city
HAVING city_count >= 2;

-- 25. Create a view for employee details with department information.

CREATE VIEW emp_dept_view AS
SELECT e.emp_id, e.name, e.salary, e.hire_date, COALESCE(d.dept_name,0)
FROM emp e
LEFT JOIN dept d
ON e.emp_id = d.dept_id;

SELECT * FROM emp_dept_view;