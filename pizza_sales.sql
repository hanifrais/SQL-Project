--1. Total Revenue
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

-- 2. Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;

--3. Total Pizzas Sold
SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales;

--4. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

--5. Average Pizzas Per Order
SELECT ROUND(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order
FROM pizza_sales;

--6. Daily Trend for Total Orders
SELECT TO_CHAR(order_date, 'Day') AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day');

--7. Hourly Trend for Orders
SELECT EXTRACT(HOUR FROM order_time) AS order_hours, 
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hours;

--8. Weekly Trend for Orders
SELECT 
    EXTRACT(WEEK FROM order_date) AS week_number,
    EXTRACT(YEAR FROM order_date) AS order_year, 
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    week_number, order_year
ORDER BY 
    week_number, order_year ;


--9. % of Sales by Pizza Category
SELECT pizza_category, 
       ROUND(CAST(SUM(total_price) AS NUMERIC), 2) AS total_revenue,
       ROUND(CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS NUMERIC), 2) AS pct
FROM pizza_sales
GROUP BY pizza_category;

--10. % of Sales by Pizza Size
SELECT pizza_size, 
       ROUND(CAST(SUM(total_price) AS NUMERIC), 2) AS total_revenue,
       ROUND(CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS NUMERIC), 2) AS pct
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


--11. Total Pizzas Sold by Pizza Category (February Only)
SELECT pizza_category, 
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

--12. Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name, 
       SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;

--13. Bottom 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name, 
       SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;