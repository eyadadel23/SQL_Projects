-- The Medical Insurance dataset on Kaggle has the following columns:
-- PatientID : Integer Value.
-- age: age of primary beneficiary
-- sex: gender of primary beneficiary (male or female)
-- bmi: body mass index of primary beneficiary
-- children: number of children covered by health insurance / number of dependents
-- smoker: whether the primary beneficiary is a smoker or not (yes or no)
-- region: the beneficiary's residential area in the US (northeast, southeast, southwest, or northwest)
-- claim: individual medical costs billed by health insurance


CREATE DATABASE insurance_data;
USE insurance_data;

-- 1. Select all columns for all patients.
SELECT * FROM insurance_data;

-- 2. Display the average claim amount for patients in each region.
SELECT insurance_data.region, AVG(insurance_data.claim) 
FROM insurance_data
GROUP BY insurance_data.region;

-- 3. Select the maximum and minimum BMI values in the table.
SELECT MAX(insurance_data.bmi) AS MAX_BMI, MIN(insurance_data.bmi) AS MIN_BIM
FROM insurance_data;

-- 4. Select the PatientID, age, and BMI for patients with a BMI between 40 and 50.
SELECT insurance_data.PatientID, insurance_data.age, insurance_data.bmi
FROM insurance_data
WHERE insurance_data.bmi BETWEEN 40 AND 50;

-- 5. Select the number of smokers in each region.
SELECT insurance_data.region, COUNT(*) 
FROM insurance_data
WHERE insurance_data.smoker = 'Yes'
GROUP BY insurance_data.region;

-- 6. What is the average claim amount for patients who are both diabetic and smokers?
SELECT AVG(insurance_data.claim) AS AVG_CLAIM
FROM insurance_data
WHERE insurance_data.diabetic = 'Yes' AND insurance_data.smoker = 'Yes';

-- 7. Retrieve all patients who have a BMI greater 
-- than the average BMI of patients who are smokers.
SELECT * FROM insurance_data
WHERE insurance_data.bmi > (SELECT AVG(insurance_data.bmi) FROM insurance_data 
							WHERE insurance_data.smoker = 'Yes');
                            
-- 8. Select the average claim amount for patients in each age group.
SELECT
CASE
	WHEN age BETWEEN 18 AND 30 THEN '18-30 AGE GROUP'
    WHEN age BETWEEN 31 AND 40 THEN '31-40 AGE GROUP'
    WHEN age BETWEEN 41 AND 50 THEN '41-50 AGE GROUP'
    ELSE 'OVER 50 AGE GROUP'
END AS AGE_GROUPS,
ROUND(AVG(insurance_data.claim),2) AS AVG_CLAIM
FROM insurance_data
GROUP BY AGE_GROUPS;

-- 9. Retrieve the total claim amount for each patient, 
-- along with the average claim amount across all patients.
SELECT insurance_data.PatientID, SUM(insurance_data.claim) OVER(PARTITION BY insurance_data.PatientID) AS TOT_CLAIM,
AVG(insurance_data.claim) OVER() AS AVG_CLAIM FROM insurance_data;

-- 10. Retrieve the top 3 patients with the highest claim amount, along with their 
-- respective claim amounts and the total claim amount for all patients.
SELECT insurance_data.PatientID, insurance_data.claim AS TOT_BY_PATIENT, 
SUM(insurance_data.claim) OVER() AS TOT_CLAIM FROM insurance_data
ORDER BY TOT_BY_PATIENT DESC
LIMIT 3;

-- 11. Select the details of patients who have a claim amount 
-- greater than the average claim amount for their region.
SELECT * FROM insurance_data t1
WHERE claim > (SELECT AVG(claim) FROM insurance_data t2 WHERE t2.region = t1.region);

-- 12. Retrieve the rank of each patient based on their claim amount.
SELECT insurance_data.PatientID, insurance_data.claim, RANK() OVER(ORDER BY insurance_data.claim DESC)
FROM insurance_data;

-- 13. Select the details of patients along with their claim amount, 
-- and their rank based on claim amount within their region.
SELECT *, RANK() OVER(PARTITION BY insurance_data.region ORDER BY insurance_data.claim) 
FROM insurance_data;
