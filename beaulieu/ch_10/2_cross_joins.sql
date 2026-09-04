SELECT
    c.name AS category_name,
    l.name AS language_name
FROM category AS c
    CROSS JOIN language AS l;



SELECT 
    ('2022-01-01'::DATE + (ones.num + tens.num + hundreds.num) * INTERVAL '1 day')::DATE AS dt
FROM
(
    SELECT 0 num UNION ALL
    SELECT 1 num UNION ALL
    SELECT 2 num UNION ALL
    SELECT 3 num UNION ALL
    SELECT 4 num UNION ALL
    SELECT 5 num UNION ALL
    SELECT 6 num UNION ALL
    SELECT 7 num UNION ALL
    SELECT 8 num UNION ALL
    SELECT 9 num
) AS ones
CROSS JOIN
(
    SELECT 0 num UNION ALL
    SELECT 10 num UNION ALL
    SELECT 20 num UNION ALL
    SELECT 30 num UNION ALL
    SELECT 40 num UNION ALL
    SELECT 50 num UNION ALL
    SELECT 60 num UNION ALL
    SELECT 70 num UNION ALL
    SELECT 80 num UNION ALL
    SELECT 90 num
) AS tens
CROSS JOIN
(
    SELECT 0 num UNION ALL
    SELECT 100 num UNION ALL
    SELECT 200 num UNION ALL
    SELECT 300 num
) AS hundreds
WHERE '2022-01-01'::DATE + (ones.num + tens.num + hundreds.num) * INTERVAL '1 day' < '2023-01-01'
ORDER BY 1;



SELECT 
    days.dt,
    COUNT(r.rental_id) AS num_rentals
FROM rental AS r
    RIGHT JOIN
    (
        SELECT 
            ('2022-01-01'::DATE + (ones.num + tens.num + hundreds.num) * INTERVAL '1 day')::DATE AS dt
        FROM
        (
           SELECT 0 num UNION ALL
           SELECT 1 num UNION ALL
           SELECT 2 num UNION ALL
           SELECT 3 num UNION ALL
           SELECT 4 num UNION ALL
           SELECT 5 num UNION ALL
           SELECT 6 num UNION ALL
           SELECT 7 num UNION ALL
           SELECT 8 num UNION ALL
          SELECT 9 num
        ) AS ones
        CROSS JOIN
        (
           SELECT 0 num UNION ALL
          SELECT 10 num UNION ALL
          SELECT 20 num UNION ALL
          SELECT 30 num UNION ALL
          SELECT 40 num UNION ALL
          SELECT 50 num UNION ALL
          SELECT 60 num UNION ALL
          SELECT 70 num UNION ALL
          SELECT 80 num UNION ALL
          SELECT 90 num
        ) AS tens
        CROSS JOIN
        (
           SELECT 0 num UNION ALL
           SELECT 100 num UNION ALL
           SELECT 200 num UNION ALL
           SELECT 300 num
        ) AS hundreds
        WHERE '2022-01-01'::DATE + (ones.num + tens.num + hundreds.num) * INTERVAL '1 day' < '2023-01-01'
    ) AS days
    ON days.dt = r.rental_date::DATE
GROUP BY days.dt
ORDER BY 1;
