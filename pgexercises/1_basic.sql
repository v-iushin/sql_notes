-- 1. retrieve all the information 
-- from the cd.facilities table
SELECT *
FROM cd.facilities;

-- 2. print out a list of the facilities 
-- and their cost to members
SELECT
	name,
	membercost
FROM cd.facilities;

-- 3. produce a list of facilities 
-- that charge a fee to members
SELECT *
FROM cd.facilities
WHERE membercost > 0;

-- 4. produce a list of facilities 
-- that charge a fee to members, and 
-- that fee is less than 1/50th 
-- of the monthly maintenance cost. 
-- return the facid, facility name, 
-- member cost, and monthly maintenance 
-- of the facilities
SELECT 
	facid, 
	name, 
	membercost, 
	monthlymaintenance
FROM cd.facilities
WHERE membercost > 0 AND membercost < monthlymaintenance / 50.0;

-- 5. produce a list of all facilities 
-- with the word 'Tennis' in their name
SELECT *
FROM cd.facilities
WHERE name LIKE '%Tennis%';

-- 6. retrieve the details of facilities
-- with ID 1 and 5,
-- do it without using the OR operator
SELECT *
FROM cd.facilities
WHERE facid IN (1, 5);

-- 7. produce a list of facilities, 
-- with each labelled as 'cheap' or 'expensive' 
-- depending on if their monthly maintenance cost
-- is more than $100. 
-- return the name and monthly maintenance 
-- of the facilities in question.
SELECT
	name,
	CASE WHEN (monthlymaintenance > 100) THEN 'expensive'
	ELSE 'cheap'
	END AS cost
FROM cd.facilities;

-- 8. produce a list of members who joined after 
-- the start of September 2012. 
-- return the memid, surname, firstname, and 
-- joindate of the members in question
SELECT
	memid,
	surname,
	firstname,
	joindate
FROM cd.members
WHERE joindate >= '2012-09-01';

-- 9. produce an ordered list of the first 10 surnames
-- in the members table. 
-- the list must not contain duplicates.
SELECT DISTINCT surname
FROM cd.members
ORDER BY surname
LIMIT 10;

-- 10. a combined list of all surnames and 
-- all facility names
SELECT surname
FROM cd.members
	UNION
SELECT name
FROM cd.facilities;

-- 11. get the signup date of your last member
SELECT MAX(joindate) AS latest
FROM cd.members;

-- 12. get the first and last name 
-- of the last member(s) who signed up
SELECT 
	firstname,
	surname,
	joindate
FROM cd.members
WHERE joindate = 
	(
		SELECT MAX(joindate)
		FROM cd.members
	);
