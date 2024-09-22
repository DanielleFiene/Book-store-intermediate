SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM books
LIMIT 10;

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'customers';

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'orders';

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'books';

EXPLAIN ANALYZE SELECT customer_id, quantity
FROM orders
WHERE quantity > 18
;

CREATE INDEX orders_big_sales_idx 
ON orders (customer_id, quantity)
WHERE quantity > 18
;

EXPLAIN ANALYZE SELECT customer_id, quantity
FROM orders
WHERE quantity > 18
;

EXPLAIN ANALYZE SELECT *
FROM customers
WHERE customer_id < 100;

ALTER TABLE customers
  ADD CONSTRAINT customers_pkey
    PRIMARY KEY (customer_id);

EXPLAIN ANALYZE SELECT *
FROM customers
WHERE customer_id < 100;

CLUSTER customers
USING customers_pkey;

SELECT *
FROM customers
LIMIT 10;

CREATE INDEX orders_customer_id_book_id_idx
ON orders (customer_id, book_id)
;

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'orders';

DROP INDEX IF EXISTS orders_customer_id_book_id_idx;

CREATE INDEX orders_customer_id_book_id_quantity_idx
ON orders (customer_id, book_id, quantity)
;

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'orders';

DROP INDEX IF EXISTS books_author_idx;
DROP INDEX IF EXISTS books_title_idx;

CREATE INDEX books_author_title_idx
ON books (author, title)
;

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'books';

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE quantity * price_base > 100
;

CREATE INDEX orders_quantity_price_base_idx
ON orders (quantity, price_base)
WHERE quantity * price_base > 100
;

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE quantity * price_base > 100
;

SELECT *
FROM pg_indexes
WHERE tablename IN ('customers', 'books', 'orders')
ORDER BY tablename, indexname;

CREATE INDEX customers_last_name_first_name_email_address ON customers (last_name, first_name, email_address);

SELECT *
FROM pg_indexes
WHERE tablename IN ('customers', 'books', 'orders')
ORDER BY tablename, indexname;
