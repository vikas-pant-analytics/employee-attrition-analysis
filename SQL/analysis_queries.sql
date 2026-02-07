/* ======================================
   Employee Attrition Analysis Project
   Author: VIKAS PANT 
   Description: SQL investigation of attrition drivers
====================================== */


/* --- Salary vs Attrition --- */
-- Compare average salary of leavers vs stayers

SELECT e.attrition,
       AVG(c.monthly_income) AS avg_salary
FROM employees e
JOIN compensation c
ON e.employee_id = c.employee_id
GROUP BY e.attrition;


/* --- Satisfaction vs Attrition --- */
-- Compare job satisfaction levels

SELECT e.attrition,
       AVG(s.job_satisfaction) AS avg_job_sat
FROM employees e
JOIN satisfaction s
ON e.employee_id = s.employee_id
GROUP BY e.attrition;


/* --- Tenure Analysis --- */
-- Compare years at company

SELECT e.attrition,
       AVG(x.years_at_company) AS avg_tenure
FROM employees e
JOIN experience x
ON e.employee_id = x.employee_id
GROUP BY e.attrition;


/* --- Training Analysis --- */
-- Compare training frequency

SELECT e.attrition,
       AVG(p.training_times_last_year) AS avg_training
FROM employees e
JOIN performance p
ON e.employee_id = p.employee_id
GROUP BY e.attrition;


/* --- Risk Profiling Model --- */
-- Classify employees by risk level

SELECT e.employee_id,
       CASE
           WHEN c.monthly_income < 4000
                AND s.job_satisfaction <= 2
                AND x.years_at_company < 5
           THEN 'High Risk'
           ELSE 'Low Risk'
       END AS risk_level
FROM employees e
JOIN compensation c ON e.employee_id = c.employee_id
JOIN satisfaction s ON e.employee_id = s.employee_id
JOIN experience x ON e.employee_id = x.employee_id;


/* --- Risk Hotspot by Department --- */
-- Identify departments with most high-risk employees

SELECT j.department,
       COUNT(*) AS high_risk_count
FROM employees e
JOIN jobs j ON e.employee_id = j.employee_id
JOIN compensation c ON e.employee_id = c.employee_id
JOIN satisfaction s ON e.employee_id = s.employee_id
JOIN experience x ON e.employee_id = x.employee_id
WHERE c.monthly_income < 4000
  AND s.job_satisfaction <= 2
  AND x.years_at_company < 5
GROUP BY j.department;
