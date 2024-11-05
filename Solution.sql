-- BASIC QUES-- 

-- Retrieve the total number of orders placed.-- 
select count(order_id) as total_order from orders;

-- Calculate the total revenue(total sales) generated from pizza sales.--
select
round(sum(order_details.quantity * pizzas.price),2) as total_revenue
from order_details 
join pizzas 
on order_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.--
select pizza_types.name, pizzas.price from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc
limit 1; 

-- Another querry for same output-- 

select pizza_types.name,
max(pizzas.price) from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name
order by max(pizzas.price) desc
limit 1;


-- Identify the most common pizza size ordered.-- 
select pizzas.size,
count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc
limit 1;


-- List the top 5 most ordered pizza types along with their quantities.--
select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by quantity desc
limit 5;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- INTERMEDIATE QUES-- 

-- Join the necessary tables to find the total quantity of each pizza category ordered-- 
select pizza_types.category,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category;


-- Determine the distribution of orders by hour of the day--
select hour(order_time) as hours,
count(order_id) as no_of_order
from orders
group by hours
order by hours asc; 


-- Join relevant tables to find the category-wise distribution of pizzas.-- 
select category, count(name) from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.--
select round(avg(quantity),0) from 
(select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue--
select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by revenue desc 
limit 3;
 
 ----------------------------------------------------------------------------------------------------------------------------------------
 
 -- ADVANCED QUES--
 
 -- Calculate the percentage contribution of each pizza type to total revenue--
 SELECT pizza_types.category,
 -- total revenue(%) = (revenue of single category/total revenue) * 100 
	round((sum(order_details.quantity*pizzas.price)/ 
    (select round(sum(order_details.quantity * pizzas.price),2) as total_revenue
		from order_details 
		join pizzas 
		on order_details.pizza_id = pizzas.pizza_id ) *100),2) as revenue
 from pizza_types join pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
 join order_details
 on pizzas.pizza_id = order_details.pizza_id
 group by pizza_types.category;
 
