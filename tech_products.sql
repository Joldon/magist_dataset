-- filters tech products with tow columns: 1. indicated 'tech', 2. list of tech products
SELECT 
t.TechCategory, 
t.product_category_name_english AS en_name
FROM products AS p
LEFT JOIN product_category_name_translation AS t
ON p.product_category_name=t.product_category_name
WHERE TechCategory='tech';

SELECT
t.TechCategory, 
COUNT(t.TechCategory)
-- t.product_category_name_english AS en_name
FROM products AS p
LEFT JOIN product_category_name_translation AS t
ON p.product_category_name=t.product_category_name
WHERE TechCategory='tech'; # 4302 tech items

select COUNT(product_id) from products; #32951 overall items

SELECT COUNT(TechCategory)
FROM order_items AS oi
JOIN products as p
ON p.product_id=oi.product_id
LEFT JOIN product_category_name_translation AS t
ON p.product_category_name=t.product_category_name
WHERE TechCategory='tech' AND price > 540; #670 expensive products

-- looks correct
SELECT COUNT(TechCategory), TechCategory
FROM order_items AS oi
JOIN products as p
ON p.product_id=oi.product_id
LEFT JOIN product_category_name_translation AS t
ON p.product_category_name=t.product_category_name
GROUP BY TechCategory; # aggregated number of tech and non-tech numbers

Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'magist.oi.order_id'; this is incompatible with sql_mode=only_full_group_by

select * from order_items;
select price from order_items;
-- filters tech products with  1. indicated 'tech', 2. list of tech products, 3. avg 
SELECT 
-- t.TechCategory, 
t.product_category_name_english AS en_name,
ROUND(AVG(oi.price)) AS avg_hightech_price,
MIN(oi.price) AS min_hightech_price
FROM products AS p
LEFT JOIN product_category_name_translation AS t
ON p.product_category_name=t.product_category_name
JOIN order_items AS oi
ON p.product_id=oi.product_id
WHERE TechCategory='tech' AND price > 540
GROUP BY en_name
;

-- displays two columns with distinct product_names
select distinct product_category_name, product_category_name_english from product_category_name_translation;

-- avergage price of tech products (not working)
SELECT *,
-- AVG(order_items.price),
CASE
	WHEN products.product_category_name IN ('telefonia', 'audio', 'eletrodomesticos', 'eletronicos') THEN 'tech'
    ELSE 'non-tech'
END AS product_category
FROM products
WHERE product_category='tech'
;
Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'magist.products.product_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

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
select * from products;
SELECT * ,
CASE
	WHEN price > 540 THEN 'expensive'
    ELSE 'non-expensive'
END AS price_category
FROM order_items
ORDER BY price_category;

SELECT *
-- COUNT(products.product_id)
FROM order_items
JOIN products
ON order_items.product_id = products.product_id
JOIN product_category_name_translation
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_english IN ('computers_accessories', 'electronics', 'auto', 'audio', 'cine_photo', 'dvds_blu_ray',
'pc_gamer', 'computers', 'tablets_printing_image', 'telephony', 'fixed-telephony')
AND price > 540 AND TechCategory='tech'
ORDER BY price DESC;
-- GROUP BY product_category_name_english;


