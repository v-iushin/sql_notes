SELECT last_name, first_name
FROM customer
WHERE LEFT(last_name, 1) = 'Q';

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';

SELECT last_name, first_name
FROM customer
--WHERE last_name LIKE 'Q%' OR 
--    last_name LIKE 'Y%';
WHERE last_name ~ '^[QY]';
