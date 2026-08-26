SELECT actor_id, COUNT(*)
FROM film_actor
GROUP BY actor_id;



SELECT 
    fa.actor_id, 
    f.rating, 
    COUNT(*)
FROM film_actor AS fa
    INNER JOIN film AS f
    ON fa.film_id = f.film_id
GROUP BY fa.actor_id, f.rating
ORDER BY 1, 2;



SELECT 
    EXTRACT(YEAR FROM rental_date) AS year,
    COUNT(*) AS how_many
FROM rental
GROUP BY EXTRACT(YEAR FROM rental_date);

SELECT 
    TO_CHAR(rental_date, 'YYYY-MM') AS "year-month",
    COUNT(*) AS how_many
FROM rental
GROUP BY "year-month"
ORDER BY "year-month";



SELECT 
    fa.actor_id, 
    f.rating, 
    COUNT(*)
FROM film_actor AS fa
    INNER JOIN film AS f
    ON fa.film_id = f.film_id
GROUP BY ROLLUP(fa.actor_id, f.rating)
ORDER BY 1, 2;

SELECT 
    fa.actor_id, 
    f.rating, 
    COUNT(*)
FROM film_actor AS fa
    INNER JOIN film AS f
    ON fa.film_id = f.film_id
GROUP BY GROUPING SETS ((fa.actor_id, f.rating), ())
ORDER BY 1, 2;



SELECT 
    fa.actor_id, 
    f.rating, 
    COUNT(*)
FROM film_actor AS fa
    INNER JOIN film AS f
    ON fa.film_id = f.film_id
WHERE f.rating IN ('G', 'PG')
GROUP BY fa.actor_id, f.rating
HAVING COUNT(*) > 9;
