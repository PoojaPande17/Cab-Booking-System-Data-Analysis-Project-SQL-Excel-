Use CabTrip;
/** Analysis of Operational Efficiency & Optimization **/ 

/** 1.  Analyze the average waiting time (difference between booking time and trip start 
time) for different pickup locations. **/

/**For only pickup location**/ 
/**This is more making sense as having only pickup location - for cab arriving irrespective of destination location**/ 
Select b.Pick_up_Location,
Avg(timestampdiff(minute, b.Booking_Time, t.Pick_up_Time)) as Average_Wating_Time
from Booking_Info b
Inner Join Trip_Details t
On b.Booking_ID = t.Booking_ID
where b.Status= 'Completed'
Group by b.Pick_up_Location
Order by Average_Wating_Time desc;

/**For only pickup location and drop0ff location combination**/ 
Select b.Pick_up_Location,b.Drop_off_Location,
Avg(timestampdiff(minute, b.Booking_Time, t.Pick_up_Time)) as Average_Wating_Time
from Booking_Info b
Inner Join Trip_Details t
On b.Booking_ID = t.Booking_ID
where b.Status= 'Completed'
Group by b.Pick_up_Location,b.Drop_off_Location
Order by Average_Wating_Time desc;


/** 2.   Identify the most common reasons for trip cancellations from customer feedback.   **/

/** For ALL Rating **/
Select
Count(case when f.Review like '%cancel%' or f.Review like '%late%' or f.Review like '%wait%' or f.Review like '%delay%' then 1 end ) as Efficiency_Issues,
Count(case when f.Review like  '%location%'  or f.Review like '%wrong%' or f.Review like '%lost%' or f.Review like '%address%' then 1 end ) as Location_Issues,
Count(case when f.Review like '%cost%'  or f.Review like '%fare%' or f.Review like '%expensive%' or f.Review like '%price%' then 1 end ) as  Pricing_Issues,
Count(case when f.Review like  '%smell%'  or f.Review like '%car%' or f.Review like '%messy%' or f.Review like '%vehicle%' then 1 end ) as Vehicle_Condition_Issues,
Count(case when f.Review like  '%rude%' or f.Review like '%phone%' or f.Review like '%unprofessional%' or f.Review like '%driver%' then 1 end ) as  Driver_Behavior_Issues
from Feedback f;

/** For Rating less than or equal **/
Select
Count(case when f.Review like '%cancel%' or f.Review like '%late%' or f.Review like '%wait%' or f.Review like '%delay%' then 1 end ) as Efficiency_Issues,
Count(case when f.Review like  '%location%'  or f.Review like '%wrong%' or f.Review like '%lost%' or f.Review like '%address%' then 1 end ) as Location_Issues,
Count(case when f.Review like '%cost%'  or f.Review like '%fare%' or f.Review like '%expensive%' or f.Review like '%price%' then 1 end ) as  Pricing_Issues,
Count(case when f.Review like  '%smell%'  or f.Review like '%car%' or f.Review like '%messy%' or f.Review like '%vehicle%' then 1 end ) as Vehicle_Condition_Issues,
Count(case when f.Review like  '%rude%' or f.Review like '%phone%' or f.Review like '%unprofessional%' or f.Review like '%driver%' then 1 end ) as  Driver_Behavior_Issues
from Feedback f
where Rating <= 3.0;


/** 3.   Find out whether shorter trips (low-distance) contribute significantly to revenue.  **/

/** FINAL combined Result Revenue Percentage for distance less than 0r = 10 km **/
Select
    (Select sum(Fare) from Booking_Info Where Status = 'Completed' and Distance <= 10) as Short_Trip_Revenue,
    (Select sum(Fare) from Booking_Info Where Status = 'Completed') as Total_Revenue,
    (Select sum(Fare) from Booking_Info Where Status = 'Completed' and Distance <= 10) * 100.0 / 
    (Select sum(Fare) from Booking_Info Where Status = 'Completed') as Short_Trip_Revenue_Percentage;