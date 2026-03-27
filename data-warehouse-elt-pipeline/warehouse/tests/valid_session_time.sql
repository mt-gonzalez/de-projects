SELECT *
FROM {{ ref('fct_session_performance') }}
WHERE avg_session_duration < 0