
-- DROP existing tables to start fresh
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;

-- 1️⃣ CREATE CUSTOMERS table
CREATE TABLE CUSTOMERS (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(20),
    address VARCHAR2(200)
);

-- 2️⃣ INSERT into CUSTOMERS
INSERT INTO CUSTOMERS VALUES (1, 'Alice Johnson', 'alice.johnson@example.com', '9876543210', '123 Green St, Delhi');
INSERT INTO CUSTOMERS VALUES (2, 'Bob Smith', 'bob.smith@example.com', '9876543211', '456 Blue St, Mumbai');
INSERT INTO CUSTOMERS VALUES (3, 'Charlie Brown', 'charlie.brown@example.com', '9876543212', '789 Red St, Bangalore');
INSERT INTO CUSTOMERS VALUES (4, 'Diana Prince', 'diana.prince@example.com', '9876543213', '101 Yellow St, Chennai');
INSERT INTO CUSTOMERS VALUES (5, 'Ethan Hunt', 'ethan.hunt@example.com', '9876543214', '202 White St, Hyderabad');
INSERT INTO CUSTOMERS VALUES (6, 'Fiona Gallagher', 'fiona.g@example.com', '9876543215', '303 Purple St, Pune');
INSERT INTO CUSTOMERS VALUES (7, 'George Clooney', 'george.c@example.com', '9876543216', '404 Black St, Jaipur');
INSERT INTO CUSTOMERS VALUES (8, 'Hannah Montana', 'hannah.m@example.com', '9876543217', '505 Pink St, Kolkata');

-- 3️⃣ CREATE ORDERS table
CREATE TABLE ORDERS (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES CUSTOMERS(customer_id),
    order_date DATE,
    amount NUMBER(10,2),
    status VARCHAR2(20)
);

-- 4️⃣ INSERT into ORDERS
INSERT INTO ORDERS VALUES (101, 1, DATE '2025-06-25', 1500.50, 'Delivered');
INSERT INTO ORDERS VALUES (102, 2, DATE '2025-06-26', 2500.75, 'Shipped');
INSERT INTO ORDERS VALUES (103, 3, DATE '2025-06-27', 3200.00, 'Processing');
INSERT INTO ORDERS VALUES (104, 1, DATE '2025-06-28', 450.25, 'Cancelled');
INSERT INTO ORDERS VALUES (105, 4, DATE '2025-06-29', 789.60, 'Delivered');
INSERT INTO ORDERS VALUES (106, 5, DATE '2025-06-30', 999.99, 'Returned');
INSERT INTO ORDERS VALUES (107, 2, DATE '2025-06-30', 2100.00, 'Delivered');
INSERT INTO ORDERS VALUES (108, 6, DATE '2025-06-30', 1750.00, 'Processing');

-- ✅ 1️⃣ INNER JOIN — Basic
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.customer_id = o.customer_id;

-- ✅ 2️⃣ LEFT JOIN — Keep all customers
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id;

-- ✅ 3️⃣ RIGHT JOIN — Customers and orders
-- Note: Oracle does not support RIGHT JOIN directly, so we swap tables
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM ORDERS o
LEFT JOIN CUSTOMERS c ON o.customer_id = c.customer_id;

-- ✅ 4️⃣ FULL OUTER JOIN — Everything
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
FULL OUTER JOIN ORDERS o ON c.customer_id = o.customer_id;

-- ✅ 5️⃣ CROSS JOIN — Cartesian Product
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
CROSS JOIN ORDERS o;

-- ✅ 6️⃣ Aggregate JOIN — COUNT
SELECT c.customer_id, c.name AS customer_name, COUNT(o.order_id) AS total_orders
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- ✅ 7️⃣ SELF JOIN — Customer to Customer
SELECT c1.customer_id AS customer1_id, c1.name AS customer1_name,
       c2.customer_id AS customer2_id, c2.name AS customer2_name
FROM CUSTOMERS c1
JOIN CUSTOMERS c2 ON c1.customer_id != c2.customer_id;

-- ✅ 8️⃣ WHERE vs JOIN Condition — CROSS JOIN test
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c, ORDERS o
WHERE c.customer_id = o.customer_id;

-- ✅ 9️⃣ LEFT JOIN — Filter in ON vs WHERE (ON filter)
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id AND o.status = 'Delivered';

-- ✅ 9️⃣ LEFT JOIN — Filter in ON vs WHERE (WHERE filter)
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered';

-- ✅ 🔟 LEFT JOIN — Advanced condition (ON filter)
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id AND o.customer_id > 1;

-- ✅ 🔟 LEFT JOIN — Advanced condition (WHERE filter)
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.amount, o.status
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE o.customer_id > 1;
