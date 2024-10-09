CREATE DATABASE titanic_project;
USE titanic_project;


SELECT * FROM titanic;

-- 1. Show the first 10 rows of the dataset.
Select * FROM titanic
LIMIT 10;

-- 2. Find the number of passengers who survived.
SELECT COUNT(*)
FROM titanic
WHERE titanic.Survived = 1;

-- 3. Find the average age of all passengers.
SELECT AVG(titanic.Age) AS AVG_AGE
FROM titanic;

-- 4. Find the number of passengers in each class.
SELECT titanic.Pclass, COUNT(*)
FROM titanic
GROUP BY titanic.Pclass
ORDER BY COUNT(*) DESC;

-- 5. Find the first 10 rows of the dataset sorted by passenger class in descending order.
SELECT * 
FROM titanic
ORDER BY titanic.Pclass DESC 
LIMIT 10;

-- 6. Find the number of passengers in each class sorted by class in ascending order.
SELECT titanic.Pclass, COUNT(*)
FROM titanic
GROUP BY titanic.Pclass
ORDER BY titanic.Pclass ASC;

-- 7. Find the average fare paid by passengers in each class.
SELECT titanic.Pclass, AVG(titanic.Fare)
FROM titanic
GROUP BY titanic.Pclass;

-- 8. Find the name of the passenger with the highest fare.
SELECT titanic.Name, titanic.Fare
FROM titanic 
WHERE titanic.Fare = (SELECT MAX(titanic.Fare)FROM titanic);

-- 9. Find the name of the passenger who had the highest age among the survivors.
SELECT titanic.Name, titanic.AGE 
FROM titanic
WHERE titanic.Survived = 1 AND titanic.Age = (SELECT MAX(titanic.Age) FROM titanic);

-- 10. Find the number of passengers who paid more than the average fare.
SELECT COUNT(*) 
FROM titanic
WHERE titanic.Fare > (SELECT AVG(titanic.Fare) FROM titanic);

-- 11. Find the name of the passenger who had the most parents or children on board.
SELECT titanic.Name, titanic.Parch FROM titanic
WHERE titanic.Parch = (SELECT MAX(titanic.Parch) FROM titanic);

-- 12. Find the number of male and female passengers who survived, 
-- and order the results by sex in ascending order:
SELECT titanic.Sex, COUNT(*) 
FROM titanic
WHERE titanic.Survived = 1
GROUP BY titanic.SEX
ORDER BY SEX ASC;

-- 13. Find the name, age, and fare of the oldest passenger who survived.
SELECT titanic.Name, titanic.Age, titanic.Fare 
FROM titanic
WHERE titanic.Survived = 1 AND titanic.Age = (SELECT MAX(titanic.Age) FROM titanic);

-- 14. Find the name and age of the youngest female passenger who survived in third class.
SELECT name,age FROM titanic WHERE titanic.Sex = "Female" AND titanic.Pclass = 3 AND titanic.Survived = 1
AND titanic.age = (SELECT MIN(Age) FROM titanic WHERE titanic.Sex = "female" AND titanic.Pclass = 3
                   AND titanic.Survived = 1);


