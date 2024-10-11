# Project 1 Answers

How many users do we have?
	130 
	
	select count(*) 
	from dev_db.dbt_pschaeferbettercollectivecom.stg_postgres__users
	
On average, how many orders do we receive per hour?
	15.041667

	with hourly_orders as (
        select EXTRACT(HOUR from created_at) as 	order_hour
            ,COUNT(order_id) as order_count
        from dev_db.dbt_pschaeferbettercollectivecom.stg_postgres__orders
        group by 1)

    select avg(order_count) as avg_orders_per_hour
    from hourly_orders;

On average, how long does an order take from being placed to being delivered?
	93.403278688611

	select AVG(DATEDIFF('second', created_at, delivered_at)) / 3600 as avg_delivery_time_hours
    from dev_db.dbt_pschaeferbettercollectivecom.stg_postgres__orders
    where delivered_at is not NULL

How many users have only made one purchase? Two purchases? Three+ purchases?
    One purchase: 25
    Two purchases: 28 
    Three purchases: 34

    select purchase_count
        , COUNT(user_id) as num_users
    from (select user_id
          , COUNT(order_id) as purchase_count
        from dev_db.dbt_pschaeferbettercollectivecom.stg_postgres__orders
        group by user_id ) as user_purchase_counts
    group by purchase_count
    order by purchase_count;

On average, how many unique sessions do we have per hour?
	39.458333 

	with hourly_sessions as (
        select extract(hour from created_at) as event_hour
            , count(distinct session_id) as unique_sessions
        from dev_db.dbt_pschaeferbettercollectivecom.stg_postgres__events
        group by extract(hour FROM created_at)
    )
    
    select AVG(unique_sessions) as avg_unique_sessions_per_hour
    from hourly_sessions;