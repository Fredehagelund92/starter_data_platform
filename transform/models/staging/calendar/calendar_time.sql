with time_spine as (
    {{ time_spine(
            start_hour=0,
            end_hour=23,
            start_minute=0,
            end_minute=59,
            start_second=0,
            end_second=0
        )
    }}
), calculated as (
	select
		to_char(time_of_day, 'hh24:mi:ss') as time_of_day,
		extract(hour from time_of_day) as hour,
		extract(minute from time_of_day) as minute,
		extract(second from time_of_day) as second,
		to_char(time_of_day - (extract(minute from time_of_day)::integer % 15 || 'minutes')::interval, 'hh24:mi') ||
		' – ' ||
		to_char(time_of_day - (extract(minute from time_of_day)::integer % 15 || 'minutes')::interval + '14 minutes'::interval, 'hh24:mi') as quarter_hour,

		case when to_char(time_of_day, 'hh24:mi') between '12:00' and '23:59'
			then 'PM'
			else 'AM'
		end as am_pm,
		case when to_char(time_of_day, 'hh24:mi') between '07:00' and '19:59' then 'Day'
			else 'Night'
		end AS day_night

	from time_spine
)

select
    time_of_day,
    hour,
    minute,
    second,
    quarter_hour,
    am_pm,
    day_night
from calculated