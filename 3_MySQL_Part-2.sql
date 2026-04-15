CREATE DATABASE IF NOT EXISTS prime;
USE prime;
CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(30), city VARCHAR(25));
INSERT INTO customers VALUES (1,'Alice','Mumbai'),(2,'Bob','Delhi'),(3,'Charlie','Bangalore'),(4,'David','Mumbai');
CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT, amount INT);
INSERT INTO orders VALUES (101,1,500),(102,1,900),(103,2,300),(104,5,700);
SELECT * FROM customers;
SELECT * FROM orders; 

-- -------------------------------------------------------------------------------------------------------------------------
-- JOINs in SQL (Set Operations)
-- JOINs are used to combine rows from two or more tables based on a related column between them.

-- INNER JOIN-: Only rows with matches in both tables.
SELECT * FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.customer_id,o.order_id,c.name,o.amount FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- LEFT JOIN / LEFT OUTER JOIN-: All rows from left + matches from right (else NULL)
SELECT * FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN / RIGHT OUTER JOIN-: All rows from right + matches from left (else NULL)
SELECT * FROM customers c RIGHT JOIN orders o ON c.customer_id=o.customer_id;

-- OUTER JOIN-: LEFT JOIN UNION RIGHT JOIN 
SELECT * FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT * FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- CROSS JOIN-: Every possible  combination of rows.
SELECT * FROM customers CROSS JOIN orders;

-- SELF JOIN-: It is a regular join but the table is joined with itself.
SELECT * FROM customers a JOIN customers b ON a.customer_id = b.customer_id;

-- LEFT EXCLUSIVE JOIN (A-B)
SELECT * FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id WHERE o.customer_id IS NULL;

-- RIGHT EXCLUSIVE JOIN (B-A)
SELECT * FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id WHERE c.customer_id IS NULL;

-- ---------------------------------------------------------------------------------------------------------
-- SUB-Queries in SQL
-- I. Inside WHERE (Finds all orders that are above average)
SELECT * FROM orders 
       WHERE amount > 
             (SELECT AVG(amount) FROM orders);

-- II. Inside SELECT (create a table of customer names with the total no of orders each person has placed)
SELECT name, 
      (SELECT COUNT(*) FROM orders o 
			WHERE o.customer_id = c.customer_id) as Order_Count 
                  FROM customers c;

-- III. Inside FROM (create a table of average amounts per customer)
SELECT summary.customer_id, summary.Avg_Amount 
       FROM (SELECT customer_id, 
             AVG(amount) AS Avg_Amount FROM orders
                        GROUP BY customer_id) AS summary;

-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- Views in SQL
-- A view is a virtual table based on the result-set of an SQL statement.
-- A view always shows up-to-date data. The database engine recreates the view, every time a user queries it.
-- We can also delete the View using DROP like tables.
CREATE VIEW view1 AS 
			SELECT customer_id,name FROM customers;
SELECT * FROM view1;
SELECT * FROM view1 WHERE name = 'Alice';
DROP VIEW view1;

-- View with JOIN
CREATE VIEW view2 AS
       SELECT c.customer_id, c.name, o.order_id, o.amount
              FROM customers c INNER JOIN orders o
                   ON c.customer_id = o.customer_id;
SELECT * FROM view2;
DROP VIEW view2;












