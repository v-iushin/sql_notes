SELECT
    TO_CHAR(payment_date, 'IYYY IW') AS payment_week,
    SUM(amount) AS week_total,
    LAG(SUM(amount), 1) OVER
        (
            ORDER BY TO_CHAR(payment_date, 'IYYY IW')
        ) AS prev_wk_tot,
    LEAD(SUM(amount), 1) OVER
        (
            ORDER BY TO_CHAR(payment_date, 'IYYY IW')
        ) AS next_weel_tot
FROM payment
GROUP BY TO_CHAR(payment_date, 'IYYY IW')
ORDER BY 1;



SELECT
    TO_CHAR(payment_date, 'IYYY IW') AS payment_week,
    SUM(amount) AS week_total,
    ROUND((SUM(amount) - LAG(SUM(amount), 1) OVER
        (
            ORDER BY TO_CHAR(payment_date, 'IYYY IW')
        )
    ) / LAG(SUM(amount), 1) OVER
        (
            ORDER BY TO_CHAR(payment_date, 'IYYY IW')
        )
    * 100, 1
    ) AS pct_diff
FROM payment
GROUP BY TO_CHAR(payment_date, 'IYYY IW')
ORDER BY 1;
/*
7909.16 - 1
514.18  - ?
? = 0.065
pct_diff = (0.065 - 1) * 100 = -93.5
*/
