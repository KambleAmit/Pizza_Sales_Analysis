# Pizza_Sales_Analysis

## Table of contents:
   - [Project Overview](#project-overview)
   - [Use Case](#use-case)
   - [Queries](#queries)
   - [Tools](#tools)
   - [Conclusion](#conclusion)
## Project Overview:

This SQL project revolves around a database schema designed to manage and analyze data for a pizza store.The database consists of four primary tables: order_details, pizzas, orders, and pizza_types.
Each table plays a crucial role in storing different facets of the business operations, from individual orders to the types of pizzas offered. Below is a detailed description of each table and its columns:

1. order_details:
   - order_details_id: A unique identifier for each entry in the order details.
   - order_id: References the ID from the orders table, linking the order detail to a specific order.
   - pizza_id: References the ID from the pizzas table, identifying which pizza was ordered.
   - quantity: The number of pizzas ordered of the specified type.

2. pizzas:
   - pizza_id: A unique identifier for each type of pizza available.
   - pizza_type_id: Links to the pizza_types table, specifying the type of pizza.
   - size: The size of the pizza (e.g., small, medium, large).
   - price: The cost of the pizza.

3. orders:
   - order_id: A unique identifier for each order placed.
   - date: The date on which the order was placed.
   - time: The time at which the order was placed.

4. pizza_types:
   - pizza_type_id: A unique identifier for each type of pizza.
   - name: The name of the pizza type (e.g., Margherita, Pepperoni).
   - category: Categorizes the pizza (e.g., Vegetarian, Non-Vegetarian).
   - ingredients: Lists the ingredients used in the pizza.
  
## Use Case:
A pizza sales store manager can utilize this SQL project to extract valuable insights and conduct detailed data analysis, facilitating informed decision-making and efficient management of the store's operations. Here are a few points illustrating the importance and utility of this database for a store manager:

- Sales Analysis: By querying the order_details and pizzas tables, managers can identify the best-selling pizzas, assess revenue from different pizza sizes, and evaluate pricing strategies.
- Inventory Management: Analyzing the pizza_types and their ingredients helps in managing inventory more efficiently, ensuring that ingredients are stocked according to demand and reducing waste.
- Customer Preferences: Through data gathered in the orders and pizzas tables, managers can track customer preferences over time, adjusting the menu to cater to popular choices and experimenting with new or seasonal offerings.
- Operational Efficiency: Date and time data from the orders table allow managers to assess peak hours and staff the store appropriately, ensuring operational efficiency and customer satisfaction.
- Marketing Insights: Data analysis can also support targeted marketing campaigns, like promotions on specific types of pizzas that are popular or on days when sales are typically lower.


# Queries
Basic:
- Retrieve the total number of orders placed.
- Calculate the total revenue generated from pizza sales.
- Identify the highest-priced pizza.
- Identify the most common pizza size ordered.
- List the top 5 most ordered pizza types along with their quantities.

Intermediate:
- Find the total quantity of each pizza category ordered (this will help us to understand the category which customers prefer the most).
- Determine the distribution of orders by hour of the day (at which time the orders are maximum (for inventory management and resource allocation).
- Find the category-wise distribution of pizzas (to understand customer behaviour).
- Group the orders by date and calculate the average number of pizzas ordered per day.
- Determine the top 3 most ordered pizza types based on revenue (let's see the revenue wise pizza orders to understand from sales perspective which pizza is the best selling)

Advanced:
- Calculate the percentage contribution of each pizza type to total revenue (to understand % of contribution of each pizza in the total revenue)
- Analyze the cumulative revenue generated over time.
- Determine the top 3 most ordered pizza types based on revenue for each pizza category (In each category which pizza is the most selling)

## Tools:
MySQL

## Conclusion:

This SQL project not only serves as a robust data management system but also as a strategic tool for business intelligence. By maintaining comprehensive data on every aspect of the store's operations, the database allows store managers to make precise adjustments to improve both customer experience and profitability.
   
