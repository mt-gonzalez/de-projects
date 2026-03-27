-- Date dimension table

SELECT 
    event_date,
    EXTRACT(YEAR FROM event_date) AS date_year PRIMARY KEY,
    EXTRACT(MONTH FROM event_date) AS date_month,
    EXTRACT(QUARTER FROM event_date) AS date_quarter,
    EXTRACT(WEEK FROM event_date) AS date_week,
    EXTRACT(DAY FROM event_date) AS date_day
FROM {{ ref('int_fct_events')}}
