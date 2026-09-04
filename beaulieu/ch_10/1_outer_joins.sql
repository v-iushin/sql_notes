SELECT
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS num_copies
FROM film AS f
    LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.film_id;



SELECT
    f.film_id,
    f.title,
    i.inventory_id
FROM film AS f
    LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE f.film_id BETWEEN 13 AND 15;



SELECT
    f.film_id,
    f.title,
    i.inventory_id,
    r.rental_date
FROM film AS f
    LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
    LEFT JOIN rental AS r
    ON i.inventory_id = r.inventory_id
WHERE f.film_id BETWEEN 13 AND 15;
