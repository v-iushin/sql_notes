-- 1. add a new facility - a spa.
-- add it into the facilities table. 
-- use the following values:
-- facid: 9, name: 'Spa', 
-- membercost: 20, guestcost: 30, 
-- initialoutlay: 100000, monthlymaintenance: 800
INSERT INTO cd.facilities
(
	facid, name,
	membercost, guestcost,
  	initialoutlay, monthlymaintenance
)
VALUES
(
	9, 'Spa',
	20, 30,
	100000, 800
);

-- 2. add multiple facilities in one command. 
-- use the following values:
-- facid: 9, name: 'Spa', 
-- membercost: 20, guestcost: 30, 
-- initialoutlay: 100000, monthlymaintenance: 800;
-- facid: 10, name: 'Squash Court 2', 
-- membercost: 3.5, guestcost: 17.5, 
-- initialoutlay: 5000, monthlymaintenance: 80
INSERT INTO cd.facilities
(
	facid, name,
	membercost, guestcost,
  	initialoutlay, monthlymaintenance
)
VALUES
(
	9, 'Spa',
	20, 30,
	100000, 800
),
(
    10, 'Squash Court 2',
    3.5, 17.5,
    5000, 80
);

-- 3. add the spa to the facilities table again. 
-- this time automatically generate the value 
-- for the next facid. 
-- use the following values for everything else:
-- name: 'Spa', 
-- membercost: 20, guestcost: 30, 
-- initialoutlay: 100000, monthlymaintenance: 800
INSERT INTO cd.facilities
(
	facid, 
    name,
	membercost, guestcost,
  	initialoutlay, monthlymaintenance
)
VALUES
(
	(SELECT MAX(facid) FROM cd.facilities) + 1, 
    'Spa',
	20, 30,
	100000, 800
);

-- 4. for the second tennis court the initial outlay 
-- was 10000 rather than 8000. 
-- alter the data to fix the error
UPDATE cd.facilities
SET
    initialoutlay = 10000
WHERE name = 'Tennis Court 2';

-- 5. to increase the price of the tennis courts 
-- for both members and guests. 
-- update the costs to be 6 for members, 
-- and 30 for guests.
UPDATE cd.facilities
SET
    membercost = 6,
    guestcost = 30
WHERE name IN ('Tennis Court 1','Tennis Court 2');

-- 6. alter the price of the second tennis court 
-- so that it costs 10% more than the first one. 
-- try to do this without using constant values 
-- for the prices, so that we can reuse the statement 
-- if we want to
UPDATE cd.facilities
SET (membercost, guestcost) =
(
	SELECT membercost * 1.1, guestcost * 1.1
	FROM cd.facilities
	WHERE facid = 0
)
WHERE facid = 1;

-- 7. delete all bookings from the cd.bookings table
DELETE FROM cd.bookings;

-- 8. remove member 37, who has never made a booking, 
-- from our database
DELETE FROM cd.members
WHERE memid = 37;

-- 9. delete all members who have never made a booking
DELETE FROM cd.members 
WHERE memid NOT IN 
(
    SELECT memid 
    FROM cd.bookings
); 
