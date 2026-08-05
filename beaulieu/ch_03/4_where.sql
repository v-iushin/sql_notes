SELECT title, rating, rental_duration
FROM film
WHERE (rating = 'G' AND rental_duration >= 7)
    OR (rating = 'PG-13' AND rental_duration < 4);