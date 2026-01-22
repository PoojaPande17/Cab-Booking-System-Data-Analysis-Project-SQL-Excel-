Use CabTrip;
/** Analysis of Predictive Analysis **/ 

/** 1. Compare the revenue generated from 'Sedan' and 'SUV' cabs.  **/
Select v.Vehicle_Type, sum(b.Fare) as Total_Revenue
from Booking_Info b
Inner Join Vehicle_Info v
On b.Vehicle_ID = v.Vehicle_ID
Where b.Status = 'Completed'
and v.Vehicle_Type in ('Sedan','SUV')
Group by v.Vehicle_Type
Order by Total_Revenue desc;


/** 2. Predict which customers are likely to stop using the service based on their last booking 
date and frequency of rides.**/
/**Curdate() if date is generalised,
 window for checking last booking since days is 30 days, beyound which all are at risk of losinf customer**/   
Select c.Customer_ID, c.Customer_Name,Booking.Last_Booking_Date, Booking.Total_Bookings,
datediff('2025-06-01', Booking.Last_Booking_Date) as Days_since_Booking
from Customer_Info c
Inner Join (
    Select
        Customer_ID,
        max(Booking_Time) as Last_Booking_Date,
        count(Booking_ID) as Total_Bookings
    from Booking_Info
    Group by Customer_ID
) as Booking  
On c.Customer_ID = Booking.Customer_ID
Group by  c.Customer_ID,c.Customer_Name
Having Days_since_Booking  > 30 
Order by  Days_since_Booking desc, Booking.Total_Bookings;

/** 3. Analyze whether weekend bookings differ significantly from weekday bookings.  **/
/** For all Bookings(Completed, Canceled) **/
Select  
    case
       when dayname(Booking_Time) in ('Sunday','Saturday') then 'Weekend' else 'Weekday'
       end as Week_Name,
sum(Fare) as Total_Revenue, avg(Fare) as avg_Revenue, Count(Booking_ID) as Total_Booking
from Booking_Info 
Group by Week_Name
order by Total_Booking desc;

/** where Status = 'Completed' **/
Select  
    case
       when dayname(Booking_Time) in ('Sunday','Saturday') then 'Weekend' else 'Weekday'
       end as Week_Name,
sum(Fare) as Total_Revenue, avg(Fare) as avg_Revenue, Count(Booking_ID) as Total_Booking
from Booking_Info 
where Status = 'Completed'
Group by Week_Name
order by Total_Booking desc;