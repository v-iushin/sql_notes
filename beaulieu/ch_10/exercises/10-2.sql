SELECT
    c.name,
    SUM(p.amount)
FROM payment AS p
    RIGHT JOIN customer AS c
    ON p.customer_id = c.customer_id
GROUP BY c.name;
