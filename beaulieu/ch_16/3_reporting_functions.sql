SELECT
    TO_CHAR(payment_date, 'FMMonth') AS payment_month,
    amount,
    SUM(amount) OVER
        (
            PARTITION BY TO_CHAR(payment_date, 'FMMonth')
        ) AS month_total,
    SUM(amount) OVER () AS grand_total
FROM payment
WHERE amount >= 10
ORDER BY payment_date;



SELECT 
    TO_CHAR(payment_date, 'FMMonth') AS payment_month,
    SUM(amount) AS month_total,
    ROUND(SUM(amount) / SUM(SUM(amount)) OVER() * 100, 2) AS pct_of_total
FROM payment
GROUP BY TO_CHAR(payment_date, 'FMMonth')
ORDER BY MIN(payment_date);



SELECT
    TO_CHAR(payment_date, 'FMMonth') AS payment_month,
    SUM(amount) AS month_total,
    CASE SUM(amount)
        WHEN MAX(SUM(amount)) OVER () THEN 'Highest'
        WHEN MIN(SUM(amount)) OVER () THEN 'Lowest'
        ELSE 'Middle'
    END AS descriptor
FROM payment
GROUP BY TO_CHAR(payment_date, 'FMMonth')
ORDER BY MIN(payment_date);
