SELECT
    product_id,
    brand,
    category_id,
    category_code,
    price
FROM {{ ref('fct_events') }}
GROUP BY product_id