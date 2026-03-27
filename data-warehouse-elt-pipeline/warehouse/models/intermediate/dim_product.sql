-- Products dimension table/view

SELECT
    product_id,
    brand,
    category_id,
    category_code,
    price
FROM {{ ref('int_fct_events')}}