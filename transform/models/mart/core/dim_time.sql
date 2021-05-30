WITH source AS (
    SELECT * FROM
    {{ ref('calendar_time') }}
), transformed AS (
    SELECT

        {{ dbt_utils.surrogate_key(['time_of_day']) }} AS dim_time_id,
        time_of_day,
        hour,
        minute,
        second,
        quarter_hour,
        am_pm,
        day_night,
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

