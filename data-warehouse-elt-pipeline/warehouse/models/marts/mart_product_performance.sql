-- Table ready to serve data to Product Managers/Teams and Marketing performance

SELECT
    e.product_id,
    e.event_date,
    p.brand,
    p.category_code,
    COUNT(*) FILTER (WHERE e.event_type = 'view') AS views,
    COUNT(*) FILTER (WHERE e.event_type = 'cart') AS carts,
    COUNT(*) FILTER (WHERE e.event_type = 'purchase') AS purchases,
    SUM(CASE WHEN e.event_type = 'purchase' THEN e.price ELSE 0 END) AS revenue
FROM {{ ref('int_events') }} e
LEFT JOIN {{ ref('dim_products') }} p
    ON e.product_id = p.product_id
GROUP BY e.product_id, e.event_date, p.brand, p.category_code