create database HealthcareProject;
use HealthcareProject;
show tables;

# 1 Number of Patients across various summaries
SELECT 
    SUM(`Number of patients included in the transfusion summary`) AS total_transfusion_patients,
    SUM(`Number of patients in hypercalcemia summary`) AS total_hypercalcemia_patients,
    SUM(`Number of patients in Serum phosphorus summary`) AS total_serum_phosphorus_patients,
    SUM(`Number of patients included in hospitalization summary`) AS total_hospitalization_patients,
    SUM(`Number of Patients included in survival summary`) AS total_survival_patients,
    SUM(`Number of Patients included in fistula summary`) AS total_fistula_patients,
    SUM(`Number of patients in long term catheter summary`) AS total_long_term_catheter_patients,
    SUM(`Number of patients in nPCR summary`) AS total_nPCR_patients
FROM dialysis1;

# 2. Profit Vs Non-Profit Stats

SELECT
    SUM(CASE WHEN `Profit or Non-Profit` = 'Profit' THEN 1 ELSE 0 END) AS profit_count,
    SUM(CASE WHEN `Profit or Non-Profit` = 'Non-Profit' THEN 1 ELSE 0 END) AS non_profit_count
FROM dialysis1;

# 3 Chain Organizations w.r.t. Total Performance Score as No Score

SELECT d1.`Chain Organization`
FROM dialysis1 AS d1
JOIN dialysis2 AS d2 ON d1.`Facility Name` = d2.`Facility Name`
WHERE d2.`Total Performance Score` = 'No Score';

# 4 Dialysis Stations Stats

SELECT `Chain Organization`, SUM(`# of Dialysis Stations`) AS total_dialysis_stations
FROM dialysis1
GROUP BY `Chain Organization`;

# 5 of Category Text  - As Expected

SELECT
COUNT(CASE WHEN `Patient Transfusion category text` = 'As Expected' THEN 1 END) AS Transfusion_Count,
COUNT(CASE WHEN `Patient hospitalization category text` = 'As Expected' THEN 1 END) AS Hospitalization_Count,
COUNT(CASE WHEN `Patient Survival Category Text` = 'As Expected' THEN 1 END) AS Survival_Count,
COUNT(CASE WHEN `Patient Infection category text` = 'As Expected' THEN 1 END) AS Infection_Count,
COUNT(CASE WHEN `Fistula Category Text` = 'As Expected' THEN 1 END) AS Fistula_Count,
COUNT(CASE WHEN `PPPW category text` = 'As Expected' THEN 1 END) AS PPPW_Count
FROM dialysis1;

# 6 Average Payment Reduction Rate

SELECT AVG(CAST(`py2020 payment reduction percentage` AS DECIMAL(18, 10))) AS average_percentage
FROM dialysis2
WHERE `py2020 payment reduction percentage` != 'no reduction';
