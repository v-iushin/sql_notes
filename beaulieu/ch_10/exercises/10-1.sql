SELECT
    c.name,
    SUM(p.amount)
FROM customer AS c
    LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.name;
