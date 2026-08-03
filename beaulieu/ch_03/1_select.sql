SELECT 
    language_id,
    'COMMON' AS language_usage,
    language_id * 3.1415927 AS lang_pi_value,
    upper(name) AS language_name
FROM language;

SELECT DISTINCT actor_id 
FROM film_actor
ORDER BY actor_id;
-- generating DISTINCT set requires sorting or hashing
-- which is time consuming for large sets

SELECT actor_id
FROM actor;