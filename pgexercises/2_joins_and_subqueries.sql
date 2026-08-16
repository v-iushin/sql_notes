-- 1. produce a list of the start times 
-- for bookings by members named 'David Farrell'
SELECT b.starttime
FROM cd.bookings AS b
    INNER JOIN cd.members AS m
    ON b.memid = m.memid
WHERE m.firstname = 'David' AND
    m.surname = 'Farrell';

-- 2. produce a list of the start times 
-- for bookings for tennis courts, 
-- for the date '2012-09-21'. 
-- return a list of start time and facility name 
-- pairings, ordered by the time
SELECT
	b.starttime AS start,
	f.name
FROM cd.bookings AS b
	INNER JOIN cd.facilities AS f
	ON b.facid = f.facid
WHERE f.name LIKE 'Tennis%' AND
	b.starttime >= '2012-09-21' AND
	b.starttime < '2012-09-22'
ORDER BY b.starttime;

-- 3. output a list of all members 
-- who have recommended another member. 
-- ensure that there are no duplicates 
-- in the list, and that results are 
-- ordered by (surname, firstname)
SELECT DISTINCT
	m2.firstname, 
	m2.surname
FROM cd.members AS m2
	INNER JOIN cd.members AS m1
	ON m1.recommendedby = m2.memid
--WHERE m1.recommendedby IS NOT NULL
ORDER BY m2.surname, m2.firstname;

-- 4. output a list of all members, 
-- including the individual who 
-- recommended them (if any). 
-- ensure that results are 
--ordered by (surname, firstname).
SELECT 
	m1.firstname AS memfname,
	m1.surname AS memsname,
	m2.firstname AS recfname, 
	m2.surname AS recsname
FROM cd.members AS m1
	LEFT JOIN cd.members AS m2
	ON m1.recommendedby = m2.memid
ORDER BY m1.surname, m1.firstname;

-- 5. produce a list of all members 
-- who have used a tennis court.
-- include in your output the name of the court, 
-- and the name of the member formatted 
-- as a single column. 
-- ensure no duplicate data, and order by 
-- the member name followed by the facility name
SELECT DISTINCT
	CONCAT(m.firstname, ' ', m.surname) AS member,
	f.name AS facility
FROM cd.members AS m
	INNER JOIN cd.bookings AS b
	ON m.memid = b.memid
	INNER JOIN cd.facilities AS f
	ON b.facid = f.facid
WHERE f.name LIKE 'Tennis%'
ORDER BY 1, 2;

-- 6. produce a list of bookings on the day of 
-- 2012-09-14 which will cost the member (or guest)
-- more than $30.
-- remember that guests have different costs to members 
-- (the listed costs are per half-hour 'slot'), 
-- and the guest user is always ID 0. 
-- include in your output the name of the facility,
-- the name of the member 
-- formatted as a single column, and the cost. 
-- order by descending cost, and 
-- do not use any subqueries.
SELECT
	m.firstname || ' ' || m.surname AS member,
	f.name AS facility,
	CASE WHEN m.memid = 0 
		THEN b.slots * f.guestcost
		ELSE b.slots * f.membercost
	END AS cost
FROM cd.members AS m
	INNER JOIN cd.bookings AS b
	ON m.memid = b.memid
	INNER JOIN cd.facilities AS f
	ON b.facid = f.facid
WHERE b.starttime >= '2012-09-14' AND
	b.starttime < '2012-09-15' AND
	(
        (m.memid = 0 AND b.slots * f.guestcost > 30)
        OR
        (m.memid != 0 AND b.slots * f.membercost > 30)
	)
ORDER BY cost DESC;

-- 7. output a list of all members, including 
-- the individual who recommended them (if any), 
-- without using any joins.
-- ensure that there are no duplicates in the list,
-- and that each firstname + surname pairing
-- is formatted as a column and ordered.
SELECT DISTINCT
	m.firstname || ' ' || m.surname AS member,
	(
        SELECT r.firstname || ' ' || r.surname
        FROM cd.members AS r
        WHERE m.recommendedby = r.memid
	) AS recommender
FROM cd.members AS m
ORDER BY member;

-- 8. exercise #6 contained some messy logic: 
-- we had to calculate the booking cost in both
-- the WHERE clause and the CASE statement. 
-- simplify this calculation using subqueries
SELECT 
    --book.member,
    --book.facility,
    --book.cost
    *
FROM
    (
        SELECT
	        m.firstname || ' ' || m.surname AS member,
	        f.name AS facility,
	        CASE WHEN m.memid = 0 
		        THEN b.slots * f.guestcost
		        ELSE b.slots * f.membercost
	        END AS cost
        FROM cd.members AS m
	        INNER JOIN cd.bookings AS b
        	ON m.memid = b.memid
        	INNER JOIN cd.facilities AS f
        	ON b.facid = f.facid
        WHERE b.starttime >= '2012-09-14' AND
        	b.starttime < '2012-09-15'
    ) AS book
WHERE book.cost > 30
ORDER BY book.cost DESC;
