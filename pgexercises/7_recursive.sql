-- 1. find the upward recommendation chain 
-- for member ID 27: 
-- that is, the member who recommended them, 
-- and the member who recommended that member, 
-- and so on. 
-- return member ID, first name, and surname. 
-- order by descending member id.
WITH RECURSIVE 
recommenders(recommender) AS 
    (
        SELECT recommendedby
        FROM cd.members
        WHERE memid = 27
            UNION ALL
        SELECT m.recommendedby
        FROM recommenders AS r
            INNER JOIN cd.members AS m
            ON m.memid = r.recommender
    )
SELECT 
    r.recommender,
    m.firstname, 
    m.surname
FROM recommenders AS r
	INNER JOIN cd.members AS m
	ON r.recommender = m.memid
ORDER BY memid DESC;


-- 2. find the downward recommendation chain
-- for member ID 1:
-- that is, the members they recommended,
-- the members those members recommended,
-- and so on. 
-- return member ID and name, 
-- and order by ascending member id
WITH RECURSIVE
recommendeds(memid) AS
    (
        SELECT memid
        FROM cd.members
        WHERE recommendedby = 1
            UNION ALL
        SELECT m.memid
        FROM cd.members AS m
            INNER JOIN recommendeds AS r
            ON m.recommendedby = r.memid
    )
SELECT
    r.memid,
    m.firstname,
    m.surname
FROM recommendeds AS r
    INNER JOIN cd.members AS m
    ON m.memid = r.memid
ORDER BY r.memid;

-- 3. produce a CTE that can return the upward
-- recommendation chain for any member. 
-- you should be able to select recommender
-- from recommenders where member=x. 
-- demonstrate it by getting the chains
-- for members 12 and 22. 
-- results table should have member and
-- recommender, ordered by member ascending,
-- recommender descending
WITH RECURSIVE 
recommenders(recommender, member) AS 
    (
        SELECT recommendedby, memid
        FROM cd.members
            UNION ALL
        SELECT m.recommendedby, r.member
        FROM recommenders AS r
            INNER JOIN cd.members AS m
            ON m.memid = r.recommender
    )
SELECT 
    r.member,
    r.recommender,
    m.firstname, 
    m.surname
FROM recommenders AS r
	INNER JOIN cd.members AS m
	ON r.recommender = m.memid
WHERE r.member IN (12, 22)
ORDER BY r.member ASC, r.recommender DESC;
