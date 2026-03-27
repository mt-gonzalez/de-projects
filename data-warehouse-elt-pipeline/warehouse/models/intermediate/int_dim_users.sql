-- Users dimension table/view, in this case we only have user_id

SELECT 
    user_id
FROM {{ ref('int_fct_events') }}