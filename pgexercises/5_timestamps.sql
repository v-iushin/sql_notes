-- 1. produce a timestamp for 1 a.m. on the 
-- 31st of August 2012
SELECT
    '2012-08-31 01:00:00'::TIMESTAMP;

-- 2. find the result of subtracting 
-- the timestamp '2012-07-30 01:00:00' 
-- from the timestamp '2012-08-31 01:00:00'
SELECT
    '2012-08-31 01:00:00'::TIMESTAMP -
    '2012-07-30 01:00:00'::TIMESTAMP AS interval;

-- 3. produce a list of all the dates
-- in October 2012
SELECT
	GENERATE_SERIES(
	'2012-10-01'::TIMESTAMP,
	'2012-10-31'::TIMESTAMP,
	'1 day'::INTERVAL
	) AS ts;

-- 4. get the day of the month from the 
-- timestamp '2012-08-31' as an integer
SELECT
    EXTRACT(DAY FROM '2012-08-31'::TIMESTAMP) AS date_part;

-- 5. work out the number of seconds between
-- the timestamps '2012-08-31 01:00:00' 
-- and '2012-09-02 00:00:00'
SELECT
    EXTRACT(EPOCH FROM 
        ('2012-09-02 00:00:00'::TIMESTAMP - '2012-08-31 01:00:00'::TIMESTAMP)
    )::INTEGER AS date_part;

-- 6. for each month of the year in 2012, 
-- output the number of days in that month. 
-- format the output as an integer column 
-- containing the month of the year, 
-- and a second column 
-- containing an interval data type
SELECT
    EXTRACT(MONTH FROM cal.mon) AS month,
    /*
	EXTRACT(DAY FROM 
        (DATE_TRUNC('month', cal.mon) 
        + '1 month'::INTERVAL 
        - '1 day'::INTERVAL)
        )||' days' AS length,
    */
    (cal.mon + '1 month'::INTERVAL) - cal.mon AS length
FROM
(
    SELECT GENERATE_SERIES('2012-01-01'::TIMESTAMP, '2012-12-01'::TIMESTAMP, '1 month'::INTERVAL) AS mon
) AS cal;

-- 7. for any given timestamp, work out 
-- the number of days remaining in the month. 
-- the current day should count as a whole day, 
-- regardless of the time. 
-- use '2012-02-11 01:00:00' as an example timestamp
-- for the purposes of making the answer
SELECT
    /*
    ts.test,
    DATE_TRUNC('day', ts.test) AS plain_day,
    DATE_TRUNC('month', ts.test) AS plain_month,
    DATE_TRUNC('month', ts.test) + '1 month'::INTERVAL AS plain_next_month,
    */
    DATE_TRUNC('month', ts.test) 
        + '1 month'::INTERVAL 
        - DATE_TRUNC('day', ts.test) AS remaining
FROM
(
    SELECT '2012-02-11 01:00:00'::TIMESTAMP AS test
) AS ts;

-- 8. return a list of the start and end time 
-- of the last 10 bookings (ordered by the time
--  at which they end, followed by the time 
-- at which they start) in the system
SELECT
	b.starttime AS starttime,
	b.starttime + b.slots * '30 minute'::INTERVAL AS endtime
FROM cd.bookings AS b
ORDER BY endtime DESC, starttime DESC
LIMIT 10;

-- 9. return a count of bookings for each month,
-- sorted by month
SELECT
	DATE_TRUNC('month', b.starttime) AS month,
	COUNT(*)
FROM cd.bookings AS b
GROUP BY DATE_TRUNC('month', b.starttime)
ORDER BY DATE_TRUNC('month', b.starttime);

-- 10. work out the utilisation percentage
-- for each facility by month, sorted by name
-- and month, rounded to 1 decimal place. 
-- opening time is 8am, closing time is 8.30pm
SELECT 
    name, 
    month, 
	ROUND(
        (100 * slots) /
		(25 * 
            (
                (month + '1 month'::INTERVAL)::DATE
                - month::DATE
            )::NUMERIC
        )
    , 1) AS utilisation
FROM  
(
	SELECT 
        f.name AS name, 
        DATE_TRUNC('month', b.starttime) AS month, 
        SUM(b.slots) as slots
	FROM cd.bookings AS b
	    INNER JOIN cd.facilities AS f
		ON b.facid = f.facid
	GROUP BY f.facid, month
) AS inn
ORDER BY name, month;
