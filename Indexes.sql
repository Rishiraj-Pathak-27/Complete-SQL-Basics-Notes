USE employee;

CREATE TABLE emps(
emp_id INT PRIMARY KEY,
fname VARCHAR(50),
lname VARCHAR(50),
desig VARCHAR(50),
dept VARCHAR(50),
salary INT NOT NULL
);

INSERT INTO emps (emp_id, fname, lname, desig, dept, salary) VALUES
(101, 'Raju', 'Rastogi', 'Manager', 'Loan', 37000),
(102, 'Sham', 'Mohan', 'Cashier', 'Cash', 32000),
(103, 'Baburao', 'Apte', 'Associate', 'Loan', 25000),
(104, 'Paul', 'Philip', 'Accountant', 'Account', 45000),
(105, 'Alex', 'Watt', 'Associate', 'Deposit', 35000),
(106, 'Rick', 'Watt', 'Manager', 'Account', 65000),
(107, 'Leena', 'Johnson', 'Lead', 'Cash', 25000),
(108, 'John', 'Paul', 'Manager', 'IT', 75000),
(109, 'Alex', 'Watt', 'Probation', 'Loan', 40000),
(110, 'Neha', 'Sharma', 'Analyst', 'IT', 50000);

SELECT * FROM emps;
SELECT * FROM emps WHERE fname = "Alex";

START TRANSACTION;

SET SQL_SAFE_UPDATES = 0;

UPDATE emps
SET salary = 45000
WHERE emp_id = 101;

COMMIT;

-- Normal Index Creation for emps table
CREATE INDEX i_fname
ON emps(fname);

-- to show the indexes
SHOW INDEXES FROM emps;
SELECT * FROM emps;

-- unique index creation
CREATE UNIQUE INDEX i_empid
ON emps(emp_id);

SHOW INDEXES FROM emps;
SELECT * FROM emps;

-- Deleting an Index

ALTER TABLE emps
DROP INDEX i_fname;
 