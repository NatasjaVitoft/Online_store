ALTER TABLE orders ADD COLUMN customer_name VARCHAR(100);
ALTER TABLE orders ADD COLUMN customer_email VARCHAR(100);

UPDATE orders
SET customer_name = customers.name,
	customer_email = customers.email
FROM customers
WHERE orders.customer_id = customers.customer_id;