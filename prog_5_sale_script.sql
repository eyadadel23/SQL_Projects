-- SQL Retail Sales Analysis Project

-- Creating Database
CREATE DATABASE projects;

USE projects;

-- Creating Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE customers
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM Customers;

SELECT TOP 15* FROM Customers;


-- Data Cleaning

-- Checking For Null Values
SELECT * FROM Customers
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR 
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	age IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Handling Null Values
DELETE FROM customers
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR 
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	age IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL; 

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) FROM customers;

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customers.customer_id) 
FROM customers;


-- Data Analysis & Business Key Problems & Answers


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM customers
WHERE customers.sale_date = '2022-11-05';

SELECT COUNT(*)
FROM customers
WHERE customers.sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT * 
FROM customers
WHERE customers.category = 'Clothing'
AND 
customers.quantiy >= 3
AND
customers.sale_date BETWEEN '2022-11-01' AND '2022-11-30';

SELECT COUNT(*) 
FROM customers
WHERE customers.category = 'Clothing'
AND 
customers.quantiy >= 3
AND
customers.sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT customers.category, SUM(customers.total_sale) 
FROM customers
GROUP BY customers.category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(customers.age)
FROM customers
WHERE customers.category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM customers
WHERE customers.total_sale >= 1000;

SELECT COUNT(*) 
FROM customers
WHERE customers.total_sale >= 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT customers.gender, COUNT(customers.transactions_id)
FROM customers
GROUP BY customers.gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH TOP_MONTH AS (
SELECT 
	YEAR(customers.sale_date) AS Y,
	MONTH(customers.sale_date) AS M,
	AVG(customers.total_sale) AS AVG_SALE,
	RANK() OVER(PARTITION BY YEAR(customers.sale_date) ORDER BY AVG(customers.total_sale) DESC) AS RANK
FROM customers
GROUP BY YEAR(customers.sale_date), MONTH(customers.sale_date))

SELECT * 
FROM TOP_MONTH 
WHERE RANK = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT SUM(customers.total_sale), customers.customer_id
FROM customers
GROUP BY customers.customer_id
ORDER BY 1 DESC;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT customers.category, COUNT(DISTINCT customers.customer_id)
FROM customers
GROUP BY customers.category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
CREATE VIEW customer_shifts  AS
	SELECT *,
		CASE
			WHEN DATEPART(HOUR, customers.sale_time) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, customers.sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS SHIFTS
	FROM customers;

SELECT COUNT(customer_shifts.transactions_id), customer_shifts.SHIFTS 
FROM customer_shifts
GROUP BY customer_shifts.SHIFTS;



-- The End.