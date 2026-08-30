SELECT
    c.first_name,
    c.last_name
FROM customer AS c
WHERE 20 = 
    (
        SELECT COUNT(*)
        FROM rental AS r
        WHERE r.customer_id = c.customer_id
    );



SELECT
    c.first_name,
    c.last_name
FROM customer AS c
WHERE
    (
        SELECT SUM(p.amount)
        FROM payment AS p
        WHERE p.customer_id = c.customer_id
    ) 
    BETWEEN 180 AND 240;



SELECT
    c.first_name,
    c.last_name
FROM customer AS c
WHERE EXISTS
    (
        SELECT 1
        FROM rental AS r
        WHERE r.customer_id = c.customer_id
            AND r.rental_date::DATE < '2022-05-24'
    );
-- EXISTS counts DISTINCT values



SELECT
    a.first_name,
    a.last_name
FROM actor AS a
WHERE NOT EXISTS
    (
        SELECT 1
        FROM film_actor AS fa
            INNER JOIN film AS f
            ON f.film_id = fa.film_id
        WHERE fa.actor_id = a.actor_id
            AND f.rating = 'R' 
    );



/*

UPDATE customer AS c
SET c.last_update = 
    (
        SELECT MAX(r.rental_date)
        FROM rental AS r
        WHERE r.customer_id = c.customer_id
    )
WHERE EXISTS
    (
        SELECT 1
        FROM rental AS r
        WHERE r.customer_id = c.customer_id
    );



DELETE FROM customer AS c
WHERE 365 < ALL
    (
        SELECT (NOW()::DATE - r.rental_date::DATE) AS days_since_last_rental
        FROM rental AS r
        WHERE r.customer_id = c.customer_id
    );

*/
