-- 197. Rising Temperature

-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
-- Return the result table in any order.

SELECT w1.id AS id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate)=1
WHERE w1.temperature > w2.temperature;