SELECT f.title, f_prnt.title AS prequel
FROM film AS f
    INNER JOIN film AS f_prnt
    ON f_prnt.film_id = f.prequel_film_id
WHERE f.prequel_film_id IS NOT NULL;

-- column prequel_film_id doesnt exist
-- so it wont run
