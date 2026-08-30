SELECT
    c.first_name,
    c.last_name,
    pymnt.num_rentals,
    pymnt.tot_payments
FROM customer AS c
    INNER JOIN
        (
            SELECT
                customer_id,
                COUNT(*) AS num_rentals,
                SUM(amount) AS tot_payments
            FROM payment
            GROUP BY customer_id
        ) AS pymnt
    ON c.customer_id = pymnt.customer_id;



SELECT 
    'Small Fry' AS name,
    0 AS low_limit,
    74.99 AS high_limit
    UNION ALL
SELECT
    'Average Joes' AS name,
    75 AS low_limit,
    149.99 AS high_limit
    UNION ALL
SELECT
    'Heavy Hitters' AS name,
    150 AS low_limit,
    9999999.99 AS high_limit;



SELECT
    pymnt_grps.name,
    COUNT(*) AS num_customers
FROM
    (
        SELECT
            customer_id,
            COUNT(*) AS num_rentals,
            SUM(amount) AS tot_payments
        FROM payment
        GROUP BY customer_id
    ) AS pymnt
    INNER JOIN
    (
        SELECT 
            'Small Fry' AS name,
            0 AS low_limit,
            74.99 AS high_limit
            UNION ALL
        SELECT
            'Average Joes' AS name,
            75 AS low_limit,
            149.99 AS high_limit
            UNION ALL
        SELECT
            'Heavy Hitters' AS name,
            150 AS low_limit,
            9999999.99 AS high_limit
    ) AS pymnt_grps
    ON pymnt.tot_payments
        BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
GROUP BY pymnt_grps.name;
