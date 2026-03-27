SELECT *
FROM {{ ref('int_sessions') }}
WHERE session_end < session_start