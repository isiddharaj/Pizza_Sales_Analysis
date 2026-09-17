create database pizzahome;
use pizzahome;

create table orders
(
order_id int not null primary key,
order_date date not null,
order_time time not null
);

create table orders_details
(
order_details_id int not null primary key,
order_id int not null,
pizza_id text not null,
quantity int not null
);
select * from pizzas;
select * from pizza_types;
select * from orders;
select * from orders_details; 



-- 1]Retrieve the total number of orders placed.
select count(order_id) from orders as total_orders;  

-- 2]Calculate the total revenue generated from pizza sales.
select
sum(orders_details.quantity * pizzas.price) as total_sales
from orders_details join pizzas
on pizzas.pizza_id = orders_details.pizza_id ;

-- 3]Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id 
order by pizzas.price desc limit 1;

-- 4]Identify the most common pizza size ordered.
select pizzas.size, count(orders_details.order_details_id) as o
from pizzas join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size order by o desc limit 1;

-- 5]List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join orders_details 
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- Intermediate:
-- 6]Join the necessary tables to find the total quantity
-- of each pizza category category.
select pizza_types.category,sum(orders_details.quantity) as total_quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details 
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by total_quantity ;

-- 7]Determine the distribution of orders by hour of the day.
select hour(order_time) as hours, count(order_id) as total_order_count
from orders
group by hour(order_time);

-- 8]Join relevant tables to 
-- find the category-wise distribution of pizzas
select category, count(name) from pizza_types
group by pizza_types.category;

-- 9]Group the orders by date and 
-- calculate the number of pizzas ordered per day.

select orders.order_date ,sum(orders_details.quantity)
from orders join orders_details
on  orders.order_id = orders_details.order_id
group by order_date;

-- 10]Group the orders by date and 
-- calculate the average number of pizzas ordered per day.

select avg(quantity) as average_pizzas_order_per_day from
(select orders.order_date, sum(orders_details.quantity) as quantity
from orders join orders_details
on orders.order_id = orders_details.order_id
group by orders.order_date) as order_quantity;


-- 11]Determine the top 3 most ordered pizza types based on revenue
select pizza_types.name, sum(orders_details.quantity * pizzas.price) as Revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details 
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by Revenue desc limit 3; 

select * from pizzas;
select * from pizza_types;
select * from orders;
select * from orders_details; 

-- 12]Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select pizza_types.category, pizza_types.name, 
sum((orders_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name order by revenue desc limit 3;
