use CabTrip;

/** Analysis of Customer behaviour **/

/** 1. Identify customers who have completed the most bookings. **/
select c.Customer_ID, c.Customer_Name, count(b.Booking_ID) as Most_completed_Trip
from Customer_Info c
INNER JOIN Booking_Info b
ON c.Customer_ID = b.Customer_ID
WHERE b.Status = 'Completed'
group by c.Customer_ID, c.Customer_Name
order by Most_completed_Trip desc,c.Customer_Name asc
limit 5;


/** 2.  Find customers who have canceled more than 30% of their total bookings.  **/
select c.Customer_ID, c.Customer_Name, 
(SUM(b.Status = 'Canceled_by_Customer') * 100.0 / count(b.Booking_ID) ) AS Cancellation_Percentage
from Customer_Info c
INNER JOIN Booking_Info b
ON c.Customer_ID = b.Customer_ID
group by c.Customer_ID, c.Customer_Name
HAVING Cancellation_Percentage > 30
order by Cancellation_Percentage desc, c.Customer_Name asc;

/** 3.  Determine the busiest day of the week for bookings.  **/
select  dayname(Booking_Time)  as Day_of_week,
COUNT(Booking_ID) AS Total_Completed_Bookings
from Booking_Info 
Where Status = 'Completed'
Group by Day_of_week
order by  Total_Completed_Bookings desc, Day_of_week asc
limit 3;