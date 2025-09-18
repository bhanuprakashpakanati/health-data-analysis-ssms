SELECT
	[NAME]
	,AGE
	,GENDER
	,BLOOD_TYPE
	,MEDICAL_CONDITION
	,DATE_OF_ADMISSION
	,DOCTOR
	,HOSPITAL
	,INSURANCE_PROVIDER
	,ROUND(BILLING_AMOUNT,2) AS BILLING_AMOUNT
	,ROOM_NUMBER
	,ADMISSION_TYPE
	,DISCHARGE_DATE
	,MEDICATION
	,TEST_RESULTS
	,LENGTH_OF_STAY
FROM HEALTH;

---Handle missing/Invalid Values (Example: Negative Billing Amount)
-- Check for negative billing
SELECT COUNT(*) AS NEGATIVE_BILLING_RECORDS
FROM Health
WHERE Billing_Amount < 0;

/*--If found, you might decide to set them to NULL or investigate further.
UPDATE Health 
SET BILLING_AMOUNT = NULL
WHERE BILLING_AMOUNT < 0;*/

/*--Create a new calculated column for Length of Stay (in days)
ALTER TABLE HEALTH
ADD LENGTH_OF_STAY INT;

UPDATE HEALTH
SET LENGTH_OF_STAY = DATEDIFF(DAY,DATE_OF_ADMISSION,DISCHARGE_DATE);*/

---A. Patient Demographics & Epidemiology:

---A1. What is the distribution of patients by Gender and Age groups?
SELECT
	GENDER
		,CASE
			WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
			WHEN AGE BETWEEN 19 AND 35 THEN '19-35'
			WHEN AGE BETWEEN 36 AND 50 THEN '36-50'
			WHEN AGE BETWEEN 51 AND 65 THEN '51-65'
			ELSE '65+'
		END AS AGE_GROUP
		,COUNT(*) AS NUMBER_OF_PATIENTS
FROM HEALTH
GROUP BY
		GENDER
		,CASE
			WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
			WHEN AGE BETWEEN 19 AND 35 THEN '19-35'
			WHEN AGE BETWEEN 36 AND 50 THEN '36-50'
			WHEN AGE BETWEEN 51 AND 65 THEN '51-65'
			ELSE '65+'
		END
ORDER BY GENDER,AGE_GROUP;

---A2. What are the top 5 most common Medical Conditions among admitted patients?
SELECT TOP 5
		MEDICAL_CONDITION
		,COUNT(*) AS ADMISSION_COUNT
FROM HEALTH
GROUP BY MEDICAL_CONDITION
ORDER BY ADMISSION_COUNT DESC;

---A3.Is there a correlation between Blood Type and specific Medical Conditions?
SELECT
	BLOOD_TYPE
	,MEDICAL_CONDITION
	,COUNT(*) AS [COUNT]
FROM HEALTH
GROUP BY
		BLOOD_TYPE
		,MEDICAL_CONDITION
ORDER BY
		BLOOD_TYPE
		,[COUNT] DESC;
---B. Hospital & Operational Analysis:

---B1. Which Hospital has the highest number of admissions? Which has the highest average Billing Amount?
--- Admissions
SELECT
	HOSPITAL
	,COUNT(*) AS ADMISSION_COUNT
FROM HEALTH
GROUP BY HOSPITAL
ORDER BY ADMISSION_COUNT DESC;

--- Highest Average Billing
SELECT
	HOSPITAL
	,AVG(BILLING_AMOUNT) AS AVG_BILLING_AMOUNT
FROM HEALTH
GROUP BY HOSPITAL
ORDER BY AVG_BILLING_AMOUNT DESC;

---B2. Who are the top 5 Doctors by number of patients treated?
SELECT TOP 5
	DOCTOR
	,COUNT(*) AS TOTAL_PATIENTS_TREATED
FROM HEALTH
GROUP BY DOCTOR
ORDER BY TOTAL_PATIENTS_TREATED DESC;

---B3. What is the average length of stay (Discharge Date - Date of Admission) for each Admission Type (Urgent, Emergency, Elective)?
SELECT
	ADMISSION_TYPE
	,AVG(LENGTH_OF_STAY) AS AVG_LENGTH_OF_STAY
FROM HEALTH
GROUP BY ADMISSION_TYPE;

---C. Financial & Insurance Analysis:

---C1. What is the total and average Billing Amount by Insurance Provider?
SELECT
	INSURANCE_PROVIDER
	,SUM(BILLING_AMOUNT) AS TOTAL_BILLING_AMOUNT
	,AVG(BILLING_AMOUNT) AS AVG_BILLING_AMOUNT
FROM HEALTH
GROUP BY INSURANCE_PROVIDER
ORDER BY TOTAL_BILLING_AMOUNT DESC;

---C2. Which Medical Condition has the highest average billing amount?
SELECT
	MEDICAL_CONDITION
	,AVG(BILLING_AMOUNT) AS AVG_BILLING_AMOUNT
FROM HEALTH
GROUP BY MEDICAL_CONDITION
ORDER BY AVG_BILLING_AMOUNT DESC;

---C3. What is the distribution of Admission Type across different Insurance Providers?
SELECT
	INSURANCE_PROVIDER
	,ADMISSION_TYPE
	,COUNT(*) AS [COUNT]
FROM HEALTH
GROUP BY  INSURANCE_PROVIDER ,ADMISSION_TYPE
ORDER BY INSURANCE_PROVIDER ,[COUNT] DESC;

---D. Treatment & Outcomes Analysis:

---D1. What is the most common Medication prescribed for each Medical Condition?
WITH RANKED_MEDS AS (
			SELECT
				MEDICAL_CONDITION
				,MEDICATION
				,COUNT(*) AS PRESCRIPTION_COUNT
				,RANK() OVER(PARTITION BY MEDICAL_CONDITION ORDER BY COUNT(*) DESC) AS [RANK] -- Ranks medications by frequency for each condition
			FROM HEALTH
			GROUP BY MEDICAL_CONDITION, MEDICATION
)
SELECT
	MEDICAL_CONDITION
	,MEDICATION
	,PRESCRIPTION_COUNT
FROM RANKED_MEDS
WHERE [RANK] = 1 -- Selects only the most common medication for each condition
ORDER BY MEDICAL_CONDITION;

---D2. How does the Test Results (Normal, Abnormal, Inconclusive) breakdown look for each condition?
SELECT
	MEDICAL_CONDITION
	,TEST_RESULTS
	,COUNT(*) AS RESULT_COUNT
FROM HEALTH
GROUP BY MEDICAL_CONDITION, TEST_RESULTS
ORDER BY MEDICAL_CONDITION, RESULT_COUNT DESC;

---D3. Is there a relationship between the Length of Stay and the Test Results?
SELECT
	TEST_RESULTS
	,AVG(LENGTH_OF_STAY) AS AVG_LENGTH_OF_STAY
	,MIN(LENGTH_OF_STAY) AS MIN_LENGTH_OF_STAY
	,MAX(LENGTH_OF_STAY) AS MAX_LENGTH_OF_STAY
FROM HEALTH
GROUP BY TEST_RESULTS
ORDER BY AVG_LENGTH_OF_STAY DESC;

/* End of script */
