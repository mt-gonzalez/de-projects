-- Fact Session Table, grain: 1 session = 1 row

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'user_id',
        'user_session'
    ]) }} AS session_id,
    user_id,
    user_session,
    COUNT(*) FILTER (WHERE event_type IN ('view', 'cart', 'purchase')) AS view_count,
    COUNT(*) FILTER (WHERE event_type IN ('cart', 'purchase')) AS cart_count,
    COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchase_count,
    SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS revenue_per_session,
    MIN(event_timestamp) AS session_start,
    MAX(event_timestamp) AS session_end,
    MIN(event_date) AS session_start_date,
    MAX(event_date) AS session_end_date,
    GREATEST(EXTRACT(EPOCH FROM(MAX(event_timestamp) - MIN(event_timestamp))), 0) AS duration
FROM {{ ref('int_events')}}
GROUP BY user_id, user_session