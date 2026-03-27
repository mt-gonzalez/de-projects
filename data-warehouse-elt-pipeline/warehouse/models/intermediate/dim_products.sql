SELECT
    product_id,
    
    -- We need this columns to be in a group by clause or on an aggregate function or postgresql will fail
    MIN(brand) AS brand,
    MIN(category_id) AS category_id,
    MIN(category_code) AS category_code
FROM {{ ref('int_events') }}
GROUP BY product_id