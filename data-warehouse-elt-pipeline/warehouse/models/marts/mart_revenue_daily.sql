-- Table ready to serve to Finance teams and Stakeholders

SELECT
    event_date,
    SUM(revenue) AS revenue,
    SUM(purchase_count) AS orders,
    ROUND(
        (SUM(revenue)::NUMERIC / NULLIF(SUM(purchase_count), 0)), 2
    ) AS avg_order_value,
    ROUND(
        (SUM(revenue)::NUMERIC / NULLIF(COUNT(DISTINCT user_id), 0)), 2
    ) AS rev_per_user
FROM {{ ref('int_user_daily_activity') }}
GROUP BY event_date
ORDER BY event_date DESC