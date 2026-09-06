SELECT
    TO_CHAR(rental_date, 'FMMonth') AS rental_month,
    COUNT(*) AS num_rentals
FROM rental
WHERE rental_date BETWEEN '2022-05-01'
    AND '2022-08-01'
GROUP BY TO_CHAR(rental_date, 'FMMonth')
ORDER BY MIN(rental_date);

SELECT
    SUM(CASE
            WHEN TO_CHAR(rental_date, 'FMMonth') = 'May' THEN 1
            ELSE 0
        END
    ) AS may_rentals,
    SUM(CASE
            WHEN TO_CHAR(rental_date, 'FMMonth') = 'June' THEN 1
            ELSE 0
        END
    ) AS june_rentals,
    SUM(CASE
            WHEN TO_CHAR(rental_date, 'FMMonth') = 'July' THEN 1
            ELSE 0
        END
    ) AS july_rentals
FROM rental
WHERE rental_date BETWEEN '2022-05-01'
    AND '2022-08-01';



SELECT
    a.first_name,
    a.last_name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM film_actor AS fa
                INNER JOIN film AS f
                ON fa.film_id = f.film_id
            WHERE fa.actor_id = a.actor_id
                AND f.rating = 'G'
        ) THEN 'Y'
        ELSE 'N'
    END AS g_actor,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM film_actor AS fa
                INNER JOIN film AS f
                ON fa.film_id = f.film_id
            WHERE fa.actor_id = a.actor_id
                AND f.rating = 'PG'
        ) THEN 'Y'
        ELSE 'N'
    END AS pg_actor,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM film_actor AS fa
                INNER JOIN film AS f
                ON fa.film_id = f.film_id
            WHERE fa.actor_id = a.actor_id
                AND f.rating = 'NC-17'
        ) THEN 'Y'
        ELSE 'N'
    END AS nc17_actor
FROM actor AS a
WHERE a.last_name LIKE 'S%'
    OR a.first_name LIKE 'S%';

SELECT
    f.title,
    CASE
        (
            SELECT COUNT(*) 
            FROM inventory AS i
            WHERE i.film_id = f.film_id
        )
        WHEN 0 THEN 'Out Of Stock'
        WHEN 1 THEN 'Scarce'
        WHEN 2 THEN 'Scarce'
        WHEN 3 THEN 'Available'
        WHEN 4 THEN 'Available'
        ELSE 'Common'
    END AS film_availability
FROM film AS f;



--SELECT 100 / 0;

SELECT
    c.first_name,
    c.last_name,
    SUM(p.amount) AS tot_payment_amt,
    COUNT(p.amount) AS num_payments,
    --SUM(p.amount) / NULLIF(COUNT(p.amount), 0) AS avg_payment
    SUM(p.amount) / 
        CASE
            WHEN COUNT(p.amount) = 0 THEN 1
            ELSE COUNT(p.amount)
        END avg_payment
FROM customer AS c
    LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;
