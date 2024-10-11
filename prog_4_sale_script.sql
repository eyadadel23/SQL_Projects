CREATE DATABASE supermarket;
USE supermarket;


SELECT * FROM supermarket;

-- 1. Display the first 5 rows from the dataset.
SELECT *
FROM supermarket
LIMIT 5;

-- 2. Display count, min, max, avg values for a the gross income column in the dataset.
SELECT MIN(`gross income`), MAX(`gross income`), AVG(`gross income`)
FROM supermarket;

-- 3. Count the number of occurrences of each city.
SELECT supermarket.City, COUNT(supermarket.City)
FROM supermarket
GROUP BY supermarket.City;

-- 4. Find the most frequently used payment method.
SELECT supermarket.Payment, COUNT(supermarket.Payment)
FROM supermarket
GROUP BY supermarket.Payment
ORDER BY COUNT(supermarket.Payment) DESC
LIMIT 1;

-- 5. Does The Cost of Goods Sold Affect The Ratings That The Customers Provide? 
SELECT supermarket.cogs, supermarket.Rating
FROM supermarket;

-- 6. Find the most profitable branch as per gross income.
SELECT supermarket.Branch, SUM(supermarket.`gross income`) AS gross_inc
FROM supermarket
GROUP BY supermarket.Branch
ORDER BY gross_inc DESC 
LIMIT 1;

-- 7.  Find the most used payment method city-wise.
SELECT city,
   SUM(CASE WHEN Payment="Cash" THEN 1 ELSE 0 END) AS "Cash",
   SUM(CASE WHEN Payment="Ewallet" THEN 1 ELSE 0 END) AS "Ewallet",
   SUM(CASE WHEN Payment="Credit card" THEN 1 ELSE 0 END) AS "Credit card"
FROM supermarket GROUP BY City;

-- 8. Find the product line purchased in the highest quantity.
SELECT supermarket.`Product line`, SUM(supermarket.Quantity)
FROM supermarket
GROUP BY supermarket.`Product line` 
ORDER BY SUM(supermarket.Quantity) DESC
LIMIT 1;

-- 9. Display the daily sales by day of the week.
UPDATE supermarket SET supermarket.Date = str_to_date(supermarket.Date, '%m,%d,%y'); 
SELECT dayname(supermarket.Date) AS day , dayofweek(supermarket.date), 
SUM(supermarket.Total)
FROM supermarket
GROUP BY day, dayofweek(supermarket.date)
ORDER BY SUM(supermarket.Total) DESC;

-- 10. Find the month with the highest sales.
SELECT monthname(supermarket.Date) AS name, month(supermarket.Date) AS month,
SUM(supermarket.Total)
FROM supermarket
GROUP BY  name, month
ORDER BY SUM(supermarket.Total) DESC;

-- 11. Find the time at which sales are highest.
SELECT hour(supermarket.Time) AS hour, SUM(supermarket.Total) 
FROM supermarket
GROUP BY hour 
ORDER BY SUM(supermarket.Total);

-- 12. Which gender spends more on average?
SELECT supermarket.Gender, AVG(supermarket.Total)
FROM supermarket
GROUP BY supermarket.Gender;