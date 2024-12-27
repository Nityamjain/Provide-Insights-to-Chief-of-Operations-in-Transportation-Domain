with sol_1 AS (SELECT city_id,
                      COUNT(trip_id) AS 'total_trips',
                      SUM(fare_amount) / COUNT(trip_id) AS 'avg_fare_per_trip',
                      SUM(fare_amount) / SUM(distance_travelled_km) AS 'avg_fare_per_km',
                      (COUNT(trip_id) / (SELECT COUNT(trip_id) FROM fact_trips)) * 100 AS 'percentage_contribution_to_totaltrips'
               FROM fact_trips
               GROUP BY city_id)

select dc.city_name,
       s1.total_trips,
       s1.avg_fare_per_trip,
	   s1.avg_fare_per_km,
       s1.percentage_contribution_to_totaltrips
from dim_city as dc
join sol_1 as s1 
     on dc.city_id = s1.city_id ;