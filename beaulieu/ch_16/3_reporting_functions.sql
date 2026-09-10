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
