UPDATE person
    SET
        street = '1225 Tremont St.',
        city = 'Boston',
        state = 'MA',
        country = 'USA',
        postal_code = '02138'
    WHERE person_id = 1;

SELECT * FROM person;

DELETE FROM person
    WHERE person_id = 2;

SELECT * FROM person;
