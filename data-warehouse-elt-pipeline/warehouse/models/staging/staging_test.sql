-- staging model simple
select *
from {{ source('raw', 'events') }}
limit 100