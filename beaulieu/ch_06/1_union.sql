SELECT 1 num, 'abc' str
UNION
SELECT 9 num, 'xyz' str;



SELECT 
    'CUST' AS typ,
    c.first_name,
    c.last_name
FROM customer AS c
    UNION ALL
SELECT
    'ACTR' as typ,
    a.first_name,
    a.last_name
FROM actor AS a;



SELECT
    c.first_name,
    c.last_name
FROM customer AS c
WHERE c.first_name LIKE 'J%' AND
    c.last_name LIKE 'D%'
    --UNION ALL
    UNION
SELECT 
    a.first_name,
    a.last_name
FROM actor AS a
WHERE a.first_name LIKE 'J%' AND
    a.last_name LIKE 'D%';
