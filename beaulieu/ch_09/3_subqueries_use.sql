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



SELECT
    c.first_name,
    c.last_name,
    ct.city,
    SUM(p.amount) AS tot_payments,
    COUNT(*) AS tot_rentals
FROM payment AS p
    INNER JOIN customer AS c
    ON p.customer_id = c.customer_id
    INNER JOIN address AS a
    ON c.address_id = a.address_id
    INNER JOIN city AS ct
    ON a.city_id = ct.city_id
GROUP BY c.first_name, c.last_name, ct.city;



SELECT
    customer_id,
    COUNT(*) AS tot_rentals,
    SUM(amount) AS tot_payments
FROM payment
GROUP BY customer_id;



SELECT
    c.first_name,
    c.last_name,
    ct.city,
    pymnt.tot_payments,
    pymnt.tot_rentals
FROM
    (
        SELECT
            customer_id,
            COUNT(*) AS tot_rentals,
            SUM(amount) AS tot_payments
        FROM payment
        GROUP BY customer_id
    ) AS pymnt
    INNER JOIN customer AS c
    ON pymnt.customer_id = c.customer_id
    INNER JOIN address AS a
    ON c.address_id = a.address_id
    INNER JOIN city AS ct
    ON a.city_id = ct.city_id;






-- WITH clause

-- begining of WITH
WITH
    actors_s AS
    (
        SELECT 
            actor_id, 
            first_name, 
            last_name
        FROM actor
        WHERE last_name LIKE 'S%'
    ),
    actors_s_pg AS
    (
        SELECT 
            s.actor_id,
            s.first_name,
            s.last_name,
            f.film_id,
            f.title
        FROM actors_s AS s
            INNER JOIN film_actor AS fa
            ON s.actor_id = fa.actor_id
            INNER JOIN film AS f
            ON fa.film_id = f.film_id
        WHERE f.rating = 'PG'
    ),
    actors_s_pg_revenue AS
    (
        SELECT
            spg.first_name,
            spg.last_name,
            p.amount
        FROM actors_s_pg AS spg
            INNER JOIN inventory AS i
            ON i.film_id = spg.film_id
            INNER JOIN rental AS r
            ON i.inventory_id = r.inventory_id
            INNER JOIN payment AS p
            ON r.rental_id = p.rental_id
    ) 
-- ending of WITH
SELECT 
    spg_rev.first_name,
    spg_rev.last_name,
    SUM(spg_rev.amount) AS tot_revenue
FROM actors_s_pg_revenue AS spg_rev
GROUP BY spg_rev.first_name, spg_rev.last_name
ORDER BY 3 DESC;






SELECT
    (
        SELECT c.first_name
        FROM customer AS c
        WHERE c.customer_id = p.customer_id
    ) AS first_name,
    (
        SELECT c.last_name
        FROM customer AS c
        WHERE c.customer_id = p.customer_id
    ) AS last_name,
    (
        SELECT ct.city
        FROM customer AS c
            INNER JOIN address AS a
            ON c.address_id = a.address_id
            INNER JOIN city AS ct
            ON a.city_id = ct.city_id
        WHERE c.customer_id = p.customer_id
    ) AS city,
    SUM(p.amount) AS tot_payments,
    COUNT(*) AS tot_rentals
FROM payment AS p
GROUP BY p.customer_id;



SELECT
    a.actor_id,
    a.first_name,
    a.last_name
FROM actor AS a
ORDER BY
    (
        SELECT COUNT(*)
        FROM film_actor AS fa
        WHERE fa.actor_id = a.actor_id
    ) DESC;
