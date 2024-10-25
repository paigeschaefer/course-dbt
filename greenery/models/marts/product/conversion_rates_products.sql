with events as (
    select *
    from {{ ref('stg_postgres__events')}}
), 

orders as (
    select *
    from {{ ref('stg_postgres__orders')}} 
),

order_items as (
    select *
    from {{ ref('stg_postgres__order_items')}} 
),

products as (
    select *
    from {{ ref('stg_postgres__products')}} 
),

total_sessions as (
    select count(distinct events.session_id) as total_sessions
        , products.name
    from events
    left join products on events.product_id = products.product_id
    group by products.name), 

purchase_sessions as (
    select count(distinct events.session_id) as purchase_sessions
        , products.name
    from events
    left join orders on events.order_id = orders.order_id
    left join order_items on orders.order_id = order_items.order_id
    left join products on order_items.product_id = products.product_id
    where event_type = 'checkout'
    group by products.name)

select purchase.purchase_sessions/ total.total_sessions as conversion_ratio
    , purchase.name 
from total_sessions total
left join purchase_sessions purchase on total.name = purchase.name