SELECT 
    c.first_name, 
    c.last_name,
  --CAST(rental.rental_date AS TIME) AS rental_time
    r.rental_date::TIME AS rental_time
FROM customer AS c
    INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
WHERE
  --CAST(rental.rental_date AS DATE) = '2022-08-03';
    r.rental_date::DATE = '2022-08-03';
