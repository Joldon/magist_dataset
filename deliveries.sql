USE magist;

select * from orders;
select * from order_payments;
select * from order_items;

/* What’s the average time between the order being placed and the product being delivered?
How many orders are delivered on time vs orders delivered with a delay?
Is there any pattern for delayed orders, e.g. big products being delayed more often? */

-- What’s the average time between the order being placed and the product being delivered?
select count(order_id) as 'Quantity (Orders)', 
YEAR(order_purchase_timestamp) as 'Year', 
month(order_purchase_timestamp) as 'Month';

SELECT 
YEAR(order_approved_at) as 'YEAR',
MONTH(order_approved_at) as 'MONTH',
DAY(order_approved_at) as 'DAY',
order_approved_at AS placed, 
order_delivered_customer_date AS delivered, 
order_delivered_customer_date - order_approved_at AS time_difference
from orders
WHERE order_delivered_customer_date - order_approved_at;





-- from Karolina all solutions

# 3.2. In relation to the sellers:
# How many months of data are included in the magist database?
 select * from orders;
 
 #create table max_min_date
 select min(order_purchase_timestamp) as ear_date, max(order_purchase_timestamp) as lat_date 
 from orders;
 select ((datediff(lat_date,ear_date))/30.4167)
 from max_min_date;  # '25.4137'
 
 #How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
 

#create table all_seller
select seller_id,  order_id, price, freight_value, order_item_id, product_category_name_english,product_weight_g,tech_or_no
from order_items as o
left join all_in
on o.product_id = all_in.product_id;

#How many sellers are there?
select count(distinct seller_id)
from  all_seller; # 3095
#How many Tech sellers are there?
select count(distinct seller_id)
from all_seller
where tech_or_no = 'tech'; # 453
#What percentage of overall sellers are Tech sellers?  ok 15%

#What is the total amount earned by all sellers?
select sum(price) 
from order_items; #'13591643.701720357'

select sum(price)
from all_seller; #13591643.701720357

#What is the total amount earned by all sellers? 
select sum(price)
from all_seller as a
left join orders as o
on a.order_id = o.order_id
where order_status = 'delivered'; # When I added that products have to be delivered: '13221498.112056851'

#What is the total amount earned by all Tech sellers?
select sum(price)
from all_seller as a
left join orders as o
on a.order_id = o.order_id
where order_status = 'delivered' and tech_or_no = 'tech'; # '1630411.9158651829'

# Can you work out the average monthly income of all sellers?   13221498.112056851 / 25.4137 = 520250.814012
# Can you work out the average monthly income of Tech sellers? 1630411.9158651829 / 25.4137 = 64154.84 

# 3.3. In relation to the delivery time:
# What’s the average time between the order being placed and the product being delivered?#
 

select datediff(order_delivered_customer_date, order_purchase_timestamp) as 'Delivery Time'
from orders
where order_status = 'delivered';

# What is avg delivery time?
select avg(datediff(order_delivered_customer_date, order_purchase_timestamp)) as 'Average Delivery Time'
from orders
where order_status = 'delivered';

# How many orders are delivered on time vs orders delivered with a delay? estimated date - delivery date

#create table dif_est_del as
select datediff(order_estimated_delivery_date, order_delivered_customer_date) as 'Difference_date_est'
from orders
where order_status ='delivered';

select * from dif_est_del;

  select count('Difference between estimated date and delivery time') as 'Amount of days without dalay',
  case when Difference_date_est > 0 then 'No delay'
  when Difference_date_est = 0 then 'On time'
  when Difference_date_est < 0 then 'Delayed'
  end as 'Order_status'
  from dif_est_del
  group by Order_status;


# Is there any pattern for delayed orders, e.g. big products being delayed more often?
create table dif_est_del_order_id
select datediff(order_estimated_delivery_date, order_delivered_customer_date) as 'Difference between estimated date and delivery time', order_id
from orders
where order_status ='delivered';

select * from product_category_name_translation;






