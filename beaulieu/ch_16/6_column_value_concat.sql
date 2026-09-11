SELECT
    f.title,
    STRING_AGG(
        a.last_name::TEXT, ', ' ORDER BY a.last_name
    ) AS actors
FROM actor AS a
    INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
    ON fa.film_id = f.film_id
GROUP BY f.title
HAVING COUNT(*) = 3;
