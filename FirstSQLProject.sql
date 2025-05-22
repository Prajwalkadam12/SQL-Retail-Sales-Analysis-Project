/*SQL Retail Sales Analysis.*/
Create database Project1;

/*Using  Project1 DataBase for the Retail Sales Analysis*/
use Project1;

/*Createing The Table for the DataBase to Store the Data For Analysis */
Create table Retail_Sales_Table(
transactions_id int primary key,	
sale_date date,	
sale_time time,	
customer_id	int,
gender Varchar(7),	
age int,
category Varchar(15),	
quantiy	int,
price_per_unit float,	
cogs float,	
total_sale float
);


/* data Imported*/
/*Checking the data is imported retail_sales_table*/
select * from Retail_Sales_Table ;


/*Cleaning Of the Data */
/*Checking for the Null Values*/
select * from Retail_Sales_Table
Where transactions_id Is Null
or sale_date Is Null
or sale_time Is Null
or customer_id Is Null
or gender Is Null
or age Is Null
or Category Is Null
or category Is Null
or quantiy Is Null
or price_per_unit Is Null
or cogs Is Null
or total_sale Is Null;


/*Data Exporation*/
/*Overall Sale of the Retail*/
Select count(*) as Overall_Sales 
from Retail_Sales_Table;

# How Many Distinct Customers We Have 
Select count(distinct customer_id) as Overall_Customer
from Retail_Sales_Table;

#How Many Distinct Catrgory We Have 
Select count(distinct category) as Overall_Customer
from Retail_Sales_Table;

#Name Of The Distinct Categort We Have 
Select distinct category as Overall_Customer
from Retail_Sales_Table;


#Retrieve Data Form All Column for Sale made on '2022-11-05'
Select * 
from Retail_Sales_Table
Where sale_date = '2022-11-05';

#Retrieve Transcation Data From the Table of category Clothing & of november month
SELECT transactions_id
FROM Retail_Sales_Table
WHERE category = 'Clothing' AND date_format(sale_date, '%Y-%m') = '2022-11';
    
    
    
#Retrieve All cloumn Data From the Table of category Clothing & of november month
SELECT *
FROM Retail_Sales_Table
WHERE category = 'Clothing' AND date_format(sale_date, '%Y-%m') = '2022-11';


#Find Out What Are the sum of Total Sales of the each Category form Table
Select Category , sum(total_sale) as Net_Sales
from Retail_Sales_Table
Group By 1;

#Min Age of the customer form the Beauty category 
select min(age) as Min_Customer
from Retail_Sales_Table
where category ='Beauty';


# find the average Age of the customer form the beatuy category 
select avg(age) as Average_Customer
from Retail_Sales_Table
where category ='Beauty';

#find All transactions form the Total_sale where total_sale is greater than 1000
select total_sale , category
from Retail_Sales_Table
where total_sale > 1000;

#Fint out the total number of transaction made by each gender in each category
select category , gender, count(total_sale) as total_transaction
from Retail_Sales_Table
group by category , gender 
Order by 1;

#Calculate the average sale for each month , find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        YEAR(sale_date) AS year,
        DATE_FORMAT(sale_date, '%b') AS month, -- Use '%b' for abbreviated month names
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranks
    FROM Retail_Sales_Table
    GROUP BY year, month
) AS t1
WHERE ranks = 1;



#Find out the top 5 customers based on the highest total sales
select customer_id , sum(total_sale) as Total_Sales
from Retail_Sales_Table
Group by 1 order by 2 limit 5;


#Find out the unique customer purchased items from each category
SELECT category, COUNT(DISTINCT customer_id) AS Unique_Customer_id
FROM Retail_Sales_Table
GROUP BY category;

#Create the each shift and number of order 
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM Retail_Sales_Table
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

