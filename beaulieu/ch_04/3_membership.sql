SELECT title, rating
FROM film
WHERE rating = 'G' OR rating = 'PG';

SELECT title, rating
FROM film
WHERE rating IN ('G','PG');

SELECT title, rating
FROM film
WHERE rating IN
    (
        SELECT rating
        FROM film
        WHERE title LIKE '%PET%'
    );

SELECT title, rating
FROM film
WHERE rating NOT IN ('PG-13', 'R', 'NC-17');
