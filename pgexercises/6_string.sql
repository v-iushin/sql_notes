-- 1. output the names of all members,
-- formatted as 'Surname, Firstname'
SELECT surname || ', ' || firstname AS name
FROM cd.members;

-- 2. find all facilities whose name 
-- begins with 'Tennis'
SELECT *
FROM cd.facilities
WHERE name LIKE 'Tennis%';

-- 3. perform a case-insensitive search to find
-- all facilities whose name begins with 'tennis'
/*
SELECT *
FROM cd.facilities
WHERE UPPER(name) LIKE 'TENNIS%';
*/
SELECT *
FROM cd.facilities
WHERE name ILIKE 'tennis%';

-- 4. you've noticed that the club's member table
-- has telephone numbers with very
-- inconsistent formatting. 
-- you'd like to find all the telephone numbers
-- that contain parentheses, returning 
-- the member ID and telephone number
-- sorted by member ID
SELECT
	memid,
	telephone
FROM cd.members
--WHERE telephone LIKE '(%)%'
WHERE telephone ~ '[()]'
ORDER BY memid;

-- 5. the zip codes in our example dataset
-- have had leading zeroes removed from them
-- by virtue of being stored as a numeric type. 
-- retrieve all zip codes from the members table,
-- padding any zip codes less than 5 characters
-- long with leading zeroes. 
-- order by the new zip code
/*
SELECT LPAD(zipcode::TEXT, 5, '0') AS zip
FROM cd.members 
ORDER BY zip
*/
SELECT TO_CHAR(zipcode, 'FM00000') AS zip
FROM cd.members
ORDER BY zip;

-- 6. produce a count of how many members 
-- you have whose surname starts with
-- each letter of the alphabet
SELECT
	SUBSTRING(surname, 1, 1) AS letter,
	COUNT(*)
FROM cd.members
GROUP BY letter
ORDER BY letter;

-- 7. the telephone numbers in the database
-- are very inconsistently formatted. 
-- you'd like to print a list of member ids
-- and numbers that have had '-', '(', ')',
-- and ' ' characters removed
/*
SELECT
    memid,
    TRANSLATE(telephone, '-() ', '') AS telephone
FROM cd.members
ORDER BY memid;
*/
SELECT
    memid,
    REGEXP_REPLACE(telephone, '[^0-9]', '', 'g') AS telephone
FROM cd.members
ORDER BY memid;
