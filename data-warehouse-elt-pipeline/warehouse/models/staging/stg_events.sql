SELECT 
    CAST(event_time AS TIMESTAMP) AS event_timestamp,
    LOWER(event_type) AS event_type,
    CAST(product_id AS BIGINT) AS product_id,
    CAST(category_id AS BIGINT) AS category_id,
    COALESCE(category_code, 'unknown') AS category_code,
    LOWER(COALESCE(brand, 'no_brand')) AS brand,
    CAST(price AS NUMERIC) AS price,
    CAST(user_id AS BIGINT) AS user_id,
    user_session
FROM {{ source('raw', 'events') }}