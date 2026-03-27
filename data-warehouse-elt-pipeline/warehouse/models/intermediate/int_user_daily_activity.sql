-- User Daily Activity table, grain: user_id + date = 1 row

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'user_id',
        'event_date'
    ]) }} AS usr_daily_act_id,
    user_id,
    event_date,
    count(*) AS events_count,
    count(*) FILTER (where event_type = 'view') AS views,
    count(*) FILTER (where event_type = 'cart') AS carts,
    count(*) FILTER (where event_type = 'purchase') AS purchases,
    sum(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS revenue

FROM {{ ref('stg_events') }}
GROUP BY user_id, event_date