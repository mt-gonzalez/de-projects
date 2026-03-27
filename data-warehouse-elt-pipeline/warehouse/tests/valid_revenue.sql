SELECT *
FROM {{ ref('fct_revenue_daily') }}
WHERE revenue < 0
   OR orders < 0