use case1;
select * from WEEKLY_SALES limit 10

#data cleaning
drop table clean_weekly_sales;
CREATE TABLE clean_weekly_sales as
select week_date,
week(week_date) as week_number,
month(week_date) as month_number,
year(week_date) as calendar_year,
region,platform,
case
	when segment = null then 'Unknown'
    else segment
    end as segment,
case 
	When right(segment, 1) = '1' then 'Young Adults'
    When right(segment, 1) = '2' then 'Middle Aged'
    When right(segment, 1) in ('3','4' ) then 'Retirees'
	else 'Unknown'
	end as age_band,
case 
	When left(segment, 1) = 'c' then 'Couples'
    When left(segment, 1) = 'f' then 'Families'
    else 'unknown'
    end as demographic,
customer_type,transactions,sales,
round(sales/transactions,2) as 'Avg_transaction'
from WEEKLY_SALES;

select * from clean_weekly_sales limit 10;


## Data Exploration

## 1.Which week numbers are missing from the dataset?

create table seq100
(x int not null auto_increment primary key);
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 values (),(),(),(),(),(),(),(),(),();
insert into seq100 select x + 50 from seq100;
select * from seq100;
create table seq52 as (select x from seq100 limit 52);
select distinct x as week_day from seq52 where x not in(select distinct week_number from clean_weekly_sales); 

select distinct week_number from clean_weekly_sales;

# 2. How many total transactions were there for each year in the dataset?
Select calendar_year,
SUM(transactions) AS total_transactions
From clean_weekly_sales
group by calendar_year;

# 3. What are the total sales for each region for each month?
SELECT month_number,region,
SUM(sales) AS total_sales
FROM clean_weekly_sales
GROUP BY month_number, region
ORDER BY month_number, region;

# 4. What is the total count of transactions for each platform

Select platform,
count(transactions) as total_transactions
from clean_weekly_sales
group by platform;

# 5. What is the percentage of sales for Retail vs Shopify for each month?


