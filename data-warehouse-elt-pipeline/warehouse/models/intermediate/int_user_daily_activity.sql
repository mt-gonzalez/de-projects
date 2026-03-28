-- User Daily Activity table, grain: user_id + date = 1 row

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'user_id',
        'event_date'
    ]) }} AS usr_daily_act_id,
    user_id,
    event_date,
    COUNT(*) AS events_count,
    COUNT(*) FILTER (WHERE event_type IN ('view', 'cart', 'purchase')) AS view_count,
    COUNT(*) FILTER (WHERE event_type IN ('cart', 'purchase')) AS cart_count,
    COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchase_count,
    SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS revenue

FROM {{ ref('stg_events') }}
GROUP BY user_id, event_date