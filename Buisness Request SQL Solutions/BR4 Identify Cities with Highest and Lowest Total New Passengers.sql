with sol_4 as ((select city_id , 
                       sum(new_passengers) as 'tnp','TOP3' as city_category
				from fact_passenger_summary 
                group by city_id 
				order by tnp desc
				limit 3)
                
                union
                
                (select city_id , 
                        sum(new_passengers) as 'tnp','BOTTOM3' as city_category
				 from fact_passenger_summary 
                 group by city_id 
                 order by tnp asc
				 limit 3))

select dc.city_name,
       s4.tnp as 'total_new_passengers',
	   s4.city_category
from dim_city as dc
join sol_4 as s4 
     on dc.city_id = s4.city_id;


