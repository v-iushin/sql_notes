SELECT
    c.first_name,
    c.last_name,
    a.address
FROM customer AS c
    CROSS JOIN address AS a;
