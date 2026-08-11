SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NULL;

SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NOT NULL;

SELECT
    rental_id,
    customer_id,
    return_date
FROM rental
WHERE return_date NOT BETWEEN 
    '2022-05-01' AND '2022-09-01';

SELECT
    rental_id,
    customer_id,
    return_date
FROM rental
WHERE return_date IS NULL
    OR return_date NOT BETWEEN 
    '2022-05-01' AND '2022-09-01';
