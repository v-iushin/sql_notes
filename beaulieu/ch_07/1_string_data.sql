DROP TABLE IF EXISTS string_tbl;

CREATE TABLE IF NOT EXISTS string_tbl
(
    char_fld CHAR(30),
    vchar_fld VARCHAR(30),
    text_fld TEXT
);



INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES
    (
        'This is char data',
        'This is varchar data',
        'This is text data'
    );

SELECT * FROM string_tbl;

/*
UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';
*/

UPDATE string_tbl
SET text_fld = 'Apostrophe: '' ';

SELECT * FROM string_tbl;

SELECT QUOTE_LITERAL(text_fld)
FROM string_tbl;



SELECT 'abcdefg', 
CHR(97) || 
CHR(98) || 
CHR(99) || 
CHR(100) || 
CHR(101) || 
CHR(102) || 
CHR(103);

SELECT
CHR(246) ||
CHR(352) ||
CHR(8249) ||
CHR(338) ||
CHR(381) ||
CHR(8216);

SELECT
ASCII('ö');



DELETE FROM string_tbl;

SELECT * FROM string_tbl;



INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES
    (
        'This string is 28 characters',
        'This string is 28 characters',
        'This string is 28 characters'
    );

SELECT 
    LENGTH(char_fld) AS char_length,
    LENGTH(vchar_fld) AS vchar_length,
    LENGTH(text_fld) AS text_length
FROM string_tbl;

SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;



SELECT
    name,
    name LIKE '%y' AS ends_in_y
FROM category;



DELETE FROM string_tbl;



INSERT INTO string_tbl (text_fld)
VALUES ('This string was 29 characters');

UPDATE string_tbl
SET text_fld = text_fld || 'but now it is longer';

SELECT text_fld FROM string_tbl;



SELECT 
    first_name || 
    ' ' ||
    last_name ||
    ' has been a customer since ' ||
    create_date::DATE
    AS cust_narrative
FROM customer;



SELECT OVERLAY('goodbye world' PLACING 'cruel ' FROM 9 FOR 0)
AS string;

SELECT OVERLAY('goodbye world' PLACING 'hello' FROM 1 FOR 7)
AS string;

SELECT REPLACE('goodbye world', 'goodbye', 'hello')
AS string;

SELECT REPLACE('banana', 'a', 'X')
AS string;



SELECT SUBSTRING('goodbye cruel world' FROM 9 FOR 5)
AS string;
