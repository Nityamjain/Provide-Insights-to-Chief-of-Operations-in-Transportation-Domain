	with total_trips_monthly as (select dd.start_of_month,ft.city_id,
	count(ft.trip_id) as 'total_trips'
	from fact_trips as ft join
	dim_date as dd 
	on ft.date=dd.date
	group by ft.city_id,dd.start_of_month
	order by dd.start_of_month,ft.city_id),

	sol_2 as (select at.city_id,tt.month, 
    at.total_trips as 'actual_trips', 
    tt.total_target_trips as 'target_trips',
    CASE
        WHEN at.total_trips > tt.total_target_trips THEN 'Above Target'
        WHEN at.total_trips < tt.total_target_trips THEN 'Below Target'
    END AS 'status',
round(((at.total_trips-tt.total_target_trips)/tt.total_target_trips) *100,2) as 'percentage_diff'
	from targets_db.monthly_target_trips as tt
	join total_trips_monthly as at 
	on tt.city_id =at.city_id and tt.month = at.start_of_month
	)
    
    select dc.city_name,
    s2.month,
    s2.actual_trips,
    s2.target_trips,
    s2.status,
    s2.percentage_diff
    from dim_city as dc
    join sol_2 as s2
    on dc.city_id = s2.city_id ;