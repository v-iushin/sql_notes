SELECT
    customer_id,
    first_name,
    last_name
FROM customer
WHERE customer_id = (SELECT MAX(customer_id) FROM customer);



SELECT
    city_id,
    city
FROM city
WHERE country_id !=
    (
        SELECT country_id
        FROM country
        WHERE country = 'India'
    );



SELECT
    city_id,
    city
FROM city
WHERE country_id NOT IN
    (
        SELECT country_id
        FROM country
        WHERE country IN ('Canada', 'Mexico')
    );



SELECT
    first_name,
    last_name
FROM customer
WHERE customer_id != ALL
    (
        SELECT customer_id
        FROM payment
        WHERE amount = 0
    );



SELECT
    customer_id,
    COUNT(*)
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > ALL
    (
        SELECT COUNT(*)
        FROM rental AS r
            INNER JOIN customer AS c
            ON r.customer_id = c.customer_id
            INNER JOIN address AS a
            ON c.address_id = a.address_id
            INNER JOIN city AS ct
            ON a.city_id = ct.city_id
            INNER JOIN country AS co
            ON ct.country_id = co.country_id
        WHERE co.country IN ('United States', 'Mexico', 'Canada')
        GROUP BY r.customer_id
    );



SELECT
    customer_id,
    SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > ANY
    (
        SELECT SUM(p.amount)
        FROM payment AS p
            INNER JOIN customer AS c
            ON p.customer_id = c.customer_id
            INNER JOIN address AS a
            ON c.address_id = a.address_id
            INNER JOIN city AS ct
            ON a.city_id = ct.city_id
            INNER JOIN country AS co
            ON ct.country_id = co.country_id
        WHERE co.country IN ('Bolivia', 'Paraguay', 'Chile')
        GROUP BY co.country
    );



SELECT
    fa.actor_id,
    fa.film_id
FROM film_actor AS fa
WHERE fa.actor_id IN
    (
        SELECT actor_id
        FROM actor
        WHERE last_name = 'MONROE'
    )
    AND fa.film_id IN
    (
        SELECT film_id
        FROM film
        WHERE rating = 'PG'
    );

SELECT
    actor_id,
    film_id
FROM film_actor
WHERE (actor_id, film_id) IN
    (
        SELECT 
            a.actor_id, 
            f.film_id
        FROM actor AS a
            CROSS JOIN film AS f
        WHERE a.last_name = 'MONROE'
            AND f.rating = 'PG'
    );
