SELECT
    SUM(CASE
            WHEN rating = 'PG' THEN 1
            ELSE 0
        END
    ) AS pg,
    SUM(CASE
            WHEN rating = 'G' THEN 1
            ELSE 0
        END
    ) AS g,
    SUM(CASE
            WHEN rating = 'NC-17' THEN 1
            ELSE 0
        END
    ) AS nc_17,
    SUM(CASE
            WHEN rating = 'PG-13' THEN 1
            ELSE 0
        END
    ) AS pg_13,
    SUM(CASE
            WHEN rating = 'R' THEN 1
            ELSE 0
        END
    ) AS r
FROM film;
