# SELECT Statement
-- Display all products.
SELECT* FROM products;
-- Display all orders.
SELECT* FROM orders;
-- Display all customers
SELECT* FROM customers;

# WHERE Clause
-- Show all delivered orders
SELECT* FROM orders
WHERE order_status= 'delivered';

-- Order quantity greater than 2
SELECT * FROM orders
WHERE quantity >2;

-- Customers from Delhi
SELECT* FROM customers 
WHERE city ='Delhi';

# ORDER BY
-- Products sorted by highest price.
SELECT * FROM products
ORDER BY price DESC;

-- Orders sorted by latest date.
SELECT* FROM orders 
ORDER BY order_date DESC;

# GROUP BY
-- Total orders by payment method.
SELECT payment_method,
COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method;

-- Customers in each city
SELECT city ,
COUNT(*) AS total_customers
FROM customers
GROUP BY city;

# Aggregate Functions
-- Total sales.
SELECT SUM(total_amount) AS REVENUE
FROM orders;

-- Average order value.
SELECT AVG(total_amount) AS average_order_value
FROM orders;

-- Maximum order amount.
SELECT MAX(total_amount) AS highest_order
FROM orders;

# INNER JOIN
-- Customer Name with Order Details
SELECT
c.customer_name,
o.order_id,
o.total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- Product Name with Order Details
SELECT p.product_name, o.order_id, o.total_amount
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id;

# LEFT JOIN
-- Show all customers with their orders
SELECT
c.customer_name,
o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

# RIGHT JOIN

-- Show all orders with customer names
SELECT
c.customer_name,
o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;


# Subqueries
-- Products priced above average
SELECT *
FROM products
WHERE price >
(
SELECT AVG(price)
FROM products
);

-- Customers who placed orders above average order amount
SELECT customer_name
FROM customers
WHERE customer_id IN
(
SELECT customer_id
FROM orders
WHERE total_amount >
(
SELECT AVG(total_amount)
FROM orders
)
);

# Views
-- Create Sales View
CREATE VIEW sales_summary AS

SELECT
o.order_id,
c.customer_name,
p.product_name,
o.total_amount

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

JOIN products p
ON o.product_id = p.product_id;

# Display View
SELECT *
FROM sales_summary;

# Indexes
-- Create Index on Customer ID
CREATE INDEX idx_customer
ON orders(customer_id);
-- Create Index on Product ID
CREATE INDEX idx_product
ON orders(product_id);
