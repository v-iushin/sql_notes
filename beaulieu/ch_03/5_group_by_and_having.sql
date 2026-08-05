SELECT c.first_name, c.last_name, COUNT(*)
FROM customer AS c
    INNER JOIN rental AS r
    on c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(*) >= 40;