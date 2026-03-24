-- staging model simple
select
    event_id,
    user_id,
    event_type,
    event_timestamp::timestamp as event_ts
from raw.events