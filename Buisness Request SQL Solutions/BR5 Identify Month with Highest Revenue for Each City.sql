with sol_5 as (select ft.city_id as 'city_id' ,
                      dd.month_name as 'month',
					  sum(fare_amount) as 'revenue' 
			   from fact_trips as ft
               join dim_date as dd 
                    on dd.date = ft.date 
                    group by dd.month_name,
							ft.city_id
				),

 max_revenue_per_city as (select city_id,
								 max(revenue) AS max_revenue
						  from sol_5
						  group by city_id 
                          ),

city_toal_revenue as (select city_id ,
							 sum(revenue) as total_revenue
					  from sol_5
                      group by city_id
                      )
                      
select dc.city_name, 
       s5.month as 'highest_revenue_month',
	   s5.revenue,
	   round((mrc.max_revenue * 100.0) / ctr.total_revenue, 2) AS 'percentage_contribution'
from sol_5 as s5 

join max_revenue_per_city as mrc
     on s5.city_id = mrc.city_id and 
        s5.revenue = mrc.max_revenue
        
join city_toal_revenue as ctr
     on s5.city_id = ctr.city_id 
     
join dim_city as dc 
     on s5.city_id = dc.city_id
     
order by s5.revenue desc;

       