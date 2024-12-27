 with s1 as (select city_id ,trip_count,round(sum(repeat_passenger_count) / (select sum(repeat_passenger_count) as 'total_rep_passenger'
 from dim_repeat_trip_distribution)*100 ,3 )as 'per_rep_pass'
 from dim_repeat_trip_distribution 
 group by trip_count,city_id) 
 
 SELECT
	 dc.city_name,
    SUM(CASE WHEN trip_count = '2-Trips' THEN per_rep_pass ELSE 0 END) AS `2-Trips`,
    SUM(CASE WHEN trip_count = '3-Trips' THEN per_rep_pass ELSE 0 END) AS `3-Trips`,
    SUM(CASE WHEN trip_count = '4-Trips' THEN per_rep_pass ELSE 0 END) AS `4-Trips`,
    SUM(CASE WHEN trip_count = '5-Trips' THEN per_rep_pass ELSE 0 END) AS `5-Trips`,
    SUM(CASE WHEN trip_count = '6-Trips' THEN per_rep_pass ELSE 0 END) AS `6-Trips`,
    SUM(CASE WHEN trip_count = '7-Trips' THEN per_rep_pass ELSE 0 END) AS `7-Trips`,
    SUM(CASE WHEN trip_count = '8-Trips' THEN per_rep_pass ELSE 0 END) AS `8-Trips`,
    SUM(CASE WHEN trip_count = '9-Trips' THEN per_rep_pass ELSE 0 END) AS `9-Trips`,
    SUM(CASE WHEN trip_count = '10-Trips' THEN per_rep_pass ELSE 0 END) AS `10-Trips`
FROM s1 
join dim_city as dc 
on s1.city_id = dc.city_id
GROUP BY s1.city_id;
