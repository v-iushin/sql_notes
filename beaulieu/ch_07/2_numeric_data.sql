SELECT ROUND((37.0 * 59) / (78 - (8 * 6)), 2);

SELECT MOD(22.75, 5);
SELECT (22.75 % 5);

SELECT POWER(2,3);
SELECT (2 ^ 3);

SELECT CEIL(72.1), FLOOR(72.1);

SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);
SELECT TRUNC(72.0909, 1), TRUNC(72.0909, 2), TRUNC(72.0909, 3);

SELECT 
    number, 
    SIGN(number) AS sign, 
    ABS(number) AS abs
FROM 
    (
        VALUES 
            (-30), 
            (0), 
            (30)
    ) AS t(number);
