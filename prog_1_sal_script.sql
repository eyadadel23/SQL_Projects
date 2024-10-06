/* [About Dataset]:

 One way to understand how a city government works is by looking at who it employs and how its employees are compensated. 
 This data contains the names, job title, and compensation for San Francisco city 
 employees on an annual basis from 2011 to 2014.
 */


-- Creating our DataBase:
CREATE DATABASE sf_salaries;
-- ---------------------------------------------------------

-- 1	Show all columns and rows in the table. 
SELECT * FROM Salaries;

-- 2	Show only the EmployeeName and JobTitle columns.
SELECT Salaries.EmployeeName, Salaries.JobTitle
FROM Salaries;

-- 3	Show the number of employees in the table.
SELECT COUNT(ID) FROM Salaries;

-- 4	Show the unique job titles in the table.
SELECT DISTINCT Salaries.JobTitle
FROM Salaries;

-- 5	Show the job title and overtime pay for all employees with 
-- overtime pay greater than 50000.
SELECT Salaries.JobTitle, Salaries.OvertimePay
FROM Salaries
WHERE Salaries.OvertimePay > 50000;

-- 6	Show the average base pay for all employees.
SELECT AVG(Salaries.BasePay) AS AVG_SAL FROM Salaries;

-- 7	Show the top 10 highest paid employees.
SELECT Salaries.Id, Salaries.EmployeeName, Salaries.JobTitle, Salaries.TotalPay
FROM Salaries
ORDER BY Salaries.TotalPay DESC
LIMIT 10;

-- 8	Show the average of BasePay, OvertimePay, and OtherPay for each employee:
SELECT AVG(Salaries.BasePay) AS AVG_BASE, AVG(Salaries.OvertimePay) AS AVG_OVERTIME,
AVG(Salaries.OtherPay) AS AVG_OTHERPAY
FROM Salaries;

-- 9	Show all employees who have the word "Manager" in their job title.
SELECT Salaries.EmployeeName, Salaries.JobTitle
FROM Salaries
WHERE Salaries.JobTitle LIKE '%Manager';

-- 10	Show all employees with a job title not equal to "Manager".
SELECT Salaries.EmployeeName, Salaries.JobTitle
FROM Salaries
WHERE Salaries.JobTitle NOT LIKE '%Manager';

-- 11	Show all employees with a total pay between 50,000 and 75,000.
SELECT * 
FROM Salaries
WHERE Salaries.TotalPay BETWEEN 50000 AND 70000;

-- 12	Show all employees with a base pay less than 50,000 
-- or a total pay greater than 100,000.
SELECT Salaries.EmployeeName, Salaries.BasePay, Salaries.TotalPay 
FROM Salaries
WHERE Salaries.BasePay < 50000 OR Salaries.TotalPay > 100000;

-- 13	Show all employees with a total pay benefits value 
-- between 125,000 and 150,000 and a job title containing the word "Director".
SELECT Salaries.EmployeeName, Salaries.JobTitle, Salaries.TotalPayBenefits
FROM Salaries
WHERE Salaries.TotalPayBenefits BETWEEN 125000 AND 150000 AND Salaries.JobTitle LIKE '%Director%';

-- 14	Show all employees ordered by their total pay benefits in descending order.
SELECT Salaries.EmployeeName, Salaries.JobTitle, Salaries.TotalPayBenefits
FROM Salaries
ORDER BY Salaries.TotalPayBenefits DESC;

-- 15	Show all job titles with an average base pay of 
-- at least 100,000 and order them by the average base pay in descending order.
SELECT Salaries.JobTitle, AVG(Salaries.BasePay) AS AVG_BASEPAY
FROM Salaries
GROUP BY Salaries.JobTitle
HAVING AVG(Salaries.BasePay) >= 100000
ORDER BY AVG_BASEPAY DESC;

-- 16	Show the average TotalPay by year
SELECT AVG(Salaries.TotalPay), Salaries.Year
FROM Salaries
GROUP BY Salaries.Year;

-- 17	Delete the 'Notes'column. 
ALTER TABLE Salaries
DROP COLUMN Notes;

-- 18	Update the base pay of all employees with 
-- the job title containing "Manager" by increasing it by 10%.
UPDATE Salaries
SET Salaries.BasePay = Salaries.BasePay * 1.1
WHERE Salaries.JobTitle LIKE '%Manager%';

-- 19	Delete all employees who have no OvertimePay. 
DELETE FROM Salaries
WHERE Salaries.OvertimePay = 0;