select * from returns_data;  


select * from orders_data; 


select sum(sales) as total_sales from orders_data; 


select max(sales) as total_sales from orders_data;   

select min(sales) as total_sales from orders_data;  

select * from orders_data order by sales; 


select max(sale) as Total_sales 
from orders_data; 


# total sales as number of records 

select count(*) number_records 
from orders_data; 


select sum(sales)/count(*) as avg_sales 
from orders_data; 


# number row 

select count(*) 
from orders_data;  


select count(*),count(order_id) as no_records 
from orders_data; 


select * from orders_data 
where city is not null;  


select count(*),count(order_id),count(city) as no_records 
from orders_data; 

# unique values 

select distinct category 
from orders_data;  



select count(*),count(order_id),count(city) as no_records 
,count('ankit'),count(distinct category ),count(distinct city)
from orders_data; 


select category,region,sum(sales) as Category_sales,sum(profit) as category_profit
from orders_data 
group by category region;  


select city,sum(sales) as city_sales
from orders_data 
where region = 'West'
group by city 
having sum(sales)>100 
order by city_sales;


# group by and having immeditaly 


select top 2 city,sum(sales) as city_sales
from orders_data 
where region = 'West'
group by city 
having sum(sales)>100 
order by city_sales; 

# sometime we have work mutiple different table and join together 

select * from orders_data;
select * from returns_data; 


select category,sum(sales) as Total_Sales from orders_data 
inner join returns_data on orders_data.order_id = returns_data.order_id 
group by category;  


select * from orders_data ; 


# aggrate data   group by bread in butter 

select category,sum(sales) as Category_sales
,sum(profit) as CATEGORY_PROFTS 
FROM orders_data 
group by category;   


select category,region,sum(sales) as category_sales 
,sum(profit) as category_profit 
from orders_data 
group by category,region;



# let look what you want to aggrate filtere on that 

select city,sum(sales) as city_sales 
from orders_data 
group by city;   


# where row by row check  
# having sum of slea >100 give those city   

select city,sum(sales) as city_sales 
from orders_data 
group by city 
having sum(sales)<500;
 


# interseted west region 

select city,sum(sales) as city_sales 
from orders_data 
where region = 'West'
group by city 
having sum(sales)>500;   



# city profits 


select city,sum(profit) city_prifts 
from orders_data 
where region = 'West' 
group by city 
having sum(profit)<500;
 


 select city,sum(sales) as city_sales 
from orders_data 
where region = 'West'
group by city 
having sum(sales)>500 
order by city_Sales  

# let move little   sometime mutileple table '


select * from orders_data;
select * from returns_data;  

# JOIN CONDITION  GIVE ALIA TO MAKE  GOOD 

select * 
from orders_data 
inner join returns_data on orders_data.order_id = returns_data.order_id 
where orders_Data.order_id='CA-2020-109806';   

# we can say what table join with group by having  when na value come pic then left join 


select * 
from orders_data 
left join returns_data on orders_data.order_id = returns_data.order_id; 

# give all data which is not returned 


select * 
from orders_data 
left join returns_data on orders_data.order_id = returns_data.order_id 
where returns_data.return_reason is null;  



select o.*
from orders_data o
 inner join returns_data on o.order_id = returns_data.order_id
where returns_data.return_reason is null; 



select o.order_id,r.return_reason 
from orders_data o
 inner join returns_data r on o.order_id = r.order_id;
 

 # group by and jon  


 select r.return_reason,sum(o.sales) as return_sales 
 from orders_data o
 left join  returns_data r on o.order_id = r.order_id 
 group by r.return_reason; 


 # all data which is not returned 

 select * from orders_Data; 

select * from returns_data;  


select * 
,case when return_reason = 'Wrong Item'then 'Wrong Items' else return_reason end as new_return_reason 
from returns_data; 


## profit>0 loss,prfit>50 then low profit ,>100 very high profit 


select * 
,case
when profit<0 then  'loss'
when profit<50 then  'low profit'
when profit<100 then 'high_profit'
else 'high_profit'
 end as Profit_bucket 
from orders_data;


select * from orders_Data;  


select * 
,case 
when sales<0 then 'no_work'
when sales<50 then 'avgerage_work'
when sales<100 then 'excellent work' 
else 'excellent work'  
end as salary_buckets 
from orders_data; 


# conditional low profit  between 

select *
, case 
when profit <0 then 'loss' 
when profit between 50 and 90 then 'high_profits' 
when profit between 0 and 49  then 'low_prifts' 
else 'very high profit'
end as profit_bucket 
from orders_data; 


# date and string functions 

select * from orders_data;  

# left function 
select customer_name,len(customer_name) as length_name
,left(order_id,2) as cust_length
from orders_data;  


# charcter 4  ,02 charctor 
select 
from orders_data 


select customer_name,len(customer_name) as length_name
,right(order_id,6) as cust_length
from orders_data;    


# substring 03 orment 

select customer_name,len(customer_name) as length_name
,right(order_id,6) as cust_length,
substring(order_id,4,4) as year_order
from orders_data;    

select customer_name,len(customer_name) as length_name
,right(order_id,6) as cust_length,
substring(order_id,4,2) as year_order
from orders_data;   


select customer_name,len(customer_name) as length_name
,right(order_id,6) as cust_length,
substring(order_id,6,2) as year_order
from orders_data;   


# replce other value 

select customer_name,len(customer_name) as length_name
,right(order_id,6) as cust_length,
substring(order_id,6,2) as year_order
,replace(customer_name,'C1','pa')
from orders_data;  


# date functions 

select left(order_date,4),sum(sales)
from orders_data 
group by left(order_date,4) 

# year from 

select order_id,order_date
,datepart(month,order_date) as order_month 
from orders_data ;



select order_id,order_date
,datepart(month,order_date) as order_month 
,datepart(year,order_date) as order_year
from orders_data ;


# sales by analysis 

select 
datepart(year,order_date) as order_year,datepart(month,order_date) as order_month,sum(sales) as Total_Sales
from orders_data
group by datepart(month,order_date),datepart(year,order_date) ;  


# weekday and tuesday 


select 
year(order_date) as order_year,month(order_date) as order_month,sum(sales) as Total_Sales
from orders_data
group by  year(order_date),month(order_date);   


select order_id,order_date
,datename(month,order_date) as order_month_name 
from orders_data;  


select order_id,order_Date,ship_date 
from orders_date;


select order_id,order_date,ship_date,
datediff(day,order_date,ship_date) as lead_Day
from orders_data;  



select order_id,order_date,ship_date,
datediff(YEAR,order_date,ship_date) as lead_Day,
DATEADD(DAY,5,ORDER_DATE) AS ORDER_5 
from orders_data;  
