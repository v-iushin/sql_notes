SELECT 
    a.first_name AS fname, 
    a.last_name AS lname
FROM actor AS a
WHERE a.first_name LIKE 'J%' AND 
    a.last_name LIKE 'D%'
    UNION ALL
SELECT 
    c.first_name AS fname, 
    c.last_name AS lname
FROM customer AS c
WHERE c.first_name LIKE 'J%' AND 
    c.last_name LIKE 'D%'
ORDER BY lname, fname;



SELECT 
    a.first_name, 
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'J%' AND 
    a.last_name LIKE 'D%'
    UNION ALL
SELECT 
    a.first_name, 
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'M%' AND 
    a.last_name LIKE 'T%'
    UNION
SELECT 
    c.first_name, 
    c.last_name
FROM customer AS c
WHERE c.first_name LIKE 'J%' AND
    c.last_name LIKE 'D%';



SELECT 
    a.first_name, 
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'J%' AND 
    a.last_name LIKE 'D%'
    UNION
SELECT 
    a.first_name, 
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'M%' AND 
    a.last_name LIKE 'T%'
    UNION ALL
SELECT 
    c.first_name, 
    c.last_name
FROM customer AS c
WHERE c.first_name LIKE 'J%' AND
    c.last_name LIKE 'D%';



SELECT 
    a.first_name, 
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'J%' AND 
    a.last_name LIKE 'D%'
    UNION
(
SELECT 
    a.first_name, 
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'M%' AND 
    a.last_name LIKE 'T%'
    UNION ALL
SELECT 
    c.first_name, 
    c.last_name
FROM customer AS c
WHERE c.first_name LIKE 'J%' AND
    c.last_name LIKE 'D%'
);
