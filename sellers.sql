USE magist;

select * from products;
select * from sellers;
select * from order_items;
select * from orders;

/* 
How many months of data are included in the magist database?
How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?
*/

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

ALTER TABLE product_category_name_translation
ADD COLUMN TechCategory VARCHAR(255) AS 
(CASE WHEN product_category_name_english in ('audio', 'computers', 'computers_accessories', 'electronics', 'home_appliances', 'home_appliances_2', 'market_place', 'music', 'signaling_and_security','small_appliances', 'tablets_printing_image', 'telephony', 'watches_gift')
	THEN 'tech'
	ELSE 'non-tech' END)VIRTUAL; 

select distinct product_category_name from products;
select distinct product_category_name from products;

-- displays two columns with distinct product_names
select distinct product_category_name, product_category_name_english from product_category_name_translation;

-- from felicitas
select count(distinct s.seller_id) as num_sellers, TechCategory
from product_category_name_translation as pct
left join products as p
on pct.product_category_name = p.product_category_name
left join order_items as oi
on p.product_id = oi.product_id
left join sellers as s
on oi.seller_id = s.seller_id
group by TechCategory
order by num_sellers;
-- I saved an additional column to product_category_name_translation called TechCategory which just says 'tech' or 'non-tech' for each product_category


-- How many months of data are included in the magist database?
