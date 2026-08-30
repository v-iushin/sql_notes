SELECT f.title
FROM film AS f
WHERE EXISTS
    (
        SELECT 1
        FROM film_category AS fc
            INNER JOIN category AS c
            ON fc.category_id = c.category_id
        WHERE c.name = 'Action'
            AND fc.film_id = f.film_id
    );
