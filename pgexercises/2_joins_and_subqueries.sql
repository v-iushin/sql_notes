-- 1. produce a list of the start times 
-- for bookings by members named 'David Farrell'
SELECT b.starttime
FROM cd.bookings AS b
    INNER JOIN cd.members AS m
    ON b.memid = m.memid
WHERE m.firstname = 'David' AND
    m.surname = 'Farrell';

