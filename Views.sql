# IN SQL Views are the Virtual Tables used to store a particular query like snapshots and futher can be used repeatedly.
# In general we create the views for the complex queries.
# The Views are used to create an alias based on a particular columns which we are going to use many times and ignore the remaining cols which we are not going to use many times.

# Syntax to create a view:
-- CREATE VIEW view_name AS
-- SELECT QUERY

# Accessing & Dropping Views:
-- SELECT * FROM view_name;
-- DROP VIEW view_name; 

-- EG)
CREATE DATABASE IF NOT EXISTS views;
USE views;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    emp_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
    );
    
INSERT INTO Orders VALUES
(1, 1, 102, '2024-01-10', 5000),
(2, 2, 103, '2024-01-12', 3000),
(3, 3, 102, '2024-02-01', 7000),
(4, 1, 104, '2024-02-10', 2000),
(5, 4, 105, '2024-02-15', 4500),
(6, 5, 103, '2024-03-01', 6000),
(7, 2, 104, '2024-03-05', 3500),
(8, 3, 105, '2024-03-10', 8000);

SELECT * FROM Orders;

CREATE VIEW view_one AS
SELECT customer_id, order_date, amount
FROM Orders;

SELECT * FROM view_one;

# Display amount > 50000;

SELECT * FROM view_one
WHERE amount > 5000;

SET SQL_SAFE_UPDATES = 0;

# changing the amount of user with id=5 with 10000 in original table without violating the data inside the view
UPDATE Orders
SET amount = 10000
WHERE customer_id = 5;

SET SQL_SAFE_UPDATES=1;

## Also affect the view as Updated the amount
SELECT * FROM view_one;

#####################################################

# PRACTICE

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    manager_id INT,
    salary INT,
    join_date DATE
);

INSERT INTO employees VALUES
(1, 'Amit', 101, NULL, 80000, '2020-01-10'),
(2, 'Neha', 102, 1, 60000, '2021-03-15'),
(3, 'Ravi', 101, 1, 50000, '2022-06-20'),
(4, 'Priya', 103, 2, 70000, '2021-07-11'),
(5, 'Karan', 102, 2, 45000, '2023-02-05'),
(6, 'Sneha', 103, 4, 65000, '2022-09-18');

SELECT * FROM employees;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Sales');

SELECT * FROM departments;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Raj', 'Mumbai'),
(2, 'Simran', 'Delhi'),
(3, 'Arjun', 'Pune'),
(4, 'Meera', 'Nagpur');

SELECT * FROM customers;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    emp_id INT,
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders VALUES
(101, 1, 2, 12000, '2024-01-10'),
(102, 2, 3, 8000, '2024-01-15'),
(103, 3, 4, 15000, '2024-02-01'),
(104, 1, 2, 20000, '2024-02-10'),
(105, 4, 5, 5000, '2024-02-20'),
(106, 2, 6, 18000, '2024-03-05');

SELECT * FROM orders;

# Create a view to show: employee name department name

CREATE VIEW name_view AS
SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

SELECT * FROM name_view;

# Create a view for employees earning more than 60,000.

CREATE VIEW salary_view AS
SELECT *
FROM employees
WHERE salary > 60000;

SELECT * FROM salary_view;






