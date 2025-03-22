EXPLAIN SELECT o.order_id, o.total_amount, c.name AS customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 100;