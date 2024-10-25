with events as (
    select * from {{ ref('stg_postgres__events')}}
),

total_sessions as (
    select *
from events),

purchase_event_sessions as (
    select *
    from events
    where event_type = 'checkout')

select count(distinct purchase.session_id)/ count(distinct total.session_id) as conversion_ratio
from total_sessions total
left join purchase_event_sessions purchase on total.session_id = purchase.session_id