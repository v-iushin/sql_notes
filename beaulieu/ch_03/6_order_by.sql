SELECT 
    c.first_name, 
    c.last_name,
    r.rental_date::TIME AS rental_time
FROM customer AS c
    INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
WHERE r.rental_date::DATE = '2022-08-03'
--ORDER BY r.rental_date::TIME DESC;
ORDER BY 3 DESC;
