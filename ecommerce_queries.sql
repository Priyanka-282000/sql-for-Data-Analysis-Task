-- Query 1: Orders after 2018-01-01
SELECT * FROM orders
WHERE order_purchase_timestamp > '2018-01-01'
ORDER BY order_purchase_timestamp DESC
LIMIT 10;

-- Query 2: Count of orders by status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Query 3: Orders with customer state
SELECT o.order_id, o.order_purchase_timestamp, c.customer_state
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LIMIT 10;

-- Query 4: Average, Minimum, and Maximum Payment per Payment Type
SELECT 
  payment_type, 
  AVG(payment_value) AS avg_payment,
  MIN(payment_value) AS min_payment,
  MAX(payment_value) AS max_payment
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment DESC;

-- Query 5: Payments above average
SELECT * FROM order_payments
WHERE payment_value > (
  SELECT AVG(payment_value) FROM order_payments
)
LIMIT 10;

--Query 6: Payment Summary by Payment Type
SELECT 
  payment_type,
  COUNT(*) AS total_transactions,
  AVG(payment_value) AS avg_payment,
  MIN(payment_value) AS min_payment,
  MAX(payment_value) AS max_payment
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment DESC;



--CREATE an index on customer_id in orders
CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX IF NOT EXISTS idx_payment_type
ON order_payments(payment_type);