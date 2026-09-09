SELECT
    EXTRACT(QUARTER FROM payment_date) AS quarter,
    TO_CHAR(payment_date, 'FMMonth') AS month_nm,
    SUM(amount) AS monthly_sales
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2022
GROUP BY EXTRACT(QUARTER FROM payment_date), TO_CHAR(payment_date, 'FMMonth')
ORDER BY MIN(payment_date);



SELECT
    EXTRACT(QUARTER FROM payment_date) AS quarter,
    TO_CHAR(payment_date, 'FMMonth') AS month_nm,
    SUM(amount) AS monthly_sales,
    MAX(SUM(amount)) OVER () AS max_overall_sales,
    MAX(SUM(amount)) OVER (PARTITION BY EXTRACT(QUARTER FROM payment_date)) AS max_qrtr_sales
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2022
GROUP BY EXTRACT(QUARTER FROM payment_date), TO_CHAR(payment_date, 'FMMonth')
ORDER BY MIN(payment_date);



SELECT
    EXTRACT(QUARTER FROM payment_date) AS quarter,
    TO_CHAR(payment_date, 'FMMonth') AS month_nm,
    SUM(amount) AS monthly_sales,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS sales_rank
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2022
GROUP BY EXTRACT(QUARTER FROM payment_date), TO_CHAR(payment_date, 'FMMonth')
ORDER BY MIN(payment_date);



SELECT
    EXTRACT(QUARTER FROM payment_date) AS quarter,
    TO_CHAR(payment_date, 'FMMonth') AS month_nm,
    SUM(amount) AS monthly_sales,
    RANK() OVER 
        (
            PARTITION BY EXTRACT(QUARTER FROM payment_date)
            ORDER BY SUM(amount) DESC
        ) AS qtr_sales_rank
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2022
GROUP BY EXTRACT(QUARTER FROM payment_date), TO_CHAR(payment_date, 'FMMonth')
ORDER BY MIN(payment_date);
