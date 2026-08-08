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
