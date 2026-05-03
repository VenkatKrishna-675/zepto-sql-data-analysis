create database zepto_sql_project;

use zepto_sql_project;

drop table if exists zepto;


ALTER TABLE zepto
CHANGE `ï»¿category` category TEXT;

ALTER TABLE zepto
ADD COLUMN sku_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE zepto
MODIFY COLUMN sku_id INT FIRST;

# data exploration

# count of rows
select count(*) from zepto;

#Sample data
select * from zepto limit 10;

#null values
select * from zepto
where name is null
or
category is null
or
mrp is null
or
discountPercent is null
or
availableQuantity is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

# Different product categories
select distinct category 
from zepto
order by category;

# products in stock vs out-of-stock
select outOfStock , count(sku_id)
from zepto
group by outOfStock;

-- product names present multiple times
select name, count(sku_id) as "Number of Sku's"
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc; 


-- Data Cleaning

-- products with price = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0;

SET SQL_SAFE_UPDATES = 0;

delete from zepto 
where mrp = 0;

-- Convert paise to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

select mrp , discountedSellingPrice from zepto;

-- Q1. Find the top 10 best-value products on the discount Percentage?
select distinct name, mrp, discountPercent
from zepto
order by discountPercent desc 
limit 10;

-- Q2. What are the products with High mrp but out of stock?
select distinct name , mrp
from zepto
where outOfStock = TRUE and mrp > 300
order by mrp desc;

-- Q3. Calculate estimated revenue for each category?
select category , 
sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto
group by category
order by total_revenue;


-- Q4. Find all the products where mrp is greater than 500 and discount less than 10 %?

select distinct name, mrp, discountPercent 
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc, discountPercent desc;


-- Q5. Identify the top 5 categories offering the highest average discount percentage?

select category, round(avg(discountPercent),2) as average_discount
from zepto 
group by category
order by average_discount desc 
limit 5;

-- Q6. Find the price per gram fo products above 100g and sort by value

select distinct name , weightInGms, discountedSellingPrice ,
round(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto 
where weightInGms >= 100
order by price_per_gram;

-- Q7. Group the products into categories like low, medium , bulk
select distinct name , weightInGms ,
case when weightInGms < 1000 then 'Low'
	 when weightInGms < 5000 then 'Medium'
     else 'Bulk'
	 end as weight_category
from zepto;

-- Q8. What is the Total Inventory weight per category
select category,
sum(weightInGms * availableQuantity) as total_weight
from zepto
group by category
order by total_weight;