SELECT *
FROM {{ ref('mart_funnel_daily') }}
WHERE users_purchased > users_carted
   OR users_carted > users_viewed