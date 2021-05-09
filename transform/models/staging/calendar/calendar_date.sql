
WITH date_spine AS (

  {{ dbt_utils.date_spine(
      start_date="to_date('01/01/2020', 'mm/dd/yyyy')",
      datepart="day",
      end_date="to_date('31/12/2021', 'mm/dd/yyyy')"
     )
  }}

), holiday as (
    select
      date_day join_date_day,
      CASE
        WHEN EXTRACT(month from date_day) = 1 AND EXTRACT(day from date_day) = 1 THEN 'New Year''s Day'
        WHEN EXTRACT(month from date_day) = 12 AND EXTRACT(day from date_day) = 25 THEN 'Christmas Day'
        WHEN EXTRACT(month from date_day) = 12 AND EXTRACT(day from date_day) = 26 THEN 'Boxing Day'
      ELSE NULL END                                                              AS holiday_desc
    from date_spine

), calculated as (
  SELECT    date_day,
            To_char(date_day, 'Day')       AS day_name,
            Extract(month FROM date_day)   AS month_no,
            Extract(year FROM date_day)    AS year_no,
            Extract(quarter FROM date_day) AS quarter_no,
            Extract(dow FROM date_day) + 1 AS day_no,
            CASE
                      WHEN To_char(date_day, 'Day') = 'Sun' THEN date_day
                      ELSE Date_trunc('week', date_day) - INTERVAL '1 day'
            end                                                                                                                     AS first_day_of_week,
            extract(week FROM date_day)                                                                                             AS week_of_year,
            extract(day FROM date_day)                                                                                              AS day_of_month,
            row_number() over (partition BY extract(year FROM date_day), extract(quarter FROM date_day) ORDER BY date_day)          AS day_of_quarter,
            row_number() over (partition BY extract(year FROM date_day) ORDER BY date_day)                                          AS day_of_year,
            to_char(date_day, 'MMMM')                                                                                               AS month_name,
            date_trunc('MONTH',date_day)                                                                                            AS first_day_of_month,
            last_value(date_day) over (partition BY extract(year FROM date_day), extract(month FROM date_day) ORDER BY date_day)    AS last_day_of_month,
            first_value(date_day) over (partition BY extract(year FROM date_day) ORDER BY date_day)                                 AS first_day_of_year,
            last_value(date_day) over (partition BY extract(year FROM date_day) ORDER BY date_day)                                  AS last_day_of_year,
            first_value(date_day) over (partition BY extract(year FROM date_day), extract(quarter FROM date_day) ORDER BY date_day) AS first_day_of_quarter,
            last_value(date_day) over (partition BY extract(year FROM date_day), extract(quarter FROM date_day) ORDER BY date_day)  AS last_day_of_quarter,
            last_value(date_day) over (partition BY extract(week FROM date_day) ORDER BY date_day)                                  AS last_day_of_week,
            (extract(year FROM date_day)
                      || '-Q'
                      || extract(quarter FROM date_day)) AS quarter_name,
            holiday.holiday_desc                         AS holiday_desc, (
            CASE
                      WHEN holiday.holiday_desc IS NULL THEN 0
                      ELSE 1
            end) AS is_holiday
  FROM      date_spine
  LEFT JOIN holiday
  ON        holiday.join_date_day = date_spine.date_day

)

SELECT
  date_day,
  day_name,
  month_no,
  year_no,
  quarter_no,
  day_no,
  first_day_of_week,
  week_of_year,
  day_of_month,
  day_of_quarter,
  day_of_year,
  month_name,
  first_day_of_month,
  last_day_of_month,
  first_day_of_year,
  last_day_of_year,
  first_day_of_quarter,
  last_day_of_quarter,
  last_day_of_week,
  quarter_name,
  holiday_desc,
  is_holiday
FROM calculated
