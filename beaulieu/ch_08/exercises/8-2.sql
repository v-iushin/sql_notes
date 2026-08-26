SELECT
    customer_id,
    COUNT(*),
    SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY customer_id;
