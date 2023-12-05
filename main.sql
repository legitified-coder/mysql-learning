# DON'T FORGET TO COMMENT OR DELETE EACH STEP AFTER YOU EXECUTE THEM.

# -- STEP 1 | 
SELECT * FROM sql_store.customers WHERE state IN ('VA', 'LA', 'CO', 'FL');

SELECT * FROM sql_inventory.products WHERE quantity_in_stock in (49, 38, 72);

SELECT * FROM sql_store.customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM sql_store.customers WHERE address LIKE '%Trail%' OR address LIKE '%Avenue%';
SELECT * FROM sql_store.customers WHERE phone LIKE '%9';

SELECT * FROM sql_store.customers WHERE first_name REGEXP 'Elka|Ambur';
SELECT * FROM sql_store.customers WHERE last_name REGEXP 'ey$|on$';
SELECT * FROM sql_store.customers WHERE last_name REGEXP '^my|se';
SELECT * FROM sql_store.customers WHERE last_name REGEXP 'b[ru]';


SELECT * FROM sql_store.orders WHERE shipped_date IS NULL;

SELECT *, quantity * unit_price AS total_price FROM sql_store.order_items WHERE order_id = 2 ORDER BY total_price DESC;

SELECT * FROM sql_store.customers ORDER BY points DESC LIMIT 3;

SELECT order_id, 
	   oi.product_id AS orders_product_id, 
	   p.product_id AS product_product_id, 
       p.name,
--        oi.unit_price AS orders_unit_price, 
--        p.unit_price AS product_unit_price, 
       quantity 
       FROM sql_store.order_items oi 
       JOIN sql_store.products p 
       ON oi.product_id = p.product_id;
       
USE sql_invoicing;

SELECT p.payment_id, 
	   p.client_id AS 'p client id', 
       c.name, p.amount, 
       pm.name AS payment 
       FROM payments p 
       JOIN clients c ON p.client_id = c.client_id
       JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;
       
SELECT p.product_id, p.name, oi.quantity 
	   FROM products p 
       LEFT JOIN order_items oi
       ON p.product_id = oi.product_id
       ORDER BY p.product_id;
       
SELECT o.order_date AS 'order date', o.order_id AS 'order id', c.first_name AS 'first name', 
	   sh.name AS shipper, os.name AS status
       FROM orders o
       JOIN customers c ON o.customer_id = c.customer_id
       LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id
       JOIN order_statuses os ON o.status = os.order_status_id;
       
SELECT p.date, c.name AS client, p.amount AS amount, pm.name AS name
	   FROM payments p 
       JOIN clients c USING (client_id)
       JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;
       
SELECT * FROM shippers sh, products p;
SELECT * FROM shippers sh CROSS JOIN products p;

SELECT customer_id, first_name, points, 'GOLD' 
       AS type FROM customers 
       WHERE points > 3000 UNION
SELECT customer_id, first_name, points, 'SILVER' 
	   AS type FROM customers 
       WHERE points >= 2000 AND points < 3000 UNION
SELECT customer_id, first_name, points, 'BRONZE' 
       AS type FROM customers 
       WHERE points < 2000 
       ORDER BY first_name;

INSERT INTO products 
	   VALUES (DEFAULT, 'Injera', 200, 1.5),
       (DEFAULT, 'SamSung TV', 15, 20.0),
       (DEFAULT, 'LG Fridge', 12, 35.9);
       
CREATE TABLE invoices_archived AS
SELECT c.client_id, c.name, i.invoice_total, i.payment_total, i.payment_date 
	   FROM invoices i 
       JOIN clients c 
       USING (client_id) 
       WHERE i.payment_date IS NOT NULL;
       
UPDATE customers 
	   SET points = points + 50
       WHERE birth_date < '1990-01-01';
       
UPDATE orders
	   SET comments = '!! GOLDEN CUSTOMER !!'
       WHERE customer_id IN (SELECT customer_id FROM customers WHERE points >= 3000);

# I hope you found this helpful❤

# Stay Awake
#legitified✔
