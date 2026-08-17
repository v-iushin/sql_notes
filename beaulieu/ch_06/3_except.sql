SELECT
    a.first_name,
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'J%' AND
    a.last_name LIKE 'D%'
    EXCEPT
SELECT 
    c.first_name,
    c.last_name
FROM customer AS c
WHERE c.first_name LIKE 'J%' AND
    c.last_name LIKE 'D%';
