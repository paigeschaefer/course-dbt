--{%- set events = ['page_view', 'add_to_cart', 'checkout', 'package_shipped']%}
{%- set events = dbt_utils.get_column_values(
    table=ref('stg_postgres__events'),
    column='event_type')%}

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

session_events as ( 
    select events.event_id 
        , events.session_id 
        , events.user_id 
        , orders.order_id 
        , products.product_id
        , products.name
        {%- for event in events %}
            , sum(case when event_type = '{{ event }}' then 1 else 0 end) as {{ event }}
        {%- endfor %}
    from events
    left join orders 
        on events.order_id = orders.order_id
    left join order_items
        on orders.order_id = order_items.order_id
    left join products 
        on order_items.product_id = products.product_id
    group by 1,2,3,4,5,6)

select event_id 
    , session_id 
    , user_id 
    , page_view
    , add_to_cart
    , checkout
    , package_shipped
    , order_id 
    , product_id 
    , name 
from session_events