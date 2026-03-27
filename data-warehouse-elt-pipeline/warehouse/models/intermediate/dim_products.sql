SELECT
    product_id,
    brand,
    category_id,
    category_code,
    price
FROM {{ ref('int_events') }}
GROUP BY product_id