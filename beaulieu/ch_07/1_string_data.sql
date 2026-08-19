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
