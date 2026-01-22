Create database retail_sales;
Use retail_sales;
Create table retail (transaction_id int, transaction_date date, customer_id varchar(20), gender character(15), age int, product_category character(20), quantity int,price_per_unit decimal(10,2),total_amount decimal(10,2));
Select count(*) as total_rows
from retail;
-- Overall Business analysis
Select count(distinct transaction_id) as total_transaction, count(distinct customer_id) as total_customers, sum(total_amount) as total_revenue, round(avg(total_amount),2) as average_revenue
from retail;
-- Monthly sales trend
Select date_format(transaction_id, '%Y-%m') as month, sum(total_amount) as monthly_sales
from retail
group by month
order by monthly_sales DESC;
-- Category performance
Select product_category, sum(total_amount) as total_revenue, count(*) as transactions
from retail
group by product_category
order by total_revenue desc;
-- Customer segmentation by spend
SELECT
    CASE
        WHEN total_spent < 500 THEN 'Low Value'
        WHEN total_spent BETWEEN 500 AND 2000 THEN 'Mid Value'
        ELSE 'High Value'
    END AS customer_segment,
    COUNT(*) AS customers
FROM (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM retail
    GROUP BY customer_id
) t
GROUP BY customer_segment;
-- Customer purchase behaviour
Select customer_id, sum(transaction_id) as total_transactions, sum(total_amount) as total_revenue
from retail
group by customer_id
order by total_revenue desc;
