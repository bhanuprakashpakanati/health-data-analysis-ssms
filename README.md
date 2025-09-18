# Health Data Analysis using SQL Server Management Studio (SSMS)

##  Project Overview
This project focuses on analyzing a comprehensive healthcare dataset using SQL Server Management Studio (SSMS). The dataset contains patient demographics, medical details, hospital admissions, billing, and treatment outcomes. The goal is to clean, process, and analyze the data to provide actionable insights for better decision-making in healthcare management.

##  Objectives
- Import and clean raw healthcare data from CSV into SQL Server.
- Standardize and validate patient, hospital, and billing records.
- Answer key business questions related to:
  - Patient demographics and epidemiology  
  - Hospital performance and operational efficiency  
  - Financial and insurance analysis  
  - Treatment patterns and outcome effectiveness  

##  Dataset Description
The dataset (`Health.csv`) includes:
- **Patient Details:** Name, Age, Gender  
- **Medical Information:** Blood Type, Medical Condition, Medication, Test Results  
- **Admission Details:** Admission & Discharge Dates, Type of Admission, Room Number  
- **Hospital & Staff:** Hospital, Doctor  
- **Billing & Insurance:** Insurance Provider, Billing Amount  

##  Technical Approach
1. **Data Import:** CSV file imported into SQL Server using SSMS.  
2. **Data Cleaning:**  
   - Fixed inconsistencies in text fields (e.g., Gender values).  
   - Converted admission/discharge dates into proper formats.  
   - Handled missing/invalid values (e.g., negative billing).  
   - Created calculated fields such as Length of Stay.  
3. **Data Analysis:** SQL queries using `GROUP BY`, `JOIN`, aggregate functions (`COUNT`, `SUM`, `AVG`) to answer business questions.  
4. **Reporting:**  
   - Exported query results into Excel for visualization.  
   - Built SQL Views for repeated queries.  
   - (Optional) SSRS reports for dashboards.  

##  Key Business Questions
- What is the age and gender distribution of patients?  
- Which are the top 5 most common medical conditions?  
- Which hospital records the highest admissions and billing amounts?  
- Who are the top-performing doctors by number of patients?  
- What are the total and average billing amounts by insurance provider?  
- Which medications are most prescribed for common conditions?  
- How does the length of stay correlate with test results?  

##  Deliverables
- Cleaned **HealthData** table in SQL Server.  
- SQL script (`SQL.sql`) with all queries used for analysis.  
- Client requirement document (`Client_Requirement_HealthData.pdf`).  
- Source dataset (`Health.csv`).  

##  How to Use
1. Import `Health.csv` into SQL Server.  
2. Run the provided SQL script (`SQL.sql`) in SSMS.  
3. Explore results and insights for reporting or visualization.  

##  Tools & Technologies
- SQL Server Management Studio (SSMS)  
- SQL (DDL & DML)  
- Microsoft Excel / SSRS (for reporting)  

---
**Author:** Bhanu Prakash Pakanati  
