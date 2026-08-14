SELECT
    a1.city_id,
    a1.address AS addr_1,
    a2.address AS addr_2
FROM address AS a1
    CROSS JOIN address AS a2
WHERE a1.city_id = a2.city_id
    AND a1.address_id != a2.address_id;
