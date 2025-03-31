use uber;
select * from uber_pune_booking_data;

-- Q1 Find the top 5 pickup locations with the highest ride requests, including both successful and canceled rides. --
 
SELECT `Pickup Location` , count(*) as HighestRides
FROM uber_pune_booking_data
group by `Pickup Location`
order by HighestRides desc
limit 5;

-- Q2Identify the most common reason for customer cancellations and how often each reason occurs.--

SELECT `Incomplete Rides Reason`,COUNT(*) AS cancelled
from uber_pune_booking_data
where `Ride Completed`= 'No'
group by `Incomplete Rides Reason`
order by cancelled desc;

-- Q3 	Calculate the average Vehicle Time to Arrival (VTAT) and Customer Time to Arrival (CTAT) for successful rides by vehicle type. --
select `Vehicle Type`, avg(`Avg VTAT`) as vehicalarrival,
avg(`Avg CTAT`) as customerarrival
from uber_pune_booking_data
where `Ride Completed`= 'Yes'
group by  `Vehicle Type`
order by `Vehicle Type` desc;

-- Q4 	Compute the cancellation rate per pickup location and highlight areas with rates above 20%. --
SELECT 
    `Pickup Location`,
    (COUNT(CASE WHEN `Ride Completed` = 'No' THEN 1 END) * 100.0 / COUNT(*)) AS cancellation_rate
FROM uber_pune_booking_data  
GROUP BY `Pickup Location`  
HAVING cancellation_rate > 20  
ORDER BY cancellation_rate DESC;

-- q5	Find the average driver rating per vehicle type and list vehicle types with driver ratings below 3.5 --
select `Vehicle Type`,
avg(`Driver Ratings`) as driverratings
from uber_pune_booking_data
group by `Vehicle Type`
having driverratings < 3.5
order by driverratings asc;

-- Q6 Identify the most frequent reason for incomplete rides and how often each reason occurs.--
SELECT `Incomplete Rides Reason`,count(*) as most
FROM uber_pune_booking_data
GROUP BY `Incomplete Rides Reason`
ORDER BY most DESC;

-- or-- 
SELECT `Incomplete Rides Reason`,most
from 
(
	SELECT `Incomplete Rides Reason`,count(*)as most,
	rank() over(ORDER BY count(*) DESC)as rnk
	FROM uber_pune_booking_data
	GROUP BY `Incomplete Rides Reason`
)ranked;

-- q6 	Find the hour of the day with the highest number of uber_pune_booking_data. --
SELECT hour(`Time`) as booking_hour,count(`Booking ID`) as total_uber_pune_booking_data
from uber_pune_booking_data
group by booking_hour
order by total_uber_pune_booking_data desc
;


-- q7 find most pickup location --
select `Pickup Location`,count(`Pickup Location`) as total,`Vehicle Type`
from uber_pune_booking_data
group by `Pickup Location`,`Vehicle Type`
order by total desc;

-- location wise uber_pune_booking_data --
SELECT `Pickup Location`,count(`Booking ID`) as total_uber_pune_booking_data
from uber_pune_booking_data
group by `Pickup Location`
order by total_uber_pune_booking_data desc
;

-- q8 	Identify the top 5 pickup and drop location pairs that generate the highest revenue from successful rides.--
SELECT `Pickup Location`,`Drop Location`,round(sum(`Booking Value`)) as revenue
from uber_pune_booking_data
where `Ride Completed` = "Yes"
group by `Pickup Location`,`Drop Location`
order by revenue desc
Limit 5;

-- q9 List the top 10 customers based on the number of successful rides they completed.--
SELECT `Customer ID`,count(*) as total
from uber_pune_booking_data
where `Ride Completed` = "Yes"
group by `Customer ID`
order by total desc
limit 10;

-- q10 •	Find the most frequently booked vehicle type for successful rides and the least preferred one. --
SELECT DISTINCT 
    FIRST_VALUE(`Vehicle Type`) OVER (ORDER BY COUNT(*) DESC) AS most_frequent,
    FIRST_VALUE(`Vehicle Type`) OVER (ORDER BY COUNT(*) ASC) AS least_frequent
FROM uber_pune_booking_data
WHERE `Ride Completed` = "Yes"
GROUP BY `Vehicle Type`;
-- q11 Find the most frequently booked vehicle type for successful rides and the least preferred one with its count--
SELECT DISTINCT 
    FIRST_VALUE(`Vehicle Type`) OVER (ORDER BY COUNT(*) DESC) AS most_frequent_vehicle,
    FIRST_VALUE(COUNT(*)) OVER (ORDER BY COUNT(*) DESC) AS most_frequent_count,
    FIRST_VALUE(`Vehicle Type`) OVER (ORDER BY COUNT(*) ASC) AS least_frequent_vehicle,
    FIRST_VALUE(COUNT(*)) OVER (ORDER BY COUNT(*) ASC) AS least_frequent_count
FROM uber_pune_booking_data
WHERE `Ride Completed` = "Yes"
GROUP BY `Vehicle Type`;

-- q12 •	Show the percentage distribution of cancellation reasons (both customer and driver).-- 
SELECT `Incomplete Rides Reason`, 
       COUNT(*) AS total_cancellations,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM uber_pune_booking_data WHERE `Incomplete Rides Reason` IS NOT NULL), 2) AS percentage
FROM uber_pune_booking_data
WHERE `Incomplete Rides Reason` IS NOT NULL
GROUP BY `Incomplete Rides Reason`
ORDER BY total_cancellations DESC;



-- q13 Compute the total revenue generated for each vehicle type from successful rides.-- 
SELECT `Vehicle Type`,sum(`Booking Value`) as revenue
from uber_pune_booking_data
where `Ride Completed` ="Yes"
group by `Vehicle Type`
order by revenue desc;

-- q15 find the avgerage ride distance for each vehicle type
select `Vehicle Type`, avg(`Ride Distance`) as avgdistance
from uber_pune_booking_data
group by `Vehicle Type`
order by avgdistance desc;

-- q16 get the total no. of rides cancelled by the customer
select `Cancelled Rides by Customer`,count(`Cancelled Rides by Customer`) as total_rides_cancelled
from uber_pune_booking_data
where `Cancelled Rides by Customer` = "Yes"
group by `Cancelled Rides by Customer`;

-- q16 list the top 5 customers who have booked the highest no. of rides
select `Customer ID`,count(`Customer ID`) as total
from uber_pune_booking_data
group by `Customer ID`
order by total desc
limit 5;

-- q17 get the number of rides cancelled by th driver due to 'Personal & Car related issues'
select count(`Reason for cancelling by Driver`) as Total_Reason
from uber_pune_booking_data
where `Reason for cancelling by Driver` = "Personal & Car related issues";

-- q18 find the max an min driver rating for prime sedan
select `Vehicle Type`,max(`Driver Ratings`) as maximum, min(`Driver Ratings`) as minimum
from uber_pune_booking_data 
where `Vehicle Type` = "Prime Sedan"
group by `Vehicle Type`;

-- q19 showw all rides were payment is upi
select *
from uber_pune_booking_data 
where `Payment Method` = "UPI";

-- q20 find the avg driver rating for each vehicle
select `Vehicle Type`, avg(`Driver Ratings`) as avgrate
from uber_pune_booking_data
group by `Vehicle Type`;

-- q21 find the total booking value
SELECT sum(`Booking Value`) as revenue
from uber_pune_booking_data
where `Ride Completed` = "Yes";

-- q22 list all incomplete ride along with reasons
select `Booking ID`, `Incomplete Rides Reason`
from uber_pune_booking_data
where `Incomplete Rides` = "Yes";

-- q23 revenue generated by each vehicle
select `Vehicle Type`,round(sum(`Booking Value`)) as revenue_generated
from uber_pune_booking_data
where `Ride Completed` = "Yes"
group by `Vehicle Type`
order by revenue_generated desc;

