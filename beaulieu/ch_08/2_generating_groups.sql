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
