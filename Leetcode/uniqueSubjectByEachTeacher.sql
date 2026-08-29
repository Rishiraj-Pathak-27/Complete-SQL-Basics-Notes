-- 2356. Number of Unique Subjects Taught by Each Teacher

-- Write a solution to calculate the number of unique subjects each teacher teaches in the university.

-- Return the result table in any order.

SELECT teacher_id,
    COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;