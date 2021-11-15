/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 1 of the case study, which means that there'll be more guidance for you about how to 
setup your local SQLite connection in PART 2 of the case study. 

The questions in the case study are exactly the same as with Tier 2. 

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

SELECT name from `Facilities` WHERE membercost > 0


/* Q2: How many facilities do not charge a fee to members? */

SELECT count(*) from `Facilities` WHERE membercost = 0


/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance from `Facilities` WHERE membercost >0 and membercost < .2*monthlymaintenance


/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

select * from Facilities where facid in (1,5)


/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

select name, monthlymaintenance,
case 
	when monthlymaintenance > 100 then 'expensive'
	else 'cheap' 
	end as Cost
from Facilities


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

SELECT concat_ws(', ', surname, firstname), joindate FROM Members order by joindate desc


/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT b.facid, name, concat_ws(', ', surname, firstname) as member
FROM Bookings as b 
left join Facilities as f 
	on b.facid = f.facid
left join Members as m
	on b.memid = m.memid
where b.facid in (0,1) and m.memid > 0
group by member
order by member


/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

select name as Facility, 
case
	when firstname = 'GUEST' then 'GUEST' 
	else concat_ws(', ', surname, firstname) 
	end as Member,  
case
	when b.memid > 0 then slots*membercost
	when b.memid = 0 then slots*guestcost
	end as Cost
from Bookings as b
left join Facilities as f
	on b.facid = f.facid
left join Members as m
	on b.memid = m.memid
where starttime like '2012-09-14%' and (slots*membercost > 30 or (b.memid = 0 and slots*guestcost > 30))
order by Cost desc

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

select name as Facility, 
case
	when firstname = 'GUEST' then 'GUEST' 
	else concat_ws(', ', surname, firstname) 
	end as Member,  
case
	when b.memid > 0 then slots*membercost
	when b.memid = 0 then slots*guestcost
	end as Cost
from Bookings as b
inner join (
    select name, membercost, guestcost, facid
    from Facilities) as f
on b.facid = f.facid
inner join (
    select firstname, surname, memid
    from Members) as m
	on b.memid = m.memid
where starttime like '2012-09-14%' and (slots*membercost > 30 or (b.memid = 0 and slots*guestcost > 30))
order by Cost desc

/* PART 2: SQLite
/* We now want you to jump over to a local instance of the database on your machine. 

Copy and paste the LocalSQLConnection.py script into an empty Jupyter notebook, and run it. 

Make sure that the SQLFiles folder containing thes files is in your working directory, and
that you haven't changed the name of the .db file from 'sqlite\db\pythonsqlite'.

You should see the output from the initial query 'SELECT * FROM FACILITIES'.

Complete the remaining tasks in the Jupyter interface. If you struggle, feel free to go back
to the PHPMyAdmin interface as and when you need to. 

You'll need to paste your query into value of the 'query1' variable and run the code block again to get an output.
 
QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

select Facility, Revenue
from (
    SELECT name as Facility, sum(Rev) as Revenue
	FROM (
        select name, 
    	case 
            when memid > 0 then slots*membercost
            when memid = 0 then slots*guestcost
            end as Rev
    	from Bookings 
		inner join Facilities 
		using (facid) ) as Revenues

		group by Facility) as TotalRevenue

where Revenue < 1000
order by Revenue

/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */

select mem1.memid as Memid, mem1.Member, mem1.rb as RecommenderMemid, 
	case
		when mem1.rb > 0 then mem2.Member 
		else ''
		end as RecommendedBy
	
from (
    SELECT memid, concat_ws(', ', surname, firstname) as Member, recommendedby as rb
	FROM Members ) as mem1
join (
    SELECT memid, concat_ws(', ', surname, firstname) as Member, recommendedby as rb
	FROM Members ) as mem2
on mem1.rb = mem2.memid
where mem1.memid > 0
order by mem1.Member, mem1.memid


/* Q12: Find the facilities with their usage by member, but not guests */


*****LISTS THE NAMES OF THE FACILITIES WITH MEMBER NAME ON SAME ROW*****

select distinct t1.memid, t2.Member, t1.facid, t3.Facility as Facilities

from (
	SELECT distinct memid,facid 
    FROM `Bookings` 
	where memid > 0
	order by memid, facid) as t1
join (
    select memid, concat_ws(', ', surname, firstname) as Member
    from Members) as t2
	on t1.memid = t2.memid
join (
    select facid, name as Facility
    from Facilities) as t3
	on t1.facid = t3.facid
	
*****LISTS THE COUNTS OF FACILITIES PER MEMBER*****

select t1.memid, Member, sum(slots) as 'Total Booking'

from (
	SELECT memid,facid, slots 
    FROM `Bookings` 
	where memid > 0) as t1
join (
    select memid, concat_ws(', ', surname, firstname) as Member
    from Members) as t2
	on t1.memid = t2.memid
join (
    select facid 
    from Facilities) as t3
	on t1.facid = t3.facid
group by Member
order by 'Total Booking'


/* Q13: Find the facilities usage by month, but not guests */

select 
	case	
		when extract(month from starttime) = 7 then 'July'
		when extract(month from starttime) = 8 then 'August'
		when extract(month from starttime) = 9 then 'September'
		else ''
		end as Month,
	count(t1.facid) as FacilityUsage

from (
	SELECT starttime, facid 
    FROM `Bookings` 
	where memid > 0) as t1

join (
    select facid
    from Facilities) as t2
	on t1.facid = t2.facid

group by extract(month from starttime)
order by FacilityUsage


