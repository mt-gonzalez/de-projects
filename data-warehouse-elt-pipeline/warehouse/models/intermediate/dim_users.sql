SELECT
    user_id,
    MIN(event_date) AS first_seen_date,
    MAX(event_date) AS last_seen_date
FROM {{ ref('int_events') }}
GROUP BY user_id