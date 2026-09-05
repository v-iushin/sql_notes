SELECT
    ones.x + tens.x + 1
FROM
    (
        SELECT 0 AS x UNION ALL
        SELECT 1 AS x UNION ALL
        SELECT 2 AS x UNION ALL
        SELECT 3 AS x UNION ALL
        SELECT 4 AS x UNION ALL
        SELECT 5 AS x UNION ALL
        SELECT 6 AS x UNION ALL
        SELECT 7 AS x UNION ALL
        SELECT 8 AS x UNION ALL
        SELECT 9 AS x
    ) AS ones
    CROSS JOIN
    (
        SELECT 0 AS x UNION ALL
        SELECT 10 AS x UNION ALL
        SELECT 20 AS x UNION ALL
        SELECT 30 AS x UNION ALL
        SELECT 40 AS x UNION ALL
        SELECT 50 AS x UNION ALL
        SELECT 60 AS x UNION ALL
        SELECT 70 AS x UNION ALL
        SELECT 80 AS x UNION ALL
        SELECT 90 AS x
    ) AS tens
ORDER BY 1;
