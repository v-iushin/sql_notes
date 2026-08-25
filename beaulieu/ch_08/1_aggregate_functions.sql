SELECT customer_id, COUNT(*) 
FROM rental
GROUP BY customer_id
HAVING COUNT(*) >= 40;



SELECT
    customer_id,
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM payment
GROUP BY customer_id;



SELECT 
    COUNT(customer_id) num_rows,
    COUNT(DISTINCT customer_id) num_customers
FROM payment;



SELECT MAX(return_date - rental_date)
FROM rental;



CREATE TABLE IF NOT EXISTS number_tbl
    (val SMALLINT);

/*
INSERT INTO number_tbl
    VALUES (1), (3), (5), (NULL);
*/

SELECT 
    COUNT(*) num_rows,
    COUNT(val) num_vals,
    SUM(val) total,
    MAX(val) max_val,
    AVG(val) avg_val
FROM number_tbl;
