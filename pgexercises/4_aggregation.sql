-- 1. how many facilities exist
SELECT COUNT(*)
FROM cd.facilities;

-- 2. produce a count of the number of facilities 
-- that have a cost to guests of 10 or more
SELECT COUNT(*)
FROM cd.facilities
WHERE guestcost >= 10;

-- 3. produce a count of the number of 
-- recommendations each member has made. 
-- order by member ID.
SELECT recommendedby, COUNT(*)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;

-- 4. produce a list of the total number of slots
-- booked per facility
SELECT
	facid, 
	SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
ORDER BY facid;

-- 5. produce a list of the total number of slots
-- booked per facility in the month of september 2012
SELECT
	facid, 
	SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-09-01' 
	AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY SUM(slots);

-- 6. produce a list of the total number of slot
-- booked per facility per month in the year of 2012
SELECT
	facid,
	EXTRACT(MONTH FROM starttime) AS month,
	SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY facid, month
ORDER BY facid, month;

-- 7. total number of members (including guests)
-- who have made at least one booking
SELECT COUNT(DISTINCT memid)
FROM cd.bookings;

-- 8. produce a list of facilities with more 
-- than 1000 slots booked
SELECT
	facid,
	SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;

-- 9. produce a list of facilities 
-- along with their total revenue
SELECT
	f.name,
	SUM(b.slots * 
		CASE
			WHEN b.memid = 0 THEN f.guestcost
			ELSE f.membercost
	    END
    ) AS revenue
FROM cd.facilities AS f
	INNER JOIN cd.bookings AS b
	ON f.facid = b.facid
GROUP BY f.name
ORDER BY revenue;

-- 10. produce a list of facilities 
-- with a total revenue less than 1000
/*
SELECT
	f.name,
	SUM(b.slots * 
		CASE
			WHEN b.memid = 0 THEN f.guestcost
			ELSE f.membercost
	    END
	) AS revenue
FROM cd.facilities AS f
	INNER JOIN cd.bookings AS b
	ON f.facid = b.facid
GROUP BY f.name
HAVING 
	SUM(b.slots * 
		CASE
			WHEN b.memid = 0 THEN f.guestcost
			ELSE f.membercost
	    END
	) < 1000
ORDER BY revenue;
*/
SELECT *
FROM
    (
        SELECT
	        f.name,
	        SUM(b.slots * 
		        CASE
			        WHEN b.memid = 0 THEN f.guestcost
			        ELSE f.membercost
	            END
            ) AS revenue
        FROM cd.facilities AS f
	        INNER JOIN cd.bookings AS b
	        ON f.facid = b.facid
        GROUP BY f.name
    ) AS subq
WHERE subq.revenue < 1000
ORDER BY subq.revenue;

-- 11. output the facility id that has 
-- the highest number of slots booked
WITH subq1 AS
    (
        SELECT 
			facid,
			SUM(slots) AS total
		FROM cd.bookings
		GROUP BY facid
    ),
     subq2 AS
    (
        SELECT MAX(subq1.total) AS max
        FROM subq1
    )
SELECT 
	subq1.facid,
	subq1.total AS "Total Slots"
FROM subq1
    CROSS JOIN subq2
WHERE subq1.total = subq2.max;

-- 12. produce a list of the total number
-- of slots booked per facility per month
-- in the year of 2012. 
-- in this version, include output rows
-- containing totals for all months per facility,
-- and a total for all months for all facilities.
-- the output table should consist of facility id,
-- month and slots, sorted by the id and month.
-- when calculating the aggregated values
-- for all months and all facids, 
-- return null values in the month
-- and facid columns 
SELECT
	facid,
	EXTRACT(MONTH FROM starttime) AS month,
	SUM(slots) AS slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY ROLLUP(facid, month)
ORDER BY facid, month;

-- 13. produce a list of the total number of hours
-- booked per facility, remembering that
-- a slot lasts half an hour. 
-- the output table should consist of the
-- facility id, name, and hours booked,
-- sorted by facility id
SELECT
	f.facid,
	f.name,
	TRUNC((SUM(b.slots) * 0.500), 2) AS "Total Hours"
FROM cd.bookings AS b
	INNER JOIN cd.facilities AS f
	ON b.facid = f.facid
GROUP BY f.facid, f.name
ORDER BY f.facid;

-- 14. 

-- 15. 

-- 16. 

-- 17. 

-- 18. 

-- 19. 

-- 20. 

-- 21. 

-- 22. 
