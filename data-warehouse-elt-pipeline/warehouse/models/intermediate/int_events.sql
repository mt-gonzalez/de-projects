-- Events Fact Table; grain: 1 event = 1 row

WITH deduplicate AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY 
                user_id,
                user_session,
                event_timestamp,
                event_type,
                product_id
            ORDER BY event_timestamp
        ) AS row_number
    FROM {{ ref('stg_events')}}
),

clean_stg_events AS (
    SELECT *
    FROM deduplicate
    WHERE row_number = 1
)

-- I found running the tests for this model that exists 629 duplicated rows, so first we apply deduplication to the view

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
    category_id,
    category_code,
    brand,
    event_type,
    price
FROM clean_stg_events