SELECT last_name
FROM customer
--WHERE last_name LIKE '_A%W%';
WHERE last_name ~ '^.A.*W';
