SELECT c.email
FROM customer AS c
    INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
WHERE r.rental_date::DATE = '2022-08-03';
