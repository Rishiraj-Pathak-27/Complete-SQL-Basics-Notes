-- 1068. Product Sales Analysis I
-- Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
-- Return the resulting table in any order.

SELECT p.product_name AS product_name,
       s.year AS year,
       s.price AS price
FROM Product p
JOIN Sales s
ON p.product_id=s.product_id;