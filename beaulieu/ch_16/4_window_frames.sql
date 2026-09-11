SELECT 
    TO_CHAR(payment_date, 'IYYY IW') AS payment_week,
    SUM(amount) AS week_total,
    SUM(SUM(amount)) OVER
        (
            ORDER BY TO_CHAR(payment_date, 'IYYY IW')
            ROWS UNBOUNDED PRECEDING
        ) AS rolling_sum
FROM payment
GROUP BY TO_CHAR(payment_date, 'IYYY IW')
ORDER BY 1;



SELECT 
    TO_CHAR(payment_date, 'IYYY IW') AS payment_week,
    SUM(amount) AS week_total,
    AVG(SUM(amount)) OVER
        (
            ORDER BY TO_CHAR(payment_date, 'IYYY IW')
            ROWS BETWEEN 1 PRECEDING 
                AND 1 FOLLOWING
        ) AS rolling_3wk_avg
FROM payment
GROUP BY TO_CHAR(payment_date, 'IYYY IW')
ORDER BY 1;



SELECT 
    payment_date::DATE,
    SUM(amount),
    AVG(SUM(amount)) OVER
        (
            ORDER BY payment_date::DATE
            RANGE BETWEEN '3 day'::INTERVAL PRECEDING
                AND '3 day'::INTERVAL FOLLOWING
        ) AS avg_7_day
FROM payment
WHERE payment_date BETWEEN '2022-05-01' AND '2022-07-01'
GROUP BY payment_date::DATE
ORDER BY 1;
