--Project Retail Sale Analysis
--# Retail Sales Analysis SQL Project
--## Project Structure

--### 1. Database Setup

--**Database Creation**: The project starts by creating a database named `p1_retail_db`.
--**Table Creation**: A table named `retail_sales2` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
Select * from retail_sales2;
--1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
select * from retail_sales2
where sale_date ='2022-11-05';
--2.--**Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022**:
select * 
from retail_sales2
where category = 'Clothing' 
and
TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
and quantity >= 4;
--3. **Write a SQL query to calculate the total sales (total_sale) for each category.**: 
select 
	category,
	sum(total_sale) as net_sale,
	COUNT(*) as total_orders
from retail_sales2
group by 1;
--4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales2
WHERE category = 'Beauty'
---checking for other category
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales2
WHERE category = 'Clothing'
--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
select * 
from retail_sales2
where total_sale> 1000;
--6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
select category, gender,
count(*) as total_tran
from retail_sales2
Group by gender,
category
order by 1;
--7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
select sale_year,
		sale_month,
		avg_sale
From		 
(
select 
	extract(Year from sale_date) as sale_year,
	extract(Month from sale_date) as sale_month,
	avg(total_sale) as avg_sale,
	Rank() over(partition by extract(Year from sale_date) order by avg(total_sale) desc) as Rank1
	from retail_sales2
Group by 1,2
) as t1
where Rank1 = 1;
--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select 
		customer_id,
		sum(total_sale) as cust_sale
from retail_sales2
group by 1
order by 2 desc
Limit 5;

--9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
select 
		category,
		count(distinct customer_id) as special_customer
from retail_sales2
group by 1
order by 2 desc;

--10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
with hourly_sale
as (
select *,
		case
		when Extract(hour from sale_time) < 12 then 'Morning'
		when Extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
		end as shift
from retail_sales2
)
select 
		shift,
		count(*) as total_orders
	from hourly_sale
	group by shift;

-- I finished the my first sql project successfully thanks to mentor**




























	
	
	
























































