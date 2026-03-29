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




