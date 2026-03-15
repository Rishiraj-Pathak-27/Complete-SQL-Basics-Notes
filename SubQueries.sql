# Sub Queries are the queries indise the query used when the data required is in the nested form
# SYNTAX -> SELECT column(s) FROM table_name WHERE column_name operator (SUB query)

# EG 1:

USE Student;

CREATE TABLE student_details
(
rollno INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
city VARCHAR(50)
) AUTO_INCREMENT = 101;


INSERT INTO student_details (name, marks, city)
VALUES
("Anil", 78, "Pune"),
("Bhumika", 93, "Mumbai"),
("Chetan", 85, "Delhi"),
("Dhruv", 96, "Mumbai"),
("Emanuel", 92, "Delhi"),
("Farah", 82, "Delhi");

SELECT * FROM student_details;

# get name of all students who scored marks more than the class avg

SELECT name, marks
FROM student_details
WHERE marks > (SELECT AVG(marks) FROM student_details);

# get the name of student with even roll number

SELECT rollno
FROM student_details
WHERE rollno % 2 = 0;

SELECT name, rollno
FROM student_details
WHERE rollno IN ( SELECT rollno FROM student_details WHERE rollno % 2 = 0 );

# find the max marks of students from city = "Delhi"

SELECT *
FROM student_details
WHERE city = "Delhi";

SELECT MAX(marks) AS max_marks
FROM (SELECT * FROM student_details WHERE city = "Delhi") AS temp;

###############################################################

## PRACTICE QUESTIONS

CREATE DATABASE employee;

USE employee;

CREATE TABLE emp (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT
);

INSERT INTO emp VALUES
(1, 'Ravi', 'IT', 60000, 3),
(2, 'Anita', 'HR', 45000, 2),
(3, 'Rahul', 'IT', 75000, 5),
(4, 'Priya', 'Finance', 50000, 4),
(5, 'Karan', 'IT', 80000, 6),
(6, 'Neha', 'HR', 47000, 3),
(7, 'Amit', 'Finance', 65000, 5),
(8, 'Sneha', 'IT', 72000, 4),
(9, 'Vikas', 'HR', 40000, 1),
(10, 'Pooja', 'Finance', 68000, 6);

SELECT * FROM emp;

#1) Find the employee who earns the maximum salary.

SELECT * 
FROM emp
WHERE salary IN (SELECT MAX(salary) FROM emp);

#2) Find employees whose salary is less than the maximum salary.

SELECT * 
FROM emp
WHERE salary < (SELECT MAX(salary) FROM emp);

#3) Find employees whose salary is greater than Ravi's salary.

SELECT *
FROM emp
WHERE salary > (SELECT salary FROM emp WHERE name="Ravi");

#4) Find employees working in the same department as Rahul.

SELECT *
FROM emp
WHERE department = (SELECT department FROM emp WHERE name = "Rahul");

#5) Find employees whose salary is greater than the average salary of IT department.

SELECT *
FROM emp
WHERE salary > (SELECT AVG(salary) FROM emp WHERE department = "IT");

#6) Find employees whose salary is equal to the minimum salary.

SELECT * 
FROM emp
WHERE salary = (SELECT MIN(salary) FROM emp);

#7) Find employees who earn more than all employees in HR department.

SELECT * 
FROM emp
WHERE salary > (SELECT MAX(salary) FROM emp WHERE department = "HR");

#8) Find employees who earn more than any employee in Finance department.

SELECT *
FROM emp
WHERE salary > ANY(SELECT salary FROM emp WHERE department = "Finance");  # ANY keyword is used with subquery inorder to find atleast one value

#9) Find employees whose experience is greater than the average experience.

SELECT *
FROM emp
WHERE experience > (SELECT AVG(experience) FROM emp);

# 10) Find employees earning more than the average salary of their department.

SELECT *
FROM emp
WHERE salary > (SELECT AVG(salary) FROM emp GROUP BY department);