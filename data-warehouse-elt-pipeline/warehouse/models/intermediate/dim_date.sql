-- Date dimension table
{{ config(materialized='table') }}

WITH dates_raw AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="CAST('2020-09-24' AS DATE)",
        end_date="CAST('2021-03-01' AS DATE)"
    )
    }}
)
SELECT
    date_day AS date,
    EXTRACT(YEAR FROM date_day) AS date_year,
    EXTRACT(MONTH FROM date_day) AS date_month,
    EXTRACT(QUARTER FROM date_day) AS date_quarter,
    EXTRACT(WEEK FROM date_day) AS date_week,
    EXTRACT(DAY FROM date_day) AS day_of_month,
    CASE WHEN EXTRACT(DOW FROM date_day) IN (0,6) THEN true ELSE false END AS is_weekend
FROM dates_raw
