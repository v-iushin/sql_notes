SELECT
    c.first_name,
    c.last_name,
    a.address
FROM customer AS c
    INNER JOIN address AS a
    --ON c.address_id = a.address_id;
    USING (address_id);

SELECT
    c.first_name,
    c.last_name,
    ct.city
FROM customer AS c
    INNER JOIN address AS a
    ON c.address_id = a.address_id
    INNER JOIN city AS ct
    ON a.city_id = ct.city_id;



SELECT
    c.first_name,
    c.last_name,
    addr.address,
    addr.city
FROM customer AS c
    INNER JOIN
    (
        SELECT 
            a.address_id,
            a.address,
            ct.city
        FROM address AS a
            INNER JOIN city AS ct
            ON a.city_id = ct.city_id
        WHERE a.district = 'California'
    ) AS addr
    ON c.address_id = addr.address_id;



SELECT f.title
FROM film AS f
    INNER JOIN film_actor AS fa
    ON f.film_id = fa.film_id
    INNER JOIN actor AS a
    ON fa.actor_id = a.actor_id
WHERE
    (
        (a.first_name = 'CATE' AND 
            a.last_name = 'MCQUEEN')
        OR
        (a.first_name = 'CUBA' AND
            a.last_name = 'BIRCH')
    );

SELECT f.title
FROM film AS f
    INNER JOIN film_actor AS fa1
    ON f.film_id = fa1.film_id
    INNER JOIN actor AS a1
    ON fa1.actor_id = a1.actor_id

    INNER JOIN film_actor AS fa2
    ON f.film_id = fa2.film_id
    INNER JOIN actor AS a2
    ON fa2.actor_id = a2.actor_id
WHERE
    (
        (a1.first_name = 'CATE' AND 
            a1.last_name = 'MCQUEEN')
        AND
        (a2.first_name = 'CUBA' AND
            a2.last_name = 'BIRCH')
    );
