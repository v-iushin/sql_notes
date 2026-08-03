-- derived table

SELECT concat(cust.last_name, ', ', cust.first_name) full_name
FROM
    (
        SELECT first_name, last_name, email
        FROM customer
        WHERE first_name = 'JESSIE'
    ) cust;
-- concat = concatenate

SELECT concat(last_name, ', ', first_name) full_name
FROM customer
WHERE first_name = 'JESSIE';



-- temporary tables

CREATE TEMPORARY TABLE actors_j
(
    actor_id SMALLINT,
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

INSERT INTO actors_j
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

SELECT * FROM actors_j;



-- view (virtual table)

CREATE VIEW cust_vw AS
SELECT customer_id, first_name, last_name, active
FROM customer;

SELECT first_name, last_name
FROM cust_vw
WHERE active = 0;

DROP VIEW cust_vw;
