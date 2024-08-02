Create database Pizza_Sales;
Use Pizza_Sales;


Show tables;

Create table orders(order_id int,order_date date,order_time time);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from order_details;  -- order_details_id	order_id	pizza_id	quantity

select * from pizzas; -- pizza_id, pizza_type_id, size, price

select * from orders;  -- order_id, date, time

select * from pizza_types;  -- pizza_type_id, name, category, ingredients

-- Retrieve the total number of orders placed

Select Count(distinct order_id) As "Total Orders" from orders;

-- Calculate the total revenue generated from pizza sales.

Select round(sum((order_details.quantity * price)),2) as 'Total  Revenue' 
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza using TOP/Limit functions

Select pizza_types.name as pizza_name,pizzas.price from pizzas
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id 
order by pizzas.price desc Limit 1;

-- Alternative (using window function) - without using TOP function

with cte as (
select pizza_types.name as pizza_name, pizzas.price,
rank() over (order by price desc) as rnk
from pizzas
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
)

select pizza_name , price from cte where rnk = 1;

-- Identify the most common pizza size ordered.

select pizzas.size, count(order_details_id) as 'No of Orders'
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by count(distinct order_id) desc limit 1;

-- List the top 5 most ordered pizza types along with their quantities.


select pizza_types.name as 'Pizza', sum(quantity) as 'Total Ordered'
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name 
order by sum(quantity) desc limit 5;

-- Find the total quantity of each pizza category ordered
-- (this will help us to understand the category which customers prefer the most).

Select pizza_types.category,sum(quantity) as Quantity
from pizza_types join pizzas on 
pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by Quantity desc;

-- Determine the distribution of orders by hour of the day.

Select hour(order_time) as 'Hour',count(distinct order_id) order_count from orders
group by hour(order_time)
order by order_count desc;

-- find the category-wise distribution of pizzas

select category, count(name) as 'No of pizzas'
from pizza_types
group by category
order by 'No of pizzas' desc;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

with cte as(
select orders.order_date as 'Date', sum(order_details.quantity) as Total_Pizza_Ordered
from order_details
join orders on order_details.order_id = orders.order_id
group by orders.order_date
)
select round(avg(Total_Pizza_Ordered),0) as 'Avg Number of pizzas ordered per day'  from cte;

-- Same Using Subquery
select round(avg(Quantity),0) as 'Avg pizzas ordered per day' from	
(select order_date ,sum(order_details.quantity) as Quantity from
orders join order_details on order_details.order_id = orders.order_id
group by order_date) as Order_Quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,sum(order_details.quantity * pizzas.price) as revenue from	
pizza_types  join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id join
order_details on  order_details.pizza_id = pizzas.pizza_id 
group by pizza_types.name 
order by revenue desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenues

Select pizza_types.category,round(sum(order_details.quantity * pizzas.price)/
(Select round(sum(order_details.quantity * pizzas.price),2) from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id) * 100,2) as Total_revenue_pct from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on  order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by Total_revenue_pct desc;

-- Analyze the cumulative revenue generated over time.

Select order_date, sum(revenue) over (order by order_date) as Cum_revenue from
(Select orders.order_date,sum(order_details.quantity * pizzas.price) as revenue from orders
join order_details on orders.order_id = order_details.order_id
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by orders.order_date) as sales;


-- Same using cte
with cte as (
select order_date, cast(sum(quantity*price) as decimal(10,2)) as Revenue
from order_details 
join orders on order_details.order_id = orders.order_id
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by order_date
)
select order_date, Revenue, sum(Revenue) over (order by order_date) as 'Cumulative Sum'
from cte 
group by order_date, Revenue;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

Select category,name,revenue,rnk from(
Select category,name,revenue, rank() over (partition by category order by revenue desc) as rnk from
(Select pizza_types.category,pizza_types.name,
sum((order_details.quantity) * pizzas.price) as revenue 
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on
order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where rnk<=3;



