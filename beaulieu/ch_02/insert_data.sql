INSERT INTO person (person_id, fname, lname, eye_color, birth_date)
    VALUES (DEFAULT, 'William', 'Turner', 'BR', '1972-05-27');

SELECT person_id, fname, lname, birth_date
    FROM person;



INSERT INTO favorite_food (person_id, food)
    VALUES 
        (1, 'pizza'),
        (1, 'cookies'),
        (1, 'nachos');

SELECT * FROM favorite_food;



INSERT INTO person
    (
        person_id, fname, lname, eye_color, birth_date, 
        street, city, state, country, postal_code
    )
    VALUES
    (
        DEFAULT, 'Susan', 'Smith', 'BL', '1975-11-02',
        '23 Maple St.', 'Arlington', 'VA', 'USA', '20220'
    );

SELECT * FROM person;
