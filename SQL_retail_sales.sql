select * from retail_sales;
-- find null values--
-- data cleaning -- 

select* from retail_sales
where quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

select * from retail_sales;

-- data exploration--
-- how many sales--
select count(*) as Total_sales from retail_sales;

-- unique customers--
select count(distinct(customer_id)) from retail_sales;

-- counts of category--
select distinct(category) from retail_sales;

-- data anlysis and business problems--
-- Q1. write a sql query to retrieve all coloumns for sales made on '2022-11-05--

select * from retail_sales where sale_date = "2022-11-05";

-- Q2. write a sql query to retrieve all transcations where category is 'clothing' and quantity sold is more than 2 in the month of nov-2022--
select* from retail_sales where category = "clothing" and sale_date BETWEEN '2022-11-01' AND '2022-11-30' and quantiy>2;

-- Q3. write a sql query to calculate total sales(total_sales)--
select category, sum(total_sale) as Total_sale, count(*) as total_orders from retail_sales group by category;

-- Q4 write a sql query to find the avg age of customers who purchased items from the beauty category--

select round(avg(age),2) as Average_age from retail_sales where category = "Beauty";

-- Q5. find all transaction where the total sales is greater than 1000--
select* from retail_sales where total_sale>1000;

-- Q6. find total No. of transcations made by each gender in each category--
select category, gender, count(*) as Total_transactions
from retail_sales
group by category, gender
order by category;

-- Q7. Calculate avg sale for each month. find out best selling month in each year--
select * from(
select year(sale_date) as Year,month(sale_date)as Month, round(avg(total_sale),2) as Average_Sale,
rank() over(partition by year(sale_date) order by round(avg(total_sale),2) Desc) as raank
from retail_sales
group by Year, Month) as T1
where raank = 1;

-- Q8. find top 5 customers based on the highest total sales--

select distinct(customer_id), sum(total_sale) as Totat_sales from retail_sales
group by customer_id
order by Totat_sales desc limit 5;

-- Q9. Find the number of unique customers who purchased items from each category--

select category, count(distinct(customer_id)) as Unique_Customer from retail_sales
group by category;

-- Q10. creat each shift and number of orders(eg. morning<=12, afternoon b/w 12-17, evening >17)

with hourly_sale as(
select*,
case
when hour(sale_time) < 12 then "Morning"
when hour(sale_time) between 12 and 17 then "afternoon"
else "Evening"
end as Shift
from retail_sales
)
select shift, count(*) as Total_orders
from hourly_sale
group by shift;

-- End of project--





















