-- This table is ready for consultation - Made for Marketing/Growth teams

SELECT
    event_date,
    COUNT(DISTINCT user_id) AS total_visitors,
    COUNT(DISTINCT user_id) FILTER (WHERE view_count > 0) AS users_viewed,
    COUNT(DISTINCT user_id) FILTER (WHERE cart_count > 0) AS users_carted,
    COUNT(DISTINCT user_id) FILTER (WHERE purchase_count > 0) AS users_purchased,
    ROUND(
        COUNT(DISTINCT user_id) FILTER (WHERE cart_count > 0) * 100.0 / 
        NULLIF(COUNT(DISTINCT user_id) FILTER (WHERE view_count > 0), 0), 2
    ) AS view_to_cart_pct,
    ROUND(
        COUNT(DISTINCT user_id) FILTER (WHERE purchase_count > 0) * 100.0 / 
        NULLIF(COUNT(DISTINCT user_id) FILTER (WHERE cart_count > 0), 0), 2
    ) AS cart_to_purchase_pct

FROM {{ ref('int_user_daily_activity') }}
GROUP BY event_date
ORDER BY event_date DESC