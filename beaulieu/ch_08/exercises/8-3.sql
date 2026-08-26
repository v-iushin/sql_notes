SELECT
    customer_id,
    COUNT(*),
    SUM(amount)
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40
ORDER BY customer_id;
