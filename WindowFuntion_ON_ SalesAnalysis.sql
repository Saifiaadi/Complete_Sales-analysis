use sales_analysis;
-- 1. row_number() – assign order to each sale per rep
select 
    rep_id,
    order_id,
    order_date,
    amount,
    row_number() over ( partition by rep_id order by order_date ) as sale_rank
from sales_orders;

-- 2. rank() – rank customers by their total spending
select 
    cust_id,
    sum(amount) as total_spent,
    rank() over (order by sum(amount) desc) as spending_rank
from sales_orders
group by cust_id;

-- 3. dense_rank() – like rank, but no skipped numbers

select 
    cust_id,
    sum(amount) as total_spent,
    dense_rank() over (order by sum(amount) desc) as dense_spending_rank
from sales_orders
group by cust_id;


-- 4. lag() / lead() – compare current order with previous/next one

select 
    cust_id,
    order_id,
    order_date,
    amount,
    lag(amount) over (partition by cust_id order by order_date) as previous_order,
    lead(amount) over (partition by cust_id order by order_date) as next_order
from sales_orders;



-- 5. sum() over() – running total per rep

select 
    rep_id,
    order_date,
    amount,
    sum(amount) over (partition by rep_id order by order_date) as running_sales
from sales_orders;


-- 6. ntile(4) – divide sales into quartiles

select 
    order_id,
    amount,
    ntile(4) over (order by amount desc) as sales_quartile
from sales_orders;

-- 1. Get customers who placed the maximum order amount
select cust_id, amount, order_id
from sales_orders
where amount = (select max(amount) from sales_orders);


 -- 2. Find customers who placed more than 2 orders
 select * from customers
 where cust_id in (
 select cust_id
 from sales_orders 
 group by cust_id
 having count(order_id) >2);
 
 
  -- 3. Show orders above average amount 
  select * from sales_orders
  where amount > (
  select avg(amount) from sales_orders);
  
  
  -- 4. Get top 3 customers by total purchase (using subquery + limit)
  
  select cust_id, total_spent
from (
  select cust_id, sum(amount) as total_spent
  from sales_orders
  group by cust_id
  order by total_spent desc
  limit 3
) as top_customers;
 
 