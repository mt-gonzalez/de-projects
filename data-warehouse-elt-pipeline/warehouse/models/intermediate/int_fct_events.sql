-- Events Fact Table; grain: 1 event = 1 row

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'user_id',
        'user_session',
        'event_timestamp',
        'event_type',
        'product_id'
    ]) }} AS event_id,
    user_id,
    user_session,
    event_timestamp,
    CAST(event_timestamp AS DATE) AS event_date,
    product_id,
    category_code,
    brand,
    event_type,
    CASE WHEN event_type='view' THEN 1 ELSE 0 END AS is_view,
    CASE WHEN event_type='cart' THEN 1 ELSE 0 END AS is_cart,
    CASE WHEN event_type='purchase' THEN 1 ELSE 0 END AS is_purchase,
    price,
    CASE WHEN event_type='purchase' THEN price ELSE 0 END AS revenue
FROM {{ ref('stg_events') }}