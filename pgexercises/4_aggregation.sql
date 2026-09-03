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

-- 14. produce a list of each member name, id,
-- and their first booking after 
-- September 1st 2012
SELECT
	m.surname,
	m.firstname,
	m.memid,
	MIN(b.starttime) AS starttime
FROM cd.members AS m
	INNER JOIN cd.bookings AS b
	ON m.memid = b.memid
WHERE b.starttime >= '2012-09-01'
GROUP BY m.surname, m.firstname, m.memid
ORDER BY m.memid;

-- 15. produce a list of member names,
-- with each row containing the 
-- total member count.
-- order by join date, and include guest members
/*
SELECT
	COUNT(*) OVER(),
	firstname,
	surname
FROM cd.members
ORDER BY joindate;
*/
SELECT
	(
	    SELECT COUNT(*) FROM cd.members
	) AS count,
	firstname,
	surname
FROM cd.members
ORDER BY joindate;

-- 16. produce a monotonically increasing
-- numbered list of members (including guests),
-- ordered by their date of joining
SELECT
	ROW_NUMBER() OVER(ORDER BY joindate),
	firstname,
	surname
FROM cd.members
ORDER BY joindate;

-- 17. output the facility id that has
-- the highest number of slots booked.
-- ensure that in the event of a tie,
-- all tieing results get output
SELECT
	facid,
	total
FROM
	(
	    SELECT
	  		facid,
	  		SUM(slots) AS total,
	  		RANK() OVER(ORDER BY SUM(slots) DESC) AS rank
	  	FROM cd.bookings
	  	GROUP BY facid
	) AS subq
WHERE rank = 1;

-- 18. produce a list of members (including guests),
-- along with the number of hours they've booked
-- in facilities, rounded to the nearest ten hours.
-- rank them by this rounded figure,
-- producing output of first name, surname,
-- rounded hours, rank. 
-- sort by rank, surname, and first name
SELECT
	m.firstname,
	m.surname,
	ROUND((SUM(b.slots) * 0.5), -1) AS hours,
	RANK() OVER(ORDER BY ROUND((SUM(b.slots) * 0.5), -1) DESC) AS rank
FROM cd.members AS m
	INNER JOIN cd.bookings AS b
	ON m.memid = b.memid
GROUP BY m.memid
ORDER BY rank, m.surname, m.firstname;

-- 19. produce a list of the top three revenue
-- generating facilities (including ties)
SELECT
	name,
	rank
FROM
	(
	    SELECT
	  		f.name AS name,
	  		RANK() OVER(ORDER BY 
							SUM(CASE
			  					WHEN b.memid = 0 THEN b.slots * f.guestcost
								ELSE b.slots * f.membercost
							END)
					   DESC) AS rank
		FROM cd.bookings AS b
			INNER JOIN cd.facilities AS f
			ON b.facid = f.facid
		GROUP BY f.name
	) AS subq
WHERE rank <= 3
ORDER BY rank;

-- 20. classify facilities into equally sized groups
-- of high, average, and low based on their revenue
/* 
WITH 
reven AS (
	SELECT
  		f.name AS name,
  		SUM(CASE
			WHEN memid = 0 THEN b.slots * f.guestcost
			ELSE b.slots * f.membercost
		END) AS rev
    FROM cd.bookings AS b
		INNER JOIN cd.facilities AS f
		ON b.facid = f.facid
	GROUP BY f.name
),
max_rev AS (
	SELECT MAX(rev) AS max FROM reven
),
min_rev AS (
	SELECT MIN(rev) AS min FROM reven
),
range_rev AS (
	SELECT (max - min) AS range FROM max_rev, min_rev
),
grp AS (
	SELECT 
		min + (range / 3.0) AS bot, 
		min + (range * 2.0 / 3.0) AS top
	FROM range_rev, min_rev
)
SELECT
	name,
	rev,
	CASE
		WHEN rev >= top THEN 'high'
		WHEN rev >= bot THEN 'average'
		ELSE 'low'
	END AS revenue,
	bot,
	top
FROM reven, grp
ORDER BY rev DESC;
*/
SELECT
	name,
	CASE
		WHEN class = 1 THEN 'high'
		WHEN class = 2 THEN 'average'
		ELSE 'low'
	END AS revenue
FROM 
	(
		SELECT
			f.name AS name,
			NTILE(3) OVER(ORDER BY 
							SUM(CASE
								WHEN b.memid = 0 THEN b.slots * f.guestcost
								ELSE b.slots * f.membercost
							END) DESC
						) AS class
		FROM cd.bookings AS b
			INNER JOIN cd.facilities AS f
			ON b.facid = f.facid
		GROUP BY f.name
	) AS subq
ORDER BY class, name;

-- 21. based on the 3 complete months of data
-- so far, calculate the amount of time
-- each facility will take to repay its cost
-- of ownership. 
-- remember to take into account ongoing monthly
-- maintenance. 
-- output facility name and payback time
-- in months, order by facility name
SELECT
	f.name AS name,
	f.initialoutlay / ((SUM(CASE
							WHEN b.memid = 0 THEN b.slots * f.guestcost
							ELSE b.slots * f.membercost
						END) / 3) - f.monthlymaintenance) AS months
FROM cd.bookings AS b
	INNER JOIN cd.facilities AS f
	ON b.facid = f.facid
GROUP BY f.facid
ORDER BY name;

-- 22. for each day in August 2012, calculate
-- a rolling average of total revenue over
-- the previous 15 days.
-- output should contain date and revenue
-- columns, sorted by the date
SELECT
	dategen.date,
	(
		SELECT SUM(CASE
					WHEN b.memid = 0 THEN b.slots * f.guestcost
					ELSE b.slots * f.membercost
				END) AS rev
		FROM cd.bookings AS b
			INNER JOIN cd.facilities AS f
			ON b.facid = f.facid
		WHERE b.starttime > dategen.date - INTERVAL '14 day'
			AND b.starttime < dategen.date + INTERVAL '1 day'
	) / 15 AS revenue
FROM
	(
		SELECT GENERATE_SERIES(TIMESTAMP '2012-08-01', '2012-08-31', '1 day')::DATE AS date
	) AS dategen
ORDER BY dategen.date;
