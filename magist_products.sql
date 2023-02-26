USE magist;

select * from products;
select * from order_payments;
select * from geo;
select * from orders;
select * from order_items;

select cat.product_category_name as c_name,
p.product_category_name as p_name,
cat.product_category_name_english as en_name
from products as p
join product_category_name_translation as cat
on p.product_category_name = cat.product_category_name;

-- selects distinct product categories
SELECT 
-- p.product_category_name AS p_name,
-- p_t.product_category_name AS p_t_name, 
DISTINCT p_t.product_category_name_english AS en_name
FROM products AS p
JOIN product_category_name_translation AS p_t
ON p.product_category_name = p_t.product_category_name;
-- GROUP BY p_t.product_category_name_english;

-- question 1. What categories of tech products does Magist have?
-- selects tech items
SELECT 
-- p.product_category_name AS p_name,
-- p_t.product_category_name AS p_t_name, 
DISTINCT p_t.product_category_name_english AS en_name
FROM products AS p
JOIN product_category_name_translation AS p_t
ON p.product_category_name = p_t.product_category_name
WHERE p_t.product_category_name_english IN (
'computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony'
);
-- GROUP BY p_t.product_category_name_english;

select * from orders;
select * from order_payments;
select * from order_items;

/*question 2. How many products of these tech categories have been sold 
(within the time window of the database snapshot)?
 What percentage does that represent from the overall number of products sold? */

SELECT 
-- p.product_category_name AS p_name,
-- p_t.product_category_name AS p_t_name, 
DISTINCT p_t.product_category_name_english AS en_name,
SUM(items.order_item_id) AS items_sum
FROM products AS p
JOIN product_category_name_translation AS p_t
ON p.product_category_name = p_t.product_category_name
INNER JOIN order_items AS items
ON p.product_id=items.product_id
WHERE p_t.product_category_name_english IN (
'computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony'
)
GROUP BY p_t.product_category_name_english
HAVING SUM(items.order_item_id);
-- HAVING SUM(items_sum);


-- What percentage does that represent from the overall number of products sold?
SELECT 

DISTINCT p_t.product_category_name_english AS en_name,
-- p.product_category_name AS p_name,
-- p_t.product_category_name AS p_t_name, 
SUM(items.order_item_id) AS items_sum,
/*CASE
	WHEN p_t.product_category_name_english IN (
'computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony'
) THEN 'Tech Products'
	ELSE 'Non-tech Products'
END AS item_types */
CASE
	WHEN p_t.product_category_name_english IN (
'computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony'
) THEN SUM(tech_products)
	ELSE non_tech_products
END AS tech_products,
SUM(tech_products)
FROM products AS p
JOIN product_category_name_translation AS p_t
ON p.product_category_name = p_t.product_category_name
INNER JOIN order_items AS items
ON p.product_id=items.product_id
/* WHERE p_t.product_category_name_english IN (
'computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony'
) */
GROUP BY tech_products

-- GROUP BY p_t.product_category_name_english
HAVING SUM(items.order_item_id)
;

select * from products;
SELECT * from product_category_name_translation;
select * from order_items;
select * from orders;

-- classified by order status with total count
select distinct order_status,
count(order_status) as total_number
from orders
group by order_status;

INSERT INTO products (product_id, product_category_name)
SELECT product_category_name_english
FROM product_category_name_translation;

-- filters tech products with two columns: 1. indicated 'tech', 2. list of tech products
SELECT 
t.TechCategory, 
t.product_category_name_english AS en_name
FROM products AS p
LEFT JOIN product_category_name_translation AS t
ON p.product_category_name=t.product_category_name
WHERE TechCategory='tech'

GROUP BY en_name
;

/*
select product_id, product_category_name_english,  product_weight_g,
case when product_category_name_english ='computers' then 'tech' 
when product_category_name_english = 'computers_accessories' then 'tech'
when product_category_name_english = 'electronics' then 'tech'
when product_category_name_english = 'telephony' then 'tech'
when product_category_name_english = 'audio' then 'tech'
when product_category_name_english = 'tablets_printing_image' then 'tech'
else 'non_tech'
from products
left join product_category_name_translation as j
on products.product_category_name = j.product_category_name;
*/

select * from order_items;
select * from orders;
select * from products;

-- What’s the average price of the products being sold?
-- rounded
SELECT ROUND(AVG(price))
FROM order_items
; # 121

SELECT AVG(price)
FROM order_items
;  #120.65373902991884



select * from order_reviews;
select * from orders;
select * from order_items;
select * from products;

-- displays two columns with distinct product_names
select distinct product_category_name, product_category_name_english from product_category_name_translation;
-- avergage price of tech products 
SELECT AVG(order_items.price),
CASE
	WHEN products.product_category_name IN ('telefonia', 'audio', 'eletrodomesticos', 'eletronicos') THEN 'tech'
    ELSE 'non-tech'
END AS tech_products
FROM products
;



-- Are expensive tech products popular? 
SELECT 
-- p.product_category_name AS p_name,
-- p_t.product_category_name AS p_t_name, 
DISTINCT p_t.product_category_name_english AS en_name,
SUM(items.order_item_id) AS items_sum
FROM products AS p
JOIN product_category_name_translation AS p_t
ON p.product_category_name = p_t.product_category_name
INNER JOIN order_items AS items
ON p.product_id=items.product_id
WHERE p_t.product_category_name_english IN (
'computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony'
) 
GROUP BY p_t.product_category_name_english
HAVING SUM(items.order_item_id);
-- HAVING SUM(items_sum);

select * from order_reviews;
select * from products;

-- average review score
SELECT AVG(review_score)
FROM order_reviews; #4.0757

SELECT
CASE
	WHEN review_score > 4 THEN 'popular'
    WHEN review_score <= 4 THEN 'not popular'
    ELSE 'review score not available'
END AS reviews,
COUNT(1) AS count
FROM order_reviews
-- GROUP BY CASE WHEN review_score > 4 THEN 'popular' ELSE 'other' END;
		
GROUP BY 1
-- HAVING reviews='popular'
;




-- from SIMGE
SELECT 
    product_category_name_english,
    order_status,
    CASE
        WHEN
            (product_category_name_english LIKE '%tablets%'
                OR product_category_name_english LIKE '%pc%'
                OR product_category_name_english LIKE '%computer%'
                OR product_category_name_english LIKE '%electronics%'
                OR product_category_name_english LIKE '%appliances%'
                OR product_category_name_english LIKE '%games%'
                OR product_category_name_english LIKE '%audio%')
        THEN
            'tech'
        ELSE 'nontech'
    END AS Tech_Products
FROM
    product_category_name_translation AS pcnt
        JOIN
    products AS p ON p.product_category_name = pcnt.product_category_name
        JOIN
    order_items AS oi ON p.product_id = oi.product_id
        JOIN
    orders AS oo ON oo.order_id = oi.order_id;

#How many products of these tech categories have been sold (within the time window of the database snapshot)?

SELECT COUNT(oi.order_id), Tech_Products
FROM product_category_name_translation as pcnt 
JOIN products AS p 
ON p.product_category_name = pcnt.product_category_name
JOIN order_items AS oi 
ON p.product_id = oi.product_id
JOIN orders AS oo
ON oo.order_id = oi.order_id
WHERE order_status = 'delivered'
GROUP BY Tech_Products;
# This data is actual 21.02.23
Error Code: 1054. Unknown column 'Tech_Products' in 'field list'

SELECT AVG(review_score), Tech_Products
FROM product_category_name_translation as pcnt 
JOIN products AS p 
ON p.product_category_name = pcnt.product_category_name
JOIN order_items AS oi 
ON p.product_id = oi.product_id
JOIN orders AS oo
ON oo.order_id = oi.order_id
JOIN order_reviews AS ors
ON oo.order_id = ors.order_id
GROUP BY Tech_Products;


