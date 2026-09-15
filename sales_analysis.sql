create database if not exists Sales;
use sales;
CREATE TABLE 
`sales`.`sales_data` (`order_id` int, `order_date` text, `customer_id` int, `region` text, 
`category` text, `channel` text, `quantity` double, `unit_price` double, `discount` double,
 `sales` double, `cost` double, `profit` double, `profit_megin` double, `year` int, `month` int, 
 `quarter` text, `month_name` text, `year_month` text, `days` text);
 load data local infile 'C:/Users/ELCOT/sales_analytics_projec/output/clean_sales_data.csv'
into table sales_data fields terminated by ',' enclosed by'"' lines terminated by '\n' ignore 1 rows;
select* from sales_data;
select count(*) as raw_count from sales_data;
SELECT
 SUM(sales) AS total_sales,
 SUM(profit) AS total_profit,
 COUNT(DISTINCT order_id) AS total_orders,
 SUM(quantity) AS total_quantity,
 SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM sales_data;
select region,
 SUM(sales) AS sales,
 SUM(profit) AS profit,
 COUNT(DISTINCT order_id) AS orders
FROM sales_data
GROUP BY region
ORDER BY sales DESC;
SELECT
 category,
 SUM(sales) AS sales,
 SUM(profit) AS profit,
 SUM(quantity) AS quantity
FROM sales_data
GROUP BY category
ORDER BY sales DESC;
select channel,
 SUM(sales) AS sales,
 SUM(profit) AS profit
FROM sales_data
GROUP BY channel
ORDER BY sales DESC;
SELECT
 date_format(order_date, '%Y-%m-01') AS month,
 SUM(sales) AS sales,
 SUM(profit) AS profit,
 COUNT(DISTINCT order_id) AS orders
FROM sales_data
GROUP BY date_format(order_date, '%Y-%m-01')
ORDER BY month;
 with region_sales AS ( SELECT region, SUM(sales) AS sales FROM sales_data
 GROUP BY region
)
SELECT region, sales,RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM region_sales
ORDER BY sales_rank;


