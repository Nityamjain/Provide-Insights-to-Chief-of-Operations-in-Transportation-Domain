with s1 as (select city_id,
		    (sum(repeat_passengers)/(select sum(total_passengers) 
									 from fact_passenger_summary) *100 ) as 'city_repeat_passenger_rate'
            from fact_passenger_summary
             group by city_id)

select dc.city_name,
       fps.month,
	   fps.total_passengers,
	   (sum(repeat_passengers)/(select sum(total_passengers) 
								from fact_passenger_summary) *100 ) as 'monthly_repeat_passenger_rate' ,
       s1.city_repeat_passenger_rate
from fact_passenger_summary as fps
join s1 
 on fps.city_id=s1.city_id
join dim_city as dc
 on fps.city_id=dc.city_id
group by fps.month,
         fps.city_id; 