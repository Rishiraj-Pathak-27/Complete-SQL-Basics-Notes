-- 1327. List the Products Ordered in a Period

-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
-- Return the result table in any order.


-- method 1

-- SELECT p.product_name AS product_name,
--        SUM(o.unit) AS unit
-- FROM Products p
-- JOIN Orders o
-- ON p.product_id=o.product_id
-- WHERE o.order_date >= '2020-02-01' AND o.order_date <= '2020-02-29'
-- GROUP BY p.product_name
-- HAVING SUM(o.unit) >= 100;


-- method 2

-- SELECT p.product_name AS product_name,
--        SUM(o.unit) AS unit
-- FROM Products p
-- JOIN Orders o
-- ON p.product_id=o.product_id
-- WHERE YEAR(o.order_date)=2020 AND MONTH(o.order_date)=2
-- GROUP BY p.product_name
-- HAVING SUM(o.unit) >= 100;


