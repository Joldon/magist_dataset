USE magist;

SELECT * FROM customers;
select * from orders;

select COUNT(order_id) from orders;
-- from Karolina
select order_status as "Status of the order" , count() as 'Quantity'
from orders
group by order_status;



-- not solved question 2
SELECT COUNT(*) AS orders, order_status
FROM orders
-- WHERE order_status='delivered'
GROUP BY order_status;

-- not solved
SELECT order_purchase_timestamp
FROM orders
WHERE order_purchase_timestamp = YEAR();

select * from products;

-- from Karolina
select count(order_id) as 'Quantity (Orders)', YEAR(order_purchase_timestamp) as 'Year', month(order_purchase_timestamp) as 'Month'
FROM orders
group by YEAR(order_purchase_timestamp), month(order_purchase_timestamp)
order by YEAR(order_purchase_timestamp), month(order_purchase_timestamp);


-- question 4
SELECT COUNT(DISTINCT product_id)
FROM products; 

-- question 5
select * from product_category_name_translation;

SELECT product_category_name AS product_name, COUNT(product_id) as product_id
FROM products
-- to use english translation
-- INNER JOIN product_category_name_translation
-- ON products.product_category_name = product_category_name_translation.product_category_name_english
GROUP BY products.product_category_name
ORDER BY COUNT(product_id) DESC;

-- with english translation
select product_category_name_english as 'Category', count(product_id) as 'Quantity'
from products
inner join product_category_name_translation as j
on products.product_category_name = j.product_category_name
group by products.product_category_name
order by count(product_id) DESC;

-- question 6. How many of those products were present in actual transactions?
select * from order_items;

SELECT COUNT(DISTINCT product_id)
FROM order_items;

-- question 7. What’s the price for the most expensive and cheapest products?
select * from order_items;

SELECT MAX(price) AS maximum_price, MIN(price) AS minimum_price
FROM order_items;

-- question 8. What are the highest and lowest payment values?
select * from order_payments;

SELECT MAX(payment_value) AS highest, MIN(payment_value) AS loweest
FROM order_payments;

-- from Karolina
select * from order_items;
select count(distinct product_id) as 'Amount of ordered products' from order_items;

select * from order_items;
select min(price), max(price), product_category_name_english
from order_items as o
inner join products as p
on p.product_id = o.product_id
inner join product_category_name_translation as pe
on pe.product_category_name = p.product_category_name
group by product_category_name_english;

select min(price), max(price)
from order_items;

select * from order_payments;
select max(payment_value) from order_payments;














