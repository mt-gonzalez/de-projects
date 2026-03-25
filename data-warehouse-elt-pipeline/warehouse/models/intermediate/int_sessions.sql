SELECT
    user_id,
    user_session,

    MIN(event_time) AS session_start,
    MAX(event_time) AS session_end,

    COUNT(*) AS events_count,
    SUM(price) AS total_spent
FROM {{ ref('stg_events') }}
GROUP BY user_id, user_session