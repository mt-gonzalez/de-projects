-- Sessions dimension table/view

SELECT
    session_id,
    user_id,
    user_session,
    MIN(event_timestamp) AS session_start,
    MAX(event_timestamp) AS session_end,
    MIN(event_date) AS session_start_date,
    MAX(event_date) AS session_end_date,
    (MAX(session_start) - MIN(session_end)) AS duration
FROM {{ ref('int_fct_events')}}
GROUP BY session_id

