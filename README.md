# Retail Sales Analysis

Welcome to the Retail Sales Analysis project! This project demonstrates how to analyze retail sales data using SQL. The queries provide insights into customer behavior, sales trends, and performance metrics.

## Project Overview
This project is designed to analyze retail sales data stored in a SQL database. It includes the following key components:
- **Data Cleaning:** Identifying and handling null values to ensure data integrity.
- **Data Exploration:** Extracting key metrics such as total sales, unique customers, and category-specific insights.
- **Advanced Analysis:** Utilizing SQL queries to uncover deeper insights such as top customers, best-selling months, and customer age demographics.

## Features
- **Database Structure:**
  - A single table (`Retail_Sales_Table`) created to store transactional data.
  - Attributes include `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantity`, `price_per_unit`, `cogs`, and `total_sale`.

- **SQL Queries:**
  - **Basic Analysis:** Overall sales count, unique customers, and category-specific data.
  - **Targeted Analysis:** Sales on specific dates, transactions for specific categories, and high-value transactions.
  - **Demographics:** Minimum and average customer age per category.
  - **Shift Analysis:** Sales distribution across morning, afternoon, and evening shifts.
  - **Customer Insights:** Top customers based on total sales and unique customers per category.
  - **Trend Analysis:** Monthly average sales and identification of best-selling months.

## Key SQL Highlights
- **Cleaning Data:**
  ```sql
  SELECT * 
  FROM Retail_Sales_Table
  WHERE transactions_id IS NULL OR sale_date IS NULL OR ...;
  ```
- **Overall Sales:**
  ```sql
  SELECT COUNT(*) AS Overall_Sales 
  FROM Retail_Sales_Table;
  ```
- **Best-Selling Months:**
  ```sql
  SELECT year, month, avg_sale
  FROM (
      SELECT 
          YEAR(sale_date) AS year,
          DATE_FORMAT(sale_date, '%b') AS month,
          AVG(total_sale) AS avg_sale,
          RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranks
      FROM Retail_Sales_Table
      GROUP BY year, month
  ) AS ranked_months
  WHERE ranks = 1;
  ```

## Prerequisites
To run the queries, you need:
- A MySQL-compatible database.
- A tool for running SQL queries (e.g., MySQL Workbench, DBeaver, or any SQL IDE).
- Retail sales data loaded into the `Retail_Sales_Table`.

## How to Use
1. Create a database and table using the provided schema.
2. Load your retail sales data into the table.
3. Execute the SQL queries in sequence or modify them as needed for specific insights.

## Insights Derived
- **Top Categories:** Clothing and beauty were identified as top-selling categories.
- **Customer Segments:** Young adults form a significant part of the customer base for beauty products.
- **Sales Trends:** November emerged as a high-performing month, especially for clothing.
- **Customer Behavior:** The top 5 customers contributed significantly to total sales.

## Future Enhancements
- Automate data loading using scripts.
- Visualize key insights using a BI tool like Tableau or Power BI.
- Extend the analysis to include predictive modeling for future sales trends.

## Author
**Prajwal Sudhir Kadam**  
Aspiring Data Scientist and Data Analytics Enthusiast  

## Contact
Feel free to connect with me for feedback or collaboration:
- [GitHub Profile](https://github.com/yourusername)
- [LinkedIn Profile](https://www.linkedin.com/in/prajwal-kadam-/)

---
Thank you for exploring this project!
