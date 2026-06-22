CREATE DATABASE IF NOT EXISTS windowfunctions;
USE windowfunctions;

CREATE TABLE exam_scores (
    student_id INT,
    student_name VARCHAR(50),
    subject VARCHAR(30),
    marks INT
);

INSERT INTO exam_scores VALUES
(101,'Aarav','Maths',88),
(101,'Aarav','Science',92),
(101,'Aarav','English',85),
(101,'Aarav','History',78),

(102,'Diya','Maths',95),
(102,'Diya','Science',89),
(102,'Diya','English',91),
(102,'Diya','History',84),

(103,'Vivaan','Maths',76),
(103,'Vivaan','Science',81),
(103,'Vivaan','English',79),
(103,'Vivaan','History',73),

(104,'Anaya','Maths',90),
(104,'Anaya','Science',94),
(104,'Anaya','English',88),
(104,'Anaya','History',86),

(105,'Krishna','Maths',68),
(105,'Krishna','Science',74),
(105,'Krishna','English',71),
(105,'Krishna','History',69),

(106,'Ishita','Maths',82),
(106,'Ishita','Science',85),
(106,'Ishita','English',87),
(106,'Ishita','History',80),

(107,'Advait','Maths',97),
(107,'Advait','Science',96),
(107,'Advait','English',93),
(107,'Advait','History',90),

(108,'Myra','Maths',78),
(108,'Myra','Science',83),
(108,'Myra','English',80),
(108,'Myra','History',76),

(109,'Arjun','Maths',85),
(109,'Arjun','Science',88),
(109,'Arjun','English',84),
(109,'Arjun','History',82),

(110,'Sara','Maths',91),
(110,'Sara','Science',87),
(110,'Sara','English',89),
(110,'Sara','History',85);

SELECT * FROM exam_scores;
DESCRIBE exam_scores;

# If we want the sum of each subject total then normally we will use the group by but it will return only few attributes and records

SELECT s.subject AS subject , SUM(s.marks) AS total_marks
FROM exam_scores s
GROUP BY s.subject;

# But if we dont want to modify the table/schema so we will directly use the window function

-- SYNTAX :-  SELECT *,
-- 			  col_name(on which you want to perform aggregation) OVER(PARTITION BY col_name(this is the window on which you have to partition and run the aggregation)) AS window_alias 
-- 			  FROM table AS table_alias;

## AGGREGATE WINDOW FUNCTIONS
    
## 1. SUM()

SELECT *,
	   SUM(s.marks) OVER(PARTITION BY s.subject) AS subject_total
       FROM exam_scores s;
       
       
## 2. AVG()

	SELECT student_name,
		   AVG(marks) OVER(
				PARTITION BY(subject)
           ) AS avg_marks
	FROM exam_scores;
    
## 3. COUNT()

	SELECT student_name,
		   COUNT(*) OVER(
				PARTITION BY(subject)
			) AS total_student_per_subject
	FROM exam_scores;
       
       
## 4. MIN()

	SELECT student_name, 
		   MIN(marks) OVER(
				PARTITION BY (subject)
            ) AS min_marks
	FROM exam_scores;

## 5. MAX()

	SELECT student_name,
		MAX(marks) OVER (
				PARTITION BY(subject)
        ) AS max_marks
	FROM exam_scores;
    

## 6. Rolling Total

## bank data

-- Eg. Initial Balance - 0

-- 22nd June   		100rs			100rs
-- 28th June   		500rs			600rs
-- 31st June   		500rs			1100rs
-- 05th July   		1000rs			2100rs

# Here based on initial+previous data we are calculating the total current (i.e the rolling total) 

CREATE TABLE bank_transactions (
    transaction_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO bank_transactions
(transaction_id, account_holder, transaction_date, transaction_type, amount)
VALUES
(1, 'Shubham', '2026-01-01', 'DEPOSIT', 1000.00),
(2, 'Shubham', '2026-01-03', 'WITHDRAW', -200.00),
(3, 'Shubham', '2026-01-05', 'DEPOSIT', 500.00),
(4, 'Shubham', '2026-01-07', 'WITHDRAW', -100.00),
(5, 'Rahul', '2026-01-01', 'DEPOSIT', 2000.00),
(6, 'Rahul', '2026-01-04', 'WITHDRAW', -300.00),
(7, 'Rahul', '2026-01-06', 'DEPOSIT', 400.00);

DESCRIBE bank_transactions;
SELECT * FROM bank_transactions;

## rolling total using SUM()

SELECT *,
	   SUM(amount) OVER(PARTITION BY account_holder ORDER BY transaction_date) AS current_bal
	   FROM bank_transactions;

## 7. ROW_NUMBER()

SELECT ROW_NUMBER() OVER(PARTITION BY student_name) AS row_no,
    student_id, student_name, subject, marks
	FROM exam_scores;
    
############################################

## PRACTICE QUESTIONS

-- Q1. Show each transaction along with the total amount transacted by that account holder.

SELECT transaction_id, account_holder, amount,
	   SUM(amount) OVER(PARTITION BY account_holder) AS total_amount
       FROM bank;
       
-- Q2. Show each transaction along with the average transaction amount for that account holder.

SELECT transaction_id, account_holder, amount,
	AVG(amount) OVER(PARTITION BY account_holder) AS avg_total
    FROM bank;
    
-- Q3. Show each transaction along with the highest transaction amount made by that account holder.

SELECT transaction_id, account_holder, amount,
	MAX(amount) OVER(PARTITION BY account_holder) AS max_otal
    FROM bank;

-- Q4. Show each transaction along with the lowest transaction amount made by that account holder.

SELECT transaction_id, account_holder, amount,
	MIN(amount) OVER(PARTITION BY account_holder) AS min_total
    FROM bank;
    
-- Q5. Show the total number of transactions performed by each account holder beside every row.

SELECT transaction_id, account_holder, amount,
	COUNT(*) OVER(PARTITION BY account_holder) AS total_count
    FROM bank;
    
-- Q6. Calculate the running balance for each account holder ordered by transaction date.

SELECT transaction_id, account_holder, amount,
	SUM(amount) OVER(PARTITION BY account_holder ORDER BY transaction_date) AS total_count
    FROM bank;

SELECT * FROM exam_scores;