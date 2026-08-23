SELECT
    n AS number,
    ABS(n) AS abs,
    SIGN(n) AS sign,
    ROUND(n, 2) AS rounded
FROM
    (SELECT -25.76823 AS n);
