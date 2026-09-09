SELECT
    customer_id,
    COUNT(*) AS num_rentals,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_number_rnk,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_rnk,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS dense_rank_rnk
FROM rental
GROUP BY customer_id
ORDER BY 2 DESC;



SELECT
    customer_id,
    rental_month,
    num_rentals,
    rank_rnk
FROM
    (
        SELECT
            customer_id,
            TO_CHAR(rental_date, 'FMMonth') AS rental_month,
            COUNT(*) AS num_rentals,
            RANK() OVER 
                (
                    PARTITION BY TO_CHAR(rental_date, 'FMMonth')
                    ORDER BY COUNT(*) DESC
                ) AS rank_rnk
        FROM rental
        GROUP BY customer_id, TO_CHAR(rental_date, 'FMMonth')
    ) AS cust_rankings
WHERE rank_rnk <= 5
ORDER BY 
    rental_month, 
    num_rentals DESC,
    rank_rnk;
