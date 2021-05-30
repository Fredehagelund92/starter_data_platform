WITH date_spine AS (

  {{ dbt_utils.date_spine(
      start_date="to_date('01/01/2020', 'mm/dd/yyyy')",
      datepart="day",
      end_date="to_date('31/12/2021', 'mm/dd/yyyy')"
     )
  }}

), holiday AS (
    SELECT
      date_day AS join_date_day,
      CASE WHEN EXTRACT(month FROM date_day) = 1 AND EXTRACT(day FROM date_day) = 1 THEN 'New Years Day'
        WHEN EXTRACT(month FROM date_day) = 12 AND EXTRACT(day FROM date_day) = 25 THEN 'Christmas Day'
        WHEN EXTRACT(month FROM date_day) = 12 AND EXTRACT(day FROM date_day) = 26 THEN 'Boxing Day'
      ELSE NULL END AS holiday_desc
    FROM date_spine

), calculated AS (
  SELECT    date_day,
            TO_CHAR(date_day, 'Day')       AS day_name,
            EXTRACT(month FROM date_day)   AS month_no,
            EXTRACT(year FROM date_day)    AS year_no,
            EXTRACT(quarter FROM date_day) AS quarter_no,
            EXTRACT(dow FROM date_day) + 1 AS day_no,
            CASE
                      WHEN TO_CHAR(date_day, 'Day') = 'Sun' THEN date_day
                      ELSE DATE_TRUNC('week', date_day) - INTERVAL '1 day'
            END                                                                                                                     AS first_day_of_week,
            EXTRACT(week FROM date_day)                                                                                             AS week_of_year,
            EXTRACT(day FROM date_day)                                                                                              AS day_of_month,
            ROW_NUMBER() OVER (PARTITION BY EXTRACT(year FROM date_day), EXTRACT(quarter FROM date_day) ORDER BY date_day)          AS day_of_quarter,
            ROW_NUMBER() OVER (PARTITION BY EXTRACT(year FROM date_day) ORDER BY date_day)                                          AS day_of_year,
            TO_CHAR(date_day, 'MMMM')                                                                                               AS month_name,
            DATE_TRUNC('MONTH',date_day)                                                                                            AS first_day_of_month,
            LAST_VALUE(date_day) OVER (PARTITION BY EXTRACT(year FROM date_day), EXTRACT(month FROM date_day) ORDER BY date_day)    AS last_day_of_month,
            FIRST_VALUE(date_day) OVER (PARTITION BY EXTRACT(year FROM date_day) ORDER BY date_day)                                 AS first_day_of_year,
            LAST_VALUE(date_day) OVER (PARTITION BY EXTRACT(year FROM date_day) ORDER BY date_day)                                  AS last_day_of_year,
            FIRST_VALUE(date_day) OVER (PARTITION BY EXTRACT(year FROM date_day), EXTRACT(quarter FROM date_day) ORDER BY date_day) AS first_day_of_quarter,
            LAST_VALUE(date_day) OVER (PARTITION BY EXTRACT(year FROM date_day), EXTRACT(quarter FROM date_day) ORDER BY date_day)  AS last_day_of_quarter,
            LAST_VALUE(date_day) OVER (PARTITION BY EXTRACT(week FROM date_day) ORDER BY date_day)                                  AS last_day_of_week,
            (EXTRACT(year FROM date_day)
                      || '-Q'
                      || EXTRACT(quarter FROM date_day)) AS quarter_name,
            holiday.holiday_desc                         AS holiday_desc, (
            CASE
                      WHEN holiday.holiday_desc IS NULL THEN 0
                      ELSE 1
            END) AS is_holiday
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
