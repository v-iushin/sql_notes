SELECT f.title
FROM film AS f
WHERE f.film_id IN
    (
        SELECT fc.film_id
        FROM film_category AS fc
            INNER JOIN category AS c
            ON fc.category_id = c.category_id
        WHERE c.name = 'Action'
    );
