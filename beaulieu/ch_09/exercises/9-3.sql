SELECT
    actr.actor_id,
    grps.level
FROM
    (
        SELECT
            actor_id,
            COUNT(*) AS num_roles
        FROM film_actor
        GROUP BY actor_id
    ) AS actr
    INNER JOIN
    (
        SELECT 
            'Hollywood Star' AS level,
            30 AS min_roles,
            99999 AS max_roles
            UNION ALL
        SELECT
            'Prolific Actor' AS level,
            20 AS min_roles,
            29 AS max_roles
            UNION ALL
        SELECT
            'Newcomer' AS level,
            1 AS min_roles,
            19 AS max_roles
    ) AS grps
    ON actr.num_roles
        BETWEEN grps.min_roles AND grps.max_roles
ORDER BY actr.actor_id;
