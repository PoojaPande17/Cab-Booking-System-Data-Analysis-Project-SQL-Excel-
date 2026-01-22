use CabTrip;

/** Analysis of Driver Performance **/

/** 1. Identify drivers who have received an average rating below 3.0 in the past three 
months.**/
select d.Driver_ID, d.Driver_Name, AVG(f.Rating) as Average_Rating
from Driver_Info d
inner join Feedback f
on d.Driver_ID = f.Driver_ID
Group by  d.Driver_ID, d.Driver_Name
Having Average_Rating <3.0
order by Average_Rating;

/** 2. Find the top 5 drivers who have completed the longest trips in terms of distance.  **/

Select d.Driver_ID,d.Driver_Name,Sum(b.Distance) as Total_Distance_Covered_KM 
from Driver_Info d 
Inner join Booking_Info b
on d.Driver_ID = b.Driver_ID
where b.Status = 'Completed'
Group by d.Driver_ID,d.Driver_Name
Order by Total_Distance_Covered_KM  desc
Limit 5;


/** 3. Identify drivers with a high percentage of canceled trips.  **/
/** For Status LIKE 'Canceled%------for all canceled'**/

Select d.Driver_ID,d.Driver_Name,   COUNT(b.Booking_ID) AS Total_Bookings,
SUM(b.Status LIKE 'Canceled%') AS Total_Canceled_Trips, 
(sum(b.Status LIKE 'Canceled%') * 100.0/COUNT(b.Booking_ID))  as Canceled_Percentage
from Driver_Info d 
Inner join Booking_Info b
on d.Driver_ID = b.Driver_ID
Group by d.Driver_ID,d.Driver_Name
having Canceled_Percentage > 0
Order by Canceled_Percentage desc, d.Driver_ID asc
limit 5;