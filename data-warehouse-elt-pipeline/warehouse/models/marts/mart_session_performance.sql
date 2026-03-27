-- This table is designed to serve data to Data Analysts and Designers teams

SELECT
    session_start_date,
    COUNT(*) AS sessions,
    SUM(CASE WHEN purchase_count > 0 THEN 1 ELSE 0 END) AS sessions_with_purchase,
    AVG(duration) AS avg_session_duration,
    SUM(revenue_per_session) AS revenue,
    AVG(revenue_per_session) AS revenue_per_session
FROM {{ ref('int_sessions') }}
GROUP BY session_start_date