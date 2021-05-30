WITH source AS (
    SELECT TO_CHAR(date_day, 'YYYYMMDD') AS date_day_char,t.* FROM
    {{ ref('calendar_date') }} t
), transformed AS (
    SELECT

        {{ dbt_utils.surrogate_key(['date_day_char']) }} AS dim_date_id,
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
        is_holiday,
        {{ audit_columns(
            model_created_by="",
            model_updated_by="",
            model_created_at="2021-01-01",
            model_updated_at="2021-01-01"
            )
        }}
    FROM source
)

SELECT * FROM transformed
