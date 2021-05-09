


{% macro time_spine(start_hour, end_hour, start_minute, end_minute, start_second, end_second) %}



with hour as (
	SELECT '00'::integer + (sequence.hour)::integer AS hour
		FROM generate_series({{ start_hour }}, {{ end_hour }}) AS sequence(hour)
		GROUP BY sequence.hour
		order by 1
), mins as (

	SELECT '00'::integer + (sequence.minute)::integer AS minute
		FROM generate_series({{ start_minute }},{{ end_minute }}) AS sequence(minute)
		GROUP BY sequence.minute
		order by 1
), seconds as (

	SELECT '00'::integer + ( sequence.second)::integer AS second
		FROM generate_series({{ start_second }},{{ end_second }}) AS sequence(second)
		GROUP BY sequence.second

)

select  '00:00:00'::time + (hour::varchar || ' hour')::interval + (minute::varchar || ' minute')::interval + (second::varchar || ' second')::interval as time_of_day from hour

cross join mins

cross join seconds

{% endmacro %}