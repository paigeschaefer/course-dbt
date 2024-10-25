# Week 3 Project Questions

## Part 1: Create new models to answer the first two questions

### Question: What is our overall conversion rate?

### Answer: 62% 

##### QUERY
```sql
select * 
from dev_db.dbt_pschaeferbettercollectivecom.conversion_rate;
```

### Question: What is our conversion rate by product?

### Answer: 

| CONVERSION_RATIO | NAME                |
|------------------|---------------------|
| 0.453333         | Orchid              |
| 0.4              | Ponytail Palm       |
| 0.418919         | Pink Anthurium      |
| 0.537313         | Bamboo              |
| 0.474576         | Spider Plant        |
| 0.423077         | Birds Nest Fern     |
| 0.344262         | Pothos              |
| 0.426471         | Ficus               |
| 0.492537         | Majesty Palm        |
| 0.39726          | Snake Plant         |
| 0.483871         | Philodendron        |
| 0.545455         | Cactus              |
| 0.474576         | Pilea Peperomioides |
| 0.464286         | Money Tree          |
| 0.409091         | Peace Lily          |
| 0.510204         | Monstera            |
| 0.509434         | Calathea Makoyana   |
| 0.411765         | Alocasia Polly      |
| 0.539683         | ZZ Plant            |
| 0.478261         | Jade Plant          |
| 0.412698         | Boston Fern         |
| 0.393443         | Angel Wings Begonia |
| 0.555556         | Arrow Head          |
| 0.45             | Bird of Paradise    |
| 0.467742         | Dragon Tree         |
| 0.5              | Fiddle Leaf Fig     |
| 0.492308         | Aloe Vera           |
| 0.518519         | Rubber Plant        |
| 0.609375         | String of Pearls    |
| 0.488889         | Devil's Ivy         |


##### QUERY
```sql
select * 
from dev_db.dbt_pschaeferbettercollectivecom.conversion_rates_product;
```

## Part 6. dbt Snapshots

### Question: Which products had their inventory change from week 2 to week 3? 

### Answer: The following products had their inventory change from week 2 to week 3:

| NAME             | INVENTORY | DBT_UPDATED_AT | DBT_VALID_FROM | DBT_VALID_TO |
|------------------|-----------|----------------|----------------|--------------|
| Monstera         | 64        | 38:02.1        | 38:02.1        | 10:04.9      |
| Monstera         | 77        | 03:33.0        | 03:33.0        | 38:02.1      |
| Philodendron     | 25        | 38:02.1        | 38:02.1        | 10:04.9      |
| Philodendron     | 51        | 03:33.0        | 03:33.0        | 38:02.1      |
| Pothos           | 20        | 38:02.1        | 38:02.1        | 10:04.9      |
| Pothos           | 40        | 03:33.0        | 03:33.0        | 38:02.1      |
| String of pearls | 10        | 38:02.1        | 38:02.1        | 10:04.9      |
| String of pearls | 58        | 03:33.0        | 03:33.0        | 38:02.1      |



##### QUERY
```sql
with total as (
select * 
from dev_db.dbt_pschaeferbettercollectivecom.products_snapshot
where dbt_valid_to is not null)

select name
    , price
    , inventory
from total
where product_id  in (
    select product_id
    from total
    group by product_id
    having count(*) > 1)
order by name;
```