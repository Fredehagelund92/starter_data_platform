WITH time_spine AS (
    {{ time_spine(
            start_hour=0,
            end_hour=23,
            start_minute=0,
            end_minute=59,
            start_second=0,
            end_second=0
        )
    }}
), calculated AS (
	SELECT
		TO_CHAR(time_of_day, 'hh24:mi:ss') AS time_of_day,
		EXTRACT(hour FROM time_of_day) AS hour,
		EXTRACT(minute FROM time_of_day) AS minute,
		EXTRACT(second FROM time_of_day) AS second,
		TO_CHAR(time_of_day - (EXTRACT(minute FROM time_of_day)::integer % 15 || 'minutes')::interval, 'hh24:mi') ||
		' – ' ||
		TO_CHAR(time_of_day - (EXTRACT(minute FROM time_of_day)::integer % 15 || 'minutes')::interval + '14 minutes'::interval, 'hh24:mi') AS quarter_hour,

		CASE WHEN TO_CHAR(time_of_day, 'hh24:mi') BETWEEN '12:00' AND '23:59'
			THEN 'PM'
			ELSE 'AM'
		END AS am_pm,
		CASE WHEN TO_CHAR(time_of_day, 'hh24:mi') BETWEEN '07:00' AND '19:59' THEN 'Day'
			ELSE 'Night'
		END AS day_night

	FROM time_spine
)

SELECT
    time_of_day,
    hour,
    minute,
    second,
    quarter_hour,
    am_pm,
    day_night
FROM calculated