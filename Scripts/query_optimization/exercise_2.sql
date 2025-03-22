EXPLAIN ANALYZE
SELECT o.order_id, o.total_amount, c.name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.order_date > '2023-01-01';

CREATE INDEX idx_orders_order_date ON Orders(order_date);

