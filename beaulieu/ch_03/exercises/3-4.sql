SELECT
    c.email,
    r.return_date
FROM customer AS c
    INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
WHERE r.rental_date::DATE = '2022-08-03'
ORDER BY 2 DESC;