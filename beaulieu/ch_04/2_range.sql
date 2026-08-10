SELECT customer_id, rental_date
FROM rental
WHERE rental_date <= '2022-05-27'
    AND rental_date >= '2022-05-25';

SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN
    '2022-05-25' AND '2022-05-27';

SELECT 
    customer_id, 
    payment_date::TIMESTAMP(0), 
    amount
FROM payment
WHERE amount BETWEEN 10.00 AND 11.99;

SELECT last_name, first_name
FROM customer
--WHERE last_name BETWEEN 'FA' AND 'FRZZ';
WHERE LEFT(last_name, 2) BETWEEN 'FA' AND 'FR';
