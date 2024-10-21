# Week 2 Project Questions 

## Part 1. Models 

### What is our user repeat rate? 
#### Answer: 79.8%

```sql
  select sum(repeat_buyer_flag) / sum(buyer_flag) as user_repeat_rate
  from dev_db.dbt_ctbernardigmailcom.fact_user_orders;
```
### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
#### Answer 
Good indicators of is a user is likely to purchase again is users who made a purchase recently are more likely to return or  customers who have made multiple purchases in the past. Indicators of users who are likely NOT to purchase again is if significant time has passed since their last purchase or users who repeatedly abandon their carts without converting. 

### Explain the product mart models you added. Why did you organize the models in the way you did?
#### Answer
I added `product/fact_page_views.sql` to help us better understand the underlying data. 
## Part 2. Tests 

### What assumptions are you making about each model? (i.e. why are you adding each test?)
#### Answer
Each test I added tested the validity of the primary keys. 

### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
#### Answer
No "bad" data was found with tests.

## Part 3. Snapshots 

### Which products had their inventory change from week 1 to week 2? 
#### Answer
```sql
select * from dev_db.dbt_pschaeferbettercollectivecom.products_snapshot
where product_id in ('4cda01b9-62e2-46c5-830f-b7f262a58fb1','55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3'
            ,'be49171b-9f72-4fc9-bf7a-9a52e259836b','fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80')
order by product_id
```