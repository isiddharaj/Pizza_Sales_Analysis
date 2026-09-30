
-- Calculate the total revenue generated from pizza sales.

select
sum(orders_details.quantity * pizzas.price) as total_sales
from orders_details join pizzas
on pizzas.pizza_id = orders_details.pizza_id ;