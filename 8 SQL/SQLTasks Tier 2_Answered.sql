/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */
SELECT *
FROM `Facilities`
WHERE `membercost` !=0
LIMIT 0 , 30

/* Q2: How many facilities do not charge a fee to members? */
SELECT COUNT( * )
FROM `Facilities`
WHERE `membercost` !=0

answer 5

/* RE-Wrote SQL 2021/21/08
Q3: Write an SQL query to show a list of facilities that charge a fee to members,  
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT `facid` , `name` , `membercost` , `monthlymaintenance`
FROM `Facilities`
WHERE `membercost` >0
AND `membercost` < ( `monthlymaintenance` * .20 )
LIMIT 0 , 30


looking at the data all the membercost is less than 20%, This includes the 0 membercost for use.

Database country_club

facid	name		memebercost	monthlymaintenance
0	Tennis Court 1	5			200
1	Tennis Court 2	5			200
4	Massage Room 1	9.9			3000
5	Massage Room 2	9.9			3000
6	Squash Court	3.5			80





/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */
SELECT *
FROM `Facilities`
WHERE `facid` in (1, 5)
LIMIT 0 , 30

/* Re Wrote 2021/02/08
Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */


SELECT `name` , CASE when `monthlymaintenance`< 100 then "cheap" 
ELSE "expensive" END AS rate, `monthlymaintenance`
FROM Facilities
order by rate
LIMIT 0 , 30;

Database country_club
name			rate		monthlymaintenance	
Badminton Court	cheap		50
Table Tennis	cheap		10
Squash Court	cheap		80
Snooker Table	cheap		15
Pool Table		cheap		15
Tennis Court 1	expensive	200
Tennis Court 2	expensive	200
Massage Room 1	expensive	3000
Massage Room 2	expensive	3000



/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

SELECT `firstname` , `surname` , `joindate`
FROM Members
WHERE joindate = (
SELECT max( joindate )
FROM Members )
firstname 	surname		joindate
Dareren		Smith		2012-09-26 18:08:45

/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
SELECT CONCAT( m.firstname, ' ', m.surname), f.name
FROM Members m
LEFT JOIN Bookings b ON m.memid = b.memid
INNER JOIN Facilities f ON f.facid = b.facid
WHERE b.facid IN ( 0, 1 )
GROUP BY f.name, m.surname
ORDER BY m.firstname
LIMIT 0 , 30

CONCAT( m.firstname, ' ', m.surname ), f.name
Anne Baker Tennis Court 1
Anne Baker Tennis Court 2
Burton Tracy Tennis Court 2
Burton Tracy Tennis Court 1
Charles Owen Tennis Court 1
Charles Owen Tennis Court 2
Darren Smith Tennis Court 2
David Jones Tennis Court 2
David Jones Tennis Court 1
David Pinker Tennis Court 1
Erica Crumpet Tennis Court 1
Florence Bader Tennis Court 2
Florence Bader Tennis Court 1
Gerald Butters Tennis Court 1
Gerald Butters Tennis Court 2
GUEST GUEST Tennis Court 2
GUEST GUEST Tennis Court 1
Henrietta Rumney Tennis Court 2
Janice Joplette Tennis Court 1
Janice Joplette Tennis Court 2
Jemima Farrell Tennis Court 2
Jemima Farrell Tennis Court 1
Joan Coplin Tennis Court 1
John Hunt Tennis Court 1
John Hunt Tennis Court 2
Matthew Genting Tennis Court 1
Millicent Purview Tennis Court 2
Nancy Dare Tennis Court 2
Nancy Dare Tennis Court 1
Ponder Stibbons Tennis Court 2
Ponder Stibbons Tennis Court 1
Ramnaresh Sarwin Tennis Court 2
Ramnaresh Sarwin Tennis Court 1
Tim Rownam Tennis Court 1
Tim Boothe Tennis Court 2
Tim Boothe Tennis Court 1
Tim Rownam Tennis Court 2
Tracy Smith Tennis Court 1



/* case statement

Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

/*SeLECT m.memid, concat( m.firstname,' ',m.surname), m.joindate, f.name as Facility, (f.guestcost *b.slots) as total_per30min 
FROM Members m
LEFT JOIN Bookings b ON m.memid = b.memid
INNER JOIN Facilities f ON f.facid = b.facid
WHERE b.starttime between '2012-09-14 00:00:00' and '2012-09-14 23:59:59' 
and m.memid = 0
having (total_per30min) > 30
*/
SELECT concat( m.firstname,' ',m.surname) as Name , f.name as Facility, CASE WHEN m.firstname = 'GUEST' THEN f.guestcost * b.slots ELSE f.membercost * b.slots END AS cost
FROM Members m
LEFT JOIN Bookings b ON m.memid = b.memid
INNER JOIN Facilities f ON f.facid = b.facid
WHERE b.starttime between '2012-09-14 00:00:00' and '2012-09-14 23:59:59' 
having (cost) > 30
order by cost desc

GUEST GUEST		Massage Room 2	320
GUEST GUEST		Massage Room 1	160
GUEST GUEST		Massage Room 1	160
GUEST GUEST		Massage Room 1	160
GUEST GUEST		Tennis Court 2	150
GUEST GUEST		Tennis Court 1	75
GUEST GUEST		Tennis Court 1	75
GUEST GUEST		Tennis Court 2	75
GUEST GUEST		Squash Court	70
Jemima Farrell	Massage Room 1	39.6
GUEST GUEST		Squash Court	35
GUEST GUEST		Squash Court	35








/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT concat( firstname, ' ', surname ) AS Name, name AS facility, cost
FROM (

SELECT m.firstname, m.surname, f.name,
CASE WHEN m.firstname = 'GUEST'
THEN f.guestcost * b.slots
ELSE f.membercost * b.slots
END AS cost, b.starttime
FROM Members m
LEFT JOIN Bookings b ON m.memid = b.memid
INNER JOIN Facilities f ON f.facid = b.facid
) AS inner_table
WHERE starttime
BETWEEN '2012-09-14 00:00:00'
AND '2012-09-14 23:59:59'
AND cost >30
ORDER BY cost DESC 

GUEST GUEST	Massage Room 2	320
GUEST GUEST	Massage Room 1	160
GUEST GUEST	Massage Room 1	160
GUEST GUEST	Massage Room 1	160
GUEST GUEST	Tennis Court 2	150
GUEST GUEST	Tennis Court 2	75
GUEST GUEST	Tennis Court 1	75
GUEST GUEST	Tennis Court 1	75
GUEST GUEST	Squash Court	70
Jemima Farrell	Massage Room 1	39.6
GUEST GUEST	Squash Court	35
GUEST GUEST	Squash Court	35



/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */


answer in juypter notebook 
    select Facility, sum(cost) 
    from(SELECT m.firstname, m.surname , f.name as Facility, CASE WHEN m.memid = 0 
        THEN f.guestcost * b.slots ELSE f.membercost * b.slots END AS cost
        FROM Members m
        JOIN Bookings b ON m.memid = b.memid
        JOIN Facilities f ON f.facid = b.facid
        where 1=1) as bob
    GROUP BY Facility
    HAVING sum( cost ) <1000
	
2.6.0
3. Query all tasks
('Pool Table', 270)
('Snooker Table', 240)
('Table Tennis', 180)



/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */

    select tim.surname, tim.firstname, (m.surname ||' '|| m.firstname) AS Referral
    from (select surname, firstname, recommendedby from Members where recommendedby > 0) as tim
    join Members m on m.memid = tim.recommendedby
    where m.memid in (select recommendedby from Members where recommendedby > 0)
    order by tim.surname, tim.firstname


2.6.0
11. Query all tasks
('Bader', 'Florence', 'Stibbons Ponder')
('Baker', 'Anne', 'Stibbons Ponder')
('Baker', 'Timothy', 'Farrell Jemima')
('Boothe', 'Tim', 'Rownam Tim')
('Butters', 'Gerald', 'Smith Darren')
('Coplin', 'Joan', 'Baker Timothy')
('Crumpet', 'Erica', 'Smith Tracy')
('Dare', 'Nancy', 'Joplette Janice')
('Genting', 'Matthew', 'Butters Gerald')
('Hunt', 'John', 'Purview Millicent')
('Jones', 'David', 'Joplette Janice')
('Jones', 'Douglas', 'Jones David')
('Joplette', 'Janice', 'Smith Darren')
('Mackenzie', 'Anna', 'Smith Darren')
('Owen', 'Charles', 'Smith Darren')
('Pinker', 'David', 'Farrell Jemima')
('Purview', 'Millicent', 'Smith Tracy')
('Rumney', 'Henrietta', 'Genting Matthew')
('Sarwin', 'Ramnaresh', 'Bader Florence')
('Smith', 'Jack', 'Smith Darren')
('Stibbons', 'Ponder', 'Tracy Burton')
('Worthington-Smyth', 'Henry', 'Smith Tracy')




/* Q12: Find the facilities with their usage by member, but not guests */
    SELECT f.name, count(f.name )
    FROM Members m
    JOIN Bookings b ON m.memid = b.memid
    JOIN Facilities f ON f.facid = b.facid
    WHERE b.memid !=0
    GROUP BY f.name
    LIMIT 0 , 30



2.6.0
12. Query all tasks
('Badminton Court', 344)
('Massage Room 1', 421)
('Massage Room 2', 27)
('Pool Table', 783)
('Snooker Table', 421)
('Squash Court', 195)
('Table Tennis', 385)
('Tennis Court 1', 308)
('Tennis Court 2', 276)




/* Q13: Find the facilities usage by month, but not guests */

    select f.name, strftime('%m',b.starttime) , count(f.name) 
    from Bookings b JOIN Facilities f ON f.facid = b.facid
    where b.memid != 0
    group by b.facid, strftime('%m',b.starttime)



2.6.0
13. Query all tasks
('Tennis Court 1', '07', 65)
('Tennis Court 1', '08', 111)
('Tennis Court 1', '09', 132)
('Tennis Court 2', '07', 41)
('Tennis Court 2', '08', 109)
('Tennis Court 2', '09', 126)
('Badminton Court', '07', 51)
('Badminton Court', '08', 132)
('Badminton Court', '09', 161)
('Table Tennis', '07', 48)
('Table Tennis', '08', 143)
('Table Tennis', '09', 194)
('Massage Room 1', '07', 77)
('Massage Room 1', '08', 153)
('Massage Room 1', '09', 191)
('Massage Room 2', '07', 4)
('Massage Room 2', '08', 9)
('Massage Room 2', '09', 14)
('Squash Court', '07', 23)
('Squash Court', '08', 85)
('Squash Court', '09', 87)
('Snooker Table', '07', 68)
('Snooker Table', '08', 154)
('Snooker Table', '09', 199)
('Pool Table', '07', 103)
('Pool Table', '08', 272)
('Pool Table', '09', 408)

