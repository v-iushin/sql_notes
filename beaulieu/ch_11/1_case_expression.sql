SELECT
    first_name,
    last_name,
    CASE
        WHEN active = 1 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS activity_type
FROM customer;



SELECT
    c.first_name,
    c.last_name,
    CASE
        WHEN active = 0 THEN 0
        ELSE
            (
                SELECT COUNT(*)
                FROM rental AS r
                WHERE r.customer_id = c.customer_id
            )
    END AS num_rentals
FROM customer AS c;
