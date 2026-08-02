SELECT 
    language_id,
    'COMMON' AS language_usage,
    language_id * 3.1415927 AS lang_pi_value,
    upper(name) AS language_name
FROM language;